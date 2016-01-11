/*
 * Copyright(c) 2014 Simmeters. All Rights Reserved. GPL License.
 * @(#) swiwrapper.c RTM 1.0 01/01/2014 (Silent Wings to CANBus wrapper version 1.0 armhf)
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
	printf("SimMeters Inerthya System(tm) [Silent Wings(tm) data wrapper]\n");
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
	serveraddr.sin_port = htons(6062);														/* asign 6061 port */							
	bind(sockudp, (struct sockaddr *) &serveraddr, sizeof(serveraddr)); 					/* bind udp socket with a port */
	printf("Wrapper running on port UDP 6062 and can-if can0, exit program with CTRL+c\n");
	
    while(optval) {
		
		/* read udp data */
		bzero(buf, BUFSIZE);
		nbytes = recvfrom(sockudp, buf, BUFSIZE, 0,(struct sockaddr *) &clientaddr, &clientlen);
		if (nbytes > 0) {

			printf("Syncing data UDP%cCANBus %i byte(s)\r", spinner[i], nbytes);
			//int timestamp = (buf[0] & 0xFF) | ((buf[1] & 0xFF) << 8) | ((buf[2] & 0xFF) << 16) | ((buf[3] & 0xFF) << 24);                                 // Millisec Timestamp
			//double position_latitude = Double.longBitsToDouble((((long) (((buf[11] & 0xFF) << 24) | ((buf[10] & 0xFF) << 16) | ((buf[9] & 0xFF) << 8) | (buf[8] & 0xFF))) << 32) | ((((buf[7] & 0xFF) << 24) | ((buf[6] & 0xFF) << 16) | ((buf[5] & 0xFF) << 8) | (buf[4] & 0xFF)] & 0xFFffffffl)); // Degrees Position Latitude
			//double position_longitude = Double.longBitsToDouble((((long) (((buf[19] & 0xFF) << 24) | ((buf[18] & 0xFF) << 16) | ((buf[17] & 0xFF) << 8) | (buf[16] & 0xFF))) << 32) | ((((buf[15] & 0xFF) << 24) | ((buf[14] & 0xFF) << 16) | ((buf[13] & 0xFF) << 8) | (buf[12] & 0xFF)] & 0xFFffffffl)); // Degrees Position Longitude
			float altitude_msl 				= tofloat((buf[20] & 0xFF) | ((buf[21] & 0xFF) << 8) | ((buf[22] & 0xFF) << 16) | ((buf[23] & 0xFF) << 24));       // Altitude - Relative to Sea-Level Meters
			float altitude_ground 			= tofloat((buf[24] & 0xFF) | ((buf[25] & 0xFF) << 8) | ((buf[26] & 0xFF) << 16) | ((buf[27] & 0xFF) << 24));       // Altitude - Relative to Ground-Level Meters
			float altitude_ground_45 		= tofloat((buf[28] & 0xFF) | ((buf[29] & 0xFF) << 8) | ((buf[30] & 0xFF) << 16) | ((buf[31] & 0xFF) << 24));       // m gnd 45 degrees ahead (NOT IMPLEMENTED YET)
			float altitude_ground_forward 	= tofloat((buf[32] & 0xFF) | ((buf[33] & 0xFF) << 8) | ((buf[34] & 0xFF) << 16) | ((buf[35] & 0xFF) << 24));       // m gnd straight ahead (NOT IMPLEMENTED YET)
			float roll 						= tofloat((buf[36] & 0xFF) | ((buf[37] & 0xFF) << 8) | ((buf[38] & 0xFF) << 16) | ((buf[39] & 0xFF) << 24));       // Degrees
			float pitch 					= tofloat((buf[40] & 0xFF) | ((buf[41] & 0xFF) << 8) | ((buf[42] & 0xFF) << 16) | ((buf[43] & 0xFF) << 24));       // Degrees
			float yaw 						= tofloat((buf[44] & 0xFF) | ((buf[45] & 0xFF) << 8) | ((buf[46] & 0xFF) << 16) | ((buf[47] & 0xFF) << 24));       // Degrees
			float d_roll 					= tofloat((buf[48] & 0xFF) | ((buf[49] & 0xFF) << 8) | ((buf[50] & 0xFF) << 16) | ((buf[51] & 0xFF) << 24));       // Deg/sec Roll speed
			float d_pitch 					= tofloat((buf[52] & 0xFF) | ((buf[53] & 0xFF) << 8) | ((buf[54] & 0xFF) << 16) | ((buf[55] & 0xFF) << 24));       // Deg/sec Pitch speed
			float d_yaw 					= tofloat((buf[56] & 0xFF) | ((buf[57] & 0xFF) << 8) | ((buf[58] & 0xFF) << 16) | ((buf[59] & 0xFF) << 24));       // Deg/sec Yaw speed
			float vx 						= tofloat((buf[60] & 0xFF) | ((buf[61] & 0xFF) << 8) | ((buf[62] & 0xFF) << 16) | ((buf[63] & 0xFF) << 24));       // m/sec Speed vector in body-axis
			float vy 						= tofloat((buf[64] & 0xFF) | ((buf[65] & 0xFF) << 8) | ((buf[66] & 0xFF) << 16) | ((buf[67] & 0xFF) << 24));       // m/sec Speed vector in body-axis
			float vz 						= tofloat((buf[68] & 0xFF) | ((buf[69] & 0xFF) << 8) | ((buf[70] & 0xFF) << 16) | ((buf[71] & 0xFF) << 24));       // m/sec Speed vector in body-axis
			float vx_wind 					= tofloat((buf[72] & 0xFF) | ((buf[73] & 0xFF) << 8) | ((buf[74] & 0xFF) << 16) | ((buf[75] & 0xFF) << 24));       // Speed vector in body-axis, relative to wind
			float vy_wind 					= tofloat((buf[76] & 0xFF) | ((buf[77] & 0xFF) << 8) | ((buf[78] & 0xFF) << 16) | ((buf[79] & 0xFF) << 24));       // Speed vector in body-axis, relative to wind
			float vz_wind 					= tofloat((buf[80] & 0xFF) | ((buf[81] & 0xFF) << 8) | ((buf[82] & 0xFF) << 16) | ((buf[83] & 0xFF) << 24));       // Speed vector in body-axis, relative to wind
			float v_eas 					= tofloat((buf[84] & 0xFF) | ((buf[85] & 0xFF) << 8) | ((buf[86] & 0xFF) << 16) | ((buf[87] & 0xFF) << 24));       // m/sec Equivalent (indicated) air speed
			float ax 						= tofloat((buf[88] & 0xFF) | ((buf[89] & 0xFF) << 8) | ((buf[90] & 0xFF) << 16) | ((buf[91] & 0xFF) << 24));       // m/sec2 Acceleration vector in body axis
			float ay 						= tofloat((buf[92] & 0xFF) | ((buf[93] & 0xFF) << 8) | ((buf[94] & 0xFF) << 16) | ((buf[95] & 0xFF) << 24));       // m/sec2 Acceleration vector in body axis
			float az 						= tofloat((buf[96] & 0xFF) | ((buf[97] & 0xFF) << 8) | ((buf[98] & 0xFF) << 16) | ((buf[99] & 0xFF) << 24));       // m/sec2 Acceleration vector in body axis
			float angle_of_attack 			= tofloat((buf[100] & 0xFF) | ((buf[101] & 0xFF) << 8) | ((buf[102] & 0xFF) << 16) | ((buf[103] & 0xFF) << 24));   // Degrees Angle of attack
			float angle_sideslip 			= tofloat((buf[104] & 0xFF) | ((buf[105] & 0xFF) << 8) | ((buf[106] & 0xFF) << 16) | ((buf[107] & 0xFF) << 24));   // Degrees Sideslip angle
			float vario 					= tofloat((buf[108] & 0xFF) | ((buf[109] & 0xFF) << 8) | ((buf[110] & 0xFF) << 16) | ((buf[111] & 0xFF) << 24));   // m/sec TE-compensated variometer.
			float heading 					= tofloat((buf[112] & 0xFF) | ((buf[113] & 0xFF) << 8) | ((buf[114] & 0xFF) << 16) | ((buf[115] & 0xFF) << 24));   // Degrees Compass heading.
			float rate_of_turn 				= tofloat((buf[116] & 0xFF) | ((buf[117] & 0xFF) << 8) | ((buf[118] & 0xFF) << 16) | ((buf[119] & 0xFF) << 24));   // Deg/sec Rate of turn
			float airpressure 				= tofloat((buf[120] & 0xFF) | ((buf[121] & 0xFF) << 8) | ((buf[122] & 0xFF) << 16) | ((buf[123] & 0xFF) << 24));   // pascal Local air pressure (at aircraft altitude)
			float density 					= tofloat((buf[124] & 0xFF) | ((buf[125] & 0xFF) << 8) | ((buf[126] & 0xFF) << 16) | ((buf[127] & 0xFF) << 24));   // Air density at aircraft altitude
			float temperature 				= tofloat((buf[128] & 0xFF) | ((buf[129] & 0xFF) << 8) | ((buf[130] & 0xFF) << 16) | ((buf[131] & 0xFF) << 24));   // Celcius Air temperature at aircraft altitude

			dataPack(ID_BODY_NORMAL_ACCELERATION = setFloat(ID_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC4, az), 0); /* check data */
			dataPack(ID_BODY_PITCH_ANGLE = setFloat(ID_BODY_PITCH_ANGLE, NODE_AHRS, SC4, pitch), 0); /* degrees pitch */
			dataPack(ID_BODY_ROLL_ANGLE = setFloat(ID_BODY_ROLL_ANGLE, NODE_AHRS, SC4, roll), 0); /* degrees bank */
			dataPack(ID_BODY_YAW_RATE = setFloat(ID_BODY_YAW_RATE, NODE_AHRS, SC4, yaw), 0); /* degrees yaw */
			dataPack(ID_BARO_CORRECTED_ALTITUDE = setFloat(ID_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC4, altitude_msl), 0); /* meters asl */
			dataPack(ID_BARO_CORRECTION = setFloat(ID_BARO_CORRECTION, NODE_AHRS, SC4, airpressure), 0); /* CANAerospace hPa */
			dataPack(ID_INDICATED_AIRSPEED = setFloat(ID_INDICATED_AIRSPEED, NODE_AHRS, SC4, v_eas), 0); /* indicated airspeed m/s */
			dataPack(ID_MAGNETIC_HEADING = setFloat(ID_MAGNETIC_HEADING, NODE_AHRS, SC4, heading), 0); /* compass degrees */
			dataPack(ID_TURN_COORDINATION_RATE = setFloat(ID_TURN_COORDINATION_RATE, NODE_AHRS, SC4, rate_of_turn / 5.0f), 0); /* rate of turn */
			dataPack(ID_BODY_SIDESLIP = setFloat(ID_BODY_SIDESLIP, NODE_AHRS, SC4, angle_sideslip * 5.0f), 0); /* sideslip ball */
			dataPack(ID_ALTITUDE_RATE = setFloat(ID_ALTITUDE_RATE, NODE_AHRS, SC4, vario), 0); /* check data */
			dataPack(ID_COMPUTED_VERTICAL_VELOCITY = setFloat(ID_COMPUTED_VERTICAL_VELOCITY, NODE_AHRS, SC4, vario), 0); /* check data */
			dataPack(ID_VHF_1_COM_FREQUENCY = setFloat(ID_VHF_1_COM_FREQUENCY, NODE_AHRS, SC4, 127.30f), 0); /* fixed data */

			i++;
			i = i % 16;

		}
    
    }

	/* pack reset data */
	dataPack(ID_BODY_NORMAL_ACCELERATION = setFloat(ID_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_PITCH_ANGLE = setFloat(ID_BODY_PITCH_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_ROLL_ANGLE = setFloat(ID_BODY_ROLL_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_YAW_RATE = setFloat(ID_BODY_YAW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BARO_CORRECTED_ALTITUDE = setFloat(ID_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BARO_CORRECTION = setFloat(ID_BARO_CORRECTION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INDICATED_AIRSPEED = setFloat(ID_INDICATED_AIRSPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_MAGNETIC_HEADING = setFloat(ID_MAGNETIC_HEADING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TURN_COORDINATION_RATE = setFloat(ID_TURN_COORDINATION_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_SIDESLIP = setFloat(ID_BODY_SIDESLIP, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ALTITUDE_RATE = setFloat(ID_ALTITUDE_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COMPUTED_VERTICAL_VELOCITY = setFloat(ID_COMPUTED_VERTICAL_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VHF_1_COM_FREQUENCY = setFloat(ID_VHF_1_COM_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);

	/* exit wrapper */
    close(sockcan);
	printf("\nWrapper exit\n");
	exit(0);
	
}