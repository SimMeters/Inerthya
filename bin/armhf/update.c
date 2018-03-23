/*
 * Copyright(c) 2014 Simmeters. All Rights Reserved. GPL License.
 * @(#)update.c RTM 2.0 01/01/2014 (Update Firmware trough CANBus)
 * Microchip HEX32 File Format
 * :BBAAAATT[DDDDDDDD]CC
 * : is start of line marker
 * BB is number of data bytes on line
 * AAAA is address in bytes
 * TT is type. 00 means data, 01 means EOF and 04 means extended address
 * DD is data bytes, number depends on BB value
 * CC is checksum (2s-complement of number of bytes+address+data)
 */

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <linux/can/raw.h>

#define HEXSIZE 6
#define BUFSIZE 256

FILE 	*file;  					/* declare a FILE pointer  */
char 	hex[HEXSIZE];           	/* hex buffer */
char 	buf[BUFSIZE];           	/* data buffer */
char 	filename[BUFSIZE];			/* name of the file */
int 	sockcan;                	/* can raw socket */
struct 	sockaddr_can addr;      	/* can address */
struct 	can_frame frame;        	/* can frame */
struct 	ifreq ifr;              	/* can interface */
char 	*ifname = "can0";       	/* default can interface */
struct 	can_filter rfilter[1];		/* array to set filter id 200 */
unsigned int pathlen, size, address, type, data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15;

void sendCANFrame(int canID, int canDLC, int DATA0, int DATA1, int DATA2, int DATA3, int DATA4, int DATA5, int DATA6, int DATA7) {
	
	frame.can_id  = canID;
	frame.can_dlc = canDLC;
	frame.data[0] = DATA0;
	frame.data[1] = DATA1;
	frame.data[2] = DATA2;
	frame.data[3] = DATA3;
	frame.data[4] = DATA4;
	frame.data[5] = DATA5;
	frame.data[6] = DATA6;
	frame.data[7] = DATA7;
	write(sockcan, &frame, sizeof(frame));
	usleep(2000);
	
}

int main(int argc, char **argv) {

	/* display information */
	printf("\n");
	printf("SimMeters.com Update Firmware Command Line Tool (Version 1.0 ARM)\n");
	printf("For any question or support please mail to: sales@simmeters.com\n");

	/* command line arguments */
	if (argc != 3) {
		fprintf(stderr, "usage: %s <path_filename.hex> <canif>\n", argv[0]);
		return 1;
	}

	/* CANBus interface setup */
	strcpy(ifr.ifr_name, argv[2]); 															/* assign can interface */
	sockcan = socket(PF_CAN, SOCK_RAW, CAN_RAW);											/* create can socket */
	rfilter[0].can_id   = 0xC8; 															/* enable filter ID_RXDATA (200) for receive on CAN */
	rfilter[0].can_mask = CAN_SFF_MASK; 
	setsockopt(sockcan, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));
	addr.can_family = AF_CAN; 																/* build the can address */
	ioctl(sockcan, SIOCGIFINDEX, &ifr);
	addr.can_ifindex = ifr.ifr_ifindex;
	fcntl(sockcan, F_SETFL, fcntl(sockcan, F_GETFL) | O_NONBLOCK); 							/* can socket non blocking */
	bind(sockcan, (struct sockaddr *)&addr, sizeof(addr)); 									/* bind can socket */
	
	/* parse filename from argc */
	strcpy(filename, argv[1]); 	

	/* open file */
	file = fopen(filename, "r");
	pathlen = strlen(filename);
	if (file == NULL) {
		printf("Firmware filename: %s not found !\n\n",filename);
		return 1;
	}
	
	/* Sends a request for bootloader, name based DLC8 chars */
	printf("Firmware filename: %s\n",filename);
	sendCANFrame(0x01, 0x08, filename[pathlen-12], filename[pathlen-11], filename[pathlen-10], filename[pathlen-9], filename[pathlen-8], filename[pathlen-7], filename[pathlen-6], filename[pathlen-5]);
	sleep(1);

	/* request device bootloader revision and display it */
	sendCANFrame(0x00, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF);

	/* device revision found */
	if(read(sockcan, &frame, sizeof(frame)) > 0) { 
		
		/* erase flash */
		memcpy(&buf[0], &frame.data, 8);
		printf("Erasing flash device rev: %s\n", buf);
		
		sendCANFrame(0x00, 0x04, (0x800 >> 0x08), (0x800 & 0xFF), (0x7FFF >> 0x08), (0x7FFF & 0xFF), 0x00, 0x00, 0x00, 0x00);
		sleep(4);
		
		/* read file until NULL pointer */
		while(fgets(buf, sizeof(buf), file) != NULL) {

			if(buf[0] = ':') {
			
				/* get data size of line */
				hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[1]; hex[5] = buf[2];
				size = strtol(hex, NULL, 16);
			
				/* get data address of line */
				hex[0] = '0'; hex[1] = 'x'; hex[2] = buf[3]; hex[3] = buf[4]; hex[4] = buf[5]; hex[5] = buf[6];
				address = strtol(hex, NULL, 16);
			
				/* get data type of line */
				hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[7]; hex[5] = buf[8];
				type = strtol(hex, NULL, 16);
			
				/* send data to program above 0x800 bootloader */
				if(address >= 0x800 && type == 0x00) {
			
					printf("Writing address 0x%X size %i byte(s)\r", address, size);
				
					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[9]; hex[5] = buf[10];
					data0 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[11]; hex[5] = buf[12];
					data1 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[13]; hex[5] = buf[14];
					data2 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[15]; hex[5] = buf[16];
					data3 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[17]; hex[5] = buf[18];
					data4 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[19]; hex[5] = buf[20];
					data5 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[21]; hex[5] = buf[22];
					data6 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[23]; hex[5] = buf[24];
					data7 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[25]; hex[5] = buf[26];
					data8 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[27]; hex[5] = buf[28];
					data9 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[29]; hex[5] = buf[30];
					data10 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[31]; hex[5] = buf[32];
					data11 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[33]; hex[5] = buf[34];
					data12 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[35]; hex[5] = buf[36];
					data13 = strtol(hex, NULL, 16);

					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[37]; hex[5] = buf[38];
					data14 = strtol(hex, NULL, 16);
	
					hex[0] = '0'; hex[1] = 'x'; hex[2] = '0'; hex[3] = '0'; hex[4] = buf[39]; hex[5] = buf[40];
					data15 = strtol(hex, NULL, 16);

					switch(size) {
				
						case 16:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9, data10, data11, data12, data13, data14, data15);
							break;

						case 15:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9, data10, data11, data12, data13, data14,  0xFF);
							break;

						case 14:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9, data10, data11, data12, data13,  0xFF,  0xFF);
							break;

						case 13:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9, data10, data11, data12,  0xFF,  0xFF,  0xFF);
							break;

						case 12:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9, data10, data11,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 11:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9, data10,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 10:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8, data9,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 9:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							sendCANFrame(0x00,  0x08, data8,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 8:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6, data7);
							break;

						case 7:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5, data6,  0xFF);
							break;

						case 6:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4, data5,  0xFF,  0xFF);
							break;

						case 5:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3, data4,  0xFF,  0xFF,  0xFF);
							break;

						case 4:
							sendCANFrame(0x00,  0x08, data0, data1, data2, data3,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 3:
							sendCANFrame(0x00,  0x08, data0, data1, data2,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 2:
							sendCANFrame(0x00,  0x08, data0, data1,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						case 1:
							sendCANFrame(0x00,  0x08, data0,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF,  0xFF);
							break;

						
					}
				
					/* after upload data send address to program */
					sendCANFrame(0x00, 0x03, (address >> 0x08), (address & 0xFF), size, 0x00, 0x00, 0x00, 0x00, 0x00);
			
				}

			}
		
		}
	
		/* Reset lru unit to user program DLC2 */
		sendCANFrame(0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
		printf("\nFirmware updated\n\n", buf);
	
	/* device not found */
	} else {
		printf("Device not found\n\n", buf);
	}

	fclose(file); 
    close(sockcan);
	return 0;

}
