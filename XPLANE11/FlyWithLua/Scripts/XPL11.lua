------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2020, SimMeters.
-- All rights reserved. Released under the BSD license.
-- XPL11.lua 1.0 01/01/2020 (Generic Export/Import Script on FlyWithLua)

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
dofile("Resources\\plugins\\FlyWithLua\\Scripts\\Inerthya.lua")
package.path  = "Resources\\plugins\\FlyWithLua\\Internals\\?.lua"
package.cpath = "Resources\\plugins\\FlyWithLua\\Internals\\?.dll"

------------------------------------------------------------------------------------------------------------------------
-- Configure Network
------------------------------------------------------------------------------------------------------------------------
socket = require("socket")
con = socket.try(socket.udp())
socket.try(con:setpeername("127.0.0.1", 6060))
socket.try(con:settimeout(0))

------------------------------------------------------------------------------------------------------------------------
-- Input Devices
------------------------------------------------------------------------------------------------------------------------
canOpsTable = {}

canOpsTable[0xA1000000] = function() set("sim/cockpit/electrical/avionics_on", 0) 			end -- SW1 OFF
canOpsTable[0xA1000001] = function() set("sim/cockpit/electrical/avionics_on", 1) 			end -- SW1 ON
canOpsTable[0xA2000000] = function() set("sim/cockpit/electrical/beacon_lights_on", 0) 		end -- SW2 OFF
canOpsTable[0xA2000001] = function() set("sim/cockpit/electrical/beacon_lights_on", 1) 		end -- SW2 ON
canOpsTable[0xA3000000] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 0) 	end -- SW3 OFF
canOpsTable[0xA3000001] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 1) 	end -- SW3 ON
canOpsTable[0xA4000000] = function() set("sim/cockpit2/switches/navigation_lights_on", 0)   end -- SW4 OFF
canOpsTable[0xA4000001] = function() set("sim/cockpit2/switches/navigation_lights_on", 1)   end -- SW4 ON
canOpsTable[0xA5000000] = function() set("sim/cockpit2/switches/landing_lights_on", 0)      end -- SW5 OFF
canOpsTable[0xA5000001] = function() set("sim/cockpit2/switches/landing_lights_on", 1)      end -- SW5 ON
canOpsTable[0xA6000000] = function() end -- SW6 OFF
canOpsTable[0xA6000001] = function() end -- SW6 ON
canOpsTable[0xA7000000] = function() end -- SW7 OFF
canOpsTable[0xA7000001] = function() end -- SW7 ON
canOpsTable[0xA8000000] = function() end -- SW8 OFF
canOpsTable[0xA8000001] = function() end -- SW8 ON
canOpsTable[0xA9000000] = function() end -- SW9 OFF
canOpsTable[0xA9000001] = function() command_once("sim/flight_controls/landing_gear_up") 	end -- SW9 UP
canOpsTable[0xA9000002] = function() command_once("sim/flight_controls/landing_gear_down") 	end -- SW9 DOWN 

canOpsTable[0xE0000000] = function() end -- EN0 OFF (RESERVED)
canOpsTable[0xE0000001] = function() end -- EN0 ON  (RESERVED)
canOpsTable[0xE0000002] = function() set("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") - 0.01) end -- EN0 DEC
canOpsTable[0xE0000003] = function() set("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") + 0.01) end -- EN0 INC

canOpsTable[0xE1000000] = function() end	-- EN1 OFF
canOpsTable[0xE1000001] = function() end	-- EN1 ON
canOpsTable[0xE1000002] = function() command_once("sim/radios/obs_HSI_down")	end	-- EN1 DEC
canOpsTable[0xE1000003] = function() command_once("sim/radios/obs_HSI_up") 		end -- EN1 INC

canOpsTable[0xE2000000] = function() end	-- EN2 OFF
canOpsTable[0xE2000001] = function() command_once("sim/autopilot/heading") 		end	-- EN2 ON
canOpsTable[0xE2000002] = function() command_once("sim/autopilot/heading_down")	end -- EN2 DEC
canOpsTable[0xE2000003] = function() command_once("sim/autopilot/heading_up") 	end -- EN2 INC

canOpsTable[0xE3000000] = function() end	-- EN3 OFF
canOpsTable[0xE3000001] = function() end	-- EN3 ON
canOpsTable[0xE3000002] = function() set("sim/cockpit2/radios/actuators/com1_frequency_hz", get("sim/cockpit2/radios/actuators/com1_frequency_hz") - 5) end	-- EN3 DEC
canOpsTable[0xE3000003] = function() set("sim/cockpit2/radios/actuators/com1_frequency_hz", get("sim/cockpit2/radios/actuators/com1_frequency_hz") + 5) end	-- EN3 INC

canOpsTable[0xE4000000] = function() end	-- EN4 OFF
canOpsTable[0xE4000001] = function() end	-- EN4 ON
canOpsTable[0xE4000002] = function() set("sim/cockpit2/radios/actuators/com2_frequency_hz", get("sim/cockpit2/radios/actuators/com2_frequency_hz") - 5) end	-- EN4 DEC
canOpsTable[0xE4000003] = function() set("sim/cockpit2/radios/actuators/com2_frequency_hz", get("sim/cockpit2/radios/actuators/com2_frequency_hz") + 5) end	-- EN4 INC

canOpsTable[0xE5000000] = function() end	-- EN5 OFF
canOpsTable[0xE5000001] = function() end	-- EN5 ON
canOpsTable[0xE5000002] = function() set("sim/cockpit2/radios/actuators/nav1_frequency_hz", get("sim/cockpit2/radios/actuators/nav1_frequency_hz") - 5) end	-- EN5 DEC
canOpsTable[0xE5000003] = function() set("sim/cockpit2/radios/actuators/nav1_frequency_hz", get("sim/cockpit2/radios/actuators/nav1_frequency_hz") + 5) end	-- EN5 INC

canOpsTable[0xE6000000] = function() end	-- EN6 OFF
canOpsTable[0xE6000001] = function() end	-- EN6 ON
canOpsTable[0xE6000002] = function() set("sim/cockpit2/radios/actuators/nav2_frequency_hz", get("sim/cockpit2/radios/actuators/nav2_frequency_hz") - 5) end	-- EN6 DEC
canOpsTable[0xE6000003] = function() set("sim/cockpit2/radios/actuators/nav2_frequency_hz", get("sim/cockpit2/radios/actuators/nav2_frequency_hz") + 5) end	-- EN6 INC

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
function loop()

	local dataIn = ""
	local dataOut = ""

	-- Display Framerate
	draw_string(10, 10, string.format("FPS %.4f", get("sim/time/framerate_period") * 1000), "white")

	-- Airspeed Indicator CANAerospace knots to m/s units
	var = string.format("%.6f", get("sim/cockpit2/gauges/indicators/airspeed_kts_pilot") * 0.5144)
	dataOut = dataOut..packFloat(CA_INDICATED_AIRSPEED, NODE_AHRS, SC0, var * 0.5144)

	-- Flaps 
	var = string.format("%.6f", get("sim/flightmodel2/wing/flap1_deg"))
	dataOut = dataOut..packFloat(CA_FLAPS_LEVER_POSITION, NODE_AHRS, SC0, var * 1)

	-- Barometric Altimeter Pressure Setting CANAerospace hPa
	var = string.format("%.6f", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot"))
	dataOut = dataOut..packFloat(CA_BARO_CORRECTION, NODE_AHRS, SC0, var * 33.8638)

	-- Indicated Altitude CANAerospace m units
	var = string.format("%.6f", get("sim/cockpit2/gauges/indicators/altitude_ft_pilot"))
	dataOut = dataOut..packFloat(CA_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC0, var * 0.3048)

	-- Vertical Speed Indicator CANAerospace fpm to m/s units
	var = string.format("%.6f", get("sim/cockpit2/gauges/indicators/vvi_fpm_pilot"))
	dataOut = dataOut..packFloat(CA_ALTITUDE_RATE, NODE_AHRS, SC0, var * 0.00508)

	-- Pitch
	var = string.format("%.6f", get("sim/cockpit/gyros/the_ind_deg3"))
	dataOut = dataOut..packFloat(CA_BODY_PITCH_ANGLE, NODE_AHRS, SC0, var * 1)
	
	-- FD Pitch
	var = string.format("%.6f", get("sim/cockpit/autopilot/flight_director_pitch"))
	dataOut = dataOut..packFloat(CA_FLIGHT_DIRECTOR_1_PITCH_DEVIATION, NODE_AHRS, SC0, var/2)

	-- Roll
	var = string.format("%.6f", get("sim/cockpit/gyros/phi_ind_deg3"))
	dataOut = dataOut..packFloat(CA_BODY_ROLL_ANGLE, NODE_AHRS, SC0, var * 1)

	-- FD Roll
	var = string.format("%.6f", get("sim/cockpit/autopilot/flight_director_roll"))
	dataOut = dataOut..packFloat(CA_FLIGHT_DIRECTOR_1_ROLL_DEVIATION, NODE_AHRS, SC0, var * 1)
	
	-- DH
	var = string.format("%.6f", get("sim/cockpit/misc/radio_altimeter_minimum"))
	dataOut = dataOut..packFloat(CA_DECISION_HEIGHT, NODE_AHRS, SC0, var * 1)
	
	-- Heading
	var = string.format("%.6f", get("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot"))
	dataOut = dataOut..packFloat(CA_HEADING_ANGLE, NODE_AHRS, SC0, var * 1)

	-- Heading Bug
	var = string.format("%.6f", get("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot"))
	dataOut = dataOut..packFloat(CA_DESIRED_TRACK_ANGLE, NODE_AHRS, SC0, var * 1)

	-- CRS
	var = string.format("%.6f", get("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot"))
	dataOut = dataOut..packFloat(CA_SELECTED_COURSE, NODE_AHRS, SC0, var * 1)

	-- VOR1 BRG
	var = string.format("%.6f", get("sim/cockpit2/radios/indicators/nav1_bearing_deg_mag"))
	dataOut = dataOut..packFloat(CA_VOR_1_RADIAL, NODE_AHRS, SC0, var * 1)
	
	-- VOR1 FREQUENCY
	var = string.format("%.6f", get("sim/cockpit/radios/nav1_freq_hz"))
	dataOut = dataOut..packFloat(CA_VOR_ILS_1_FREQUENCY, NODE_AHRS, SC0, var/100)
	
	-- VOR2 BRG
	var = string.format("%.6f", get("sim/cockpit2/radios/indicators/nav2_bearing_deg_mag"))
	dataOut = dataOut..packFloat(CA_VOR_2_RADIAL, NODE_AHRS, SC0, var * 1)
	
	-- VOR2 FREQUENCY
	var = string.format("%.6f", get("sim/cockpit/radios/nav2_freq_hz"))
	dataOut = dataOut..packFloat(CA_VOR_ILS_2_FREQUENCY, NODE_AHRS, SC0, var/100)
	
	-- DME1 Distance NM to Mts
	var = string.format("%.6f", get("sim/cockpit/radios/nav1_dme_dist_m"))
	dataOut = dataOut..packFloat(CA_DME_1_DISTANCE, NODE_AHRS, SC0, var * 1852)

	-- DME1 Gnd Speed Kts to m/s
	var = string.format("%.6f", get("sim/cockpit/radios/nav1_dme_speed_kts"))
	dataOut = dataOut..packFloat(CA_DME_1_GROUND_SPEED, NODE_AHRS, SC0, var * 0.514444)
	
	-- Gnd Speed m/s
	var = string.format("%.6f", get("sim/flightmodel/position/groundspeed"))
	dataOut = dataOut..packFloat(CA_GPS_GROUND_SPEED, NODE_AHRS, SC0, var * 1)
	
	-- ADF1 BRG
	var = string.format("%.6f", get("sim/cockpit2/radios/indicators/adf1_bearing_deg_mag"))
	dataOut = dataOut..packFloat(CA_ADF_1_BEARING, NODE_AHRS, SC0, var * 1)
	
	-- ADF1 FREQUENCY
	var = string.format("%.6f", get("sim/cockpit/radios/adf1_freq_hz"))
	dataOut = dataOut..packFloat(CA_ADF_1_FREQUENCY, NODE_AHRS, SC0, var * 1)

	-- ADF2 BRG
	var = string.format("%.6f", get("sim/cockpit2/radios/indicators/adf2_bearing_deg_mag"))
	dataOut = dataOut..packFloat(CA_ADF_2_BEARING, NODE_AHRS, SC0, var * 1)
	
	-- ADF2 FREQUENCY
	var = string.format("%.6f", get("sim/cockpit/radios/adf2_freq_hz"))
	dataOut = dataOut..packFloat(CA_ADF_2_FREQUENCY, NODE_AHRS, SC0, var * 1)

	-- LOCALIZER DEFLECTION +-100 
	var = string.format("%.4f", get("sim/cockpit/radios/nav1_hdef_dot"))
	dataOut = dataOut..packFloat(CA_ILS_1_LOCALIZE_DEVIATION, NODE_AHRS, SC0, var * 100)
	
	-- GLIDESLOPE DEFLECTION +-100 
	var = string.format("%.4f", get("sim/cockpit/radios/nav1_vdef_dot"))
	dataOut = dataOut..packFloat(CA_ILS_1_GLIDESLOPE_DEVIATION, NODE_AHRS, SC0, var * 100)

	-- LATITUDE
	var = string.format("%.6f", get("sim/flightmodel/position/latitude"))
	dataOut = dataOut..packFloat(CA_INS_AIRCRAFT_LATITUDE, NODE_AHRS, SC0, var * 1)

	-- LONGITUDE
	var = string.format("%.6f", get("sim/flightmodel/position/longitude"))
	dataOut = dataOut..packFloat(CA_INS_AIRCRAFT_LONGITUDE, NODE_AHRS, SC0, var * 1)

	-- COM1 Frequency
	var = string.format("%.6f", get("sim/cockpit/radios/com1_freq_hz"))
	dataOut = dataOut..packFloat(CA_VHF_1_COM_FREQUENCY, NODE_AHRS, SC0, var/100)

	-- COM2 Frequency
	var = string.format("%.6f", get("sim/cockpit/radios/com2_freq_hz"))
	dataOut = dataOut..packFloat(CA_VHF_2_COM_FREQUENCY, NODE_AHRS, SC0, var/100)
	
	-- Turn and Slip CANAerospace from -1 to +1
	var = string.format("%.6f", get("sim/cockpit2/gauges/indicators/slip_deg"))
	dataOut = dataOut..packFloat(CA_BODY_SIDESLIP, NODE_AHRS, SC0, var * -100)
	
	var = string.format("%.6f", get("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_pilot"))
	dataOut = dataOut..packFloat(CA_TURN_COORDINATION_RATE, NODE_AHRS, SC0, var * 0.03)
	
	-- Temperature K
	var = string.format("%.6f", get("sim/flightmodel/engine/ENGN_ITT_c",0))
	dataOut = dataOut..packFloat(CA_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var + 273.15)
	
	var = string.format("%.6f", get("sim/flightmodel/engine/ENGN_ITT_c",1))
	dataOut = dataOut..packFloat(CA_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var + 273.15)
	
	-- ERPM %
	var = string.format("%.6f", get("sim/cockpit2/engine/indicators/N2_percent",0))
	dataOut = dataOut..packFloat(CA_ENGINE_1_N2_ECS_CHANNEL_A, NODE_AHRS, SC0, var * 1)
	
	var = string.format("%.6f", get("sim/cockpit2/engine/indicators/N2_percent",1))
	dataOut = dataOut..packFloat(CA_ENGINE_2_N2_ECS_CHANNEL_A, NODE_AHRS, SC0, var * 1)
 
	-- Fuel Flow l/h
	var = string.format("%.6f", get("sim/cockpit2/engine/indicators/fuel_flow_kg_sec",0))
	dataOut = dataOut..packFloat(CA_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC0, var * 3600)
	
	var = string.format("%.6f", get("sim/cockpit2/engine/indicators/fuel_flow_kg_sec",1))
	dataOut = dataOut..packFloat(CA_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A, NODE_AHRS, SC0, var * 3600)
	
	-- OIL Pressure hPa
	var = string.format("%.6f", get("sim/cockpit2/engine/indicators/oil_pressure_psi", 0))
	dataOut = dataOut..packFloat(CA_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var * 68.9475)
	
	var = string.format("%.6f", get("sim/cockpit2/engine/indicators/oil_pressure_psi", 1))
	dataOut = dataOut..packFloat(CA_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var * 68.9475)

	-- UD_FLAGS_0_31
	flag_fd = 0
	flag_ap = 0
	var = get("sim/cockpit2/autopilot/flight_director_mode")
	if (var > 0)  then flag_fd = 1 end
	if (var == 2) then flag_ap = 1 end
	
	flag_hdg = 0
	var = get("sim/cockpit2/autopilot/heading_mode")
	if(var == 1) then flag_hdg = 1 end

	flag_vs  = 0
	flag_alt = 0
	var = get("sim/cockpit2/autopilot/altitude_mode")
	if (var == 4) then flag_vs  = 1 end
	if (var == 6) then flag_alt = 1 end
	
	flag_loc = 0
	var = get("sim/cockpit/radios/nav1_hdef_dot")
	if(var ~= 0) then flag_loc = 1 end

	flag_gs = 0
	var = get("sim/cockpit/radios/nav1_vdef_dot")
	if(var ~= 0) then flag_gs = 1 end

	lp = { 
	1,																-- 1 LT0 GAUGES LIGHTS
	get("sim/cockpit/warnings/annunciators/master_warning"), 		-- 2 LT1 
	get("sim/cockpit/warnings/annunciators/master_caution"),		-- 3 LT2
	get("sim/cockpit/warnings/annunciators/autopilot_disconnect"),	-- 4 LT3
	get("sim/cockpit/warnings/annunciators/low_vacuum"),			-- 5 LT4
	get("sim/cockpit/warnings/annunciators/low_voltage"),			-- 6 LT5
	get("sim/cockpit/warnings/annunciators/fuel_quantity"),			-- 7 LT6
	get("sim/cockpit/warnings/annunciators/hydraulic_pressure"),	-- 8 LT7

	get("sim/cockpit/warnings/annunciators/speedbrake"),			-- 9  LT8
	math.floor(get("sim/flightmodel2/gear/deploy_ratio", 0)),		-- 10 LEFT
	math.floor(get("sim/flightmodel2/gear/deploy_ratio", 1)),		-- 11 NOSE
	math.floor(get("sim/flightmodel2/gear/deploy_ratio", 2)),		-- 12 RIGHT
	0,																-- 13 
	0,																-- 14 
	0,																-- 15 
	0,																-- 16 

	flag_fd,														-- 17 EADI flag_fd
	flag_ap,														-- 18 EADI flag_ap
	flag_hdg,														-- 19 EADI flag_hdg
	flag_vs,														-- 20 EADI flag_vs
	flag_alt,														-- 21 EADI flag_alt
	flag_loc,														-- 22 EADI flag_loc
	1,																-- 23 EADI resv
	1,																-- 24 EADI resv

	1,																-- 25 EHSI flag_vor1
	0,																-- 26 EHSI flag_vor2
	1,																-- 27 EHSI flag_dme1
	1,																-- 28 EHSI flag_adf1
	0,																-- 29 EHSI flag_adf2
	flag_gs,														-- 30 EHSI flag_gs
	0,																-- 31 EHSI flag_to_from
	0 																-- 32 EHSI resv
	}
	
	var = string.format("%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1]))
	dataOut = dataOut..packUint32(UD_FLAGS_0_31, NODE_AHRS, SC0, var * 1)

------------------------------------------------------------------------------------------------------------------------
-- TX Data
------------------------------------------------------------------------------------------------------------------------
	socket.try(con:send(dataOut))
	
------------------------------------------------------------------------------------------------------------------------
-- RX Data
------------------------------------------------------------------------------------------------------------------------
	dataIn = con:receive()
	
	if dataIn then
		
		CAN_IDH 		= string.byte(dataIn,  1) -- CAN_IDH
		CAN_IDL 		= string.byte(dataIn,  2) -- CAN_IDL
		NODE_ID 		= string.byte(dataIn,  3) -- NODE ID RESERVED ALWAYS 0
		DATA_TYPE 		= string.byte(dataIn,  4) -- DATA TYPE ALWAYS BCHAR
		SERVICE_CODE 	= string.byte(dataIn,  5) -- SERVICE CODE DEVICE TYPE 0 UNKNOWN, 1 SWITCH, 2 ENCODER, 3 ANALOG
		MESSAGE_CODE 	= string.byte(dataIn,  6) -- MESSAGE CODE COUNTER 0 - 255
		DATA3 			= string.byte(dataIn,  7) -- ATA CHAPTER
		DATA2 			= string.byte(dataIn,  8) -- ATA SUBCHAPTER
		DATA1 			= string.byte(dataIn,  9) -- DEVICE NUMBER BUTTON0, BUTTON1, ENCODER2, ANALOG HSB
		DATA0 			= string.byte(dataIn, 10) -- DEVICE VALUE ON/OFF, ENC LEFT/RIGHT , ANALOG LSB

		if SERVICE_CODE == SC1 or SERVICE_CODE == SC2 then 	-- SWITCH/ENCODER DEVICE

			if canOpsTable[((DATA3 * (16^6)) + (DATA2 * (16^4)) + (DATA1 * (16^2)) + DATA0)] ~= nil then
				
				canOpsTable[((DATA3 * (16^6)) + (DATA2 * (16^4)) + (DATA1 * (16^2)) + DATA0)]()
			
			end 

		elseif SERVICE_CODE == SC3 then 					-- ANALOG DEVICE

			if canOpsTable[(DATA3 * (16^2)) + DATA2] ~= nil then

				canOpsTable[(DATA3 * (16^2)) + DATA2]((DATA1 * (16^2)) + DATA0)

			end 
			
		end

	end

end

do_every_draw("loop()")