/*
 * Copyright(c) 2014 Simmeters. All Rights Reserved. GPL License.
 * @(#) cndwrapper.c RTM 1.0 01/01/2014 (Condor Soaring to CANBus wrapper version 1.0 armhf)
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <signal.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>
#include <linux/can/raw.h>
#include "canaerospace.h"

#define BUFSIZE 65535

int 	i = 0;						/* spinner animation index */
int 	optval = 1;					/* optval var */
int 	nbytes;         			/* message byte size */
int 	sockudp;                	/* udp raw socket */
int 	sockcan;                	/* can raw socket */
int 	clientlen;      			/* byte size of client's address */
float	value;						/* float value of data */
struct 	sockaddr_in serveraddr;		/* server's addr */
struct 	sockaddr_in clientaddr; 	/* client addr */
struct 	sockaddr_can addr;      	/* can address */
struct 	can_frame cframe;        	/* can frame */
struct 	ifreq ifr;              	/* can interface */
struct 	can_filter rfilter[1];		/* array to set filter id 200 */
char 	buf[BUFSIZE];           	/* message buffer */
char 	*end_str, *end_token, *key;	/* variables for split data */
char	spinner[16] = "||||////----\\\\\\\\";

void dataPack(CANFrame frame, int dly) {

	cframe.can_id  = frame.canid;
	cframe.can_dlc = frame.dlc;
	cframe.data[0] = frame.node_id;
	cframe.data[1] = frame.data_type;
	cframe.data[2] = frame.service_code;
	cframe.data[3] = frame.message_code;
	cframe.data[4] = frame.data0;
	cframe.data[5] = frame.data1;
	cframe.data[6] = frame.data2;
	cframe.data[7] = frame.data3;
	write(sockcan, &cframe, sizeof(cframe));
	usleep(dly);

}

void finish(int sig) { 
	
	close(sockudp);
	optval = 0; 

}

int main(int argc, char **argv) {
    
	/* handle control for CTRL^c */
	signal(SIGINT, finish);	

	/* header information */
	printf("SimMeters Inerthya System(tm) [Condor Soaring(tm) data wrapper]\n");
	printf("Wrapper version 1.0 armhf, CANAerospace version 1.7\n");
	
	/* CAN setup */
	strcpy(ifr.ifr_name, "can0"); 															/* assign default can0 interface */
	sockcan = socket(PF_CAN, SOCK_RAW, CAN_RAW);											/* create can socket */
	rfilter[0].can_id   = 0xC8; 															/* enable filter ID_RXDATA (200) for receive on CAN */
	rfilter[0].can_mask = CAN_SFF_MASK;														/* standard mask */ 
	setsockopt(sockcan, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));			/* apply filter to the can device */
	ioctl(sockcan, SIOCGIFINDEX, &ifr);														/* select interface index */
	addr.can_family = AF_CAN; 																/* build the can address */
	addr.can_ifindex = ifr.ifr_ifindex;														/* set interface index */
	fcntl(sockcan, F_SETFL, fcntl(sockcan, F_GETFL) | O_NONBLOCK); 							/* can raw socket non blocking */
	bind(sockcan, (struct sockaddr *)&addr, sizeof(addr)); 									/* bind can socket */

	/* UDP setup */
	clientlen = sizeof(clientaddr); 														/* size of client address */
	sockudp = socket(AF_INET, SOCK_DGRAM, 0); 												/* create udp socket */
	bzero((char *) &serveraddr, sizeof(serveraddr)); 										/* build the udp address */
	serveraddr.sin_family = AF_INET;														/* famili inet */
	serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);											/* local address */
	serveraddr.sin_port = htons(6061);														/* asign 6061 port */							
	bind(sockudp, (struct sockaddr *) &serveraddr, sizeof(serveraddr)); 					/* bind udp socket with a port */
	printf("Wrapper running on port UDP 6061 and can-if can0, exit program with CTRL+c\n");
	
    while(optval) {
		
		/* read udp data */
		bzero(buf, BUFSIZE);
		nbytes = recvfrom(sockudp, buf, BUFSIZE, 0,(struct sockaddr *) &clientaddr, &clientlen);
		if (nbytes > 0) {

			printf("Syncing data UDP%cCANBus %i byte(s)\r", spinner[i], nbytes);		
			char *fldata = strtok_r(buf, "\r\n", &end_str);	
			while(fldata != NULL) {
	
				key = strtok_r(fldata, "=", &end_token);	
				value = atof(strtok_r(NULL, "=", &end_token));
			
				if(!strcmp(key, "time")) {
					dataPack(ID_UTC = setFloat(ID_UTC, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "airspeed")) {
					dataPack(ID_INDICATED_AIRSPEED = setFloat(ID_INDICATED_AIRSPEED, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "altitude")) {
					dataPack(ID_BARO_CORRECTION = setFloat(ID_BARO_CORRECTION, NODE_AHRS, SC4, 1013.0f), 0);
					dataPack(ID_BARO_CORRECTED_ALTITUDE = setFloat(ID_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "vario")) {
					dataPack(ID_COMPUTED_VERTICAL_VELOCITY = setFloat(ID_COMPUTED_VERTICAL_VELOCITY, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "compass")) {
					dataPack(ID_HEADING_ANGLE = setFloat(ID_HEADING_ANGLE, NODE_AHRS, SC4, value), 0);
					dataPack(ID_MAGNETIC_HEADING = setFloat(ID_MAGNETIC_HEADING, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "slipball")) {
					dataPack(ID_BODY_SIDESLIP = setFloat(ID_BODY_SIDESLIP, NODE_AHRS, SC4, value * 20.0f), 0);
				} else if(!strcmp(key, "turnrate")) {
					dataPack(ID_TURN_COORDINATION_RATE = setFloat(ID_TURN_COORDINATION_RATE, NODE_AHRS, SC4, value * -1.4285f), 0);
				} else if(!strcmp(key, "radiofrequency")) {
					dataPack(ID_VHF_1_COM_FREQUENCY = setFloat(ID_VHF_1_COM_FREQUENCY, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "yaw")) {
					dataPack(ID_BODY_YAW_RATE = setFloat(ID_BODY_YAW_RATE, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "pitch")) {
					dataPack(ID_BODY_PITCH_ANGLE = setFloat(ID_BODY_PITCH_ANGLE, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "bank")) {
					dataPack(ID_BODY_ROLL_ANGLE = setFloat(ID_BODY_ROLL_ANGLE, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "vz")) {
					dataPack(ID_ALTITUDE_RATE = setFloat(ID_ALTITUDE_RATE, NODE_AHRS, SC4, value), 0);
				} else if(!strcmp(key, "gforce")) {
					dataPack(ID_BODY_NORMAL_ACCELERATION = setFloat(ID_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC4, value), 0);
				}

				fldata = strtok_r(NULL, "\r\n", &end_str);
			
			}

			i++;
			i = i % 16;

		}
    
    }

	/* pack reset data */
	dataPack(ID_UTC = setFloat(ID_UTC, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INDICATED_AIRSPEED = setFloat(ID_INDICATED_AIRSPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BARO_CORRECTED_ALTITUDE = setFloat(ID_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BARO_CORRECTION = setFloat(ID_BARO_CORRECTION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COMPUTED_VERTICAL_VELOCITY = setFloat(ID_COMPUTED_VERTICAL_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_MAGNETIC_HEADING = setFloat(ID_MAGNETIC_HEADING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HEADING_ANGLE = setFloat(ID_HEADING_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_SIDESLIP = setFloat(ID_BODY_SIDESLIP, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TURN_COORDINATION_RATE = setFloat(ID_TURN_COORDINATION_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VHF_1_COM_FREQUENCY = setFloat(ID_VHF_1_COM_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_YAW_RATE = setFloat(ID_BODY_YAW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_PITCH_ANGLE = setFloat(ID_BODY_PITCH_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_ROLL_ANGLE = setFloat(ID_BODY_ROLL_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ALTITUDE_RATE = setFloat(ID_ALTITUDE_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_NORMAL_ACCELERATION = setFloat(ID_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC4, 0.0f), 50);

	/* exit wrapper */
    close(sockcan);
	printf("\nWrapper exit\n");
	exit(0);
	
}
