------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- atachapters.lua 1.0 01/01/2015 (ATA CHAPTERS definition file).

-- Redistribution and use in source and binary forms, with or without modification, are permitted provided that the
-- following conditions are met:

-- 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
-- following disclaimer.

-- 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
-- following disclaimer in the documentation and/or other materials provided with the distribution.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-- SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
-- USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
------------------------------------------------------------------------------------------------------------------------
MASK_LAMP_00																					= 0x00000001
MASK_LAMP_01																					= 0x00000002
MASK_LAMP_02																					= 0x00000004
MASK_LAMP_03																					= 0x00000008
MASK_LAMP_04																					= 0x00000010
MASK_LAMP_05																					= 0x00000020
MASK_LAMP_06																					= 0x00000040
MASK_LAMP_07																					= 0x00000080
MASK_LAMP_08																					= 0x00000100
MASK_LAMP_09																					= 0x00000200
MASK_LAMP_10																					= 0x00000400
MASK_LAMP_11																					= 0x00000800
MASK_LAMP_12																					= 0x00001000
MASK_LAMP_13																					= 0x00002000
MASK_LAMP_14																					= 0x00004000
MASK_LAMP_15																					= 0x00008000
MASK_LAMP_16																					= 0x00010000
MASK_LAMP_17																					= 0x00020000
MASK_LAMP_18																					= 0x00040000
MASK_LAMP_19																					= 0x00080000
MASK_LAMP_20																					= 0x00100000
MASK_LAMP_21																					= 0x00200000
MASK_LAMP_22																					= 0x00400000
MASK_LAMP_23																					= 0x00800000
MASK_LAMP_24																					= 0x01000000
MASK_LAMP_25																					= 0x02000000
MASK_LAMP_26																					= 0x04000000
MASK_LAMP_27																					= 0x08000000
MASK_LAMP_28																					= 0x10000000
MASK_LAMP_29																					= 0x20000000
MASK_LAMP_30																					= 0x40000000
MASK_LAMP_31																					= 0x80000000

------------------------------------------------------------------------------------------------------------------------
-- COMMON AXIS CONSTANTS																					    = 0xA000
------------------------------------------------------------------------------------------------------------------------
PFD_PILOT_BRT                                                                                   = 0xA0000000
ND_PILOT_BRT																					= 0xA0010000
WEATHER_RADAR_GAIN                                                                              = 0xA0020000
WEATHER_RADAR_TILT                                                                              = 0xA0030000
PANEL_BRIGHTNESS_GENERAL																		= 0xA0040000
INTERCOM_VOLUME_GENERAL 																		= 0xA0050000
UHF_VOLUME 																						= 0xA0060000
COMM1_VOLUME 																					= 0xA0070000

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 20 ELECTRICAL_STANDARD_ITEMS_PRACTICES                                                               = 0x1400
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 21 AIR_CONDITIONING_GENERAL                                                                          = 0x1500
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.10 COMPRESSION                                                                                 = 0x150A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.20 DISTRIBUTION                                                                                = 0x1514
------------------------------------------------------------------------------------------------------------------------
BLEED_AIR_ON																					= 0x15140001
BLEED_AIR_OFF                                                                                   = 0x15140000
BLEED_AIR_EMER_OFF																				= 0x15140100
BLEED_AIR_EMER_ON																				= 0x15140101
BLEED_AIR_RHEO_OFF																				= 0x15140200
BLEED_AIR_RHEO_ON																				= 0x15140201
BLEED_AIR_TEST_OFF 																				= 0x15140300
BLEED_AIR_TEST_ON 																				= 0x15140301

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.30 PRESSURIZATION_CONTROL                                                                      = 0x151E
------------------------------------------------------------------------------------------------------------------------
TEMP_PRESS_NORM                                                                                 = 0x151E0001
TEMP_PRESS_RAM                                                                                  = 0x151E0000
TEMP_PRESS_DUMP                                                                                 = 0x151E0002
MAIN_SUPPLY_ON                                                                                  = 0x151E0101
MAIN_SUPPLY_OFF                                                                                 = 0x151E0100

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.40 HEATING																					 = 0x1528
------------------------------------------------------------------------------------------------------------------------
CABIN_HEATING_OFF                                                                               = 0x15280000
CABIN_HEATING_POS1                                                                              = 0x15280001
CABIN_HEATING_POS2                                                                              = 0x15280002
CABIN_HEATING_POS3                                                                              = 0x15280003
CABIN_HEATING_POS4                                                                              = 0x15280004

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.50 COOLING																					 = 0x1532
------------------------------------------------------------------------------------------------------------------------
EQUIP_COOLING_SUPPLY_NORM                                                                      	= 0x15320000
EQUIP_COOLING_SUPPLY_ALT                                                                        = 0x15320001
EQUIP_COOLING_SUPPLY_WARNING_OFF_OFF                                                            = 0x15320002
EQUIP_COOLING_SUPPLY_WARNING_OFF_ON                                                             = 0x15320003
EQUIP_COOLING_EXHAUST_NORM                                                                      = 0x15320100
EQUIP_COOLING_EXHAUST_ALT                                                                       = 0x15320101
EQUIP_COOLING_EXHAUST_WARNING_OFF_OFF                                                           = 0x15320102
EQUIP_COOLING_EXHAUST_WARNING_OFF_ON                                                            = 0x15320103

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.60 TEMPERATURE_CONTROL                                                                         = 0x153C
------------------------------------------------------------------------------------------------------------------------
MODE_MANUAL																					 	= 0x153C0000
MODE_AUTO																					   	= 0x153C0001

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 21.70 MOISTURE_AIR_CONTAMINANT_CONTROL                                                            = 0x1546
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 22 AUTO_FLIGHT_GENERAL                                                                               = 0x1600
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 22.10 AUTOPILOT                                                                                   = 0x160A
------------------------------------------------------------------------------------------------------------------------
AUTOPILOT_EAC_OFF                                                                               = 0x160A0000
AUTOPILOT_EAC_ARM                                                                               = 0x160A0001
AUTOPILOT_RALT_DIS                                                                              = 0x160A0100
AUTOPILOT_RALT_NRM                                                                              = 0x160A0101
AUTOPILOT_OFF                                                                                   = 0x160A0200
AUTOPILOT_ON																					= 0x160A0201
AUTOPILOT_PATH                                                                                  = 0x160A0301
AUTOPILOT_ALT_HDG                                                                               = 0x160A0300
AUTOPILOT_ALT                                                                                   = 0x160A0302
AUTOPILOT_ALTA_DEC                                                                              = 0x160A0400
AUTOPILOT_ALTA_INC                                                                              = 0x160A0401
AUTOPILOT_HDG_DEC                                                                               = 0x160A0500
AUTOPILOT_HDG_INC                                                                               = 0x160A0501
AUTOPILOT_NAV_TOGGLE                                                                            = 0x160A0600
AUTOPILOT_ALTA_TOGGLE                                                                           = 0x160A0700
AUTOPILOT_IAS_TOGGLE                                                                            = 0x160A0800
AUTOPILOT_APP_TOGGLE                                                                            = 0x160A0900
AUTOPILOT_AUTO_TRIM                                                                             = 0x160A0A00
AUTOPILOT_VS_TOGGLE                                                                             = 0x160A0B00
AUTOPILOT_GS_TOGGLE                                                                             = 0x160A0C00
AUTOPILOT_TEST_OFF                                                                              = 0x160A0D00
AUTOPILOT_TEST_ON                                                                               = 0x160A0D01
CAT_A_SWITCH_OFF                                                                                = 0x160A0E00
CAT_A_SWITCH_ON                                                                                 = 0x160A0E01
CAT_A_SWITCH_ANNUNC_OFF                                                                         = 0x160A0F00
CAT_A_SWITCH_ANNUNC_ON                                                                          = 0x160A0F00
HI_NR_SWITCH_OFF                                                                                = 0x160A1000
HI_NR_SWITCH_ON                                                                                 = 0x160A1001
SAS_MONITOR_TEST_L 																				= 0x160A2001
SAS_MONITOR_TEST_OFF 																			= 0x160A2000
SAS_MONITOR_TEST_R 																				= 0x160A2002
CAS_SPEED_DEC 																					= 0x160A3001
CAS_SPEED_INC 																					= 0x160A3002
DECISION_HEIGHT_DEC																				= 0x160A4001
DECISION_HEIGHT_INC																				= 0x160A4002

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 22.20 SPEED_ATTITUDE_CORRECTION                                                                   = 0x1614
------------------------------------------------------------------------------------------------------------------------
HDG_BUG_DEC																					 	= 0x16140001
HDG_BUG_INC																					 	= 0x16140002
HDG_BUG_COPILOT_DEC                                                                             = 0x16140011
HDG_BUG_COPILOT_INC                                                                             = 0x16140012
CRS_BUG_DEC																					 	= 0x16140101
CRS_BUG_INC																					 	= 0x16140102
ADI_SET_DEC																					 	= 0x16140201
ADI_SET_INC																					 	= 0x16140202
HARS_FAST_ERECT_ON                                                                              = 0x16140301
HARS_FAST_ERECT_OFF                                                                             = 0x16140300

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 22.30 AUTO_THROTTLE                                                                               = 0x161E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 22.40 SYSTEM_MONITORS                                                                             = 0x1628
------------------------------------------------------------------------------------------------------------------------
AUTOPILOT_IND_OFF                                                                               = 0x16280000
AUTOPILOT_IND_ON                                                                                = 0x16280001
AUTOPILOT_IND_ATRIM_OFF                                                                         = 0x16280100
AUTOPILOT_IND_ATRIM_ON                                                                          = 0x16280101
AUTOPILOT_IND_ATRIM_WARNING_OFF                                                                 = 0x16280200
AUTOPILOT_IND_ATRIM_WARNING_ON                                                                  = 0x16280201
AUTOPILOT_IND_APP_OFF                                                                           = 0x16280300
AUTOPILOT_IND_APP_YELLOW                                                                        = 0x16280301
AUTOPILOT_IND_APP_GREEN                                                                         = 0x16280302
AUTOPILOT_IND_NAV_OFF                                                                           = 0x16280400
AUTOPILOT_IND_NAV_YELLOW                                                                        = 0x16280401
AUTOPILOT_IND_NAV_GREEN                                                                         = 0x16280402
AUTOPILOT_IND_ALTA_OFF                                                                          = 0x16280500
AUTOPILOT_IND_ALTA_ON                                                                           = 0x16280502
AUTOPILOT_IND_IAS_OFF                                                                           = 0x16280600
AUTOPILOT_IND_IAS_ON                                                                            = 0x16280602
AUTOPILOT_IND_ALT_OFF                                                                           = 0x16280700
AUTOPILOT_IND_ALT_ON                                                                            = 0x16280702
AUTOPILOT_IND_HDG_OFF                                                                           = 0x16280800
AUTOPILOT_IND_HDG_ON                                                                            = 0x16280802
AUTOPILOT_IND_VS_OFF                                                                            = 0x16280900
AUTOPILOT_IND_VS_ON                                                                             = 0x16280902
AUTOPILOT_IND_GS_OFF                                                                            = 0x16280A00
AUTOPILOT_IND_GS_YELLOW                                                                         = 0x16280A01
AUTOPILOT_IND_GS_GREEN                                                                          = 0x16280A02
AUTOPILOT_IND_TEST_OFF                                                                          = 0x16280B00
AUTOPILOT_IND_TEST_ON                                                                           = 0x16280B01

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 22.50 AERODYNAMIC_LOAD_ALLEVIATING                                                                = 0x1632
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 23 COMMUNICATIONS_GENERAL                                                                            = 0x1700
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.10 SPEECH_COMMUNICATIONS                                                                       = 0x170A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.15 SATCOM																					  	= 0x170F
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.20 DATA_TRANSMISSION_AND_AUTOMATIC_CALLING                                                     = 0x1714
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.30 PASSENGER_ADDRESS_ENTERTAINMENT_AND_COMFORT                                                 = 0x171E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.40 INTERPHONE                                                                                  = 0x1728
------------------------------------------------------------------------------------------------------------------------
ATTEND_CALL_OFF                                                                                 = 0x17280000
ATTEND_CALL_ON                                                                                  = 0x17280001
ATTEND_CALL_LIGHT_OFF                                                                           = 0x17280100
ATTEND_CALL_LIGHT_ON                                                                            = 0x17280101
GROUND_CALL_OFF                                                                                 = 0x17280200
GROUND_CALL_ON                                                                                  = 0x17280201

GENERAL_CALL_OFF																				= 0x17280300
GENERAL_CALL_ON																					= 0x17280301
 
INTERCOM_MODE_HF																				= 0x17280400
INTERCOM_MODE_VHF																				= 0x17280401
INTERCOM_MODE_FM																				= 0x17280402
INTERCOM_MODE_INT																				= 0x17280403
 
ENABLE_INT																						= 0x17281001
ENABLE_FM																						= 0x17281101
ENABLE_VHF																						= 0x17281201
ENABLE_UHF																						= 0x17281301
ENABLE_AIM																						= 0x17281401
ENABLE_IFF																						= 0x17281501
ENABLE_ILS																						= 0x17281601
ENABLE_TCN																						= 0x17281701
ENABLE_HM																						= 0x17281801
ENABLE_VOL																						= 0x17281901
 
DISABLE_INT																						= 0x17281000
DISABLE_FM																						= 0x17281100
DISABLE_VHF																						= 0x17281200
DISABLE_UHF																						= 0x17281300
DISABLE_AIM																						= 0x17281400
DISABLE_IFF																						= 0x17281500
DISABLE_ILS																						= 0x17281600
DISABLE_TCN																						= 0x17281700
DISABLE_HM																						= 0x17281800
DISABLE_VOL																						= 0x17281900

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.50 AUDIO_INTEGRATING                                                                           = 0x1732
------------------------------------------------------------------------------------------------------------------------
SECURE_VOICE_CONTROL_RADIO_SELECT_CRAD1 														= 0x17320000
SECURE_VOICE_CONTROL_RADIO_SELECT_PLAIN 														= 0x17320001
SECURE_VOICE_CONTROL_RADIO_SELECT_CRAD2 														= 0x17320002
SECURE_VOICE_CONTROL_MODE_OP 																	= 0x17320100
SECURE_VOICE_CONTROL_MODE_LD 																	= 0x17320101
SECURE_VOICE_CONTROL_MODE_RV 																	= 0x17320102
SECURE_VOICE_CONTROL_ZEROIZE_OFF 																= 0x17320200
SECURE_VOICE_CONTROL_ZEROIZE_ON 																= 0x17320201
SECURE_VOICE_CONTROL_DELAY_OFF																	= 0x17320300
SECURE_VOICE_CONTROL_DELAY_ON																	= 0x17320301
SECURE_VOICE_CONTROL_ENCRYPTION_CODE1 															= 0x17320400
SECURE_VOICE_CONTROL_ENCRYPTION_CODE2 															= 0x17320401
SECURE_VOICE_CONTROL_ENCRYPTION_CODE3 															= 0x17320402
SECURE_VOICE_CONTROL_ENCRYPTION_CODE4 															= 0x17320403
SECURE_VOICE_CONTROL_ENCRYPTION_CODE5 															= 0x17320404
SECURE_VOICE_CONTROL_ENCRYPTION_CODE6 															= 0x17320405
SECURE_VOICE_CONTROL_POWER_OFF																	= 0x17320500
SECURE_VOICE_CONTROL_POWER_ON																	= 0x17320501

-- VRS F/A18E
RELAY_CIPHER 																					= 0x17320600
RELAY_OFF																						= 0x17320601
RELAY_PLAIN																						= 0x17320602
G_XMT_COMM1																						= 0x17320700
G_XMT_OFF																						= 0x17320701
G_XMT_COMM2																						= 0x17320702
ILS_CHANNEL_01																					= 0x17320800
ILS_CHANNEL_02																					= 0x17320801	
ILS_CHANNEL_03																					= 0x17320802
ILS_CHANNEL_04																					= 0x17320803
ILS_CHANNEL_05																					= 0x17320804
ILS_CHANNEL_06																					= 0x17320805
ILS_CHANNEL_07																					= 0x17320806
ILS_CHANNEL_08																					= 0x17320807
ILS_CHANNEL_09																					= 0x17320808
ILS_CHANNEL_10																					= 0x17320809
ILS_CHANNEL_11																					= 0x1732080A
ILS_CHANNEL_12																					= 0x1732080B
ILS_CHANNEL_13																					= 0x1732080C
ILS_CHANNEL_14																					= 0x1732080D
ILS_CHANNEL_15																					= 0x1732080E
ILS_CHANNEL_16																					= 0x1732080F
ILS_CHANNEL_17																					= 0x17320810
ILS_CHANNEL_18																					= 0x17320811
ILS_CHANNEL_19																					= 0x17320812
ILS_CHANNEL_20																					= 0x17320813
ILS_UFC																							= 0x17320900
ILS_MAIN																						= 0x17320901
IFF_CRYPTO_HOLD																					= 0x17320A00
IFF_CRYPTO_NORM																					= 0x17320A01
IFF_CRYPTO_ZERO																					= 0x17320A02
IFF_MODE4_DISAUD																				= 0x17320B00
IFF_MODE4_DIS																					= 0x17320B01
IFF_MODE4_OFF																					= 0x17320B02
IFF_MASTER_EMER																					= 0x17320C00
IFF_MASTER_NORM																					= 0x17320C01
VOLUME_VOX																						= 0x17320D00
VOLUME_ICS																						= 0x17320D01
VOLUME_VOICE																					= 0x17320D02
VOLUME_AUR																						= 0x17320D03
VOLUME_RWR																						= 0x17320D04
VOLUME_WPN																						= 0x17320D05
VOLUME_TACAN																					= 0x17320D06
VOLUME_AUX																						= 0x17320D07
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.60 STATIC_DISCHARGING                                                                          = 0x173C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.70 AUDIO_AND_VIDEO_MONITORING                                                                  = 0x1746
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 23.80 INTEGRATED_AUTOMATIC_TUNING                                                                 = 0x1750
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 24 ELECTRICAL_POWER_GENERAL                                                                          = 0x1800
------------------------------------------------------------------------------------------------------------------------
GENERATOR_1_TRANSFER_BUS_ON																		= 0x18000001
GENERATOR_1_TRANSFER_BUS_OFF																	= 0x18000000
GENERATOR_2_TRANSFER_BUS_ON																		= 0x18000101
GENERATOR_2_TRANSFER_BUS_OFF																	= 0x18000100
APU_GEN_TRANSFER_BUS_1_ON																		= 0x18000201
APU_GEN_TRANSFER_BUS_1_OFF																		= 0x18000200
APU_GEN_TRANSFER_BUS_2_ON																		= 0x18000301
APU_GEN_TRANSFER_BUS_2_OFF																		= 0x18000300
TRANSFER_BUS_OFF                  																= 0x18000400
TRANSFER_BUS_AUTO                																= 0x18000401

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 24.10 GENERATOR_DRIVE                                                                             = 0x180A
------------------------------------------------------------------------------------------------------------------------
APU_GENERATOR_ON                                                                                = 0x180A0001
APU_GENERATOR_OFF                                                                               = 0x180A0000
APU_GENERATOR_START                                                                             = 0x180A0002

-- VRS F/A18E
ENGINE_CRANK_LEFT                    															= 0x180A0100
ENGINE_CRANK_RIGHT                    															= 0x180A0101
ENGINE_CRANK_OFF                    															= 0x180A0102
GEN_TIE_CONTROL_RESET                   														= 0x180A0200
GEN_TIE_CONTROL_NORM                   															= 0x180A0202
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 24.20 AC_GENERATION                                                                               = 0x1814
------------------------------------------------------------------------------------------------------------------------
INVERTER_OFF																					= 0x18140000
INVERTER_STANDBY                                                                                = 0x18140001
INVERTER_TEST                                                                                   = 0x18140002
AC_GENERATION_RIGHT_OFF                                                                         = 0x18140100
AC_GENERATION_RIGHT_ON                                                                          = 0x18140101
AC_GENERATION_RIGHT_RESET                                                                       = 0x18140102
AC_GENERATION_LEFT_OFF                                                                          = 0x18140200
AC_GENERATION_LEFT_ON                                                                           = 0x18140201
AC_GENERATION_LEFT_RESET                                                                        = 0x18140202
INVERTER_MAIN                                                                                   = 0x18140301
INVERTER_SPARE                                                                                  = 0x18140302
INVERTER_BUS_AB                                                                                 = 0x18140400
INVERTER_BUS_AC                                                                                 = 0x18140401
INVERTER_BUS_BC                                                                                 = 0x18140402
INVERTER_LEFT_OFF																				= 0x18140500
INVERTER_LEFT_ON																				= 0x18140501
INVERTER_RIGHT_OFF																				= 0x18140600
INVERTER_RIGHT_ON																				= 0x18140601

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 24.30 DC_GENERATION                                                                               = 0x181E
------------------------------------------------------------------------------------------------------------------------
BATTERY_POWER_OFF                                                                               = 0x181E0000
BATTERY_POWER_ON                                                                                = 0x181E0001
BATTERY_POWER_RESET                                                                             = 0x181E0002
MAIN_GENERATOR_OFF                                                                              = 0x181E0100
MAIN_GENERATOR_RESET                                                                            = 0x181E0101
MAIN_GENERATOR_ON                                                                               = 0x181E0102
VM_BUS_BAT																					  	= 0x181E0200
VM_BUS_MAIN_GEN                                                                                 = 0x181E0201
VM_BUS_STBY_GEN                                                                                 = 0x181E0202
VM_BUS_ESS_BUS                                                                                  = 0x181E0203
VM_BUS_NONESS_BUS                                                                               = 0x181E0204
GENERATOR_START                                                                                 = 0x181E0300
GENERATOR_STBY                                                                                  = 0x181E0301
BUS_NONESS_MANUAL                                                                               = 0x181E0400
BUS_NONESS_NORMAL                                                                               = 0x181E0401
BATTERY_WARNING_DISCHARGE_OFF                                                                   = 0x181E1000
BATTERY_WARNING_DISCHARGE_ON                                                                    = 0x181E1001
BATTERY_WARNING_OVERHEAT_OFF                                                                    = 0x181E1100
BATTERY_WARNING_OVERHEAT_ON                                                                     = 0x181E1101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 24.40 EXTERNAL_POWER                                                                              = 0x1828
------------------------------------------------------------------------------------------------------------------------
GROUND_PWR_OFF																				  	= 0x18280000
GROUND_PWR_ON																				  	= 0x18280001
GROUND_PWR_RESET																				= 0x18280002
GROUND_PWR_NORM																					= 0x18280003
GROUND_PWR1_A_ON																				= 0x18280102
GROUND_PWR1_AUTO																				= 0x18280100
GROUND_PWR1_B_ON																				= 0x18280101
GROUND_PWR2_A_ON																				= 0x18280202
GROUND_PWR2_AUTO																				= 0x18280200
GROUND_PWR2_B_ON																				= 0x18280201
GROUND_PWR3_A_ON																				= 0x18280302
GROUND_PWR3_AUTO																				= 0x18280300
GROUND_PWR3_B_ON																				= 0x18280301
GROUND_PWR4_A_ON																				= 0x18280402
GROUND_PWR4_AUTO																				= 0x18280400
GROUND_PWR4_B_ON																				= 0x18280401

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 24.50 AC_ELECTRICAL_LOAD_DISTRIBUTION                                                             = 0x1832
------------------------------------------------------------------------------------------------------------------------
MAGNETO_OFF																					 	= 0x18320000
MAGNETO_LEFT																					= 0x18320001
MAGNETO_RIGHT                                                                                   = 0x18320002
MAGNETO_BOTH																					= 0x18320003

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 24.60 DC_ELECTRICAL_LOAD_DISTRIBUTION                                                             = 0x183C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 25 EQUIPMENT_FURNISHINGS_GENERAL                                                                     = 0x1900
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 25.10 FLIGHT_COMPARTMENT                                                                          = 0x190A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 25.20 PASSENGER_COMPARTMENT                                                                       = 0x1914
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 25.30 GALLEY																					  	= 0x191E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 25.40 LAVATORIES                                                                                  = 0x1928
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 25.60 EMERGENCY                                                                                   = 0x193C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 25.80 INSULATION                                                                                  = 0x1950
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 26 FIRE_PROTECTION_GENERAL                                                                           = 0x1A00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 26.10 DETECTION                                                                                   = 0x1A0A
------------------------------------------------------------------------------------------------------------------------
FIRE_WARNING_1_OFF                                                                              = 0x1A0A0000
FIRE_WARNING_1_ON                                                                               = 0x1A0A0001
FIRE_WARNING_2_OFF                                                                              = 0x1A0A0100
FIRE_WARNING_2_ON                                                                               = 0x1A0A0101
SMOKE_CARGO_OFF                                                                                 = 0x1A0A0200
SMOKE_CARGO_ON                                                                                  = 0x1A0A0201
FIRE_DETECTOR_TEST_OFF                                                                          = 0x1A0A0300
FIRE_DETECTOR_TEST_ON                                                                           = 0x1A0A0301
FIRE_TEST_LEFT_OFF																				= 0x1A0A0400
FIRE_TEST_LEFT_ON																				= 0x1A0A0401
FIRE_TEST_LEFT_WARN																				= 0x1A0A0402
FIRE_TEST_RIGHT_OFF																				= 0x1A0A0500
FIRE_TEST_RIGHT_ON																				= 0x1A0A0501
FIRE_TEST_RIGHT_WARN																			= 0x1A0A0502

-- VRS F/A18E
FIRE_TEST_A																						= 0x1A0A0600
FIRE_TEST_NORM																					= 0x1A0A0601
FIRE_TEST_B																						= 0x1A0A0602
BRAKE_TEST																						= 0x1A0A0700
PRESSURE_TEST																					= 0x1A0A0701
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 26.20 EXTINGUISHING                                                                               = 0x1A14
------------------------------------------------------------------------------------------------------------------------
FIRE_LENG_PULL_ON                                                                               = 0x1A140001
FIRE_LENG_PULL_OFF                                                                              = 0x1A140000
FIRE_APU_PULL_ON                                                                                = 0x1A140101
FIRE_APU_PULL_OFF                                                                               = 0x1A140100
FIRE_RENG_PULL_ON                                                                               = 0x1A140201
FIRE_RENG_PULL_OFF                                                                              = 0x1A140200
FIRE_ENG_DISC_OFF                                                                               = 0x1A140300
FIRE_LENG_DISC_ON                                                                               = 0x1A140301
FIRE_RENG_DISC_ON                                                                               = 0x1A140302

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 26.30 EXPLOSION_SUPPRESSION                                                                       = 0x1A1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 27 FLIGHT_CONTROLS_GENERAL                                                                           = 0x1B00
------------------------------------------------------------------------------------------------------------------------
MRFC_PITCH_YAW_CTRL_NORM 																		= 0x1B000001
MRFC_PITCH_YAW_CTRL_MAN_REV 																	= 0x1B000000

-- VRS F/A 18E
FCS_CHAN_1_IN                      																= 0x1B000100
FCS_CHAN_1_OUT                      															= 0x1B000101
FCS_CHAN_2_IN                      																= 0x1B000200
FCS_CHAN_2_OUT                      															= 0x1B000201
LAUNCH_BAR_IN                      																= 0x1B000300
LAUNCH_BAR_OUT                      															= 0x1B000301
FCS_CHAN_3_IN                      																= 0x1B000400
FCS_CHAN_3_OUT                      															= 0x1B000401
FCS_CHAN_4_IN                      																= 0x1B000500
FCS_CHAN_4_OUT                      															= 0x1B000501
HOOK_IN                       																	= 0x1B000600
HOOK_OUT                       																	= 0x1B000601
LG_IN                        																	= 0x1B000700
LG_OUT                        																	= 0x1B000701
-- EOF VRS F/A 18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.10 AILERON_TAB                                                                                 = 0x1B0A
------------------------------------------------------------------------------------------------------------------------
AILERON_EMERG_DISENG_L 																			= 0x1B0A0001
AILERON_EMERG_DISENG_STOP																		= 0x1B0A0000										
AILERON_EMERG_DISENG_R																			= 0x1B0A0002 																		

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.20 RUDDER_TAB                                                                                  = 0x1B14
------------------------------------------------------------------------------------------------------------------------
YAW_SAS_L_OFF 																					= 0x1B140000
YAW_SAS_L_ENGAGE 																				= 0x1B140001
YAW_SAS_R_OFF 																					= 0x1B140100
YAW_SAS_R_ENGAGE 																				= 0x1B140101

-- VRS F/A18E
-- 00 L, 01 1200, 02 R, 03 0300, 04 0430
RUD_TRIM_00																						= 0x1B140200
RUD_TRIM_01																						= 0x1B140201	
RUD_TRIM_02																						= 0x1B140202
RUD_TRIM_03																						= 0x1B140203
RUD_TRIM_04																						= 0x1B140204
RUD_TD_TRIM																						= 0x1B140205
GAIN_ORIDE																						= 0x1B140300
GAIN_NORM																						= 0x1B140301
RESET																							= 0x1B140400	
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.30 ELEVATOR_TAB                                                                                = 0x1B1E
------------------------------------------------------------------------------------------------------------------------
PITCH_SAS_L_OFF 																				= 0x1B1E0000
PITCH_SAS_L_ENGAGE 																				= 0x1B1E0001
PITCH_SAS_R_OFF 																				= 0x1B1E0100
PITCH_SAS_R_ENGAGE 																				= 0x1B1E0101
ELEVATOR_EMERG_DISENG_L 																		= 0x1B1E0201
ELEVATOR_EMERG_DISENG_STOP																		= 0x1B1E0200	
ELEVATOR_EMERG_DISENG_R																			= 0x1B1E0202																	

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.40 HORIZONTAL_STABILIZER                                                                       = 0x1B28
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.50 FLAPS																					   = 0x1B32
------------------------------------------------------------------------------------------------------------------------
FLAPS_UP																					    = 0x1B320000
FLAPS_1																					     	= 0x1B320001
FLAPS_2																					     	= 0x1B320002
FLAPS_3																					     	= 0x1B320003
FLAPS_DOWN																					  	= 0x1B320004
FLAPS_EMERG_RETRACT_ON 																			= 0x1B320101
FLAPS_EMERG_RETRACT_OFF 																		= 0x1B320100

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.60 SPOILER_DRAG_DEVICES_VARIABLE_AERODYNAMIC_FAIRING                                           = 0x1B3C
------------------------------------------------------------------------------------------------------------------------
SPEED_BRK_EMER_RETR_ON 																			= 0x1B3C0001
SPEED_BRK_EMER_RETR_OFF 																		= 0x1B3C0000

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.70 GUST_LOCK_DAMPENER                                                                          = 0x1B46
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 27.80 LIFT_AUGMENTING                                                                             = 0x1B50
------------------------------------------------------------------------------------------------------------------------
TAKE_OFF_TRIM_BTTN_PUSHED 																		= 0x1B500001
TAKE_OFF_TRIM_BTTN_RELEASED 																	= 0x1B500000
PITCH_ROLL_TRIM_NORM 																			= 0x1B500100
PITCH_ROLL_TRIM_OVERRIDE 																		= 0x1B500101
TRIM_BUTTON_NOSE_DN_EXECUTE 																	= 0x1B500201
TRIM_BUTTON_NOSE_DN_STOP 																		= 0x1B500200
TRIM_BUTTON_NOSE_UP_EXECUTE 																	= 0x1B500301
TRIM_BUTTON_NOSE_UP_STOP 																		= 0x1B500300
TRIM_BUTTON_L_WING_DN_EXECUTE 																	= 0x1B500401
TRIM_BUTTON_L_WING_DN_STOP 																	    = 0x1B500400
TRIM_BUTTON_R_WING_DN_EXECUTE 																	= 0x1B500501
TRIM_BUTTON_R_WING_DN_STOP																		= 0x1B500500

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 28 FUEL_GENERAL																					  	= 0x1C00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 28.10 STORAGE																					 	= 0x1C0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 28.20 FUEL_DISTRIBUTION                                                                           = 0x1C14
------------------------------------------------------------------------------------------------------------------------
FUEL_PUMP_OFF                                                                                   = 0x1C140000
FUEL_PUMP_ON																					= 0x1C140001
STARTER_OFF																					 	= 0x1C140100
STARTER_ON																					  	= 0x1C140101
FUEL_SELECTION_OFF                                                                              = 0x1C140200
FUEL_SELECTION_LEFT                                                                             = 0x1C140201
FUEL_SELECTION_RIGHT                                                                            = 0x1C140202
FUEL_SELECTION_BOTH                                                                             = 0x1C140203
FUEL_PUMP_FWD_OFF																				= 0x1C140300
FUEL_PUMP_FWD_ON																				= 0x1C140301
FUEL_PUNP_AFT_OFF																				= 0x1C140400
FUEL_PUNP_AFT_ON																				= 0x1C140401
PRIME_PUMP_LEFT_OFF																				= 0x1C140500
PRIME_PUMP_LEFT_ON																				= 0x1C140501
PRIME_PUMP_RIGHT_OFF																			= 0x1C140600
PRIME_PUMP_RIGHT_ON																				= 0x1C140601
EXT_TKS_WING_ON 																				= 0x1C140701
EXT_TKS_WING_OFF 																				= 0x1C140700
EXT_TKS_FUS_ON 																					= 0x1C140801
EXT_TKS_FUS_OFF 																				= 0x1C140800
SIGN_AMPL_NORM_ON 																				= 0x1C140901
SIGN_AMPL_NORM_OFF 																				= 0x1C140900
LINE_CHECK_ON 																					= 0x1C140A01
LINE_CHECK_OFF 																					= 0x1C140A00
TK_GATE_OPEN 																					= 0x1C140B01
TK_GATE_CLOSE 																					= 0x1C140B00
CROSS_FEED_ON 																					= 0x1C140C01
CROSS_FEED_OFF 																					= 0x1C140C00
RCVR_LT_ON 																						= 0x1C140D01
RCVR_LT_OFF 																					= 0x1C140D00
BOOST_PUMPS_WING_L_ON 																			= 0x1C140E01
BOOST_PUMPS_WING_L_OFF 																			= 0x1C140E00
BOOST_PUMPS_WING_R_ON 																			= 0x1C140F01
BOOST_PUMPS_WING_R_OFF 																			= 0x1C140F00
FILL_DISABLE_WING_L_ON 																			= 0x1C141001
FILL_DISABLE_WING_L_OFF 																		= 0x1C141000
FILL_DISABLE_WING_R_ON 																			= 0x1C141101
FILL_DISABLE_WING_R_OFF 																		= 0x1C141100
BOOST_PUMPS_MAIN_L_ON 																			= 0x1C141201
BOOST_PUMPS_MAIN_L_OFF 																			= 0x1C141200
BOOST_PUMPS_MAIN_R_ON 																			= 0x1C141301
BOOST_PUMPS_MAIN_R_OFF 																			= 0x1C141300
FILL_DISABLE_MAIN_L_ON 																			= 0x1C141401
FILL_DISABLE_MAIN_L_OFF 																		= 0x1C141400
FILL_DISABLE_MAIN_R_ON 																			= 0x1C141501
FILL_DISABLE_MAIN_R_OFF 																		= 0x1C141500
RCVR_OPEN 																						= 0x1C141601
RCVR_CLOSE 																						= 0x1C141600

-- VRS F/A18E
EXT_TANK_LMRM_ORIDE																				= 0x1C142000
EXT_TANK_LMRM_NORM																				= 0x1C142001
EXT_TANK_LMRM_STOP																				= 0x1C142002
EXT_TANK_LIRI_ORIDE																				= 0x1C142100
EXT_TANK_LIRI_NORM																				= 0x1C142101
EXT_TANK_LIRI_STOP																				= 0x1C142102
EXT_TANK_CTR_ORIDE																				= 0x1C142200	
EXT_TANK_CTR_NORM																				= 0x1C142201
EXT_TANK_CTR_STOP																				= 0x1C142202
PROBE_EXTEND																					= 0x1C142300	
PROBE_RETRACT																					= 0x1C142301	
PROBE_EMERG_EXTD																				= 0x1C142302	
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 28.30 DUMP																					    = 0x1C1E
------------------------------------------------------------------------------------------------------------------------
-- VRS F/A18E
FUEL_DUMP_ON																					= 0x1C1E0000
FUEL_DUMP_OFF																					= 0x1C1E0001	
-- EOF VRS F/A18E
------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 28.40 INDICATING                                                                                  = 0x1C28
------------------------------------------------------------------------------------------------------------------------
FUEL_DISPLAY_SEL_INT                                                                            = 0x1C280000
FUEL_DISPLAY_SEL_MAIN                                                                           = 0x1C280001
FUEL_DISPLAY_SEL_WING                                                                           = 0x1C280002
FUEL_DISPLAY_SEL_EXT_WING                                                                       = 0x1C280003
FUEL_DISPLAY_SEL_EXT_CTR                                                                        = 0x1C280004
FUEL_DISPLAY_TEST_IND_OFF                                                                       = 0x1C280100
FUEL_DISPLAY_TEST_IND_ON                                                                        = 0x1C280101
FUEL_LOW_WARNING_1_OFF                                                                          = 0x1C280200
FUEL_LOW_WARNING_1_ON                                                                           = 0x1C280201
FUEL_LOW_WARNING_2_OFF                                                                          = 0x1C280300
FUEL_LOW_WARNING_2_ON                                                                           = 0x1C280301

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 29 HYDRAULIC_POWER_GENERAL                                                                           = 0x1D00
------------------------------------------------------------------------------------------------------------------------
-- VRS F/A18E
MC_1_OFF																						= 0x1D000000
MC_NORM																							= 0x1D000001
MC_2_OFF																						= 0x1D000002
HYD_ISOL_ORIDE																					= 0x1D000100	
HYD_ISOL_NORM																					= 0x1D000101
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 29.10 MAIN																					    = 0x1D0A
------------------------------------------------------------------------------------------------------------------------
FORCE_TRIM_OFF                                                                                  = 0x1D0A0000
FORCE_TRIM_ON                                                                                   = 0x1D0A0001
HYD_CONT_OFF																					= 0x1D0A0100
HYD_CONT_ON																					 	= 0x1D0A0101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 29.20 AUXILIARY                                                                                   = 0x1D14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 29.30 HYDRAULIC_INDICATING                                                                        = 0x1D1E
------------------------------------------------------------------------------------------------------------------------
HYD_TEST_LEFT_ON																				= 0x1D1E0001
HYD_TEST_LEFT_OFF																				= 0x1D1E0000
HYD_TEST_RIGHT_ON																				= 0x1D1E0101
HYD_TEST_RIGHT_OFF																				= 0x1D1E0100

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 30  ICE_AND_RAIN_PROTECTION_GENERAL                                                                  = 0x1E00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.10 AIRFOIL																					 	= 0x1E0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.20 AIR_INTAKES                                                                                 = 0x1E14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.30 PITOT_AND_STATIC                                                                            = 0x1E1E
------------------------------------------------------------------------------------------------------------------------
PITOT_HEAT_ON                                                                                   = 0x1E1E0001
PITOT_HEAT_OFF                                                                                  = 0x1E1E0000
PITOT_HEAT_LEFT_OFF																				= 0x1E1E0100
PITOT_HEAT_LEFT_ON																				= 0x1E1E0101
PITOT_HEAT_RIGHT_OFF																			= 0x1E1E0200
PITOT_HEAT_RIGHT_ON																				= 0x1E1E0201

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.40 WINDOWS_WINDSHIELDS_AND_DOORS                                                               = 0x1E28
------------------------------------------------------------------------------------------------------------------------
WINDSHIELD_DEICE_ON                                                                             = 0x1E280001
WINDSHIELD_DEICE_OFF                                                                            = 0x1E280000
WINDSHIELD_MODE_RAIN                                                                            = 0x1E280101
WINDSHIELD_MODE_WASH                                                                            = 0x1E280100
WINDSHIELD_MODE_OFF                                                                             = 0x1E280102
WIPER_BOTH																					  	= 0x1E280200
WIPER_PILOT																					 	= 0x1E280201
WIPER_COPILOT                                                                                   = 0x1E280202
WIPER_SEL_PARK                                                                                  = 0x1E280300
WIPER_SEL_OFF                                                                                   = 0x1E280301
WIPER_SEL_LOW                                                                                   = 0x1E280302
WIPER_SEL_MED                                                                                   = 0x1E280303
WIPER_SEL_HIGH                                                                                  = 0x1E280304

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.50 ANTENNAS_AND_RADOMES                                                                        = 0x1E32
------------------------------------------------------------------------------------------------------------------------
WEATHER_RADAR_OFF                                                                               = 0x1E320000
WEATHER_RADAR_STBY                                                                              = 0x1E320001
WEATHER_RADAR_TST                                                                               = 0x1E320002
WEATHER_RADAR_ON                                                                                = 0x1E320003
WEATHER_RADAR_STAB_OFF                                                                          = 0x1E320100
WEATHER_RADAR_STAB_ON                                                                           = 0x1E320101
WEATHER_RADAR_WX_OFF																			= 0x1E320200
WEATHER_RADAR_WX_ON																				= 0x1E320201
WEATHER_RADAR_WXA_OFF																			= 0x1E320300
WEATHER_RADAR_WXA_ON																			= 0x1E320301
WEATHER_RADAR_GND_MAP_OFF                                                                       = 0x1E320400
WEATHER_RADAR_GND_MAP_ON                                                                        = 0x1E320401
WEATHER_RADAR_VP_OFF																			= 0x1E320500
WEATHER_RADAR_VP_ON																				= 0x1E320501
WEATHER_RADAR_TRK_L_OFF                                                                         = 0x1E320600
WEATHER_RADAR_TRK_L_ON                                                                          = 0x1E320601
WEATHER_RADAR_TRK_R_OFF                                                                         = 0x1E320700
WEATHER_RADAR_TRK_R_ON                                                                          = 0x1E320701

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.60 PROPELLERS_ROTORS                                                                           = 0x1E3C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.70 WATER_LINES                                                                                 = 0x1E46
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 30.80 ICE_RAIN_DETECTION                                                                          = 0x1E50
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 31 INDICATING_RECORDING_SYSTEMS_GENERAL                                                              = 0x1F00
------------------------------------------------------------------------------------------------------------------------
AVIONICS_OFF																					= 0x1F000000
AVIONICS_ON																						= 0x1F000001
CDS_TEST_OFF																					= 0x1F000100
CDS_TEST_ON																						= 0x1F000101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.10 INSTRUMENT_AND_CONTROL_PANELS                                                               = 0x1F0A
------------------------------------------------------------------------------------------------------------------------
PFD_PILOT_OFF                                                                                   = 0x1F0A0000
PFD_PILOT_ON																					= 0x1F0A0001
ND_PILOT_OFF																					= 0x1F0A0200
ND_PILOT_ON																					 	= 0x1F0A0201
PFD_ND_COPILOT_BRT_INC_OFF                                                                      = 0x1F0A0400
PFD_ND_COPILOT_BRT_INC_ON                                                                       = 0x1F0A0401
PFD_ND_COPILOT_BRT_DEC_OFF                                                                      = 0x1F0A0500
PFD_ND_COPILOT_BRT_DEC_ON                                                                       = 0x1F0A0501
CAD_OFF																					     	= 0x1F0A0500
CAD_ON																							= 0x1F0A0501
CAD_SCROLL_OFF                                                                                  = 0x1F0A0600
CAD_SCROLL_ON                                                                                   = 0x1F0A0601
CAD_SELECT_OFF                                                                                  = 0x1F0A0700
CAD_SELECT_ON																					= 0x1F0A0701
CAD_BRT_INC_OFF                                                                                 = 0x1F0A0800
CAD_BRT_INC_ON                                                                                  = 0x1F0A0801
CAD_BRT_DEC_OFF																					= 0x1F0A0900
CAD_BRT_DEC_ON																					= 0x1F0A0901
VEMD_1_OFF																						= 0x1F0A0A00
VEMD_1_ON																						= 0x1F0A0A01
VEMD_2_OFF																						= 0x1F0A0B00
VEMD_2_ON																						= 0x1F0A0B01
VEMD_SCROLL_OFF																					= 0x1F0A0C00
VEMD_SCROLL_ON																					= 0x1F0A0C01
VEMD_RESET_OFF																					= 0x1F0A0D00
VEMD_RESET_ON																					= 0x1F0A0D01
VEMD_SELECT_OFF																					= 0x1F0A0E00
VEMD_SELECT_ON																					= 0x1F0A0E01
VEMD_INC_OFF																					= 0x1F0A0F00
VEMD_INC_ON																						= 0x1F0A0F01
VEMD_DEC_OFF																					= 0x1F0A1000
VEMD_DEC_ON																						= 0x1F0A1001
VEMD_ENTER_OFF																					= 0x1F0A1100
VEMD_ENTER_ON																					= 0x1F0A1101
VEMD_BRT_INC_OFF                                                                                = 0x1F0A1200
VEMD_BRT_INC_ON                                                                                 = 0x1F0A1201
VEMD_BRT_DEC_OFF																				= 0x1F0A1300
VEMD_BRT_DEC_ON																					= 0x1F0A1301
ICP_PILOT_PFD_OFF																				= 0x1F0A1400
ICP_PILOT_PFD_ON																				= 0x1F0A1401
ICP_PILOT_ND_OFF																				= 0x1F0A1500
ICP_PILOT_ND_ON																					= 0x1F0A1501
ICP_PILOT_ARROW1_OFF																			= 0x1F0A1600
ICP_PILOT_ARROW1_ON																				= 0x1F0A1601
ICP_PILOT_ARROW2_OFF																			= 0x1F0A1700
ICP_PILOT_ARROW2_ON																				= 0x1F0A1701
ICP_PILOT_EXT_OFF																				= 0x1F0A1800
ICP_PILOT_EXT_ON																				= 0x1F0A1801
ICP_PILOT_NAV_OFF																				= 0x1F0A1900
ICP_PILOT_NAV_ON																				= 0x1F0A1901
ICP_PILOT_ZOOM_OUT_OFF																			= 0x1F0A1A00
ICP_PILOT_ZOOM_OUT_ON																			= 0x1F0A1A01
ICP_PILOT_ZOOM_IN_OFF																			= 0x1F0A1B00
ICP_PILOT_ZOOM_IN_ON																			= 0x1F0A1B01
ICP_COPILOT_PFD_OFF																				= 0x1F0A1C00
ICP_COPILOT_PFD_ON																				= 0x1F0A1C01
ICP_COPILOT_ND_OFF																				= 0x1F0A1D00
ICP_COPILOT_ND_ON																				= 0x1F0A1D01
ICP_COPILOT_ARROW1_OFF																			= 0x1F0A1E00
ICP_COPILOT_ARROW1_ON																			= 0x1F0A1E01
ICP_COPILOT_ARROW2_OFF																			= 0x1F0A1F00
ICP_COPILOT_ARROW2_ON																			= 0x1F0A1F01
ICP_COPILOT_EXT_OFF																				= 0x1F0A2000
ICP_COPILOT_EXT_ON																				= 0x1F0A2001
ICP_COPILOT_NAV_OFF																				= 0x1F0A2100
ICP_COPILOT_NAV_ON																				= 0x1F0A2101
ICP_COPILOT_ZOOM_OUT_OFF																		= 0x1F0A2200
ICP_COPILOT_ZOOM_OUT_ON																			= 0x1F0A2201
ICP_COPILOT_ZOOM_IN_OFF																			= 0x1F0A2300
ICP_COPILOT_ZOOM_IN_ON																			= 0x1F0A2301

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.20 INDEPENDENT_INSTRUMENTS                                                                     = 0x1F14
------------------------------------------------------------------------------------------------------------------------
RADIO_ALT_PILOT_DEC                                                                             = 0x1F140000
RADIO_ALT_PILOT_INC                                                                             = 0x1F140001
RADIO_ALT_COPILOT_DEC                                                                           = 0x1F140010
RADIO_ALT_COPILOT_INC                                                                           = 0x1F140011
ARTIFICIAL_HORIZON_PILOT_SET_DEC                                                                = 0x1F140100
ARTIFICIAL_HORIZON_PILOT_SET_INC																= 0x1F140101
ARTIFICIAL_HORIZON_PILOT_PB_OFF																	= 0x1F140200
ARTIFICIAL_HORIZON_PILOT_PB_ON																	= 0x1F140201
ARTIFICIAL_HORIZON_COPILOT_SET_DEC                                                              = 0x1F140300
ARTIFICIAL_HORIZON_COPILOT_SET_INC																= 0x1F140301
ARTIFICIAL_HORIZON_COPILOT_PB_OFF																= 0x1F140400
ARTIFICIAL_HORIZON_COPILOT_PB_ON																= 0x1F140401
STBY_HORIZON_OFF																				= 0x1F140500
STBY_HORIZON_ON																					= 0x1F140501
STBY_HORIZON_TEST																				= 0x1F140502

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.30 RECORDERS                                                                                   = 0x1F1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.40 CENTRAL_COMPUTERS                                                                           = 0x1F28
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.50 CENTRAL_WARNING_SYSTEMS                                                                     = 0x1F32
------------------------------------------------------------------------------------------------------------------------
ANUNCIATOR_CTL_RESET                                                                            = 0x1F320001
ANUNCIATOR_CTL_OFF                                                                              = 0x1F320000
ANUNCIATOR_CTL_TEST                                                                             = 0x1F320002
ANUNCIATOR_LGT_BRIGHT                                                                           = 0x1F320101
ANUNCIATOR_LGT_OFF                                                                              = 0x1F320100
ANUNCIATOR_LGT_DIM                                                                              = 0x1F320102
MASTER_CAUTION_OFF																				= 0x1F320200
MASTER_CAUTION_ON																				= 0x1F320201
WARNING_TEST_OFF																				= 0x1F320300
WARNING_TEST_ON																					= 0x1F320301
SIGNAL_LIGHTS_TEST_OFF 																			= 0x1F320400
SIGNAL_LIGHTS_TEST_ON 																			= 0x1F320401

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.60 CENTRAL_DISPLAY_SYSTEMS                                                                     = 0x1F3C
------------------------------------------------------------------------------------------------------------------------
CDU_POWER_ON																					= 0x1F3C0001
CDU_POWER_OFF                                                                                   = 0x1F3C0000
EGI_POWER_ON																					= 0x1F3C0101
EGI_POWER_OFF                                                                                   = 0x1F3C0100
STEER_FLTPLAN                                                                                   = 0x1F3C0201
STEER_MARK																					  	= 0x1F3C0202
STEER_MISSION                                                                                   = 0x1F3C0203
PAGE_OTHER																					  	= 0x1F3C0301
PAGE_POSITION                                                                                   = 0x1F3C0302
PAGE_STEER																					  	= 0x1F3C0303
PAGE_WAYPT																					  	= 0x1F3C0304
STEER_UP																					    = 0x1F3C0401
STEER_OFF																					   	= 0x1F3C0400
STEER_DOWN																					  	= 0x1F3C0402

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 31.70 AUTOMATIC_DATA_REPORTING_SYSTEMS                                                            = 0x1F46
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 32 LANDING_GEAR_GENERAL                                                                              = 0x2000
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.10 MAIN_GEAR_AND_DOORS                                                                         = 0x200A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.20 NOSE_GEAR_AND_DOORS                                                                         = 0x2014
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.30 EXTENSION_AND_RETRACTION                                                                    = 0x201E
------------------------------------------------------------------------------------------------------------------------
LANDING_GEAR_UP                                                                                 = 0x201E0000
LANDING_GEAR_DOWN                                                                               = 0x201E0001
LANDING_GEAR_EMERGENCY_DOWN_OFF																	= 0x201E0100
LANDING_GEAR_EMERGENCY_DOWN_ON																	= 0x201E0101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.40 WHEELS_AND_BRAKES                                                                           = 0x2028
------------------------------------------------------------------------------------------------------------------------
ANTI_SKID_OFF                                                                                   = 0x20280000
ANTI_SKID_ON																					= 0x20280001
PARKING_BRAKE_OFF                                                                               = 0x20280100
PARKING_BRAKE_ON                                                                                = 0x20280101
BRAKE_LEFT_OFF                                                                                  = 0x20280200
BRAKE_LEFT_ON                                                                                   = 0x20280201
BRAKE_RIGHT_OFF                                                                                 = 0x20280300
BRAKE_RIGHT_ON                                                                                  = 0x20280301

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.50 STEERING																					= 0x2032
------------------------------------------------------------------------------------------------------------------------
TAIL_WHEEL_LOCK_OFF																				= 0x20320000
TAIL_WHEEL_LOCK_ON																				= 0x20320001

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.60 POSITION_AND_WARNING                                                                        = 0x203C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 32.70 SUPPLEMENTARY_GEAR                                                                          = 0x2046
------------------------------------------------------------------------------------------------------------------------
DOWNLOCK_OVERRIDE_OFF                                                                           = 0x20460000
DOWNLOCK_OVERRIDE_ON                                                                            = 0x20460001

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 33 LIGHTS_GENERAL																					= 0x2100
------------------------------------------------------------------------------------------------------------------------
-- VRS F/A 18E
FORMATION_LIGHTS																				= 0x21000000
EXT_LIGHTS_POSITION																				= 0x21000100
STROBE_LIGHTS_BRIGHT																			= 0x21000200
STROBE_LIGHTS_OFF																				= 0x21000201
STROBE_LIGHTS_DIM																				= 0x21000202
IDENT_LIGHTS_NORM																				= 0x21000300
IDENT_LIGHTS_A																					= 0x21000301
IDENT_LIGHTS_B																					= 0x21000302
IDENT_LIGHTS_C																					= 0x21000303
IDENT_LIGHTS_D																					= 0x21000304
IDENT_LIGHTS_E																					= 0x21000305
IDENT_LIGHTS_F																					= 0x21000306
INTR_WING_LIGHTS_INHIBIT																		= 0x21000400
INTR_WING_LIGHTS_NORM																			= 0x21000401
-- EOF VRS F/A 18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 33.10 LIGHTS_FLIGHT_COMPARTMENT                                                                   = 0x210A
------------------------------------------------------------------------------------------------------------------------
SIGNAL_BRT																					  	= 0x210A0001
SIGNAL_DIM																					  	= 0x210A0000
ACCELCOMP_ON																					= 0x210A0101
ACCELCOMP_OFF                                                                                   = 0x210A0100
DOME_WHITE																					  	= 0x210A0201
DOME_OFF																					    = 0x210A0200
DOME_GREEN																					  	= 0x210A0202
INSTRUMENT_LIGHT_OFF																			= 0x210A0300
INSTRUMENT_LIGHT_NORM																			= 0x210A0301
INSTRUMENT_LIGHT_NVG																			= 0x210A0302

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 33.20 LIGHTS_PASSENGER_COMPARTMENT                                                                = 0x2114
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 33.30 CARGO_AND_SERVICE_COMPARTMENTS                                                              = 0x211E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 33.40 EXTERIOR																					= 0x2128
------------------------------------------------------------------------------------------------------------------------
LAND_LIGHT_OFF                                                                                  = 0x21280000
LAND_LIGHT_ON                                                                                   = 0x21280001
LAND_LIGHT_TAXI                                                                                 = 0x21280002
LAND_LIGHT_L_OFF                                                                                = 0x21280003
LAND_LIGHT_L_EXTEND                                                                             = 0x21280004
LAND_LIGHT_L_ON                                                                                 = 0x21280005
LAND_LIGHT_R_OFF                                                                                = 0x21280006
LAND_LIGHT_R_EXTEND                                                                             = 0x21280007
LAND_LIGHT_R_ON																					= 0x21280008
LAND_LIGHT_FIXED_L_OFF                                                                          = 0x21280009
LAND_LIGHT_FIXED_L_ON                                                                           = 0x2128000A
LAND_LIGHT_FIXED_R_OFF                                                                          = 0x2128000B
LAND_LIGHT_FIXED_R_ON                                                                           = 0x2128000C
POSITION_FLASH                                                                                  = 0x21280101
POSITION_OFF																					= 0x21280100
POSITION_STEADY                                                                                 = 0x21280102
ANTICOLLISION_ON                                                                                = 0x21280201
ANTICOLLISION_OFF                                                                               = 0x21280200
NOSE_ON																					     	= 0x21280301
NOSE_OFF																					    = 0x21280300
TAXI_LIGHT_OFF                                                                                  = 0x21280400
TAXI_LIGHT_ON                                                                                   = 0x21280401
TAXI_LIGHT_AUTO																					= 0x21280402
POSITION_BRIGHT                                                                                 = 0x21280500
POSITION_DIM																					= 0x21280501
RWY_TURNOFF_LIGHT_L_OFF																			= 0x21280600
RWY_TURNOFF_LIGHT_L_ON																			= 0x21280601
RWY_TURNOFF_LIGHT_R_OFF																			= 0x21280700
RWY_TURNOFF_LIGHT_R_ON																			= 0x21280701
LOGO_LIGHT_OFF																					= 0x21280800
LOGO_LIGHT_ON																					= 0x21280801
WING_LIGHT_OFF																					= 0x21280900
WING_LIGHT_ON																					= 0x21280901
WHEEL_WELL_LIGHT_OFF																			= 0x21280A00
WHEEL_WELL_ON																					= 0x21280A01
SEARCH_LIGHT_ON 																				= 0x21280B01
SEARCH_LIGHT_OFF 																				= 0x21280B00
SEARCH_LIGHT_STOW 																				= 0x21280B02
LAND_LIGHT_EXTR																					= 0x21280C01
LAND_LIGHT_NOP																					= 0x21280C00
LAND_LIGHT_RETR																					= 0x21280C02
STROBE_OFF																						= 0x21280D00
STROBE_ON																						= 0x21280D01
NVIS_LIGHTS_TOP 																				= 0x21280E01
NVIS_LIGHTS_ALL 																				= 0x21280E02
NVIS_LIGHTS_OFF 																				= 0x21280E00

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 33.50 EMERGENCY_LIGHTING                                                                          = 0x2132
------------------------------------------------------------------------------------------------------------------------
EMERGENCY_FLOOD_OFF                                                                             = 0x21320000
EMERGENCY_FLOOD_ON                                                                              = 0x21320001

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 34 NAVIGATION_GENERAL                                                                                = 0x2200
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 34.10 FLIGHT_ENVIRONMENT_DATA                                                                     = 0x220A
------------------------------------------------------------------------------------------------------------------------
NMSP_HARS_ON																					= 0x220A0001
NMSP_HARS_OFF                                                                                   = 0x220A0000
NMSP_PTR_ABLE                                                                                   = 0x220A0101
NMSP_PTR_OFF																					= 0x220A0100
NMSP_PTR_STOW                                                                                   = 0x220A0102
NMSP_EGI_ON																					 	= 0x220A0201
NMSP_EGI_OFF																					= 0x220A0200
NMSP_TISL_ON																					= 0x220A0301
NMSP_TISL_OFF                                                                                   = 0x220A0300
NMSP_STEER_ON                                                                                   = 0x220A0401
NMSP_STEER_OFF                                                                                  = 0x220A0400
NMSP_ANCHR_ON                                                                                   = 0x220A0501
NMSP_ANCHR_OFF                                                                                  = 0x220A0500
NMSP_TCN_ON																					 	= 0x220A0601
NMSP_TCN_OFF																					= 0x220A0600
NMSP_ILS_ON																					 	= 0x220A0701
NMSP_ILS_OFF																					= 0x220A0700
QNH_ENC_INC																					 	= 0x220A0802
QNH_ENC_DEC																					 	= 0x220A0801
QNH_ENC_PUSH_STD                                                                                = 0x220A0800
QNH_COPILOT_ENC_INC                                                                             = 0x220A1002
QNH_COPILOT_ENC_DEC                                                                             = 0x220A1001
QNH_COPILOT_ENC_PUSH_STD                                                                        = 0x220A1000

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 34.20 ATTITUDE_DIRECTION                                                                          = 0x2214
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 34.30 LANDING_AND_TAXIING_AIDS                                                                    = 0x221E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 34.40 INDEPENDENT_POSITION_DETERMINING                                                            = 0x2228
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 34.50 DEPENDENT_POSITION_DETERMINING                                                              = 0x2232
------------------------------------------------------------------------------------------------------------------------
HARS_SYNC_ON																					= 0x22320001
HARS_SYNC_OFF                                                                                   = 0x22320000
HARS_SYNC_DEC                                                                                   = 0x22320101
HARS_SYNC_INC                                                                                   = 0x22320102
HARS_MAGVAR_INC                                                                                 = 0x22320201
HARS_MAGVAR_OFF                                                                                 = 0x22320200
HARS_MAGVAR_DEC                                                                                 = 0x22320202
HARS_DG_N																					   	= 0x22320301
HARS_DG_S																					   	= 0x22320300
HARS_SLAVE_ON                                                                                   = 0x22320401
HARS_SLAVE_OFF                                                                                  = 0x22320400
HARS_SAS_SWITCH_OVERRIDE 																		= 0x22320501
HARS_SAS_SWITCH_NORM 																			= 0x22320500

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 34.60 FLIGHT_MANAGEMENT_COMPUTING                                                                 = 0x223C
------------------------------------------------------------------------------------------------------------------------
UFC_STEER_INC_ON																				= 0x223C0001
UFC_STEER_INC_OFF																				= 0x223C0000
UFC_STEER_DEC_ON																				= 0x223C0101
UFC_STEER_DEC_OFF																				= 0x223C0100
UFC_OSB_1_ON																					= 0x223C0201
UFC_OSB_1_OFF																					= 0x223C0200
UFC_OSB_2_ON																					= 0x223C0301
UFC_OSB_2_OFF																					= 0x223C0300
UFC_OSB_3_ON																					= 0x223C0401
UFC_OSB_3_OFF																					= 0x223C0400
UFC_OSB_4_ON																					= 0x223C0501
UFC_OSB_4_OFF																					= 0x223C0500
UFC_OSB_5_ON																					= 0x223C0601
UFC_OSB_5_OFF																					= 0x223C0600
UFC_OSB_6_ON																					= 0x223C0701
UFC_OSB_6_OFF																					= 0x223C0700
UFC_OSB_7_ON																					= 0x223C0801
UFC_OSB_7_OFF																					= 0x223C0800
UFC_OSB_8_ON																					= 0x223C0901
UFC_OSB_8_OFF																					= 0x223C0900
UFC_OSB_9_ON																					= 0x223C0A01
UFC_OSB_9_OFF																					= 0x223C0A00
UFC_OSB_0_ON																					= 0x223C0B01
UFC_OSB_0_OFF																					= 0x223C0B00
UFC_OSB_HACK_ON																					= 0x223C0C01
UFC_OSB_HACK_OFF																				= 0x223C0C00
UFC_OSB_SPC_ON																					= 0x223C0D01
UFC_OSB_SPC_OFF																					= 0x223C0D00
UFC_OSB_FUNC_ON																					= 0x223C0E01
UFC_OSB_FUNC_OFF																				= 0x223C0E00
UFC_OSB_LTR_ON																					= 0x223C0F01
UFC_OSB_LTR_OFF																					= 0x223C0F00
UFC_OSB_CLR_ON																					= 0x223C1001
UFC_OSB_CLR_OFF																					= 0x223C1000
UFC_OSB_ENT_ON																					= 0x223C1101
UFC_OSB_ENT_OFF																					= 0x223C1100
UFC_OSB_MK_ON																					= 0x223C1201
UFC_OSB_MK_OFF																					= 0x223C1200
UFC_OSB_ALT_ON																					= 0x223C1301
UFC_OSB_ALT_OFF																					= 0x223C1300
UFC_OSB_MASTER_ON																				= 0x223C1401
UFC_OSB_MASTER_OFF																				= 0x223C1400
UFC_OSB_COM1_ON																					= 0x223C1501
UFC_OSB_COM1_OFF																				= 0x223C1500
UFC_OSB_COM2_ON																					= 0x223C1601
UFC_OSB_COM2_OFF																				= 0x223C1600
UFC_OSB_COM_SEC_ON																				= 0x223C1701
UFC_OSB_COM_SEC_OFF																				= 0x223C1700
UFC_OSB_ECCM_ON																					= 0x223C1801
UFC_OSB_ECCM_OFF																				= 0x223C1800
UFC_OSB_IFF_ON																					= 0x223C1901
UFC_OSB_IFF_OFF																					= 0x223C1900
UFC_OSB_IDM_ON																					= 0x223C1A01
UFC_OSB_IDM_OFF																					= 0x223C1A00
UFC_DATA_INC_ON																					= 0x223C1B01
UFC_DATA_INC_OFF																				= 0x223C1B00
UFC_DATA_DEC_ON																					= 0x223C1C01
UFC_DATA_DEC_OFF																				= 0x223C1C00
UFC_SEL_INC_ON																					= 0x223C1D01
UFC_SEL_INC_OFF																					= 0x223C1D00
UFC_SEL_DEC_ON																					= 0x223C1E01
UFC_SEL_DEC_OFF																					= 0x223C1E00
UFC_INTEN_INC_ON																				= 0x223C1F01
UFC_INTEN_INC_OFF																				= 0x223C1F00
UFC_INTEN_DEC_ON																				= 0x223C2001
UFC_INTEN_DEC_OFF																				= 0x223C2000
UFC_DEPR_INC_ON																					= 0x223C2101
UFC_DEPR_INC_OFF																				= 0x223C2100
UFC_DEPR_DEC_ON																					= 0x223C2201
UFC_DEPR_DEC_OFF																				= 0x223C2200
CDU_OSB_L0_OFF																					= 0x223C2300
CDU_OSB_L0_ON																					= 0x223C2301
CDU_OSB_L1_OFF																					= 0x223C2400
CDU_OSB_L1_ON																					= 0x223C2401
CDU_OSB_L2_OFF																					= 0x223C2500
CDU_OSB_L2_ON																					= 0x223C2501
CDU_OSB_L3_OFF																					= 0x223C2600
CDU_OSB_L3_ON																					= 0x223C2601
CDU_OSB_R0_OFF																					= 0x223C2700
CDU_OSB_R0_ON																					= 0x223C2701
CDU_OSB_R1_OFF																					= 0x223C2800
CDU_OSB_R1_ON																					= 0x223C2801
CDU_OSB_R2_OFF																					= 0x223C2900
CDU_OSB_R2_ON																					= 0x223C2901
CDU_OSB_R3_OFF																					= 0x223C2A00
CDU_OSB_R3_ON																					= 0x223C2A01
CDU_OSB_SYS_OFF																					= 0x223C2B00
CDU_OSB_SYS_ON																					= 0x223C2B01
CDU_OSB_NAV_OFF																					= 0x223C2C00
CDU_OSB_NAV_ON																					= 0x223C2C01
CDU_OSB_WP_OFF																					= 0x223C2D00
CDU_OSB_WP_ON																					= 0x223C2D01
CDU_OSB_OSET_OFF																				= 0x223C2E00
CDU_OSB_OSET_ON																					= 0x223C2E01
CDU_OSB_FPM_OFF																					= 0x223C2F00
CDU_OSB_FPM_ON																					= 0x223C2F01
CDU_OSB_PREV_OFF																				= 0x223C3000
CDU_OSB_PREV_ON																					= 0x223C3001
CDU_OSB_DIM_OFF																					= 0x223C3100
CDU_OSB_DIM_ON																					= 0x223C3101
CDU_OSB_BRT_OFF																					= 0x223C3200
CDU_OSB_BRT_ON																					= 0x223C3201
CDU_OSB_0_OFF																					= 0x223C3300
CDU_OSB_0_ON																					= 0x223C3301
CDU_OSB_1_OFF																					= 0x223C3400
CDU_OSB_1_ON																					= 0x223C3401
CDU_OSB_2_OFF																					= 0x223C3500
CDU_OSB_2_ON																					= 0x223C3501
CDU_OSB_3_OFF																					= 0x223C3600
CDU_OSB_3_ON																					= 0x223C3601
CDU_OSB_4_OFF																					= 0x223C3700
CDU_OSB_4_ON																					= 0x223C3701
CDU_OSB_5_OFF                                        											= 0x223C3800
CDU_OSB_5_ON                                        											= 0x223C3801
CDU_OSB_6_OFF                                        											= 0x223C3900
CDU_OSB_6_ON                                        											= 0x223C3901
CDU_OSB_7_OFF                                        											= 0x223C3A00
CDU_OSB_7_ON                                        											= 0x223C3A01
CDU_OSB_8_OFF                                        											= 0x223C3B00
CDU_OSB_8_ON                                        											= 0x223C3B01
CDU_OSB_9_OFF                                        											= 0x223C3C00
CDU_OSB_9_ON                                        											= 0x223C3C01
CDU_OSB_DOT_OFF                                        											= 0x223C3D00
CDU_OSB_DOT_ON                                        											= 0x223C3D01
CDU_OSB_SLASH_OFF                                        										= 0x223C3E00
CDU_OSB_SLASH_ON                                        										= 0x223C3E01
CDU_OSB_A_OFF                                        											= 0x223C3F00
CDU_OSB_A_ON                                        											= 0x223C3F01
CDU_OSB_B_OFF                                        											= 0x223C4000
CDU_OSB_B_ON                                        											= 0x223C4001
CDU_OSB_C_OFF                                        											= 0x223C4100
CDU_OSB_C_ON                                        											= 0x223C4101
CDU_OSB_D_OFF                                        											= 0x223C4200
CDU_OSB_D_ON                                        											= 0x223C4201
CDU_OSB_E_OFF                                        											= 0x223C4300
CDU_OSB_E_ON                                        											= 0x223C4301
CDU_OSB_F_OFF                                        											= 0x223C4400
CDU_OSB_F_ON                                        											= 0x223C4401
CDU_OSB_G_OFF                                        											= 0x223C4500
CDU_OSB_G_ON                                        											= 0x223C4501
CDU_OSB_H_OFF                                        											= 0x223C4600
CDU_OSB_H_ON                                        											= 0x223C4601
CDU_OSB_I_OFF                                        											= 0x223C4700
CDU_OSB_I_ON                                        											= 0x223C4701
CDU_OSB_J_OFF                                        											= 0x223C4800
CDU_OSB_J_ON																					= 0x223C4801
CDU_OSB_K_OFF																					= 0x223C4900
CDU_OSB_K_ON																					= 0x223C4901
CDU_OSB_L_OFF																					= 0x223C4A00
CDU_OSB_L_ON																					= 0x223C4A01
CDU_OSB_M_OFF																					= 0x223C4B00
CDU_OSB_M_ON																					= 0x223C4B01
CDU_OSB_N_OFF																					= 0x223C4C00
CDU_OSB_N_ON																					= 0x223C4C01
CDU_OSB_O_OFF																					= 0x223C4D00
CDU_OSB_O_ON																					= 0x223C4D01
CDU_OSB_P_OFF																					= 0x223C4E00
CDU_OSB_P_ON																					= 0x223C4E01
CDU_OSB_Q_OFF																					= 0x223C4F00
CDU_OSB_Q_ON																					= 0x223C4F01
CDU_OSB_R_OFF																					= 0x223C5000
CDU_OSB_R_ON																					= 0x223C5001
CDU_OSB_S_OFF																					= 0x223C5100
CDU_OSB_S_ON																					= 0x223C5101
CDU_OSB_T_OFF																					= 0x223C5200
CDU_OSB_T_ON																					= 0x223C5201
CDU_OSB_U_OFF																					= 0x223C5300
CDU_OSB_U_ON																					= 0x223C5301
CDU_OSB_V_OFF																					= 0x223C5400
CDU_OSB_V_ON																					= 0x223C5401
CDU_OSB_W_OFF																					= 0x223C5500
CDU_OSB_W_ON																					= 0x223C5501
CDU_OSB_X_OFF																					= 0x223C5600
CDU_OSB_X_ON																					= 0x223C5601
CDU_OSB_Y_OFF																					= 0x223C5700
CDU_OSB_Y_ON																					= 0x223C5701
CDU_OSB_Z_OFF																					= 0x223C5800
CDU_OSB_Z_ON																					= 0x223C5801
CDU_OSB_INC_OFF																					= 0x223C5900
CDU_OSB_INC_ON																					= 0x223C5901
CDU_OSB_DEC_OFF																					= 0x223C5A00
CDU_OSB_DEC_ON																					= 0x223C5A01
CDU_OSB_BLK0_OFF																				= 0x223C5B00
CDU_OSB_BLK0_ON																					= 0x223C5B01
CDU_OSB_BLK1_OFF																				= 0x223C5C00
CDU_OSB_BLK1_ON																					= 0x223C5C01
CDU_OSB_BCK_OFF																					= 0x223C5D00
CDU_OSB_BCK_ON																					= 0x223C5D01
CDU_OSB_SPC_OFF																					= 0x223C5E00
CDU_OSB_SPC_ON																					= 0x223C5E01
CDU_OSB_MK_OFF																					= 0x223C5F00
CDU_OSB_MK_ON																					= 0x223C5F01
CDU_OSB_LEFT_OFF																				= 0x223C6000
CDU_OSB_LEFT_ON																					= 0x223C6001
CDU_OSB_RIGHT_OFF																				= 0x223C6100
CDU_OSB_RIGHT_ON																				= 0x223C6101
CDU_OSB_CLR_OFF																					= 0x223C6200
CDU_OSB_CLR_ON																					= 0x223C6201
CDU_OSB_FA_OFF																					= 0x223C6300
CDU_OSB_FA_ON																					= 0x223C6301
CDU_OSB_P_UP_OFF																				= 0x223C6400
CDU_OSB_P_UP_ON																					= 0x223C6401
CDU_OSB_G_DOWN_OFF																				= 0x223C6500
CDU_OSB_G_DOWN_ON																				= 0x223C6501

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 35 OXYGEN_GENERAL																					= 0x2300
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 35.10 CREW																					    = 0x230A
------------------------------------------------------------------------------------------------------------------------
OXY_IND_TEST_ON                                                                                 = 0x230A0001
OXY_IND_TEST_OFF                                                                                = 0x230A0000

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 35.20 PASSENGER                                                                                   = 0x2314
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 35.30 PORTABLE																					= 0x231E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 36 PNEUMATIC_GENERAL                                                                                 = 0x2400
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 36.10 PNEUMATIC_DISTRIBUTION                                                                      = 0x240A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 36.20 PNEUMATIC_INDICATING                                                                        = 0x2414
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 37 VACUUM_GENERAL																					= 0x2500
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 37.10 VACUUM_DISTRIBUTION                                                                         = 0x250A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 37.20 VACUUM_INDICATING                                                                           = 0x2514
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 38 WATER_WASTE_GENERAL                                                                               = 0x2600
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 38.10 POTABLE																					 	= 0x260A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 38.20 WASH																					    = 0x2614
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 38.30 WASTE_DISPOSAL                                                                              = 0x261E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 38.40 AIR_SUPPLY                                                                                  = 0x2628
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 44 CABIN_SYSTEMS_GENERAL                                                                             = 0x2C00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 44.10 CABIN_CORE_SYSTEM                                                                           = 0x2C0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 44.20 IN_FLIGHT_ENTERTAINMENT_SYSTEM                                                              = 0x2C14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 44.30 EXTERNAL_COMMUNICATION_SYSTEM                                                               = 0x2C1E
------------------------------------------------------------------------------------------------------------------------
COM1_MHZ_DEC																					= 0x2C1E0001
COM1_MHZ_INC																					= 0x2C1E0002
COM1_KHZ_DEC																					= 0x2C1E0101
COM1_KHZ_INC																					= 0x2C1E0102
COM1_PUSH_TEST_OFF                                                                              = 0x2C1E0200
COM1_PUSH_TEST_ON                                                                               = 0x2C1E0201
COM1_ACT_SBY_TOGGLE_OFF                                                                         = 0x2C1E0300
COM1_ACT_SBY_TOGGLE_ON                                                                          = 0x2C1E0301
COM1_CHANNEL_OFF                                                                                = 0x2C1E0400
COM1_CHANNEL_ON                                                                                 = 0x2C1E0401
COM1_PUSH_K_OFF                                                                                 = 0x2C1E0500
COM1_PUSH_K_ON                                                                                  = 0x2C1E0501
COM2_MHZ_DEC																					= 0x2C1E0601
COM2_MHZ_INC																					= 0x2C1E0602
COM2_KHZ_DEC																					= 0x2C1E0701
COM2_KHZ_INC																					= 0x2C1E0702
COM2_PUSH_TEST_OFF                                                                              = 0x2C1E0800
COM2_PUSH_TEST_ON                                                                               = 0x2C1E0801
COM2_ACT_SBY_TOGGLE_OFF                                                                         = 0x2C1E0900
COM2_ACT_SBY_TOGGLE_ON                                                                          = 0x2C1E0901
COM2_CHANNEL_OFF                                                                                = 0x2C1E0A00
COM2_CHANNEL_ON                                                                                 = 0x2C1E0A01
COM2_PUSH_K_OFF                                                                                 = 0x2C1E0B00
COM2_PUSH_K_ON                                                                                  = 0x2C1E0B01
NAV1_MHZ_DEC																					= 0x2C1E0C01
NAV1_MHZ_INC																					= 0x2C1E0C02
NAV1_KHZ_DEC																					= 0x2C1E0D01
NAV1_KHZ_INC																					= 0x2C1E0D02
NAV1_PUSH_IDENT_OFF                                                                             = 0x2C1E0E00
NAV1_PUSH_IDENT_ON                                                                              = 0x2C1E0E01
NAV1_ACT_SBY_TOGGLE_OFF                                                                         = 0x2C1E0F00
NAV1_ACT_SBY_TOGGLE_ON                                                                          = 0x2C1E0F01
NAV1_MODE_OFF                                                                                   = 0x2C1E1000
NAV1_MODE_ON																					= 0x2C1E1001
NAV1_PUSH_OBS_OFF                                                                               = 0x2C1E1100
NAV1_PUSH_OBS_ON                                                                                = 0x2C1E1101
NAV2_MHZ_DEC																					= 0x2C1E1201
NAV2_MHZ_INC																					= 0x2C1E1202
NAV2_KHZ_DEC																					= 0x2C1E1301
NAV2_KHZ_INC																					= 0x2C1E1302
NAV2_PUSH_IDENT_OFF                                                                             = 0x2C1E1400
NAV2_PUSH_IDENT_ON                                                                              = 0x2C1E1401
NAV2_ACT_SBY_TOGGLE_OFF                                                                         = 0x2C1E1500
NAV2_ACT_SBY_TOGGLE_ON                                                                          = 0x2C1E1501
NAV2_MODE_OFF                                                                                   = 0x2C1E1600
NAV2_MODE_ON																					= 0x2C1E1601
NAV2_PUSH_OBS_OFF                                                                               = 0x2C1E1700
NAV2_PUSH_OBS_ON                                                                                = 0x2C1E1701
RADIO_ICS_OFF 																					= 0x2C1E1800
RADIO_ICS_ON 																					= 0x2C1E1801
UHF_FREQUENCY_INC																				= 0x2C1E1902
UHF_FREQUENCY_DEC																				= 0x2C1E1901
UHF_CHANNEL_INC																					= 0x2C1E1A02
UHF_CHANNEL_DEC																					= 0x2C1E1A01
UHF_MODE_OFF																					= 0x2C1E1B00
UHF_MODE_ON																						= 0x2C1E1B01
UHF_MODE_LSB																					= 0x2C1E1C01
UHF_MODE_USB																					= 0x2C1E1C02
UHF_MODE_AM																						= 0x2C1E1C03
UHF_MODE_TEL																					= 0x2C1E1C04
UHF_STD_OFF																						= 0x2C1E1D00
UHF_STD_ON																						= 0x2C1E1D01
UHF_TONE_OFF																					= 0x2C1E1E00
UHF_TONE_ON																						= 0x2C1E1E01
UHF_TEST_OFF																					= 0x2C1E1F00
UHF_TEST_ON																						= 0x2C1E1F01

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 44.40 CABIN_MASS_MEMORY_SYSTEM                                                                    = 0x2C28
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 44.50 CABIN_MONITORING_SYSTEM                                                                     = 0x2C32
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 44.60 MISCELLANEOUS_CABIN_SYSTEM                                                                  = 0x2C3C
------------------------------------------------------------------------------------------------------------------------
MASTER_ARM_ON                                                                                   = 0x2C3C0001
MASTER_ARM_SAFE                                                                                 = 0x2C3C0000
MASTER_ARM_TRAIN                                                                                = 0x2C3C0002
GUNPAC_ARM																					  	= 0x2C3C0101
GUNPAC_SAFE																					 	= 0x2C3C0100
GUNPAC_GUNARM                                                                                   = 0x2C3C0102
LASER_ARM																					   	= 0x2C3C0201
LASER_SAFE																					  	= 0x2C3C0200
LASER_TRAIN																					 	= 0x2C3C0202
TGP_ON																					      	= 0x2C3C0301
TGP_OFF																					     	= 0x2C3C0300
ALT_SCE_BARO																					= 0x2C3C0401
ALT_SCE_DELTA                                                                                   = 0x2C3C0400
ALT_SCE_RADAR                                                                                   = 0x2C3C0402
HUD_MODE_DAY																					= 0x2C3C0501
HUD_MODE_NIGHT                                                                                  = 0x2C3C0500
HUD_MODE_NORMAL                                                                                 = 0x2C3C0601
HUD_MODE_STBY                                                                                   = 0x2C3C0600
CICU_ON																					     	= 0x2C3C0701
CICU_OFF																					    = 0x2C3C0700
JTRS_ON																					     	= 0x2C3C0801
JTRS_OFF																					    = 0x2C3C0800
IFCC_ON																					     	= 0x2C3C0901
IFCC_TEST																					   	= 0x2C3C0900
IFCC_OFF																					    = 0x2C3C0902
WEAPON_SAFE																						= 0x2C3C0A00
WEAPON_ARMED																					= 0x2C3C0A01
WEAPON_CENTER_SAFE																				= 0x2C3C0A10
WEAPON_CENTER_ARMED																				= 0x2C3C0A11
WEAPON_WING_LEFT_SAFE																			= 0x2C3C0A20
WEAPON_WING_LEFT_ARMED																			= 0x2C3C0A21
WEAPON_WING_RIGHT_SAFE																			= 0x2C3C0A30
WEAPON_WING_RIGHT_ARMED																			= 0x2C3C0A31
BOMB_FUSING_OFF																					= 0x2C3C0B00
BOMB_FUSING_DIVE_DELAYED																		= 0x2C3C0B01
BOMB_FUSING_DIVE_INSTANT																		= 0x2C3C0B02
BOMB_FUSING_LEVEL_DELAYED																		= 0x2C3C0B11
BOMB_FUSING_LEVEL_INSTANT																		= 0x2C3C0B12
BOMB_EMERGENCY_RELEASE_OFF																		= 0x2C3C0B20
BOMB_EMERGENCY_RELEASE_ON																		= 0x2C3C0B21

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 45 CENTRAL_MAINTENANCE_SYSTEM_CMS_GENERAL                                                            = 0x2D00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 45.05 CMS_AIRCRAFT_GENERAL                                                                        = 0x2D05
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 45.20 CMS_AIRFRAME_SYSTEMS                                                                        = 0x2D14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 45.45 CENTRAL_MAINTENANCE_SYSTEM                                                                  = 0x2D2D
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 45.50 CMS_STRUCTURES                                                                              = 0x2D32
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 45.60 CMS_PROPELLERS                                                                              = 0x2D3C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 45.70 CMS_POWER_PLANT                                                                             = 0x2D46
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 46 INFORMATION_SYSTEMS_GENERAL                                                                       = 0x2E00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 46.10 AIRPLANE_GENERAL_INFORMATION_SYSTEMS                                                        = 0x2E0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 46.20 FLIGHT_DECK_INFORMATION_SYSTEMS                                                             = 0x2E14
------------------------------------------------------------------------------------------------------------------------
LMFCD_OSB0_OFF                                                                                  = 0x2E140000
LMFCD_OSB0_ON                                                                                   = 0x2E140001
LMFCD_OSB1_OFF                                                                                  = 0x2E140100
LMFCD_OSB1_ON                                                                                   = 0x2E140101
LMFCD_OSB2_OFF                                                                                  = 0x2E140200
LMFCD_OSB2_ON                                                                                   = 0x2E140201
LMFCD_OSB3_OFF                                                                                  = 0x2E140300
LMFCD_OSB3_ON                                                                                   = 0x2E140301
LMFCD_OSB4_OFF                                                                                  = 0x2E140400
LMFCD_OSB4_ON                                                                                   = 0x2E140401
LMFCD_OSB5_OFF                                                                                  = 0x2E140500
LMFCD_OSB5_ON                                                                                   = 0x2E140501
LMFCD_OSB6_OFF                                                                                  = 0x2E140600
LMFCD_OSB6_ON                                                                                   = 0x2E140601
LMFCD_OSB7_OFF                                                                                  = 0x2E140700
LMFCD_OSB7_ON                                                                                   = 0x2E140701
LMFCD_OSB8_OFF                                                                                  = 0x2E140800
LMFCD_OSB8_ON                                                                                   = 0x2E140801
LMFCD_OSB9_OFF                                                                                  = 0x2E140900
LMFCD_OSB9_ON                                                                                   = 0x2E140901
LMFCD_OSB10_OFF                                                                                 = 0x2E140A00
LMFCD_OSB10_ON                                                                                  = 0x2E140A01
LMFCD_OSB11_OFF                                                                                 = 0x2E140B00
LMFCD_OSB11_ON                                                                                  = 0x2E140B01
LMFCD_OSB12_OFF                                                                                 = 0x2E140C00
LMFCD_OSB12_ON                                                                                  = 0x2E140C01
LMFCD_OSB13_OFF                                                                                 = 0x2E140D00
LMFCD_OSB13_ON                                                                                  = 0x2E140D01
LMFCD_OSB14_OFF                                                                                 = 0x2E140E00
LMFCD_OSB14_ON                                                                                  = 0x2E140E01
LMFCD_OSB15_OFF                                                                                 = 0x2E140F00
LMFCD_OSB15_ON                                                                                  = 0x2E140F01
LMFCD_OSB16_OFF                                                                                 = 0x2E141000
LMFCD_OSB16_ON                                                                                  = 0x2E141001
LMFCD_OSB17_OFF                                                                                 = 0x2E141100
LMFCD_OSB17_ON                                                                                  = 0x2E141101
LMFCD_OSB18_OFF                                                                                 = 0x2E141200
LMFCD_OSB18_ON                                                                                  = 0x2E141201
LMFCD_OSB19_OFF                                                                                 = 0x2E141300
LMFCD_OSB19_ON                                                                                  = 0x2E141301
LMFCD_INC_ADJ_OFF                                                                               = 0x2E141400
LMFCD_INC_ADJ_ON                                                                                = 0x2E141401
LMFCD_DEC_ADJ_OFF                                                                               = 0x2E141500
LMFCD_DEC_ADJ_ON                                                                                = 0x2E141501
LMFCD_INC_DSP_OFF                                                                               = 0x2E141600
LMFCD_INC_DSP_ON                                                                                = 0x2E141601
LMFCD_DEC_DSP_OFF                                                                               = 0x2E141700
LMFCD_DEC_DSP_ON                                                                                = 0x2E141701
LMFCD_INC_BRT_OFF                                                                               = 0x2E141800
LMFCD_INC_BRT_ON                                                                                = 0x2E141801
LMFCD_DEC_BRT_OFF                                                                               = 0x2E141900
LMFCD_DEC_BRT_ON                                                                                = 0x2E141901
LMFCD_INC_CON_OFF                                                                               = 0x2E141A00
LMFCD_INC_CON_ON                                                                                = 0x2E141A01
LMFCD_DEC_CON_OFF                                                                               = 0x2E141B00
LMFCD_DEC_CON_ON                                                                                = 0x2E141B01
LMFCD_INC_SYM_OFF                                                                               = 0x2E141C00
LMFCD_INC_SYM_ON                                                                                = 0x2E141C01
LMFCD_DEC_SYM_OFF                                                                               = 0x2E141D00
LMFCD_DEC_SYM_ON                                                                                = 0x2E141D01
LMFCD_SEL_OFF                                                                                   = 0x2E141E00
LMFCD_SEL_NIGHT                                                                                 = 0x2E141E01
LMFCD_SEL_DAY                                                                                   = 0x2E141E02
RMFCD_OSB0_OFF                                                                                  = 0x2E141F00
RMFCD_OSB0_ON                                                                                   = 0x2E141F01
RMFCD_OSB1_OFF                                                                                  = 0x2E142000
RMFCD_OSB1_ON                                                                                   = 0x2E142001
RMFCD_OSB2_OFF                                                                                  = 0x2E142100
RMFCD_OSB2_ON                                                                                   = 0x2E142101
RMFCD_OSB3_OFF                                                                                  = 0x2E142200
RMFCD_OSB3_ON                                                                                   = 0x2E142201
RMFCD_OSB4_OFF                                                                                  = 0x2E142300
RMFCD_OSB4_ON                                                                                   = 0x2E142301
RMFCD_OSB5_OFF                                                                                  = 0x2E142400
RMFCD_OSB5_ON                                                                                   = 0x2E142401
RMFCD_OSB6_OFF                                                                                  = 0x2E142500
RMFCD_OSB6_ON                                                                                   = 0x2E142501
RMFCD_OSB7_OFF                                                                                  = 0x2E142600
RMFCD_OSB7_ON                                                                                   = 0x2E142601
RMFCD_OSB8_OFF                                                                                  = 0x2E142700
RMFCD_OSB8_ON                                                                                   = 0x2E142701
RMFCD_OSB9_OFF                                                                                  = 0x2E142800
RMFCD_OSB9_ON                                                                                   = 0x2E142801
RMFCD_OSB10_OFF                                                                                 = 0x2E142900
RMFCD_OSB10_ON                                                                                  = 0x2E142901
RMFCD_OSB11_OFF                                                                                 = 0x2E142A00
RMFCD_OSB11_ON                                                                                  = 0x2E142A01
RMFCD_OSB12_OFF                                                                                 = 0x2E142B00
RMFCD_OSB12_ON                                                                                  = 0x2E142B01
RMFCD_OSB13_OFF                                                                                 = 0x2E142C00
RMFCD_OSB13_ON                                                                                  = 0x2E142C01
RMFCD_OSB14_OFF                                                                                 = 0x2E142D00
RMFCD_OSB14_ON                                                                                  = 0x2E142D01
RMFCD_OSB15_OFF                                                                                 = 0x2E142E00
RMFCD_OSB15_ON                                                                                  = 0x2E142E01
RMFCD_OSB16_OFF                                                                                 = 0x2E142F00
RMFCD_OSB16_ON                                                                                  = 0x2E142F01
RMFCD_OSB17_OFF                                                                                 = 0x2E143000
RMFCD_OSB17_ON                                                                                  = 0x2E143001
RMFCD_OSB18_OFF                                                                                 = 0x2E143100
RMFCD_OSB18_ON                                                                                  = 0x2E143101
RMFCD_OSB19_OFF                                                                                 = 0x2E143200
RMFCD_OSB19_ON                                                                                  = 0x2E143201
RMFCD_INC_ADJ_OFF                                                                               = 0x2E143300
RMFCD_INC_ADJ_ON                                                                                = 0x2E143301
RMFCD_DEC_ADJ_OFF                                                                               = 0x2E143400
RMFCD_DEC_ADJ_ON                                                                                = 0x2E143401
RMFCD_INC_DSP_OFF                                                                               = 0x2E143500
RMFCD_INC_DSP_ON                                                                                = 0x2E143501
RMFCD_DEC_DSP_OFF                                                                               = 0x2E143600
RMFCD_DEC_DSP_ON                                                                                = 0x2E143601
RMFCD_INC_BRT_OFF                                                                               = 0x2E143700
RMFCD_INC_BRT_ON                                                                                = 0x2E143701
RMFCD_DEC_BRT_OFF                                                                               = 0x2E143800
RMFCD_DEC_BRT_ON                                                                                = 0x2E143801
RMFCD_INC_CON_OFF                                                                               = 0x2E143900
RMFCD_INC_CON_ON                                                                                = 0x2E143901
RMFCD_DEC_CON_OFF                                                                               = 0x2E143A00
RMFCD_DEC_CON_ON                                                                                = 0x2E143A01
RMFCD_INC_SYM_OFF                                                                               = 0x2E143B00
RMFCD_INC_SYM_ON                                                                                = 0x2E143B01
RMFCD_DEC_SYM_OFF                                                                               = 0x2E143C00
RMFCD_DEC_SYM_ON                                                                                = 0x2E143C01
RMFCD_SEL_OFF                                                                                   = 0x2E143D00
RMFCD_SEL_NIGHT                                                                                 = 0x2E143D01
RMFCD_SEL_DAY                                                                                   = 0x2E143D02

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 46.30 MAINTENANCE_INFORMATION_SYSTEMS                                                             = 0x2E1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 46.40 PASSENGER_CABIN_INFORMATION_SYSTEMS                                                         = 0x2E28
------------------------------------------------------------------------------------------------------------------------
NO_SMOKING_LIGHT_OFF																			= 0x2E280000
NO_SMOKING_LIGHT_AUTO																			= 0x2E280001
NO_SMOKING_LIGHT_ON																				= 0x2E280002
FASTEN_BELTS_LIGHT_OFF																			= 0x2E280100
FASTEN_BELTS_LIGHT_AUTO																			= 0x2E280101
FASTEN_BELTS_LIGHT_ON																			= 0x2E280102

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 46.50 MISCELLANEOUS_INFORMATION_SYSTEMS                                                           = 0x2E32
------------------------------------------------------------------------------------------------------------------------
IFF_ANT_BOTH																					= 0x2E320000
IFF_ANT_UPPER                                                                                   = 0x2E320001
IFF_ANT_LOWER                                                                                   = 0x2E320002
SAT_ANT_OFF																					 	= 0x2E320100
SAT_ANT_HIGH																					= 0x2E320101
SAT_ANT_LOW																					 	= 0x2E320102
EGI_HQ_TOD_ARC_210                                                                              = 0x2E320202
EGI_HQ_TOD_ARC_164                                                                              = 0x2E320201
EGI_HQ_TOD_ARC_OFF																				= 0x2E320200
TEMS_DATA_OFF                                                                                   = 0x2E320300
TEMS_DATA_ON																					= 0x2E320301
EW_OSB1_ON																					  	= 0x2E320401
EW_OSB1_OFF																					 	= 0x2E320400
EW_OSB2_ON																					  	= 0x2E320501
EW_OSB2_OFF																					 	= 0x2E320500
EW_OSB3_ON																					  	= 0x2E320601
EW_OSB3_OFF																					 	= 0x2E320600
EW_OSB4_ON																					  	= 0x2E320701
EW_OSB4_OFF																					 	= 0x2E320700
EW_NXT_UP_ON																					= 0x2E320801
EW_NXT_UP_OFF                                                                                   = 0x2E320800
EW_NXT_DOWN_ON                                                                                  = 0x2E320901
EW_NXT_DOWN_OFF                                                                                 = 0x2E320900
EW_RTN_ON																					   	= 0x2E320A01
EW_RTN_OFF																					  	= 0x2E320A00
EW_JTSN_ON																					  	= 0x2E320B01
EW_JTSN_OFF																					 	= 0x2E320B00
EW_MWS_UP																					   	= 0x2E320C01
EW_MWS_CENTER                                                                                   = 0x2E320C00
EW_MWS_DOWN																					 	= 0x2E320C02
EW_JMR_UP																					   	= 0x2E320D01
EW_JMR_CENTER                                                                                   = 0x2E320D00
EW_JMR_DOWN																					 	= 0x2E320D02
EW_RWR_UP																					   	= 0x2E320E01
EW_RWR_CENTER                                                                                   = 0x2E320E00
EW_RWR_DOWN																					 	= 0x2E320E02
EW_DISP_UP																					  	= 0x2E320F01
EW_DISP_CENTER                                                                                  = 0x2E320F00
EW_DISP_DOWN																					= 0x2E320F02
EW_MODE_OFF																					 	= 0x2E321001
EW_MODE_STBY																					= 0x2E321002
EW_MODE_MAN																					 	= 0x2E321003
EW_MODE_SEMI																					= 0x2E321004
EW_MODE_AUTO																					= 0x2E321005
IFF_CODE_HOLD_OFF																				= 0x2E322000
IFF_CODE_HOLD_ON																				= 0x2E322001

-- VRS F/A18E
COMM1_UPPER																						= 0x2E323000
COMM1_AUTO																						= 0x2E323001
COMM1_LOWER																						= 0x2E323002
-- EOF VRS F/A18E

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 49 AIRBORNE_AUXILIARY_POWER_GENERAL                                                                  = 0x3100
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.10 POWER_PLANT                                                                                 = 0x310A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.20 ENGINE																					  	= 0x3114
------------------------------------------------------------------------------------------------------------------------
ENG_MAIN_SW1_OFF																				= 0x31140000
ENG_MAIN_SW1_IDLE																				= 0x31140001
ENG_MAIN_SW1_FLIGHT																				= 0x31140002
ENG_MAIN_SW2_OFF																				= 0x31140100
ENG_MAIN_SW2_IDLE																				= 0x31140101
ENG_MAIN_SW2_FLIGHT																				= 0x31140102

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.30 ENGINE_FUEL_AND_CONTROL                                                                     = 0x311E
------------------------------------------------------------------------------------------------------------------------
LOW_RPM_ALERT_OFF                                                                               = 0x311E0000
LOW_RPM_ALERT_ON                                                                                = 0x311E0001
FUEL_OFF																					    = 0x311E0100
FUEL_ON																					     	= 0x311E0101
DEICE_OFF																					   	= 0x311E0400
DEICE_ON																					    = 0x311E0401
GOVERNOR_OFF																					= 0x311E0500
GOVERNOR_ON																					 	= 0x311E0501
GOVERNOR_INC 																					= 0x313C0601
GOVERNOR_NOP  																					= 0x313C0600
GOVERNOR_DEC 																					= 0x313C0602

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.40 IGNITION_AND_STARTING                                                                       = 0x3128
------------------------------------------------------------------------------------------------------------------------
ENG_1_GND																						= 0x31280001
ENG_1_OFF																						= 0x31280000
ENG_1_CONT																						= 0x31280002
ENG_1_FLT																						= 0x31280003
ENG_2_GND																						= 0x31280101
ENG_2_OFF																						= 0x31280100
ENG_2_CONT																						= 0x31280102
ENG_2_FLT																						= 0x31280103
IGNITION_SELECT_1																				= 0x31280200
IGNITION_SELECT_BOTH																			= 0x31280201
IGNITION_SELECT_2																				= 0x31280202
RELEASE_STARTER_ENG_1_OFF                                                                       = 0x31280300
RELEASE_STARTER_ENG_1_ON                                                                        = 0x31280301
RELEASE_STARTER_ENG_2_OFF                                                                       = 0x31280400
RELEASE_STARTER_ENG_2_ON                                                                        = 0x31280401

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.50 AIR																					     	= 0x3132
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.60 ENGINE_CONTROLS                                                                             = 0x313C
------------------------------------------------------------------------------------------------------------------------
FADEC_1_OFF																						= 0x313C0000
FADEC_1_ON																						= 0x313C0001
FADEC_2_OFF																						= 0x313C0100
FADEC_2_ON																						= 0x313C0101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.70 AIRBORNE_INDICATING                                                                         = 0x3146
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.80 EXHAUST																					 	= 0x3150
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 49.90 OIL																					     	= 0x315A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 50 CARGO_AND_ACCESSORY_COMPARTMENTS_GENERAL                                                          = 0x3200
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 50.10 CARGO_COMPARTMENTS                                                                          = 0x320A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 50.20 CARGO_LOADING_SYSTEMS                                                                       = 0x3214
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 50.30 CARGO_RELATED_SYSTEMS                                                                       = 0x321E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 50.40 AVAILABLE                                                                                   = 0x3228
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 50.50 ACCESSORY_COMPARTMENTS                                                                      = 0x3232
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 50.60 CARGO_INSULATION                                                                            = 0x323C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 52 DOORS_GENERAL																					 	= 0x3400
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.10 PASSENGER_CREW																				= 0x340A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.20 EMERGENCY_EXIT																				= 0x3414
------------------------------------------------------------------------------------------------------------------------
EMER_EXIT_LIGHTS_OFF																			= 0x34140000
EMER_EXIT_LIGHTS_ARMED																			= 0x34140001
EMER_EXIT_LIGHTS_ON																				= 0x34140002
EMER_EXIT_LIGHTS_NOT_ARMED_OFF																	= 0x34140100
EMER_EXIT_LIGHTS_NOT_ARMED_ON																	= 0x34140101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.30 CARGO																						= 0x341E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.40 SERVICE																						= 0x3428
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.50 FIXED_INTERIOR																				= 0x3432
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.60 ENTRANCE_STAIRS																				= 0x343C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.70 DOOR_WARNING																				= 0x3446
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 52.80 LANDING_GEAR																				= 0x3450
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 53 FUSELAGE_GENERAL																					= 0x3500
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 54 NACELLES_PYLONS_GENERAL																			= 0x3600
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 54.10 NACELLE_SECTION																				= 0x360A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 54.50 PYLON																						= 0x3632
------------------------------------------------------------------------------------------------------------------------
EXT_STORES_JETT_ON                                                                              = 0x36320001
EXT_STORES_JETT_OFF                                                                             = 0x36320000

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 55 STABILIZERS_GENERAL																				= 0x3700
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 55.10 HORIZONTAL_STABILIZER_OR_CANARD																= 0x370A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 55.20 ELEVATOR																					= 0x3714
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 55.30 VERTICAL_STABILIZER																			= 0x371E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 55.40 RUDDER																						= 0x3728
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 56 WINDOWS_GENERAL																					= 0x3800
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 56.10 WINDOWS_FLIGHT_COMPARTMENT																	= 0x380A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 56.20 WINDOWS_PASSENGER_COMPARTMENT																= 0x3814
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 56.30 DOOR																						= 0x381E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 56.40 INSPECTION_AND_OBSERVATION																	= 0x3828
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 57 WINGS_GENERAL																						= 0x3900
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.10 CENTER_WING																					= 0x390A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.20 OUTER_WING																					= 0x3914
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.30 WING_TIP																					= 0x391E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.40 LEADING_EDGE_AND_LEADING_EDGE_DEVICES														= 0x3928
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.50 TRAILING_EDGE_AND_TRAILING_EDGE_DEVICES														= 0x3932
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.60 AILERONS																					= 0x393C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.70 SPOILERS																					= 0x3946
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 57.90 WING_FOLDING_SYSTEM																			= 0x395A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 61 PROPELLERS_PROPULSORS_GENERAL																		= 0x3D00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 61.10 PROPELLER_ASSEMBLY																			= 0x3D0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 61.20 CONTROLLING																					= 0x3D14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 61.30 BRAKING																						= 0x3D1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 61.40 PROPELLERS_INDICATING																		= 0x3D28
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 61.50 PROPULSOR_DUCT																				= 0x3D32
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 62 ROTORS																							= 0x3E00
------------------------------------------------------------------------------------------------------------------------
ROTOR_WARNING_LOW_RPM_OFF																		= 0x3E000000
ROTOR_WARNING_LOW_RPM_ON																		= 0x3E000001

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 63 ROTOR_DRIVES																						= 0x3F00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 64 TAIL_ROTOR																						= 0x4000
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 65 TAIL_ROTOR_DRIVE																					= 0x4100
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 66 FOLDING_BLADES_PYLON																				= 0x4200
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 67 ROTORS_FLIGHT_CONTROL																				= 0x4300
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 71 POWER_PLANT_GENERAL																				= 0x4700
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.10 COWLING																						= 0x470A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.20 MOUNTS																						= 0x4714
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.30 FIRE_SEALS																					= 0x471E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.40 ATTACH_FITTINGS																				= 0x4728
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.50 ELECTRICAL_HARNESS																			= 0x4732
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.60 POWER_AIR_INTAKES																			= 0x473C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 71.70 ENGINE_DRAINS																				= 0x4746
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 72 ENGINE_TURBINE_TURBO_PROP_DUCTED_FAN_UNDUCTED_FAN													= 0x4800
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.10 REDUCTION_GEAR_SHAFT_SECTION_TURBO_PROP                                                     = 0x480A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.20 AIR_INLET_SECTION																			= 0x4814
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.30 COMPRESSOR_SECTION																			= 0x481E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.40 COMBUSTION_SECTION																			= 0x4828
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.50 TURBINE_SECTION																				= 0x4832
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.60 ACCESSORY_DRIVES																			= 0x483C
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.70 BY_PASS_SECTION																				= 0x4846
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 72.80 PROPULSOR_SECTION_REAR_MOUNTED																= 0x4850
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 73 ENGINE_FUEL_AND_CONTROL_GENERAL																	= 0x4900
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 73.10 ENGINE_FUEL_DISTRIBUTION																	= 0x490A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 73.20 ENGINE_FUEL_CONTROLLING																		= 0x4914
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 73.30 ENGINE_FUEL_INDICATING																		= 0x491E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 74 IGNITION_GENERAL																					= 0x4A00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 74.10 ELECTRICAL_POWER_SUPPLY																		= 0x4A0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 74.20 IGNITION_DISTRIBUTION																		= 0x4A14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 74.30 SWITCHING																					= 0x4A1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 75 AIR_GENERAL																						= 0x4B00
------------------------------------------------------------------------------------------------------------------------
-- VRS F/A 18E
DEFOG_POS_LOW																					= 0x4B000000 
DEFOG_POS_2																						= 0x4B000001
DEFOG_POS_NORM																					= 0x4B000002
DEFOG_POS_4																						= 0x4B000003
DEFOG_POS_HIGH																					= 0x4B000004
WINDSHIELD_ANTI_ICE																				= 0x4B000100
WINDSHIELD_OFF																					= 0x4B000101
WINDSHIELD_RAIN																					= 0x4B000102
-- EOF VRS F/A 18E

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 75.10 ENGINE_ANTI_ICING																			= 0x4B0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 75.20 AIR_COOLING																					= 0x4B14
------------------------------------------------------------------------------------------------------------------------
RADIATOR_CUTOFF_LEFT_OFF																		= 0x4B140000
RADIATOR_CUTOFF_LEFT_ON																			= 0x4B140001
RADIATOR_CUTOFF_RIGHT_OFF																		= 0x4B140010
RADIATOR_CUTOFF_RIGHT_ON																		= 0x4B140011
RADIATOR_MODE_OFF																				= 0x4B140100
RADIATOR_MODE_CLOSE																				= 0x4B140101
RADIATOR_MODE_OPEN																				= 0x4B140102
RADIATOR_MODE_AUTO																				= 0x4B140103

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 75.30 COMPRESSOR_CONTROL																			= 0x4B1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 75.40 AIR_INDICATING																				= 0x4B28
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 76 ENGINE_CONTROLS_GENERAL																			= 0x4C00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 76.10 POWER_CONTROL																				= 0x4C0A
------------------------------------------------------------------------------------------------------------------------
ENG_MODE_LEFT_NORM																				= 0x4C0A0000
ENG_MODE_LEFT_MANUAL																			= 0x4C0A0001
ENG_MODE_RIGHT_NORM																				= 0x4C0A0100
ENG_MODE_RIGHT_MANUAL																			= 0x4C0A0101

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 76.20 EMERGENCY_SHUTDOWN																			= 0x4C14
------------------------------------------------------------------------------------------------------------------------
EMER_OFF_ACTIVE_1_IND_OFF																		= 0x4C140000
EMER_OFF_ACTIVE_1_IND_ON																		= 0x4C140001
EMER_OFF_ACTIVE_2_IND_OFF																		= 0x4C140000
EMER_OFF_ACTIVE_2_IND_ON																		= 0x4C140101
EMER_OFF_1_TOOGLE																				= 0x4C140200
EMER_OFF_2_TOOGLE																				= 0x4C140300

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 77 ENGINE_INDICATING_GENERAL																			= 0x4D00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 77.10 POWER																						= 0x4D0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 77.20 TEMPERATURE																					= 0x4D14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 77.30 ANALYZERS																					= 0x4D1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 77.40 INTEGRATED_ENGINE_INSTRUMENT_SYSTEMS														= 0x4D28
------------------------------------------------------------------------------------------------------------------------
CHIP_DET_XSMN                                                                                   = 0x4D280001
CHIP_DET_BOTH                                                                                   = 0x4D280000
CHIP_DET_TAIL                                                                                   = 0x4D280002

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 78 EXHAUST_GENERAL																					= 0x4E00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 78.10 COLLECTOR_NOZZLE																			= 0x4D0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 78.20 NOISE_SUPPRESSOR																			= 0x4D14
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 78.30 THRUST_REVERSER																				= 0x4D1E
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 78.40 SUPPLEMENTARY_AIR																			= 0x4D28
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 79 OIL_GENERAL																						= 0x4F00
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 79.10 OIL_STORAGE																					= 0x4F0A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 79.20 OIL_INDICATING 																				= 0x4F1E
------------------------------------------------------------------------------------------------------------------------
XMSN_OIL_P_WARNING_OFF																			= 0x4F1E0000
XMSN_OIL_P_WARNING_ON																			= 0x4F1E0001

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 80 STARTING_GENERAL																					= 0x5000
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 80.10 CRANKING																					= 0x500A
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- CHAPTER 81 VRS F/A 18E SPECIFICS																				= 0x6000
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 81.10 SENSORS PANEL																				= 0x600A
------------------------------------------------------------------------------------------------------------------------
FLIR_ON																							= 0x600A0000
FLIR_STANDBY																					= 0x600A0001			
FLIR_OFF																						= 0x600A0002
LTD_R_ARM																						= 0x600A0100				
LTD_R_SAFE																						= 0x600A0101
LST_NFLIR_ON																					= 0x600A0200
LST_NFLIR_OFF																					= 0x600A0201
RADAR_OFF																						= 0x600A0300
RADAR_STANDBY																					= 0x600A0301
RADAR_OPR																						= 0x600A0302
RADAR_EMERGENCY																					= 0x600A0303	
NORM_OFF																						= 0x600A0400
NORM_CV																							= 0x600A0401	
NORM_GND																						= 0x600A0402
NORM_NAV																						= 0x600A0403	
NORM_IFA																						= 0x600A0404
NORM_GYRO																						= 0x600A0405
NORM_GB																							= 0x600A0406
NORM_TEST																						= 0x600A0407		
------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 81.20 ECM PANEL																				= 0x600B
------------------------------------------------------------------------------------------------------------------------
JAMMER_CUT																						= 0x600B0000
JAMMER_ON																						= 0x600B0001
JAMMER_OFF																						= 0x600B0002
RWR_ON																							= 0x600B0100
RWR_OFF																							= 0x600B0101
CMWS_ON																							= 0x600B0200
CMWS_OFF																						= 0x600B0201
DISPENSER_BYPASS																				= 0x600B0300
DISPENSER_ON																					= 0x600B0301
DISPENSER_OFF																					= 0x600B0302

------------------------------------------------------------------------------------------------------------------------
-- SUBCHAPTER 81.30 CANOPY PANEL                    														= 0x600C
------------------------------------------------------------------------------------------------------------------------
CANOPY_OPEN                      																= 0x600C0000
CANOPY_CLOSE 																					= 0x600C0001
