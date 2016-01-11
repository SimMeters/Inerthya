/*
 * Copyright(c) 2014 Simmeters. All Rights Reserved. GPL License.
 * @(#) udpwrapper.c RTM 1.0 01/01/2014 (Generic UDP to CANBus wrapper version 1.0 armhf)
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
	printf("SimMeters Inerthya System(tm) [Generic UDP data wrapper]\n");
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
	serveraddr.sin_port = htons(6060);														/* asign 6061 port */							
	bind(sockudp, (struct sockaddr *) &serveraddr, sizeof(serveraddr)); 					/* bind udp socket with a port */
	printf("Wrapper running on port UDP 6060 and can-if can0, exit program with CTRL+c\n");
	
    while(optval) {
		
		/* read udp data */
		bzero(buf, BUFSIZE);
		nbytes = recvfrom(sockudp, buf, BUFSIZE, 0,(struct sockaddr *) &clientaddr, &clientlen);
		if (nbytes > 0) {

			printf("Syncing data UDP%cCANBus %i byte(s)\r", spinner[i], nbytes);		
			char *fldata = strtok_r(buf, ";", &end_str);	
			while(fldata != NULL) {
	
				key = strtok_r(fldata, "=", &end_token);	
			
				if(!strcmp(key, "ID_LAMPS_0_31")) {
					dataPack(ID_LAMPS_0_31 = setUint32(ID_LAMPS_0_31, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_32_63")) {
					dataPack(ID_LAMPS_32_63 = setUint32(ID_LAMPS_32_63, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_64_95")) {
					dataPack(ID_LAMPS_64_95 = setUint32(ID_LAMPS_64_95, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_96_127")) {
					dataPack(ID_LAMPS_96_127 = setUint32(ID_LAMPS_96_127, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_128_159")) {
					dataPack(ID_LAMPS_128_159 = setUint32(ID_LAMPS_128_159, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_160_191")) {
					dataPack(ID_LAMPS_160_191 = setUint32(ID_LAMPS_160_191, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_192_223")) {
					dataPack(ID_LAMPS_192_223 = setUint32(ID_LAMPS_192_223, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LAMPS_224_255")) {
					dataPack(ID_LAMPS_224_255 = setUint32(ID_LAMPS_224_255, NODE_AHRS, SC4, atoi(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_LONGITUDINAL_ACCELERATION")) {
					dataPack(ID_BODY_LONGITUDINAL_ACCELERATION = setFloat(ID_BODY_LONGITUDINAL_ACCELERATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_LATERAL_ACCELERATION")) {
					dataPack(ID_BODY_LATERAL_ACCELERATION = setFloat(ID_BODY_LATERAL_ACCELERATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_NORMAL_ACCELERATION")) {
					dataPack(ID_BODY_NORMAL_ACCELERATION = setFloat(ID_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_PITCH_RATE")) {
					dataPack(ID_BODY_PITCH_RATE = setFloat(ID_BODY_PITCH_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_ROLL_RATE")) {
					dataPack(ID_BODY_ROLL_RATE = setFloat(ID_BODY_ROLL_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_YAW_RATE")) {
					dataPack(ID_BODY_YAW_RATE = setFloat(ID_BODY_YAW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_RUDDER_POSITION")) {
					dataPack(ID_RUDDER_POSITION = setFloat(ID_RUDDER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_STABILIZER_POSITION")) {
					dataPack(ID_STABILIZER_POSITION = setFloat(ID_STABILIZER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ELEVATOR_POSITION")) {
					dataPack(ID_ELEVATOR_POSITION = setFloat(ID_ELEVATOR_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LEFT_AILERON_POSITION")) {
					dataPack(ID_LEFT_AILERON_POSITION = setFloat(ID_LEFT_AILERON_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_RIGHT_AILERON_POSITION")) {
					dataPack(ID_RIGHT_AILERON_POSITION = setFloat(ID_RIGHT_AILERON_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_PITCH_ANGLE")) {
					dataPack(ID_BODY_PITCH_ANGLE = setFloat(ID_BODY_PITCH_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_ROLL_ANGLE")) {
					dataPack(ID_BODY_ROLL_ANGLE = setFloat(ID_BODY_ROLL_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_SIDESLIP")) {
					dataPack(ID_BODY_SIDESLIP = setFloat(ID_BODY_SIDESLIP, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ALTITUDE_RATE")) {
					dataPack(ID_ALTITUDE_RATE = setFloat(ID_ALTITUDE_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INDICATED_AIRSPEED")) {
					dataPack(ID_INDICATED_AIRSPEED = setFloat(ID_INDICATED_AIRSPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRUE_AIRSPEED")) {
					dataPack(ID_TRUE_AIRSPEED = setFloat(ID_TRUE_AIRSPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_CALIBRATED_AIRSPEED")) {
					dataPack(ID_CALIBRATED_AIRSPEED = setFloat(ID_CALIBRATED_AIRSPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_MACH_NUMBER")) {
					dataPack(ID_MACH_NUMBER = setFloat(ID_MACH_NUMBER, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BARO_CORRECTION")) {
					dataPack(ID_BARO_CORRECTION = setFloat(ID_BARO_CORRECTION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BARO_CORRECTED_ALTITUDE")) {
					dataPack(ID_BARO_CORRECTED_ALTITUDE = setFloat(ID_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HEADING_ANGLE")) {
					dataPack(ID_HEADING_ANGLE = setFloat(ID_HEADING_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_STANDARD_ALTITUDE")) {
					dataPack(ID_STANDARD_ALTITUDE = setFloat(ID_STANDARD_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TOTAL_AIR_TEMPERATURE")) {
					dataPack(ID_TOTAL_AIR_TEMPERATURE = setFloat(ID_TOTAL_AIR_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_STATIC_AIR_TEMPERATURE")) {
					dataPack(ID_STATIC_AIR_TEMPERATURE = setFloat(ID_STATIC_AIR_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DIFFERENTIAL_PRESSURE")) {
					dataPack(ID_DIFFERENTIAL_PRESSURE = setFloat(ID_DIFFERENTIAL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_STATIC_PRESSURE")) {
					dataPack(ID_STATIC_PRESSURE = setFloat(ID_STATIC_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HEADING_RATE")) {
					dataPack(ID_HEADING_RATE = setFloat(ID_HEADING_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PORT_SIDE_ANGLE_OF_ATTACK")) {
					dataPack(ID_PORT_SIDE_ANGLE_OF_ATTACK = setFloat(ID_PORT_SIDE_ANGLE_OF_ATTACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_STARBORD_SIDE_ANGLE_OF_ATTACK")) {
					dataPack(ID_STARBORD_SIDE_ANGLE_OF_ATTACK = setFloat(ID_STARBORD_SIDE_ANGLE_OF_ATTACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DENSITY_ALTITUDE")) {
					dataPack(ID_DENSITY_ALTITUDE = setFloat(ID_DENSITY_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TURN_COORDINATION_RATE")) {
					dataPack(ID_TURN_COORDINATION_RATE = setFloat(ID_TURN_COORDINATION_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRUE_ALTITUDE")) {
					dataPack(ID_TRUE_ALTITUDE = setFloat(ID_TRUE_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_WIND_SPEED")) {
					dataPack(ID_WIND_SPEED = setFloat(ID_WIND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_WIND_DIRECTION")) {
					dataPack(ID_WIND_DIRECTION = setFloat(ID_WIND_DIRECTION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_OUTSIDE_AIR_TEMPERATURE")) {
					dataPack(ID_OUTSIDE_AIR_TEMPERATURE = setFloat(ID_OUTSIDE_AIR_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_NORMAL_VELOCITY")) {
					dataPack(ID_BODY_NORMAL_VELOCITY = setFloat(ID_BODY_NORMAL_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_LONGITUDINAL_VELOCITY")) {
					dataPack(ID_BODY_LONGITUDINAL_VELOCITY = setFloat(ID_BODY_LONGITUDINAL_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_BODY_LATERAL_VELOCITY")) {
					dataPack(ID_BODY_LATERAL_VELOCITY = setFloat(ID_BODY_LATERAL_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TOTAL_PRESSURE")) {
					dataPack(ID_TOTAL_PRESSURE = setFloat(ID_TOTAL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PITCH_CONTROL_POSITION")) {
					dataPack(ID_PITCH_CONTROL_POSITION = setFloat(ID_PITCH_CONTROL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ROLL_CONTROL_POSITION")) {
					dataPack(ID_ROLL_CONTROL_POSITION = setFloat(ID_ROLL_CONTROL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LATERAL_STICK_TRIM_POSITION_COMMAND")) {
					dataPack(ID_LATERAL_STICK_TRIM_POSITION_COMMAND = setFloat(ID_LATERAL_STICK_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_YAW_CONTROL_POSITION")) {
					dataPack(ID_YAW_CONTROL_POSITION = setFloat(ID_YAW_CONTROL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COLLECTIVE_CONTROL_POSITION")) {
					dataPack(ID_COLLECTIVE_CONTROL_POSITION = setFloat(ID_COLLECTIVE_CONTROL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LONGITUDINAL_STICK_TRIM_POSITION_COMMAND")) {
					dataPack(ID_LONGITUDINAL_STICK_TRIM_POSITION_COMMAND = setFloat(ID_LONGITUDINAL_STICK_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DIRECTIONAL_PEDALS_TRIM_POSITION_COMMAND")) {
					dataPack(ID_DIRECTIONAL_PEDALS_TRIM_POSITION_COMMAND = setFloat(ID_DIRECTIONAL_PEDALS_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COLLECTIVE_LEVER_TRIM_POSITION_COMMAND")) {
					dataPack(ID_COLLECTIVE_LEVER_TRIM_POSITION_COMMAND = setFloat(ID_COLLECTIVE_LEVER_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_CYCLIC_CONTROL_STICK_SWITCHES")) {
					dataPack(ID_CYCLIC_CONTROL_STICK_SWITCHES = setFloat(ID_CYCLIC_CONTROL_STICK_SWITCHES, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LATERAL_TRIM_SPEED")) {
					dataPack(ID_LATERAL_TRIM_SPEED = setFloat(ID_LATERAL_TRIM_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LONGITUDINAL_TRIM_SPEED")) {
					dataPack(ID_LONGITUDINAL_TRIM_SPEED = setFloat(ID_LONGITUDINAL_TRIM_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PEDAL_TRIM_SPEED")) {
					dataPack(ID_PEDAL_TRIM_SPEED = setFloat(ID_PEDAL_TRIM_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COLLECTIVE_TRIM_SPEED")) {
					dataPack(ID_COLLECTIVE_TRIM_SPEED = setFloat(ID_COLLECTIVE_TRIM_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NOSE_WHEEL_STEERING_HANDLE_POSITION")) {
					dataPack(ID_NOSE_WHEEL_STEERING_HANDLE_POSITION = setFloat(ID_NOSE_WHEEL_STEERING_HANDLE_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FLAPS_LEVER_POSITION")) {
					dataPack(ID_FLAPS_LEVER_POSITION = setFloat(ID_FLAPS_LEVER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_SLATS_LEVER_POSITION")) {
					dataPack(ID_SLATS_LEVER_POSITION = setFloat(ID_SLATS_LEVER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PARK_BRAKE_LEVER_POSITION")) {
					dataPack(ID_PARK_BRAKE_LEVER_POSITION = setFloat(ID_PARK_BRAKE_LEVER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_SPEEDBRAKE_LEVER_POSITION")) {
					dataPack(ID_SPEEDBRAKE_LEVER_POSITION = setFloat(ID_SPEEDBRAKE_LEVER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_THROTTLE_MAX_LEVER_POSITION")) {
					dataPack(ID_THROTTLE_MAX_LEVER_POSITION = setFloat(ID_THROTTLE_MAX_LEVER_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PILOT_LEFT_BRAKE_PEDAL_POSITION")) {
					dataPack(ID_PILOT_LEFT_BRAKE_PEDAL_POSITION = setFloat(ID_PILOT_LEFT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PILOT_RIGHT_BRAKE_PEDAL_POSITION")) {
					dataPack(ID_PILOT_RIGHT_BRAKE_PEDAL_POSITION = setFloat(ID_PILOT_RIGHT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COPILOT_LEFT_BRAKE_PEDAL_POSITION")) {
					dataPack(ID_COPILOT_LEFT_BRAKE_PEDAL_POSITION = setFloat(ID_COPILOT_LEFT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COPILOT_RIGHT_BRAKE_PEDAL_POSITION")) {
					dataPack(ID_COPILOT_RIGHT_BRAKE_PEDAL_POSITION = setFloat(ID_COPILOT_RIGHT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRIM_SYSTEM_SWITCHES")) {
					dataPack(ID_TRIM_SYSTEM_SWITCHES = setFloat(ID_TRIM_SYSTEM_SWITCHES, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRIM_SYSTEM_LIGHTS")) {
					dataPack(ID_TRIM_SYSTEM_LIGHTS = setFloat(ID_TRIM_SYSTEM_LIGHTS, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COLLECTIVE_CONTROL_STICK_SWITCHES")) {
					dataPack(ID_COLLECTIVE_CONTROL_STICK_SWITCHES = setFloat(ID_COLLECTIVE_CONTROL_STICK_SWITCHES, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_STICK_SHAKER_STALL_WARNING_DEVICE")) {
					dataPack(ID_STICK_SHAKER_STALL_WARNING_DEVICE = setFloat(ID_STICK_SHAKER_STALL_WARNING_DEVICE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_N1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_N1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_N1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_N1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_N2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_N2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_N2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_N2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_TORQUE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_TORQUE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_TORQUE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_TORQUE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_STATUS_1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_STATUS_1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_STATUS_1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_STATUS_1_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_STATUS_2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_STATUS_2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_STATUS_2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_STATUS_2_ECS_CHANNEL_A")) {
					dataPack(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_N1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_N1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_N1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_N1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_N2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_N2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_N2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_N2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_TORQUE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_TORQUE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_TORQUE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_TORQUE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_STATUS_1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_STATUS_1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_STATUS_1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_STATUS_1_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_1_STATUS_2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_2_STATUS_2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_3_STATUS_2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ENGINE_4_STATUS_2_ECS_CHANNEL_B")) {
					dataPack(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_1_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_1_FLOW_RATE = setFloat(ID_FUEL_PUMP_1_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_2_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_2_FLOW_RATE = setFloat(ID_FUEL_PUMP_2_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_3_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_3_FLOW_RATE = setFloat(ID_FUEL_PUMP_3_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_4_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_4_FLOW_RATE = setFloat(ID_FUEL_PUMP_4_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_5_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_5_FLOW_RATE = setFloat(ID_FUEL_PUMP_5_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_6_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_6_FLOW_RATE = setFloat(ID_FUEL_PUMP_6_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_7_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_7_FLOW_RATE = setFloat(ID_FUEL_PUMP_7_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_PUMP_8_FLOW_RATE")) {
					dataPack(ID_FUEL_PUMP_8_FLOW_RATE = setFloat(ID_FUEL_PUMP_8_FLOW_RATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_1_QUANTITY")) {
					dataPack(ID_FUEL_TANK_1_QUANTITY = setFloat(ID_FUEL_TANK_1_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_2_QUANTITY")) {
					dataPack(ID_FUEL_TANK_2_QUANTITY = setFloat(ID_FUEL_TANK_2_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_3_QUANTITY")) {
					dataPack(ID_FUEL_TANK_3_QUANTITY = setFloat(ID_FUEL_TANK_3_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_4_QUANTITY")) {
					dataPack(ID_FUEL_TANK_4_QUANTITY = setFloat(ID_FUEL_TANK_4_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_5_QUANTITY")) {
					dataPack(ID_FUEL_TANK_5_QUANTITY = setFloat(ID_FUEL_TANK_5_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_6_QUANTITY")) {
					dataPack(ID_FUEL_TANK_6_QUANTITY = setFloat(ID_FUEL_TANK_6_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_7_QUANTITY")) {
					dataPack(ID_FUEL_TANK_7_QUANTITY = setFloat(ID_FUEL_TANK_7_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_8_QUANTITY")) {
					dataPack(ID_FUEL_TANK_8_QUANTITY = setFloat(ID_FUEL_TANK_8_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_1_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_1_TEMPERATURE = setFloat(ID_FUEL_TANK_1_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_2_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_2_TEMPERATURE = setFloat(ID_FUEL_TANK_2_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_3_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_3_TEMPERATURE = setFloat(ID_FUEL_TANK_3_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_4_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_4_TEMPERATURE = setFloat(ID_FUEL_TANK_4_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_5_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_5_TEMPERATURE = setFloat(ID_FUEL_TANK_5_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_6_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_6_TEMPERATURE = setFloat(ID_FUEL_TANK_6_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_7_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_7_TEMPERATURE = setFloat(ID_FUEL_TANK_7_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_TANK_8_TEMPERATURE")) {
					dataPack(ID_FUEL_TANK_8_TEMPERATURE = setFloat(ID_FUEL_TANK_8_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_1_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_1_PRESSURE = setFloat(ID_FUEL_SYSTEM_1_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_2_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_2_PRESSURE = setFloat(ID_FUEL_SYSTEM_2_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_3_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_3_PRESSURE = setFloat(ID_FUEL_SYSTEM_3_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_4_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_4_PRESSURE = setFloat(ID_FUEL_SYSTEM_4_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_5_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_5_PRESSURE = setFloat(ID_FUEL_SYSTEM_5_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_6_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_6_PRESSURE = setFloat(ID_FUEL_SYSTEM_6_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_7_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_7_PRESSURE = setFloat(ID_FUEL_SYSTEM_7_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FUEL_SYSTEM_8_PRESSURE")) {
					dataPack(ID_FUEL_SYSTEM_8_PRESSURE = setFloat(ID_FUEL_SYSTEM_8_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ROTOR_1_RPM")) {
					dataPack(ID_ROTOR_1_RPM = setFloat(ID_ROTOR_1_RPM, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ROTOR_2_RPM")) {
					dataPack(ID_ROTOR_2_RPM = setFloat(ID_ROTOR_2_RPM, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ROTOR_3_RPM")) {
					dataPack(ID_ROTOR_3_RPM = setFloat(ID_ROTOR_3_RPM, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ROTOR_4_RPM")) {
					dataPack(ID_ROTOR_4_RPM = setFloat(ID_ROTOR_4_RPM, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_1_SPEED")) {
					dataPack(ID_GEARBOX_1_SPEED = setFloat(ID_GEARBOX_1_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_2_SPEED")) {
					dataPack(ID_GEARBOX_2_SPEED = setFloat(ID_GEARBOX_2_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_3_SPEED")) {
					dataPack(ID_GEARBOX_3_SPEED = setFloat(ID_GEARBOX_3_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_4_SPEED")) {
					dataPack(ID_GEARBOX_4_SPEED = setFloat(ID_GEARBOX_4_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_5_SPEED")) {
					dataPack(ID_GEARBOX_5_SPEED = setFloat(ID_GEARBOX_5_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_6_SPEED")) {
					dataPack(ID_GEARBOX_6_SPEED = setFloat(ID_GEARBOX_6_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_7_SPEED")) {
					dataPack(ID_GEARBOX_7_SPEED = setFloat(ID_GEARBOX_7_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_8_SPEED")) {
					dataPack(ID_GEARBOX_8_SPEED = setFloat(ID_GEARBOX_8_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_1_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_1_OIL_PRESSURE = setFloat(ID_GEARBOX_1_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_2_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_2_OIL_PRESSURE = setFloat(ID_GEARBOX_2_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_3_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_3_OIL_PRESSURE = setFloat(ID_GEARBOX_3_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_4_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_4_OIL_PRESSURE = setFloat(ID_GEARBOX_4_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_5_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_5_OIL_PRESSURE = setFloat(ID_GEARBOX_5_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_6_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_6_OIL_PRESSURE = setFloat(ID_GEARBOX_6_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_7_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_7_OIL_PRESSURE = setFloat(ID_GEARBOX_7_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_8_OIL_PRESSURE")) {
					dataPack(ID_GEARBOX_8_OIL_PRESSURE = setFloat(ID_GEARBOX_8_OIL_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_1_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_1_OIL_TEMPERATURE = setFloat(ID_GEARBOX_1_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_2_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_2_OIL_TEMPERATURE = setFloat(ID_GEARBOX_2_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_3_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_3_OIL_TEMPERATURE = setFloat(ID_GEARBOX_3_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_4_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_4_OIL_TEMPERATURE = setFloat(ID_GEARBOX_4_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_5_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_5_OIL_TEMPERATURE = setFloat(ID_GEARBOX_5_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_6_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_6_OIL_TEMPERATURE = setFloat(ID_GEARBOX_6_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_7_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_7_OIL_TEMPERATURE = setFloat(ID_GEARBOX_7_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_8_OIL_TEMPERATURE")) {
					dataPack(ID_GEARBOX_8_OIL_TEMPERATURE = setFloat(ID_GEARBOX_8_OIL_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_1_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_1_OIL_QUANTITY = setFloat(ID_GEARBOX_1_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_2_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_2_OIL_QUANTITY = setFloat(ID_GEARBOX_2_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_3_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_3_OIL_QUANTITY = setFloat(ID_GEARBOX_3_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_4_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_4_OIL_QUANTITY = setFloat(ID_GEARBOX_4_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_5_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_5_OIL_QUANTITY = setFloat(ID_GEARBOX_5_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_6_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_6_OIL_QUANTITY = setFloat(ID_GEARBOX_6_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_7_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_7_OIL_QUANTITY = setFloat(ID_GEARBOX_7_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEARBOX_8_OIL_QUANTITY")) {
					dataPack(ID_GEARBOX_8_OIL_QUANTITY = setFloat(ID_GEARBOX_8_OIL_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_1_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_1_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_1_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_2_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_2_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_2_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_3_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_3_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_3_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_4_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_4_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_4_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_5_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_5_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_5_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_6_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_6_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_6_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_7_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_7_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_7_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_8_PRESSURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_8_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_8_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_1_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_1_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_1_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_2_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_2_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_2_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_3_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_3_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_3_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_4_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_4_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_4_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_5_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_5_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_5_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_6_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_6_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_6_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_7_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_7_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_7_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_8_FLUID_TEMPERATURE")) {
					dataPack(ID_HYDRAULIC_SYSTEM_8_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_8_FLUID_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_1_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_1_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_1_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_2_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_2_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_2_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_3_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_3_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_3_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_4_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_4_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_4_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_5_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_5_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_5_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_6_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_6_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_6_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_7_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_7_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_7_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_HYDRAULIC_SYSTEM_8_FLUID_QUANTITY")) {
					dataPack(ID_HYDRAULIC_SYSTEM_8_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_8_FLUID_QUANTITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_1_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_1_VOLTAGE = setFloat(ID_AC_SYSTEM_1_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_2_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_2_VOLTAGE = setFloat(ID_AC_SYSTEM_2_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_3_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_3_VOLTAGE = setFloat(ID_AC_SYSTEM_3_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_4_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_4_VOLTAGE = setFloat(ID_AC_SYSTEM_4_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_5_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_5_VOLTAGE = setFloat(ID_AC_SYSTEM_5_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_6_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_6_VOLTAGE = setFloat(ID_AC_SYSTEM_6_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_7_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_7_VOLTAGE = setFloat(ID_AC_SYSTEM_7_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_8_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_8_VOLTAGE = setFloat(ID_AC_SYSTEM_8_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_9_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_9_VOLTAGE = setFloat(ID_AC_SYSTEM_9_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_10_VOLTAGE")) {
					dataPack(ID_AC_SYSTEM_10_VOLTAGE = setFloat(ID_AC_SYSTEM_10_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_1_CURRENT")) {
					dataPack(ID_AC_SYSTEM_1_CURRENT = setFloat(ID_AC_SYSTEM_1_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_2_CURRENT")) {
					dataPack(ID_AC_SYSTEM_2_CURRENT = setFloat(ID_AC_SYSTEM_2_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_3_CURRENT")) {
					dataPack(ID_AC_SYSTEM_3_CURRENT = setFloat(ID_AC_SYSTEM_3_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_4_CURRENT")) {
					dataPack(ID_AC_SYSTEM_4_CURRENT = setFloat(ID_AC_SYSTEM_4_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_5_CURRENT")) {
					dataPack(ID_AC_SYSTEM_5_CURRENT = setFloat(ID_AC_SYSTEM_5_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_6_CURRENT")) {
					dataPack(ID_AC_SYSTEM_6_CURRENT = setFloat(ID_AC_SYSTEM_6_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_7_CURRENT")) {
					dataPack(ID_AC_SYSTEM_7_CURRENT = setFloat(ID_AC_SYSTEM_7_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_8_CURRENT")) {
					dataPack(ID_AC_SYSTEM_8_CURRENT = setFloat(ID_AC_SYSTEM_8_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_9_CURRENT")) {
					dataPack(ID_AC_SYSTEM_9_CURRENT = setFloat(ID_AC_SYSTEM_9_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AC_SYSTEM_10_CURRENT")) {
					dataPack(ID_AC_SYSTEM_10_CURRENT = setFloat(ID_AC_SYSTEM_10_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_1_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_1_VOLTAGE = setFloat(ID_DC_SYSTEM_1_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_2_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_2_VOLTAGE = setFloat(ID_DC_SYSTEM_2_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_3_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_3_VOLTAGE = setFloat(ID_DC_SYSTEM_3_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_4_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_4_VOLTAGE = setFloat(ID_DC_SYSTEM_4_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_5_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_5_VOLTAGE = setFloat(ID_DC_SYSTEM_5_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_6_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_6_VOLTAGE = setFloat(ID_DC_SYSTEM_6_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_7_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_7_VOLTAGE = setFloat(ID_DC_SYSTEM_7_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_8_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_8_VOLTAGE = setFloat(ID_DC_SYSTEM_8_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_9_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_9_VOLTAGE = setFloat(ID_DC_SYSTEM_9_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_10_VOLTAGE")) {
					dataPack(ID_DC_SYSTEM_10_VOLTAGE = setFloat(ID_DC_SYSTEM_10_VOLTAGE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_1_CURRENT")) {
					dataPack(ID_DC_SYSTEM_1_CURRENT = setFloat(ID_DC_SYSTEM_1_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_2_CURRENT")) {
					dataPack(ID_DC_SYSTEM_2_CURRENT = setFloat(ID_DC_SYSTEM_2_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_3_CURRENT")) {
					dataPack(ID_DC_SYSTEM_3_CURRENT = setFloat(ID_DC_SYSTEM_3_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_4_CURRENT")) {
					dataPack(ID_DC_SYSTEM_4_CURRENT = setFloat(ID_DC_SYSTEM_4_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_5_CURRENT")) {
					dataPack(ID_DC_SYSTEM_5_CURRENT = setFloat(ID_DC_SYSTEM_5_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_6_CURRENT")) {
					dataPack(ID_DC_SYSTEM_6_CURRENT = setFloat(ID_DC_SYSTEM_6_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_7_CURRENT")) {
					dataPack(ID_DC_SYSTEM_7_CURRENT = setFloat(ID_DC_SYSTEM_7_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_8_CURRENT")) {
					dataPack(ID_DC_SYSTEM_8_CURRENT = setFloat(ID_DC_SYSTEM_8_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_9_CURRENT")) {
					dataPack(ID_DC_SYSTEM_9_CURRENT = setFloat(ID_DC_SYSTEM_9_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DC_SYSTEM_10_CURRENT")) {
					dataPack(ID_DC_SYSTEM_10_CURRENT = setFloat(ID_DC_SYSTEM_10_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_1_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_1_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_1_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_2_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_2_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_2_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_3_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_3_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_3_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_4_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_4_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_4_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_5_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_5_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_5_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_6_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_6_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_6_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_7_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_7_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_7_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_8_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_8_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_8_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_9_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_9_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_9_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_PROP_10_ICEGUARD_DC_CURRENT")) {
					dataPack(ID_PROP_10_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_10_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LATITUDE")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LATITUDE = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LATITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LONGITUDE")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LONGITUDE = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LONGITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_WAYPOINT_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_WAYPOINT_ALTITUDE")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_ALTITUDE = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_GROUND_SPEED")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_GROUND_SPEED = setFloat(ID_ACTIVE_NAV_SYSTEM_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_TRUE_TRACK")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_TRUE_TRACK = setFloat(ID_ACTIVE_NAV_SYSTEM_TRUE_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_MAGNETIC_TRACK")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_MAGNETIC_TRACK = setFloat(ID_ACTIVE_NAV_SYSTEM_MAGNETIC_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_CROSS_TRACK_ERROR")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_CROSS_TRACK_ERROR = setFloat(ID_ACTIVE_NAV_SYSTEM_CROSS_TRACK_ERROR, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_TRACK_ERROR_ANGLE")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_TRACK_ERROR_ANGLE = setFloat(ID_ACTIVE_NAV_SYSTEM_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_TIME_TO_GO")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_TIME_TO_GO = setFloat(ID_ACTIVE_NAV_SYSTEM_TIME_TO_GO, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_ESTIMATED_TIME_OF_ARRIVAL")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_TIME_OF_ARRIVAL = setFloat(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_TIME_OF_ARRIVAL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ACTIVE_NAV_SYSTEM_ESTIMATED_ENROUTE_TIME")) {
					dataPack(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_ENROUTE_TIME = setFloat(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_ENROUTE_TIME, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_IDENTIFIER_0_3")) {
					dataPack(ID_NAV_WAYPOINT_IDENTIFIER_0_3 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_0_3, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_IDENTIFIER_4_7")) {
					dataPack(ID_NAV_WAYPOINT_IDENTIFIER_4_7 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_4_7, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_IDENTIFIER_8_11")) {
					dataPack(ID_NAV_WAYPOINT_IDENTIFIER_8_11 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_8_11, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_IDENTIFIER_12_15")) {
					dataPack(ID_NAV_WAYPOINT_IDENTIFIER_12_15 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_12_15, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_TYPE_IDENTIFIER")) {
					dataPack(ID_NAV_WAYPOINT_TYPE_IDENTIFIER = setFloat(ID_NAV_WAYPOINT_TYPE_IDENTIFIER, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_LATITUDE")) {
					dataPack(ID_NAV_WAYPOINT_LATITUDE = setFloat(ID_NAV_WAYPOINT_LATITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_LONGITUDE")) {
					dataPack(ID_NAV_WAYPOINT_LONGITUDE = setFloat(ID_NAV_WAYPOINT_LONGITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MINIMUM_ALTITUDE")) {
					dataPack(ID_NAV_WAYPOINT_MINIMUM_ALTITUDE = setFloat(ID_NAV_WAYPOINT_MINIMUM_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MINIMUM_FLIGHT_LEVEL")) {
					dataPack(ID_NAV_WAYPOINT_MINIMUM_FLIGHT_LEVEL = setFloat(ID_NAV_WAYPOINT_MINIMUM_FLIGHT_LEVEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MINIMUM_RADAR_HEIGHT")) {
					dataPack(ID_NAV_WAYPOINT_MINIMUM_RADAR_HEIGHT = setFloat(ID_NAV_WAYPOINT_MINIMUM_RADAR_HEIGHT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MINIMUM_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_NAV_WAYPOINT_MINIMUM_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_NAV_WAYPOINT_MINIMUM_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MAXIMUM_ALTITUDE")) {
					dataPack(ID_NAV_WAYPOINT_MAXIMUM_ALTITUDE = setFloat(ID_NAV_WAYPOINT_MAXIMUM_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MAXIMUM_FLIGHT_LEVEL")) {
					dataPack(ID_NAV_WAYPOINT_MAXIMUM_FLIGHT_LEVEL = setFloat(ID_NAV_WAYPOINT_MAXIMUM_FLIGHT_LEVEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MAXIMUM_RADAR_HEIGHT")) {
					dataPack(ID_NAV_WAYPOINT_MAXIMUM_RADAR_HEIGHT = setFloat(ID_NAV_WAYPOINT_MAXIMUM_RADAR_HEIGHT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_MAXIMUM_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_NAV_WAYPOINT_MAXIMUM_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_NAV_WAYPOINT_MAXIMUM_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_PLANNED_ALTITUDE")) {
					dataPack(ID_NAV_WAYPOINT_PLANNED_ALTITUDE = setFloat(ID_NAV_WAYPOINT_PLANNED_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_PLANNED_FLIGHT_LEVEL")) {
					dataPack(ID_NAV_WAYPOINT_PLANNED_FLIGHT_LEVEL = setFloat(ID_NAV_WAYPOINT_PLANNED_FLIGHT_LEVEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_PLANNED_RADAR_HEIGHT")) {
					dataPack(ID_NAV_WAYPOINT_PLANNED_RADAR_HEIGHT = setFloat(ID_NAV_WAYPOINT_PLANNED_RADAR_HEIGHT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_PLANNED_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_NAV_WAYPOINT_PLANNED_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_NAV_WAYPOINT_PLANNED_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DISTANCE_TO_NAV_WAYPOINT")) {
					dataPack(ID_DISTANCE_TO_NAV_WAYPOINT = setFloat(ID_DISTANCE_TO_NAV_WAYPOINT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TIME_TO_GO_TO_NAV_WAYPOINT")) {
					dataPack(ID_TIME_TO_GO_TO_NAV_WAYPOINT = setFloat(ID_TIME_TO_GO_TO_NAV_WAYPOINT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_ESTIMATED_TIME_OF_ARRIVAL")) {
					dataPack(ID_NAV_WAYPOINT_ESTIMATED_TIME_OF_ARRIVAL = setFloat(ID_NAV_WAYPOINT_ESTIMATED_TIME_OF_ARRIVAL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_ESTIMATED_ENROUTE_TIME")) {
					dataPack(ID_NAV_WAYPOINT_ESTIMATED_ENROUTE_TIME = setFloat(ID_NAV_WAYPOINT_ESTIMATED_ENROUTE_TIME, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_NAV_WAYPOINT_STATUS_INFORMATION")) {
					dataPack(ID_NAV_WAYPOINT_STATUS_INFORMATION = setFloat(ID_NAV_WAYPOINT_STATUS_INFORMATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_AIRCRAFT_LATITUDE")) {
					dataPack(ID_GPS_AIRCRAFT_LATITUDE = setFloat(ID_GPS_AIRCRAFT_LATITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_AIRCRAFT_LONGITUDE")) {
					dataPack(ID_GPS_AIRCRAFT_LONGITUDE = setFloat(ID_GPS_AIRCRAFT_LONGITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_GPS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_GPS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_GROUND_SPEED")) {
					dataPack(ID_GPS_GROUND_SPEED = setFloat(ID_GPS_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_TRUE_TRACK")) {
					dataPack(ID_GPS_TRUE_TRACK = setFloat(ID_GPS_TRUE_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_MAGNETIC_TRACK")) {
					dataPack(ID_GPS_MAGNETIC_TRACK = setFloat(ID_GPS_MAGNETIC_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_CROSS_TRACK_ERROR")) {
					dataPack(ID_GPS_CROSS_TRACK_ERROR = setFloat(ID_GPS_CROSS_TRACK_ERROR, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_TRACK_ERROR_ANGLE")) {
					dataPack(ID_GPS_TRACK_ERROR_ANGLE = setFloat(ID_GPS_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_GLIDESLOPE_DEVIATION")) {
					dataPack(ID_GPS_GLIDESLOPE_DEVIATION = setFloat(ID_GPS_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_PREDICTED_RAIM")) {
					dataPack(ID_GPS_PREDICTED_RAIM = setFloat(ID_GPS_PREDICTED_RAIM, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_VERTICAL_FIGURE_OF_MERIT")) {
					dataPack(ID_GPS_VERTICAL_FIGURE_OF_MERIT = setFloat(ID_GPS_VERTICAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_HORIZONTAL_FIGURE_OF_MERIT")) {
					dataPack(ID_GPS_HORIZONTAL_FIGURE_OF_MERIT = setFloat(ID_GPS_HORIZONTAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GPS_MODE_OF_OPERATION")) {
					dataPack(ID_GPS_MODE_OF_OPERATION = setFloat(ID_GPS_MODE_OF_OPERATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_LATITUDE")) {
					dataPack(ID_INS_AIRCRAFT_LATITUDE = setFloat(ID_INS_AIRCRAFT_LATITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_LONGITUDE")) {
					dataPack(ID_INS_AIRCRAFT_LONGITUDE = setFloat(ID_INS_AIRCRAFT_LONGITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_INS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_INS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_GROUND_SPEED")) {
					dataPack(ID_INS_AIRCRAFT_GROUND_SPEED = setFloat(ID_INS_AIRCRAFT_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_TRUE_TRACK")) {
					dataPack(ID_INS_AIRCRAFT_TRUE_TRACK = setFloat(ID_INS_AIRCRAFT_TRUE_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_MAGNETIC_TRACK")) {
					dataPack(ID_INS_AIRCRAFT_MAGNETIC_TRACK = setFloat(ID_INS_AIRCRAFT_MAGNETIC_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_CROSS_TRACK_ERROR")) {
					dataPack(ID_INS_AIRCRAFT_CROSS_TRACK_ERROR = setFloat(ID_INS_AIRCRAFT_CROSS_TRACK_ERROR, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_AIRCRAFT_TRACK_ERROR_ANGLE")) {
					dataPack(ID_INS_AIRCRAFT_TRACK_ERROR_ANGLE = setFloat(ID_INS_AIRCRAFT_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_VERTICAL_FIGURE_OF_MERIT")) {
					dataPack(ID_INS_VERTICAL_FIGURE_OF_MERIT = setFloat(ID_INS_VERTICAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_INS_HORIZONTAL_FIGURE_OF_MERIT")) {
					dataPack(ID_INS_HORIZONTAL_FIGURE_OF_MERIT = setFloat(ID_INS_HORIZONTAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LATITUDE")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LATITUDE = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LATITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LONGITUDE")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LONGITUDE = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LONGITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_GROUND_SPEED")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_GROUND_SPEED = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRUE_TRACK")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRUE_TRACK = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRUE_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_MAGNETIC_TRACK")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_MAGNETIC_TRACK = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_MAGNETIC_TRACK, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_CROSS_TRACK_ERROR")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_CROSS_TRACK_ERROR = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_CROSS_TRACK_ERROR, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRACK_ERROR_ANGLE")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRACK_ERROR_ANGLE = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_VERTICAL_FIGURE_OF_MERIT")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_VERTICAL_FIGURE_OF_MERIT = setFloat(ID_AUXILIARY_NAV_SYSTEM_VERTICAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_AUXILIARY_NAV_SYSTEM_HORIZONTAL_FIGURE_OF_MERIT")) {
					dataPack(ID_AUXILIARY_NAV_SYSTEM_HORIZONTAL_FIGURE_OF_MERIT = setFloat(ID_AUXILIARY_NAV_SYSTEM_HORIZONTAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_MAGNETIC_HEADING")) {
					dataPack(ID_MAGNETIC_HEADING = setFloat(ID_MAGNETIC_HEADING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_RADIO_HEIGHT")) {
					dataPack(ID_RADIO_HEIGHT = setFloat(ID_RADIO_HEIGHT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_1_DISTANCE")) {
					dataPack(ID_DME_1_DISTANCE = setFloat(ID_DME_1_DISTANCE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_2_DISTANCE")) {
					dataPack(ID_DME_2_DISTANCE = setFloat(ID_DME_2_DISTANCE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_3_DISTANCE")) {
					dataPack(ID_DME_3_DISTANCE = setFloat(ID_DME_3_DISTANCE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_4_DISTANCE")) {
					dataPack(ID_DME_4_DISTANCE = setFloat(ID_DME_4_DISTANCE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_1_TIME_TO_GO")) {
					dataPack(ID_DME_1_TIME_TO_GO = setFloat(ID_DME_1_TIME_TO_GO, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_2_TIME_TO_GO")) {
					dataPack(ID_DME_2_TIME_TO_GO = setFloat(ID_DME_2_TIME_TO_GO, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_3_TIME_TO_GO")) {
					dataPack(ID_DME_3_TIME_TO_GO = setFloat(ID_DME_3_TIME_TO_GO, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_4_TIME_TO_GO")) {
					dataPack(ID_DME_4_TIME_TO_GO = setFloat(ID_DME_4_TIME_TO_GO, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_1_GROUND_SPEED")) {
					dataPack(ID_DME_1_GROUND_SPEED = setFloat(ID_DME_1_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_2_GROUND_SPEED")) {
					dataPack(ID_DME_2_GROUND_SPEED = setFloat(ID_DME_2_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_3_GROUND_SPEED")) {
					dataPack(ID_DME_3_GROUND_SPEED = setFloat(ID_DME_3_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_4_GROUND_SPEED")) {
					dataPack(ID_DME_4_GROUND_SPEED = setFloat(ID_DME_4_GROUND_SPEED, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_1_BEARING")) {
					dataPack(ID_ADF_1_BEARING = setFloat(ID_ADF_1_BEARING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_2_BEARING")) {
					dataPack(ID_ADF_2_BEARING = setFloat(ID_ADF_2_BEARING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_3_BEARING")) {
					dataPack(ID_ADF_3_BEARING = setFloat(ID_ADF_3_BEARING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_4_BEARING")) {
					dataPack(ID_ADF_4_BEARING = setFloat(ID_ADF_4_BEARING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_1_LOCALIZE_DEVIATION")) {
					dataPack(ID_ILS_1_LOCALIZE_DEVIATION = setFloat(ID_ILS_1_LOCALIZE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_2_LOCALIZE_DEVIATION")) {
					dataPack(ID_ILS_2_LOCALIZE_DEVIATION = setFloat(ID_ILS_2_LOCALIZE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_3_LOCALIZE_DEVIATION")) {
					dataPack(ID_ILS_3_LOCALIZE_DEVIATION = setFloat(ID_ILS_3_LOCALIZE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_4_LOCALIZE_DEVIATION")) {
					dataPack(ID_ILS_4_LOCALIZE_DEVIATION = setFloat(ID_ILS_4_LOCALIZE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_1_GLIDESLOPE_DEVIATION")) {
					dataPack(ID_ILS_1_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_1_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_2_GLIDESLOPE_DEVIATION")) {
					dataPack(ID_ILS_2_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_2_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_3_GLIDESLOPE_DEVIATION")) {
					dataPack(ID_ILS_3_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_3_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ILS_4_GLIDESLOPE_DEVIATION")) {
					dataPack(ID_ILS_4_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_4_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION")) {
					dataPack(ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FLIGHT_DIRECTOR_2_PITCH_DEVIATION")) {
					dataPack(ID_FLIGHT_DIRECTOR_2_PITCH_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_2_PITCH_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION")) {
					dataPack(ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_FLIGHT_DIRECTOR_2_ROLL_DEVIATION")) {
					dataPack(ID_FLIGHT_DIRECTOR_2_ROLL_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_2_ROLL_DEVIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DECISION_HEIGHT")) {
					dataPack(ID_DECISION_HEIGHT = setFloat(ID_DECISION_HEIGHT, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VHF_1_COM_FREQUENCY")) {
					dataPack(ID_VHF_1_COM_FREQUENCY = setFloat(ID_VHF_1_COM_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VHF_2_COM_FREQUENCY")) {
					dataPack(ID_VHF_2_COM_FREQUENCY = setFloat(ID_VHF_2_COM_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VHF_3_COM_FREQUENCY")) {
					dataPack(ID_VHF_3_COM_FREQUENCY = setFloat(ID_VHF_3_COM_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VHF_4_COM_FREQUENCY")) {
					dataPack(ID_VHF_4_COM_FREQUENCY = setFloat(ID_VHF_4_COM_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_ILS_1_FREQUENCY")) {
					dataPack(ID_VOR_ILS_1_FREQUENCY = setFloat(ID_VOR_ILS_1_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_ILS_2_FREQUENCY")) {
					dataPack(ID_VOR_ILS_2_FREQUENCY = setFloat(ID_VOR_ILS_2_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_ILS_3_FREQUENCY")) {
					dataPack(ID_VOR_ILS_3_FREQUENCY = setFloat(ID_VOR_ILS_3_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_ILS_4_FREQUENCY")) {
					dataPack(ID_VOR_ILS_4_FREQUENCY = setFloat(ID_VOR_ILS_4_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_1_FREQUENCY")) {
					dataPack(ID_ADF_1_FREQUENCY = setFloat(ID_ADF_1_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_2_FREQUENCY")) {
					dataPack(ID_ADF_2_FREQUENCY = setFloat(ID_ADF_2_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_3_FREQUENCY")) {
					dataPack(ID_ADF_3_FREQUENCY = setFloat(ID_ADF_3_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_ADF_4_FREQUENCY")) {
					dataPack(ID_ADF_4_FREQUENCY = setFloat(ID_ADF_4_FREQUENCY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_1_CHANNEL")) {
					dataPack(ID_DME_1_CHANNEL = setFloat(ID_DME_1_CHANNEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_2_CHANNEL")) {
					dataPack(ID_DME_2_CHANNEL = setFloat(ID_DME_2_CHANNEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_3_CHANNEL")) {
					dataPack(ID_DME_3_CHANNEL = setFloat(ID_DME_3_CHANNEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DME_4_CHANNEL")) {
					dataPack(ID_DME_4_CHANNEL = setFloat(ID_DME_4_CHANNEL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRANSPONDER_1_CODE")) {
					dataPack(ID_TRANSPONDER_1_CODE = setFloat(ID_TRANSPONDER_1_CODE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRANSPONDER_2_CODE")) {
					dataPack(ID_TRANSPONDER_2_CODE = setFloat(ID_TRANSPONDER_2_CODE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRANSPONDER_3_CODE")) {
					dataPack(ID_TRANSPONDER_3_CODE = setFloat(ID_TRANSPONDER_3_CODE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRANSPONDER_4_CODE")) {
					dataPack(ID_TRANSPONDER_4_CODE = setFloat(ID_TRANSPONDER_4_CODE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DESIRED_TRACK_ANGLE")) {
					dataPack(ID_DESIRED_TRACK_ANGLE = setFloat(ID_DESIRED_TRACK_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_MAGNETIC_VARIATION")) {
					dataPack(ID_MAGNETIC_VARIATION = setFloat(ID_MAGNETIC_VARIATION, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_SELECTED_GLIDEPATH_ANGLE")) {
					dataPack(ID_SELECTED_GLIDEPATH_ANGLE = setFloat(ID_SELECTED_GLIDEPATH_ANGLE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_SELECTED_RUNWAY_HEADING")) {
					dataPack(ID_SELECTED_RUNWAY_HEADING = setFloat(ID_SELECTED_RUNWAY_HEADING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_COMPUTED_VERTICAL_VELOCITY")) {
					dataPack(ID_COMPUTED_VERTICAL_VELOCITY = setFloat(ID_COMPUTED_VERTICAL_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_SELECTED_COURSE")) {
					dataPack(ID_SELECTED_COURSE = setFloat(ID_SELECTED_COURSE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_1_RADIAL")) {
					dataPack(ID_VOR_1_RADIAL = setFloat(ID_VOR_1_RADIAL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_2_RADIAL")) {
					dataPack(ID_VOR_2_RADIAL = setFloat(ID_VOR_2_RADIAL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_3_RADIAL")) {
					dataPack(ID_VOR_3_RADIAL = setFloat(ID_VOR_3_RADIAL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_VOR_4_RADIAL")) {
					dataPack(ID_VOR_4_RADIAL = setFloat(ID_VOR_4_RADIAL, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRUE_EAST_VELOCITY")) {
					dataPack(ID_TRUE_EAST_VELOCITY = setFloat(ID_TRUE_EAST_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRUE_NORTH_VELOCITY")) {
					dataPack(ID_TRUE_NORTH_VELOCITY = setFloat(ID_TRUE_NORTH_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRUE_UP_VELOCITY")) {
					dataPack(ID_TRUE_UP_VELOCITY = setFloat(ID_TRUE_UP_VELOCITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_TRUE_HEADING")) {
					dataPack(ID_TRUE_HEADING = setFloat(ID_TRUE_HEADING, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEAR_LEVER_SWITCHES")) {
					dataPack(ID_GEAR_LEVER_SWITCHES = setFloat(ID_GEAR_LEVER_SWITCHES, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_GEAR_LEVER_LIGHTS_WOW_SOLENOID")) {
					dataPack(ID_GEAR_LEVER_LIGHTS_WOW_SOLENOID = setFloat(ID_GEAR_LEVER_LIGHTS_WOW_SOLENOID, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_1_TIRE_PRESSURE")) {
					dataPack(ID_LANDING_GEAR_1_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_1_TIRE_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_2_TIRE_PRESSURE")) {
					dataPack(ID_LANDING_GEAR_2_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_2_TIRE_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_3_TIRE_PRESSURE")) {
					dataPack(ID_LANDING_GEAR_3_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_3_TIRE_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_4_TIRE_PRESSURE")) {
					dataPack(ID_LANDING_GEAR_4_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_4_TIRE_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_1_BRAKE_PAD_THICKNESS")) {
					dataPack(ID_LANDING_GEAR_1_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_1_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_2_BRAKE_PAD_THICKNESS")) {
					dataPack(ID_LANDING_GEAR_2_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_2_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_3_BRAKE_PAD_THICKNESS")) {
					dataPack(ID_LANDING_GEAR_3_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_3_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LANDING_GEAR_4_BRAKE_PAD_THICKNESS")) {
					dataPack(ID_LANDING_GEAR_4_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_4_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_UTC")) {
					dataPack(ID_UTC = setFloat(ID_UTC, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_CABIN_PRESSURE")) {
					dataPack(ID_CABIN_PRESSURE = setFloat(ID_CABIN_PRESSURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_CABIN_ALTITUDE")) {
					dataPack(ID_CABIN_ALTITUDE = setFloat(ID_CABIN_ALTITUDE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_CABIN_TEMPERATURE")) {
					dataPack(ID_CABIN_TEMPERATURE = setFloat(ID_CABIN_TEMPERATURE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LONGITUDINAL_CENTER_OF_GRAVITY")) {
					dataPack(ID_LONGITUDINAL_CENTER_OF_GRAVITY = setFloat(ID_LONGITUDINAL_CENTER_OF_GRAVITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_LATERAL_CENTER_OF_GRAVITY")) {
					dataPack(ID_LATERAL_CENTER_OF_GRAVITY = setFloat(ID_LATERAL_CENTER_OF_GRAVITY, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				} else if(!strcmp(key, "ID_DATE")) {
					dataPack(ID_DATE = setFloat(ID_DATE, NODE_AHRS, SC4, atof(strtok_r(NULL, "=", &end_token))), 0);
				}				

				fldata = strtok_r(NULL, ";", &end_str);
			
			}
			
			/* from CANBus to UDP */
			nbytes = read(sockcan, &cframe, sizeof(cframe)); 
			if(nbytes > 0) { 
				memcpy(&buf[0], &cframe.data, 8);
				nbytes = sendto(sockudp, buf, 8, 0, (struct sockaddr *) &clientaddr, clientlen);
			} 

			i++;
			i = i % 16;

		}
    
    }

	/* pack reset data */
	dataPack(ID_LAMPS_0_31 = setUint32(ID_LAMPS_0_31, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_32_63 = setUint32(ID_LAMPS_32_63, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_64_95 = setUint32(ID_LAMPS_64_95, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_96_127 = setUint32(ID_LAMPS_96_127, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_128_159 = setUint32(ID_LAMPS_128_159, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_160_191 = setUint32(ID_LAMPS_160_191, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_192_223 = setUint32(ID_LAMPS_192_223, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_LAMPS_224_255 = setUint32(ID_LAMPS_224_255, NODE_AHRS, SC4, 0), 50);
	dataPack(ID_BODY_LONGITUDINAL_ACCELERATION = setFloat(ID_BODY_LONGITUDINAL_ACCELERATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_LATERAL_ACCELERATION = setFloat(ID_BODY_LATERAL_ACCELERATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_NORMAL_ACCELERATION = setFloat(ID_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_PITCH_RATE = setFloat(ID_BODY_PITCH_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_ROLL_RATE = setFloat(ID_BODY_ROLL_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_YAW_RATE = setFloat(ID_BODY_YAW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_RUDDER_POSITION = setFloat(ID_RUDDER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_STABILIZER_POSITION = setFloat(ID_STABILIZER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ELEVATOR_POSITION = setFloat(ID_ELEVATOR_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LEFT_AILERON_POSITION = setFloat(ID_LEFT_AILERON_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_RIGHT_AILERON_POSITION = setFloat(ID_RIGHT_AILERON_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_PITCH_ANGLE = setFloat(ID_BODY_PITCH_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_ROLL_ANGLE = setFloat(ID_BODY_ROLL_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_SIDESLIP = setFloat(ID_BODY_SIDESLIP, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ALTITUDE_RATE = setFloat(ID_ALTITUDE_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INDICATED_AIRSPEED = setFloat(ID_INDICATED_AIRSPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRUE_AIRSPEED = setFloat(ID_TRUE_AIRSPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_CALIBRATED_AIRSPEED = setFloat(ID_CALIBRATED_AIRSPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_MACH_NUMBER = setFloat(ID_MACH_NUMBER, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BARO_CORRECTION = setFloat(ID_BARO_CORRECTION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BARO_CORRECTED_ALTITUDE = setFloat(ID_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HEADING_ANGLE = setFloat(ID_HEADING_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_STANDARD_ALTITUDE = setFloat(ID_STANDARD_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TOTAL_AIR_TEMPERATURE = setFloat(ID_TOTAL_AIR_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_STATIC_AIR_TEMPERATURE = setFloat(ID_STATIC_AIR_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DIFFERENTIAL_PRESSURE = setFloat(ID_DIFFERENTIAL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_STATIC_PRESSURE = setFloat(ID_STATIC_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HEADING_RATE = setFloat(ID_HEADING_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PORT_SIDE_ANGLE_OF_ATTACK = setFloat(ID_PORT_SIDE_ANGLE_OF_ATTACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_STARBORD_SIDE_ANGLE_OF_ATTACK = setFloat(ID_STARBORD_SIDE_ANGLE_OF_ATTACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DENSITY_ALTITUDE = setFloat(ID_DENSITY_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TURN_COORDINATION_RATE = setFloat(ID_TURN_COORDINATION_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRUE_ALTITUDE = setFloat(ID_TRUE_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_WIND_SPEED = setFloat(ID_WIND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_WIND_DIRECTION = setFloat(ID_WIND_DIRECTION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_OUTSIDE_AIR_TEMPERATURE = setFloat(ID_OUTSIDE_AIR_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_NORMAL_VELOCITY = setFloat(ID_BODY_NORMAL_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_LONGITUDINAL_VELOCITY = setFloat(ID_BODY_LONGITUDINAL_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_BODY_LATERAL_VELOCITY = setFloat(ID_BODY_LATERAL_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TOTAL_PRESSURE = setFloat(ID_TOTAL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PITCH_CONTROL_POSITION = setFloat(ID_PITCH_CONTROL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ROLL_CONTROL_POSITION = setFloat(ID_ROLL_CONTROL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LATERAL_STICK_TRIM_POSITION_COMMAND = setFloat(ID_LATERAL_STICK_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_YAW_CONTROL_POSITION = setFloat(ID_YAW_CONTROL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COLLECTIVE_CONTROL_POSITION = setFloat(ID_COLLECTIVE_CONTROL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LONGITUDINAL_STICK_TRIM_POSITION_COMMAND = setFloat(ID_LONGITUDINAL_STICK_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DIRECTIONAL_PEDALS_TRIM_POSITION_COMMAND = setFloat(ID_DIRECTIONAL_PEDALS_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COLLECTIVE_LEVER_TRIM_POSITION_COMMAND = setFloat(ID_COLLECTIVE_LEVER_TRIM_POSITION_COMMAND, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_CYCLIC_CONTROL_STICK_SWITCHES = setFloat(ID_CYCLIC_CONTROL_STICK_SWITCHES, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LATERAL_TRIM_SPEED = setFloat(ID_LATERAL_TRIM_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LONGITUDINAL_TRIM_SPEED = setFloat(ID_LONGITUDINAL_TRIM_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PEDAL_TRIM_SPEED = setFloat(ID_PEDAL_TRIM_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COLLECTIVE_TRIM_SPEED = setFloat(ID_COLLECTIVE_TRIM_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NOSE_WHEEL_STEERING_HANDLE_POSITION = setFloat(ID_NOSE_WHEEL_STEERING_HANDLE_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_THROTTLE_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_CONDITION_LEVER_POSITION_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FLAPS_LEVER_POSITION = setFloat(ID_FLAPS_LEVER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_SLATS_LEVER_POSITION = setFloat(ID_SLATS_LEVER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PARK_BRAKE_LEVER_POSITION = setFloat(ID_PARK_BRAKE_LEVER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_SPEEDBRAKE_LEVER_POSITION = setFloat(ID_SPEEDBRAKE_LEVER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_THROTTLE_MAX_LEVER_POSITION = setFloat(ID_THROTTLE_MAX_LEVER_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PILOT_LEFT_BRAKE_PEDAL_POSITION = setFloat(ID_PILOT_LEFT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PILOT_RIGHT_BRAKE_PEDAL_POSITION = setFloat(ID_PILOT_RIGHT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COPILOT_LEFT_BRAKE_PEDAL_POSITION = setFloat(ID_COPILOT_LEFT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COPILOT_RIGHT_BRAKE_PEDAL_POSITION = setFloat(ID_COPILOT_RIGHT_BRAKE_PEDAL_POSITION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRIM_SYSTEM_SWITCHES = setFloat(ID_TRIM_SYSTEM_SWITCHES, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRIM_SYSTEM_LIGHTS = setFloat(ID_TRIM_SYSTEM_LIGHTS, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COLLECTIVE_CONTROL_STICK_SWITCHES = setFloat(ID_COLLECTIVE_CONTROL_STICK_SWITCHES, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_STICK_SHAKER_STALL_WARNING_DEVICE = setFloat(ID_STICK_SHAKER_STALL_WARNING_DEVICE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_N1_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_N1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_N2_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_N2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_TORQUE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_TORQUE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_A = setFloat(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_A, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_N1_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_N1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_N2_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_N2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_TORQUE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_TORQUE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_TURBINE_INLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_INTER_TURBINE_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_FUEL_FLOW_RATE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_MANIFOLD_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_OIL_PRESSURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_OIL_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_OIL_QUANTITY_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_COOLANT_TEMPERATURE_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_POWER_RATING_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_STATUS_1_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_1_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_2_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_3_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_B = setFloat(ID_ENGINE_4_STATUS_2_ECS_CHANNEL_B, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_1_FLOW_RATE = setFloat(ID_FUEL_PUMP_1_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_2_FLOW_RATE = setFloat(ID_FUEL_PUMP_2_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_3_FLOW_RATE = setFloat(ID_FUEL_PUMP_3_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_4_FLOW_RATE = setFloat(ID_FUEL_PUMP_4_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_5_FLOW_RATE = setFloat(ID_FUEL_PUMP_5_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_6_FLOW_RATE = setFloat(ID_FUEL_PUMP_6_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_7_FLOW_RATE = setFloat(ID_FUEL_PUMP_7_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_PUMP_8_FLOW_RATE = setFloat(ID_FUEL_PUMP_8_FLOW_RATE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_1_QUANTITY = setFloat(ID_FUEL_TANK_1_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_2_QUANTITY = setFloat(ID_FUEL_TANK_2_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_3_QUANTITY = setFloat(ID_FUEL_TANK_3_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_4_QUANTITY = setFloat(ID_FUEL_TANK_4_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_5_QUANTITY = setFloat(ID_FUEL_TANK_5_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_6_QUANTITY = setFloat(ID_FUEL_TANK_6_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_7_QUANTITY = setFloat(ID_FUEL_TANK_7_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_8_QUANTITY = setFloat(ID_FUEL_TANK_8_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_1_TEMPERATURE = setFloat(ID_FUEL_TANK_1_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_2_TEMPERATURE = setFloat(ID_FUEL_TANK_2_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_3_TEMPERATURE = setFloat(ID_FUEL_TANK_3_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_4_TEMPERATURE = setFloat(ID_FUEL_TANK_4_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_5_TEMPERATURE = setFloat(ID_FUEL_TANK_5_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_6_TEMPERATURE = setFloat(ID_FUEL_TANK_6_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_7_TEMPERATURE = setFloat(ID_FUEL_TANK_7_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_TANK_8_TEMPERATURE = setFloat(ID_FUEL_TANK_8_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_1_PRESSURE = setFloat(ID_FUEL_SYSTEM_1_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_2_PRESSURE = setFloat(ID_FUEL_SYSTEM_2_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_3_PRESSURE = setFloat(ID_FUEL_SYSTEM_3_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_4_PRESSURE = setFloat(ID_FUEL_SYSTEM_4_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_5_PRESSURE = setFloat(ID_FUEL_SYSTEM_5_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_6_PRESSURE = setFloat(ID_FUEL_SYSTEM_6_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_7_PRESSURE = setFloat(ID_FUEL_SYSTEM_7_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FUEL_SYSTEM_8_PRESSURE = setFloat(ID_FUEL_SYSTEM_8_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ROTOR_1_RPM = setFloat(ID_ROTOR_1_RPM, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ROTOR_2_RPM = setFloat(ID_ROTOR_2_RPM, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ROTOR_3_RPM = setFloat(ID_ROTOR_3_RPM, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ROTOR_4_RPM = setFloat(ID_ROTOR_4_RPM, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_1_SPEED = setFloat(ID_GEARBOX_1_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_2_SPEED = setFloat(ID_GEARBOX_2_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_3_SPEED = setFloat(ID_GEARBOX_3_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_4_SPEED = setFloat(ID_GEARBOX_4_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_5_SPEED = setFloat(ID_GEARBOX_5_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_6_SPEED = setFloat(ID_GEARBOX_6_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_7_SPEED = setFloat(ID_GEARBOX_7_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_8_SPEED = setFloat(ID_GEARBOX_8_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_1_OIL_PRESSURE = setFloat(ID_GEARBOX_1_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_2_OIL_PRESSURE = setFloat(ID_GEARBOX_2_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_3_OIL_PRESSURE = setFloat(ID_GEARBOX_3_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_4_OIL_PRESSURE = setFloat(ID_GEARBOX_4_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_5_OIL_PRESSURE = setFloat(ID_GEARBOX_5_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_6_OIL_PRESSURE = setFloat(ID_GEARBOX_6_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_7_OIL_PRESSURE = setFloat(ID_GEARBOX_7_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_8_OIL_PRESSURE = setFloat(ID_GEARBOX_8_OIL_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_1_OIL_TEMPERATURE = setFloat(ID_GEARBOX_1_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_2_OIL_TEMPERATURE = setFloat(ID_GEARBOX_2_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_3_OIL_TEMPERATURE = setFloat(ID_GEARBOX_3_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_4_OIL_TEMPERATURE = setFloat(ID_GEARBOX_4_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_5_OIL_TEMPERATURE = setFloat(ID_GEARBOX_5_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_6_OIL_TEMPERATURE = setFloat(ID_GEARBOX_6_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_7_OIL_TEMPERATURE = setFloat(ID_GEARBOX_7_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_8_OIL_TEMPERATURE = setFloat(ID_GEARBOX_8_OIL_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_1_OIL_QUANTITY = setFloat(ID_GEARBOX_1_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_2_OIL_QUANTITY = setFloat(ID_GEARBOX_2_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_3_OIL_QUANTITY = setFloat(ID_GEARBOX_3_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_4_OIL_QUANTITY = setFloat(ID_GEARBOX_4_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_5_OIL_QUANTITY = setFloat(ID_GEARBOX_5_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_6_OIL_QUANTITY = setFloat(ID_GEARBOX_6_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_7_OIL_QUANTITY = setFloat(ID_GEARBOX_7_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEARBOX_8_OIL_QUANTITY = setFloat(ID_GEARBOX_8_OIL_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_1_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_1_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_2_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_2_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_3_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_3_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_4_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_4_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_5_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_5_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_6_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_6_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_7_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_7_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_8_PRESSURE = setFloat(ID_HYDRAULIC_SYSTEM_8_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_1_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_1_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_2_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_2_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_3_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_3_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_4_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_4_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_5_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_5_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_6_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_6_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_7_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_7_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_8_FLUID_TEMPERATURE = setFloat(ID_HYDRAULIC_SYSTEM_8_FLUID_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_1_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_1_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_2_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_2_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_3_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_3_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_4_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_4_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_5_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_5_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_6_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_6_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_7_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_7_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_HYDRAULIC_SYSTEM_8_FLUID_QUANTITY = setFloat(ID_HYDRAULIC_SYSTEM_8_FLUID_QUANTITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_1_VOLTAGE = setFloat(ID_AC_SYSTEM_1_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_2_VOLTAGE = setFloat(ID_AC_SYSTEM_2_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_3_VOLTAGE = setFloat(ID_AC_SYSTEM_3_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_4_VOLTAGE = setFloat(ID_AC_SYSTEM_4_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_5_VOLTAGE = setFloat(ID_AC_SYSTEM_5_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_6_VOLTAGE = setFloat(ID_AC_SYSTEM_6_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_7_VOLTAGE = setFloat(ID_AC_SYSTEM_7_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_8_VOLTAGE = setFloat(ID_AC_SYSTEM_8_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_9_VOLTAGE = setFloat(ID_AC_SYSTEM_9_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_10_VOLTAGE = setFloat(ID_AC_SYSTEM_10_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_1_CURRENT = setFloat(ID_AC_SYSTEM_1_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_2_CURRENT = setFloat(ID_AC_SYSTEM_2_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_3_CURRENT = setFloat(ID_AC_SYSTEM_3_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_4_CURRENT = setFloat(ID_AC_SYSTEM_4_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_5_CURRENT = setFloat(ID_AC_SYSTEM_5_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_6_CURRENT = setFloat(ID_AC_SYSTEM_6_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_7_CURRENT = setFloat(ID_AC_SYSTEM_7_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_8_CURRENT = setFloat(ID_AC_SYSTEM_8_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_9_CURRENT = setFloat(ID_AC_SYSTEM_9_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AC_SYSTEM_10_CURRENT = setFloat(ID_AC_SYSTEM_10_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_1_VOLTAGE = setFloat(ID_DC_SYSTEM_1_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_2_VOLTAGE = setFloat(ID_DC_SYSTEM_2_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_3_VOLTAGE = setFloat(ID_DC_SYSTEM_3_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_4_VOLTAGE = setFloat(ID_DC_SYSTEM_4_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_5_VOLTAGE = setFloat(ID_DC_SYSTEM_5_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_6_VOLTAGE = setFloat(ID_DC_SYSTEM_6_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_7_VOLTAGE = setFloat(ID_DC_SYSTEM_7_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_8_VOLTAGE = setFloat(ID_DC_SYSTEM_8_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_9_VOLTAGE = setFloat(ID_DC_SYSTEM_9_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_10_VOLTAGE = setFloat(ID_DC_SYSTEM_10_VOLTAGE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_1_CURRENT = setFloat(ID_DC_SYSTEM_1_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_2_CURRENT = setFloat(ID_DC_SYSTEM_2_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_3_CURRENT = setFloat(ID_DC_SYSTEM_3_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_4_CURRENT = setFloat(ID_DC_SYSTEM_4_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_5_CURRENT = setFloat(ID_DC_SYSTEM_5_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_6_CURRENT = setFloat(ID_DC_SYSTEM_6_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_7_CURRENT = setFloat(ID_DC_SYSTEM_7_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_8_CURRENT = setFloat(ID_DC_SYSTEM_8_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_9_CURRENT = setFloat(ID_DC_SYSTEM_9_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DC_SYSTEM_10_CURRENT = setFloat(ID_DC_SYSTEM_10_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_1_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_1_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_2_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_2_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_3_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_3_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_4_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_4_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_5_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_5_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_6_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_6_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_7_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_7_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_8_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_8_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_9_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_9_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_PROP_10_ICEGUARD_DC_CURRENT = setFloat(ID_PROP_10_ICEGUARD_DC_CURRENT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LATITUDE = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LATITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LONGITUDE = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_LONGITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_ALTITUDE = setFloat(ID_ACTIVE_NAV_SYSTEM_WAYPOINT_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_GROUND_SPEED = setFloat(ID_ACTIVE_NAV_SYSTEM_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_TRUE_TRACK = setFloat(ID_ACTIVE_NAV_SYSTEM_TRUE_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_MAGNETIC_TRACK = setFloat(ID_ACTIVE_NAV_SYSTEM_MAGNETIC_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_CROSS_TRACK_ERROR = setFloat(ID_ACTIVE_NAV_SYSTEM_CROSS_TRACK_ERROR, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_TRACK_ERROR_ANGLE = setFloat(ID_ACTIVE_NAV_SYSTEM_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_TIME_TO_GO = setFloat(ID_ACTIVE_NAV_SYSTEM_TIME_TO_GO, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_TIME_OF_ARRIVAL = setFloat(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_TIME_OF_ARRIVAL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_ENROUTE_TIME = setFloat(ID_ACTIVE_NAV_SYSTEM_ESTIMATED_ENROUTE_TIME, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_IDENTIFIER_0_3 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_0_3, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_IDENTIFIER_4_7 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_4_7, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_IDENTIFIER_8_11 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_8_11, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_IDENTIFIER_12_15 = setFloat(ID_NAV_WAYPOINT_IDENTIFIER_12_15, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_TYPE_IDENTIFIER = setFloat(ID_NAV_WAYPOINT_TYPE_IDENTIFIER, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_LATITUDE = setFloat(ID_NAV_WAYPOINT_LATITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_LONGITUDE = setFloat(ID_NAV_WAYPOINT_LONGITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MINIMUM_ALTITUDE = setFloat(ID_NAV_WAYPOINT_MINIMUM_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MINIMUM_FLIGHT_LEVEL = setFloat(ID_NAV_WAYPOINT_MINIMUM_FLIGHT_LEVEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MINIMUM_RADAR_HEIGHT = setFloat(ID_NAV_WAYPOINT_MINIMUM_RADAR_HEIGHT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MINIMUM_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_NAV_WAYPOINT_MINIMUM_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MAXIMUM_ALTITUDE = setFloat(ID_NAV_WAYPOINT_MAXIMUM_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MAXIMUM_FLIGHT_LEVEL = setFloat(ID_NAV_WAYPOINT_MAXIMUM_FLIGHT_LEVEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MAXIMUM_RADAR_HEIGHT = setFloat(ID_NAV_WAYPOINT_MAXIMUM_RADAR_HEIGHT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_MAXIMUM_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_NAV_WAYPOINT_MAXIMUM_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_PLANNED_ALTITUDE = setFloat(ID_NAV_WAYPOINT_PLANNED_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_PLANNED_FLIGHT_LEVEL = setFloat(ID_NAV_WAYPOINT_PLANNED_FLIGHT_LEVEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_PLANNED_RADAR_HEIGHT = setFloat(ID_NAV_WAYPOINT_PLANNED_RADAR_HEIGHT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_PLANNED_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_NAV_WAYPOINT_PLANNED_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DISTANCE_TO_NAV_WAYPOINT = setFloat(ID_DISTANCE_TO_NAV_WAYPOINT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TIME_TO_GO_TO_NAV_WAYPOINT = setFloat(ID_TIME_TO_GO_TO_NAV_WAYPOINT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_ESTIMATED_TIME_OF_ARRIVAL = setFloat(ID_NAV_WAYPOINT_ESTIMATED_TIME_OF_ARRIVAL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_ESTIMATED_ENROUTE_TIME = setFloat(ID_NAV_WAYPOINT_ESTIMATED_ENROUTE_TIME, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_NAV_WAYPOINT_STATUS_INFORMATION = setFloat(ID_NAV_WAYPOINT_STATUS_INFORMATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_AIRCRAFT_LATITUDE = setFloat(ID_GPS_AIRCRAFT_LATITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_AIRCRAFT_LONGITUDE = setFloat(ID_GPS_AIRCRAFT_LONGITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_GPS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_GROUND_SPEED = setFloat(ID_GPS_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_TRUE_TRACK = setFloat(ID_GPS_TRUE_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_MAGNETIC_TRACK = setFloat(ID_GPS_MAGNETIC_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_CROSS_TRACK_ERROR = setFloat(ID_GPS_CROSS_TRACK_ERROR, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_TRACK_ERROR_ANGLE = setFloat(ID_GPS_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_GLIDESLOPE_DEVIATION = setFloat(ID_GPS_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_PREDICTED_RAIM = setFloat(ID_GPS_PREDICTED_RAIM, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_VERTICAL_FIGURE_OF_MERIT = setFloat(ID_GPS_VERTICAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_HORIZONTAL_FIGURE_OF_MERIT = setFloat(ID_GPS_HORIZONTAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GPS_MODE_OF_OPERATION = setFloat(ID_GPS_MODE_OF_OPERATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_LATITUDE = setFloat(ID_INS_AIRCRAFT_LATITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_LONGITUDE = setFloat(ID_INS_AIRCRAFT_LONGITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_INS_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_GROUND_SPEED = setFloat(ID_INS_AIRCRAFT_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_TRUE_TRACK = setFloat(ID_INS_AIRCRAFT_TRUE_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_MAGNETIC_TRACK = setFloat(ID_INS_AIRCRAFT_MAGNETIC_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_CROSS_TRACK_ERROR = setFloat(ID_INS_AIRCRAFT_CROSS_TRACK_ERROR, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_AIRCRAFT_TRACK_ERROR_ANGLE = setFloat(ID_INS_AIRCRAFT_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_VERTICAL_FIGURE_OF_MERIT = setFloat(ID_INS_VERTICAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_INS_HORIZONTAL_FIGURE_OF_MERIT = setFloat(ID_INS_HORIZONTAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LATITUDE = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LATITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LONGITUDE = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_LONGITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_HEIGHT_ABOVE_ELLIPSOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_GROUND_SPEED = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRUE_TRACK = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRUE_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_MAGNETIC_TRACK = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_MAGNETIC_TRACK, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_CROSS_TRACK_ERROR = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_CROSS_TRACK_ERROR, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRACK_ERROR_ANGLE = setFloat(ID_AUXILIARY_NAV_SYSTEM_AIRCRAFT_TRACK_ERROR_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_VERTICAL_FIGURE_OF_MERIT = setFloat(ID_AUXILIARY_NAV_SYSTEM_VERTICAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_AUXILIARY_NAV_SYSTEM_HORIZONTAL_FIGURE_OF_MERIT = setFloat(ID_AUXILIARY_NAV_SYSTEM_HORIZONTAL_FIGURE_OF_MERIT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_MAGNETIC_HEADING = setFloat(ID_MAGNETIC_HEADING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_RADIO_HEIGHT = setFloat(ID_RADIO_HEIGHT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_1_DISTANCE = setFloat(ID_DME_1_DISTANCE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_2_DISTANCE = setFloat(ID_DME_2_DISTANCE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_3_DISTANCE = setFloat(ID_DME_3_DISTANCE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_4_DISTANCE = setFloat(ID_DME_4_DISTANCE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_1_TIME_TO_GO = setFloat(ID_DME_1_TIME_TO_GO, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_2_TIME_TO_GO = setFloat(ID_DME_2_TIME_TO_GO, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_3_TIME_TO_GO = setFloat(ID_DME_3_TIME_TO_GO, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_4_TIME_TO_GO = setFloat(ID_DME_4_TIME_TO_GO, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_1_GROUND_SPEED = setFloat(ID_DME_1_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_2_GROUND_SPEED = setFloat(ID_DME_2_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_3_GROUND_SPEED = setFloat(ID_DME_3_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_4_GROUND_SPEED = setFloat(ID_DME_4_GROUND_SPEED, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_1_BEARING = setFloat(ID_ADF_1_BEARING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_2_BEARING = setFloat(ID_ADF_2_BEARING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_3_BEARING = setFloat(ID_ADF_3_BEARING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_4_BEARING = setFloat(ID_ADF_4_BEARING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_1_LOCALIZE_DEVIATION = setFloat(ID_ILS_1_LOCALIZE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_2_LOCALIZE_DEVIATION = setFloat(ID_ILS_2_LOCALIZE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_3_LOCALIZE_DEVIATION = setFloat(ID_ILS_3_LOCALIZE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_4_LOCALIZE_DEVIATION = setFloat(ID_ILS_4_LOCALIZE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_1_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_1_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_2_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_2_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_3_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_3_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ILS_4_GLIDESLOPE_DEVIATION = setFloat(ID_ILS_4_GLIDESLOPE_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FLIGHT_DIRECTOR_2_PITCH_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_2_PITCH_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_FLIGHT_DIRECTOR_2_ROLL_DEVIATION = setFloat(ID_FLIGHT_DIRECTOR_2_ROLL_DEVIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DECISION_HEIGHT = setFloat(ID_DECISION_HEIGHT, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VHF_1_COM_FREQUENCY = setFloat(ID_VHF_1_COM_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VHF_2_COM_FREQUENCY = setFloat(ID_VHF_2_COM_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VHF_3_COM_FREQUENCY = setFloat(ID_VHF_3_COM_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VHF_4_COM_FREQUENCY = setFloat(ID_VHF_4_COM_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_ILS_1_FREQUENCY = setFloat(ID_VOR_ILS_1_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_ILS_2_FREQUENCY = setFloat(ID_VOR_ILS_2_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_ILS_3_FREQUENCY = setFloat(ID_VOR_ILS_3_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_ILS_4_FREQUENCY = setFloat(ID_VOR_ILS_4_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_1_FREQUENCY = setFloat(ID_ADF_1_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_2_FREQUENCY = setFloat(ID_ADF_2_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_3_FREQUENCY = setFloat(ID_ADF_3_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_ADF_4_FREQUENCY = setFloat(ID_ADF_4_FREQUENCY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_1_CHANNEL = setFloat(ID_DME_1_CHANNEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_2_CHANNEL = setFloat(ID_DME_2_CHANNEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_3_CHANNEL = setFloat(ID_DME_3_CHANNEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DME_4_CHANNEL = setFloat(ID_DME_4_CHANNEL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRANSPONDER_1_CODE = setFloat(ID_TRANSPONDER_1_CODE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRANSPONDER_2_CODE = setFloat(ID_TRANSPONDER_2_CODE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRANSPONDER_3_CODE = setFloat(ID_TRANSPONDER_3_CODE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRANSPONDER_4_CODE = setFloat(ID_TRANSPONDER_4_CODE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DESIRED_TRACK_ANGLE = setFloat(ID_DESIRED_TRACK_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_MAGNETIC_VARIATION = setFloat(ID_MAGNETIC_VARIATION, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_SELECTED_GLIDEPATH_ANGLE = setFloat(ID_SELECTED_GLIDEPATH_ANGLE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_SELECTED_RUNWAY_HEADING = setFloat(ID_SELECTED_RUNWAY_HEADING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_COMPUTED_VERTICAL_VELOCITY = setFloat(ID_COMPUTED_VERTICAL_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_SELECTED_COURSE = setFloat(ID_SELECTED_COURSE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_1_RADIAL = setFloat(ID_VOR_1_RADIAL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_2_RADIAL = setFloat(ID_VOR_2_RADIAL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_3_RADIAL = setFloat(ID_VOR_3_RADIAL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_VOR_4_RADIAL = setFloat(ID_VOR_4_RADIAL, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRUE_EAST_VELOCITY = setFloat(ID_TRUE_EAST_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRUE_NORTH_VELOCITY = setFloat(ID_TRUE_NORTH_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRUE_UP_VELOCITY = setFloat(ID_TRUE_UP_VELOCITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_TRUE_HEADING = setFloat(ID_TRUE_HEADING, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEAR_LEVER_SWITCHES = setFloat(ID_GEAR_LEVER_SWITCHES, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_GEAR_LEVER_LIGHTS_WOW_SOLENOID = setFloat(ID_GEAR_LEVER_LIGHTS_WOW_SOLENOID, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_1_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_1_TIRE_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_2_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_2_TIRE_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_3_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_3_TIRE_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_4_TIRE_PRESSURE = setFloat(ID_LANDING_GEAR_4_TIRE_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_1_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_1_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_2_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_2_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_3_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_3_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LANDING_GEAR_4_BRAKE_PAD_THICKNESS = setFloat(ID_LANDING_GEAR_4_BRAKE_PAD_THICKNESS, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_UTC = setFloat(ID_UTC, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_CABIN_PRESSURE = setFloat(ID_CABIN_PRESSURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_CABIN_ALTITUDE = setFloat(ID_CABIN_ALTITUDE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_CABIN_TEMPERATURE = setFloat(ID_CABIN_TEMPERATURE, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LONGITUDINAL_CENTER_OF_GRAVITY = setFloat(ID_LONGITUDINAL_CENTER_OF_GRAVITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_LATERAL_CENTER_OF_GRAVITY = setFloat(ID_LATERAL_CENTER_OF_GRAVITY, NODE_AHRS, SC4, 0.0f), 50);
	dataPack(ID_DATE = setFloat(ID_DATE, NODE_AHRS, SC4, 0.0f), 50);

	/* exit wrapper */
    close(sockcan);
	printf("\nWrapper exit\n");
	exit(0);
	
}
