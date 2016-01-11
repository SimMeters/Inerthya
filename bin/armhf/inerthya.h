/*******************************************************************************
 * Copyright (c) 2015, SimMeters.com
 * All rights reserved. Released under the BSD license.
 * inerthya.h 1.0 01/01/2016 (Main Inerthya Implementation)
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
 *  
 * Data Output Protocol Format (DOPF) 10 Bytes Data
 * +----------+----------+---------+-----------+--------------+--------------+-------+-------+-------+-------+
 * | BYTE9    | BYTE8    | BYTE7   | BYTE6     | BYTE5        | BYTE4        | BYTE3 | BYTE2 | BYTE1 | BYTE0 |
 * +----------+----------+---------+-----------+--------------+--------------+-------+-------+-------+-------+
 * | CAN_IDH  | CAN_IDL  | NODE_ID | DATA_TYPE | SERVICE_CODE | MESSAGE_CODE | DATA3 | DATA2 | DATA1 | DATA0 |
 * +----------+----------+---------+-----------+--------------+--------------+-------+-------+-------+-------+
 *
 * Data Input Protocol Format (DIPF) 10 Bytes Data
 * +----------+----------+---------+-----------+--------------+--------------+-------+-------+-------+-------+
 * | BYTE9    | BYTE8    | BYTE7   | BYTE6     | BYTE5        | BYTE4        | BYTE3 | BYTE2 | BYTE1 | BYTE0 |
 * +----------+----------+---------+-----------+--------------+--------------+-------+-------+-------+-------+
 * | CAN_IDH  | CAN_IDL  | NODE_ID | DATA_TYPE | SERVICE_CODE | MESSAGE_CODE | DATA3 | DATA2 | DATA1 | DATA0 |
 * +----------+----------+---------+-----------+--------------+--------------+-------+-------+-------+-------+
 * 
 * System definitions
 ******************************************************************************/
#define BUFSIZE     1024
#define DOPF_LEN    10
#define DIPF_LEN    10
unsigned short      CANID;

struct INERTHYA_FRAME {
    unsigned char CAN_IDH;
    unsigned char CAN_IDL;
    unsigned char NODE_ID;
    unsigned char DATA_TYPE;
    unsigned char SERVICE_CODE;
    unsigned char MESSAGE_CODE;
    unsigned char DATA3;
    unsigned char DATA2;
    unsigned char DATA1;
    unsigned char DATA0;
};

/*******************************************************************************
 * Define CANBus 
 ******************************************************************************/
#define DLC8	8

/*******************************************************************************
 * CANAerospace V1.7 NODES
 ******************************************************************************/
#define NODE_AHRS       0x01
#define NODE_ADC        0x02
#define NODE_VHF1       0x03
#define NODE_VHF2       0x04
#define NODE_NAVILS1    0x05
#define NODE_NAVILS2    0x06
#define NODE_ATC        0x07
#define NODE_ADF        0x08
#define NODE_GPS        0x0A
#define NODE_DME        0x0B
#define NODE_EMS        0x0C
#define NODE_ETS        0x0D
#define NODE_ES         0x0E
#define NODE_WCS        0x0F

/*******************************************************************************
 * CANAerospace V1.7 DATA TYPES
 ******************************************************************************/
#define TYPE_NODATA     0x00
#define TYPE_ERROR      0x01
#define TYPE_FLOAT      0x02
#define TYPE_LONG       0x03
#define TYPE_ULONG      0x04
#define TYPE_BLONG      0x05
#define TYPE_SHORT      0x06
#define TYPE_USHORT     0x07
#define TYPE_BSHORT     0x08
#define TYPE_CHAR       0x09
#define TYPE_UCHAR      0x0A
#define TYPE_BCHAR      0x0B
#define TYPE_SHORT2     0x0C
#define TYPE_USHORT2    0x0D
#define TYPE_BSHORT2    0x0E
#define TYPE_CHAR4      0x0F
#define TYPE_UCHAR4     0x10
#define TYPE_BCHAR4     0x11
#define TYPE_CHAR2      0x12
#define TYPE_UCHAR2     0x13
#define TYPE_BCHAR2     0x14
#define TYPE_MEMID      0x15
#define TYPE_CHKSUM     0x16
#define TYPE_ACHAR      0x17
#define TYPE_ACHAR2     0x18
#define TYPE_ACHAR4     0x19
#define TYPE_CHAR3      0x1A
#define TYPE_UCHAR3     0x1B
#define TYPE_BCHAR3     0x1C
#define TYPE_ACHAR3     0x1D
#define TYPE_DOUBLEH    0x1E
#define TYPE_DOUBLEL    0x1F
#define TYPE_RESVD      0x20
#define TYPE_UDEF       0x64

/*******************************************************************************
 * CANAerospace V1.7 SERVICE CODES
 ******************************************************************************/
#define SC0 0x00
#define SC1 0x01
#define SC2 0x02
#define SC3 0x03
#define SC4 0x04
#define SC5 0x05
#define SC6 0x06
#define SC7 0x07
#define SC8 0x08

/*******************************************************************************
 * System helpers
 ******************************************************************************/
union floatun {
    unsigned char floatbuf[4];
    float value;
} floatun;

union intun {
    unsigned char intbuf[4];
    unsigned int value;
} intun;