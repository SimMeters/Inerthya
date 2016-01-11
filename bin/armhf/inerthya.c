/*******************************************************************************
 * Copyright (c) 2015, SimMeters.com
 * All rights reserved. Released under the BSD license.
 * inerthya.c 1.0 01/01/2016 (SimMeters Inerthya System UDP/CAN Gateway)  
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, 
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, 
 * this list of conditions and the following disclaimer in the documentation 
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <signal.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>
#include <linux/can/raw.h>

#include "inerthya.h"

int optval = 1;
char buf[BUFSIZE];           		/* message buffer */
int i, nbytes, sockudp, sockcan, clientlen;

struct 	ifreq               ifr;	/* can interface */
struct 	sockaddr_in  serveraddr;	/* server's addr */
struct 	sockaddr_in  clientaddr; 	/* client addr */
struct 	sockaddr_can canbusaddr;	/* can address */
struct 	can_filter   rfilter[1];	/* array to set filter id 200 */
struct 	can_frame 		 cframe;    /* can frame */
struct 	INERTHYA_FRAME 	 oframe;	/* data output frame */
struct 	INERTHYA_FRAME 	 iframe;	/* data input frame */

void finish(int sig) { 
	
	close(sockudp);
	optval = 0; 

}

int main(int argc, char **argv) {
    
	/* handle signal for CTRL ^ C */
	signal(SIGINT, finish);	
	
	/* CAN setup */
	strcpy(ifr.ifr_name, "can0"); 															/* assign default can0 interface */
	sockcan = socket(PF_CAN, SOCK_RAW, CAN_RAW);											/* create can socket */
	rfilter[0].can_id   = 0xC8; 															/* enable filter ID_RXDATA (200) for receive on CAN */
	rfilter[0].can_mask = CAN_SFF_MASK;														/* standard mask */ 
	setsockopt(sockcan, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));			/* apply filter to the can device */
	ioctl(sockcan, SIOCGIFINDEX, &ifr);														/* select interface index */
	canbusaddr.can_family 	= AF_CAN; 														/* build the can address */
	canbusaddr.can_ifindex 	= ifr.ifr_ifindex;												/* set interface index */
	fcntl(sockcan, F_SETFL, fcntl(sockcan, F_GETFL) | O_NONBLOCK); 							/* can raw socket non blocking */
	bind(sockcan, (struct sockaddr *)&canbusaddr, sizeof(canbusaddr)); 						/* bind can socket */

	/* UDP setup */
	clientlen = sizeof(clientaddr); 														/* size of client address */
	sockudp = socket(AF_INET, SOCK_DGRAM, 0); 												/* create udp socket */
	bzero((char *) &serveraddr, sizeof(serveraddr)); 										/* build the udp address */
	serveraddr.sin_family = AF_INET;														/* family inet */
	serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);											/* local address */
	serveraddr.sin_port = htons(6060);														/* asign 6060 port */							
	bind(sockudp, (struct sockaddr *) &serveraddr, sizeof(serveraddr)); 					/* bind udp socket with a port */
	
	/* clear the screen and shows header information */
	printf("\033[2J");
	printf("\033[0;0H");
	printf("┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐\n");
	printf("│ SimMeters INERTHYA System [UDP/CAN Gateway 2.0 2016 armhf]                                                                           │\n");
	printf("│ Wrapper running on port UDP 6060 and can-if can0, exit program with CTRL ^ C                                    0pkt(s)    0bytes(s) │\n");
	printf("├─────────────┬──────────┬──────────┬─────────┬───────────┬──────────────┬──────────────┬───────┬───────┬───────┬───────┬──────────────┤\n");
	printf("│ OUT CAN SID │ BYTE9    │ BYTE8    │ BYTE7   │ BYTE6     │ BYTE5        │ BYTE4        │ BYTE3 │ BYTE2 │ BYTE1 │ BYTE0 │    DATA      │\n");
	printf("│ (HEX / DEC) │ CAN_IDH  │ CAN_IDL  │ NODE_ID │ DATA_TYPE │ SERVICE_CODE │ MESSAGE_CODE │ DATA3 │ DATA2 │ DATA1 │ DATA0 │    VALUE     │\n");
	printf("└─────────────┴──────────┴──────────┴─────────┴───────────┴──────────────┴──────────────┴───────┴───────┴───────┴───────┴──────────────┘\n");

    while(optval) {
		
		/* read udp data */
		bzero(buf, BUFSIZE);
		nbytes = recvfrom(sockudp, buf, BUFSIZE, 0,(struct sockaddr *) &clientaddr, &clientlen);

        if (nbytes < 0) {

            perror("Error receiving data\n");

        } else {
            
			/* begins header information */
			printf("\033[0;0H");
   			printf("┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐\n");
			printf("│ SimMeters INERTHYA System [UDP/CAN Gateway 2.0 2016 armhf]                                                                           │\n");
    		printf("│ Wrapper running on port UDP 6060 and can-if can0, exit program with CTRL ^ C                                  %03ipkt(s) %04ibytes(s) │\n", nbytes/DOPF_LEN, nbytes);
    		printf("├─────────────┬──────────┬──────────┬─────────┬───────────┬──────────────┬──────────────┬───────┬───────┬───────┬───────┬──────────────┤\n");
			printf("│ OUT CAN SID │ BYTE9    │ BYTE8    │ BYTE7   │ BYTE6     │ BYTE5        │ BYTE4        │ BYTE3 │ BYTE2 │ BYTE1 │ BYTE0 │    DATA      │\n");
			printf("│ (HEX / DEC) │ CAN_IDH  │ CAN_IDL  │ NODE_ID │ DATA_TYPE │ SERVICE_CODE │ MESSAGE_CODE │ DATA3 │ DATA2 │ DATA1 │ DATA0 │    VALUE     │\n");
    		printf("├──────┬──────┼────┬─────┼────┬─────┼────┬────┼─────┬─────┼──────┬───────┼──────┬───────┼───┬───┼───┬───┼───┬───┼───┬───┼──────────────┤\n");

            int idx = 0;
            for(i = 0; i < nbytes/DOPF_LEN; i++) {

                /* parse data output buffer */
                oframe.CAN_IDH       = buf[idx]; 
                oframe.CAN_IDL       = buf[idx + 1];
                oframe.NODE_ID       = buf[idx + 2];
                oframe.DATA_TYPE     = buf[idx + 3];
                oframe.SERVICE_CODE  = buf[idx + 4];
                oframe.MESSAGE_CODE  = buf[idx + 5];
                oframe.DATA3         = buf[idx + 6];
                oframe.DATA2         = buf[idx + 7];
                oframe.DATA1         = buf[idx + 8];
                oframe.DATA0         = buf[idx + 9];

 				printf("│ %04X │ %04i │ %02X │ %03i │ %02X │ %03i │ %02X │ %03i│  %02X │ %03i │   %02X │ %03i   │   %02X │ %03i   │ %02X│%03i│ %02X│%03i│ %02X│%03i│ %02X│%03i│",
				(oframe.CAN_IDH << 8) | oframe.CAN_IDL, (oframe.CAN_IDH << 8) | oframe.CAN_IDL, oframe.CAN_IDH, oframe.CAN_IDH, oframe.CAN_IDL, oframe.CAN_IDL, oframe.NODE_ID,
				oframe.NODE_ID, oframe.DATA_TYPE, oframe.DATA_TYPE, oframe.SERVICE_CODE, oframe.SERVICE_CODE, oframe.MESSAGE_CODE, oframe.MESSAGE_CODE, oframe.DATA3, oframe.DATA3,
				oframe.DATA2, oframe.DATA2, oframe.DATA1, oframe.DATA1, oframe.DATA0, oframe.DATA0);
                
				/* display data float format */
                if(oframe.DATA_TYPE == TYPE_FLOAT) { 
                    
                    floatun.floatbuf[3] = oframe.DATA3;
                    floatun.floatbuf[2] = oframe.DATA2;
                    floatun.floatbuf[1] = oframe.DATA1;
                    floatun.floatbuf[0] = oframe.DATA0;
                    printf(" %012.6f │\n", floatun.value);
                                    
				/* display data Uint32 format */
                } else if(oframe.DATA_TYPE == TYPE_ULONG) {
                    
                    intun.intbuf[3] = oframe.DATA3;
                    intun.intbuf[2] = oframe.DATA2;
                    intun.intbuf[1] = oframe.DATA1;
                    intun.intbuf[0] = oframe.DATA0;
                    printf(" HEX %08X │\n", intun.value);

                } else {
                	printf(" ------- │\n");
                }
				
				/* send data to the canbus */
				cframe.can_id  = (oframe.CAN_IDH << 8) | oframe.CAN_IDL;
				cframe.can_dlc = DLC8;
				cframe.data[0] = oframe.NODE_ID;
				cframe.data[1] = oframe.DATA_TYPE;
				cframe.data[2] = oframe.SERVICE_CODE;
				cframe.data[3] = oframe.MESSAGE_CODE;
				cframe.data[4] = oframe.DATA3;
				cframe.data[5] = oframe.DATA2;
				cframe.data[6] = oframe.DATA1;
				cframe.data[7] = oframe.DATA0;

				write(sockcan, &cframe, sizeof(cframe));
				idx = idx + DOPF_LEN;

			}

    		printf("├──────┴──────┼────┴─────┼────┴─────┼────┴────┼─────┴─────┼──────┴───────┼──────┴───────┼───┴───┼───┴───┼───┴───┼───┴───┼──────────────┤\n");
			printf("│ INP CAN SID │ BYTE9    │ BYTE8    │ BYTE7   │ BYTE6     │ BYTE5        │ BYTE4        │ BYTE3 │ BYTE2 │ BYTE1 │ BYTE0 │    DATA      │\n");
			printf("│ (HEX / DEC) │ CAN_IDH  │ CAN_IDL  │ NODE_ID │ DATA_TYPE │ SERVICE_CODE │ MESSAGE_CODE │ DATA3 │ DATA2 │ DATA1 │ DATA0 │    VALUE     │\n");
			printf("├──────┬──────┼────┬─────┼────┬─────┼────┬────┼─────┬─────┼──────┬───────┼──────┬───────┼───┬───┼───┬───┼───┬───┼───┬───┼──────────────┤\n");

        }

		/* from CANBus to UDP */
		nbytes = read(sockcan, &cframe, sizeof(cframe)); 
		if(nbytes > 0) { 
			
	        /* parse data input buffer */
	        iframe.CAN_IDH       = (char)(cframe.can_id >> 8);
	       	iframe.CAN_IDL       = (char)(cframe.can_id);
	        iframe.NODE_ID       = cframe.data[0];
	        iframe.DATA_TYPE     = cframe.data[1];
			iframe.SERVICE_CODE  = cframe.data[2];
	        iframe.MESSAGE_CODE  = cframe.data[3];
	        iframe.DATA3         = cframe.data[4];
	        iframe.DATA2         = cframe.data[5];
	        iframe.DATA1         = cframe.data[6];
	        iframe.DATA0         = cframe.data[7];
			
			/* send data to udp */			
			buf[0] = iframe.CAN_IDH;
			buf[1] = iframe.CAN_IDL;
			buf[2] = iframe.NODE_ID;
			buf[3] = iframe.DATA_TYPE;
			buf[4] = iframe.SERVICE_CODE;
			buf[5] = iframe.MESSAGE_CODE;
			buf[6] = iframe.DATA3;
			buf[7] = iframe.DATA2;
			buf[8] = iframe.DATA1;
			buf[9] = iframe.DATA0;
			sendto(sockudp, buf, DIPF_LEN, 0, (struct sockaddr *) &clientaddr, clientlen);
		
		}

		printf("│ %04X │ %04i │ %02X │ %03i │ %02X │ %03i │ %02X │ %03i│  %02X │ %03i │   %02X │ %03i   │   %02X │ %03i   │ %02X│%03i│ %02X│%03i│ %02X│%03i│ %02X│%03i│",
		(iframe.CAN_IDH << 8) | iframe.CAN_IDL, (iframe.CAN_IDH << 8) | iframe.CAN_IDL, iframe.CAN_IDH, iframe.CAN_IDH, iframe.CAN_IDL, iframe.CAN_IDL, iframe.NODE_ID,
		iframe.NODE_ID, iframe.DATA_TYPE, iframe.DATA_TYPE, iframe.SERVICE_CODE, iframe.SERVICE_CODE, iframe.MESSAGE_CODE, iframe.MESSAGE_CODE, iframe.DATA3, iframe.DATA3,
		iframe.DATA2, iframe.DATA2, iframe.DATA1, iframe.DATA1, iframe.DATA0, iframe.DATA0);

        intun.intbuf[3] = iframe.DATA3;
        intun.intbuf[2] = iframe.DATA2;
        intun.intbuf[1] = iframe.DATA1;
        intun.intbuf[0] = iframe.DATA0;
        printf(" HEX %08X │\n", intun.value);

		printf("└──────┴──────┴────┴─────┴────┴─────┴────┴────┴─────┴─────┴──────┴───────┴──────┴───────┴───┴───┴───┴───┴───┴───┴───┴───┴──────────────┘\n");
		fflush(stdout);
	
	}

	/* clear the screen and shows header information */
	printf("\033[2J");
	printf("\033[0;0H");
	printf("Please wait, sending data from CANBus SID 200 to 2047\n");

	/* reset 200 to 2047 ID's DATA when exit to set autozero */
	for(i = 200; i < 2048; i++) {
		
		/* send data to the canbus */
		cframe.can_id  = i;
		cframe.can_dlc = DLC8;
		cframe.data[0] = 0;
		cframe.data[1] = 0;
		cframe.data[2] = 0;
		cframe.data[3] = 0;
		cframe.data[4] = 0;
		cframe.data[5] = 0;
		cframe.data[6] = 0;
		cframe.data[7] = 0;
		write(sockcan, &cframe, sizeof(cframe));
		usleep(1000);

	}

	/* exit the wrapper */
    close(sockcan);
	printf("Gateway closed.\n");
	exit(0);
	
}