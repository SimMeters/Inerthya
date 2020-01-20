/* Fligh Data EADI */

int flags       		= FLData.ID_LAMPS_0_31.getUint32();                    		/* Data Flags */
boolean flag_fd  		= (flags & 0b00000000_00000001_00000000_00000000) > 0;     	/* Flight Director */
boolean flag_ap  		= (flags & 0b00000000_00000010_00000000_00000000) > 0;     	/* Autopilot */
boolean flag_hdg 		= (flags & 0b00000000_00000100_00000000_00000000) > 0;     	/* Autopilot Heading Selected */
boolean flag_vs  		= (flags & 0b00000000_00001000_00000000_00000000) > 0;     	/* Autopilot VS selected */
boolean flag_alt 		= (flags & 0b00000000_00010000_00000000_00000000) > 0;     	/* Autopilot altitude selected */
boolean flag_loc 		= (flags & 0b00000000_00100000_00000000_00000000) > 0;     	/* localizer */
boolean flag_gs  		= (flags & 0b00100000_00000000_00000000_00000000) > 0;     	/* glideslope */
float pit       		= FLData.ID_BODY_PITCH_ANGLE.getFloat();                    /* Pitch Angle Degrees */
float bnk       		= FLData.ID_BODY_ROLL_ANGLE.getFloat();                     /* Roll Angle Degrees */
float fd_pit    		= FLData.ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION.getFloat();   /* FD Pitch Angle Degrees */
float fd_bnk    		= FLData.ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION.getFloat();    /* FD Roll Angle Degrees */
float slipball  		= FLData.ID_BODY_SIDESLIP.getFloat();                       /* slipball position +-50 */
float gs        		= FLData.ID_ILS_1_GLIDESLOPE_DEVIATION.getFloat();          /* GlideSlope Deviation +- 100*/
float loc        		= FLData.ID_ILS_1_LOCALIZE_DEVIATION.getFloat();           	/* Localize Deviation +- 100*/
float com1f     		= FLData.ID_VHF_1_COM_FREQUENCY.getFloat();                 /* Frequency COM1 Mhz */
float com2f     		= FLData.ID_VHF_2_COM_FREQUENCY.getFloat();                 /* Frequency COM2 Mhz */
float qnh 				= FLData.ID_BARO_CORRECTION.getFloat();                 	/* Baro Correction */
float dh 				= FLData.ID_DECISION_HEIGHT.getFloat();                   	/* Decision Height */

if(fd_pit > 100) fd_pit = 100;
if(fd_pit < -100) fd_pit = -100;

if(slipball> 50) slipball  = 50;
if(slipball< -50) slipball = -50;

if(gs> 100) gs  = 100;
if(gs< -100) gs = -100;

if(loc > 100) loc  = 100;
if(loc < -100) loc = -100;

/* Fligh Data EHSI */
int flags       		= FLData.ID_LAMPS_0_31.getUint32();                         /* Data Flags */
boolean flag_vor1    	= (flags & 0b00000001_00000000_00000000_00000000) > 0;     	/* Flag VOR1 Active */
boolean flag_vor2    	= (flags & 0b00000010_00000000_00000000_00000000) > 0;      /* Flag VOR2 Active */
boolean flag_dme1    	= (flags & 0b00000100_00000000_00000000_00000000) > 0;     	/* Flag DME1 Active */
boolean flag_adf1    	= (flags & 0b00001000_00000000_00000000_00000000) > 0;      /* Flag ADF1 Active */
boolean flag_adf2    	= (flags & 0b00010000_00000000_00000000_00000000) > 0;     	/* Flag ADF2 Active */
boolean flag_gs      	= (flags & 0b00100000_00000000_00000000_00000000) > 0;     	/* Flag GlideSLope Active */
boolean flag_to_from 	= (flags & 0b01000000_00000000_00000000_00000000) > 0;    	/* TO-FROM */
float hdg       		= FLData.ID_HEADING_ANGLE.getFloat();                       /* Heading Indication Degrees */
float bug       		= FLData.ID_DESIRED_TRACK_ANGLE.getFloat();                 /* Heading Bug Indicator Degrees */
float crs       		= FLData.ID_SELECTED_COURSE.getFloat();                     /* Course Indicator Degrees */
float vor1      		= FLData.ID_VOR_1_RADIAL.getFloat();                        /* Bearing VOR1 Degrees */
float vor1f     		= FLData.ID_VOR_ILS_1_FREQUENCY.getFloat();                 /* Frequency NAV1 Mhz */
float vor2      		= FLData.ID_VOR_2_RADIAL.getFloat();                        /* Bearing VOR2 Degrees */
float vor2f     		= FLData.ID_VOR_ILS_2_FREQUENCY.getFloat();                 /* Frequency VOR2 Mhz */
float dme1      		= FLData.ID_DME_1_DISTANCE.getFloat() * 0.000539956803f;    /* DME Distance m to nm */
float dme1s     		= FLData.ID_DME_1_GROUND_SPEED.getFloat() * 1.94384f;       /* DME Ground Speed m/s to knots */
float gspd      		= FLData.ID_GPS_GROUND_SPEED.getFloat() * 1.94384f;         /* GPS Ground Speed m/s to knots */
float adf1      		= FLData.ID_ADF_1_BEARING.getFloat();                       /* Bearing ADF1 Degrees */
float adf1f     		= FLData.ID_ADF_1_FREQUENCY.getFloat();                     /* Frequency ADF1 Mhz */
float adf2      		= FLData.ID_ADF_2_BEARING.getFloat();                       /* Bearing ADF2 Degrees */
float adf2f     		= FLData.ID_ADF_2_FREQUENCY.getFloat();                     /* Frequency ADF2 Mhz */
float gs        		= FLData.ID_ILS_1_GLIDESLOPE_DEVIATION.getFloat();          /* GlideSlope Deviation +- 100*/
float lat       		= FLData.ID_INS_AIRCRAFT_LATITUDE.getFloat();               /* Latitude Decimal Degrees*/
float lon       		= FLData.ID_INS_AIRCRAFT_LONGITUDE.getFloat();              /* Longitude Decimal Degrees*/

if(gs> 100) gs  		= 100;
if(gs< -100) gs 		= -100;

