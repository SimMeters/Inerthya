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
canOpsTable = {}
package.path  = "Resources\\plugins\\FlyWithLua\\Internals\\?.lua"
package.cpath = "Resources\\plugins\\FlyWithLua\\Internals\\?.dll"

------------------------------------------------------------------------------------------------------------------------
-- Configure Network
------------------------------------------------------------------------------------------------------------------------
socket = require("socket")

con = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("192.168.1.134", 6060))

--aux = socket.try(socket.udp())
--socket.try(aux:settimeout(.001))
--socket.try(aux:setpeername("192.168.1.146", 6060))

------------------------------------------------------------------------------------------------------------------------
-- Input Devices
------------------------------------------------------------------------------------------------------------------------
canOpsTable[0xA1000000] = function() set("sim/cockpit/electrical/avionics_on", 0) 	    end -- SW1 OFF
canOpsTable[0xA1000001] = function() set("sim/cockpit/electrical/avionics_on", 1) 	    end -- SW1 ON
canOpsTable[0xA2000000] = function() set("sim/cockpit/electrical/beacon_lights_on", 0) 	    end -- SW2 OFF
canOpsTable[0xA2000001] = function() set("sim/cockpit/electrical/beacon_lights_on", 1) 	    end -- SW2 ON
canOpsTable[0xA3000000] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 0)   end -- SW3 OFF
canOpsTable[0xA3000001] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 1)   end -- SW3 ON
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

	local packet = ""
	local flightData = {}

	-- Airspeed Indicator CANAerospace knots to m/s units
	table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f", get("sim/cockpit2/gauges/indicators/airspeed_kts_pilot") * 0.5144))

	-- Flaps 
 	table.insert(flightData,string.format("ID_FLAPS_LEVER_POSITION=%.4f", get("sim/flightmodel2/wing/flap1_deg")))

	-- Barometric Altimeter Pressure Setting CANAerospace hPa
	table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") * 33.8638))

	-- Indicated Altitude CANAerospace m units
	table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f", get("sim/cockpit2/gauges/indicators/altitude_ft_pilot") * 0.3048))

	-- Vertical Speed Indicator CANAerospace fpm to m/s units
	table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f", get("sim/cockpit2/gauges/indicators/vvi_fpm_pilot") * 0.00508))

	-- Pitch
	table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f",get("sim/cockpit/gyros/the_ind_deg3")))
	
	-- FD Pitch
	table.insert(flightData,string.format("ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION=%.4f",get("sim/cockpit/autopilot/flight_director_pitch")/2))

	-- Roll
	table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f",get("sim/cockpit/gyros/phi_ind_deg3")))

	-- FD Roll
	table.insert(flightData,string.format("ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION=%.4f",get("sim/cockpit/autopilot/flight_director_roll")))
	
	-- DH
	table.insert(flightData,string.format("ID_DECISION_HEIGHT=%.4f",get("sim/cockpit/misc/radio_altimeter_minimum")))
	
	-- Heading
	table.insert(flightData,string.format("ID_HEADING_ANGLE=%.4f", get("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot")))

	-- Heading Bug
	table.insert(flightData,string.format("ID_DESIRED_TRACK_ANGLE=%.4f", get("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot")))

	-- CRS
	table.insert(flightData,string.format("ID_SELECTED_COURSE=%.4f", get("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot")))

	-- VOR1 BRG
	table.insert(flightData,string.format("ID_VOR_1_RADIAL=%.4f", get("sim/cockpit2/radios/indicators/nav1_bearing_deg_mag")))
	
	-- VOR1 FREQUENCY
	table.insert(flightData,string.format("ID_VOR_ILS_1_FREQUENCY=%.4f", get("sim/cockpit/radios/nav1_freq_hz")/100))
	
	-- VOR2 BRG
	table.insert(flightData,string.format("ID_VOR_2_RADIAL=%.4f", get("sim/cockpit2/radios/indicators/nav2_bearing_deg_mag")))
	
	-- VOR2 FREQUENCY
	table.insert(flightData,string.format("ID_VOR_ILS_2_FREQUENCY=%.4f", get("sim/cockpit/radios/nav2_freq_hz")/100))
	
	-- DME1 Distance NM to Mts
	table.insert(flightData,string.format("ID_DME_1_DISTANCE=%.4f", get("sim/cockpit/radios/nav1_dme_dist_m") * 1852))

	-- DME1 Gnd Speed Kts to m/s
	table.insert(flightData,string.format("ID_DME_1_GROUND_SPEED=%.4f", get("sim/cockpit/radios/nav1_dme_speed_kts") * 0.514444))
	
	-- Gnd Speed m/s
	table.insert(flightData,string.format("ID_GPS_GROUND_SPEED=%.4f", get("sim/flightmodel/position/groundspeed")))
	
	-- ADF1 BRG
	table.insert(flightData,string.format("ID_ADF_1_BEARING=%.4f", get("sim/cockpit2/radios/indicators/adf1_bearing_deg_mag")))
	
	-- ADF1 FREQUENCY
	table.insert(flightData,string.format("ID_ADF_1_FREQUENCY=%.4f", get("sim/cockpit/radios/adf1_freq_hz")))

	-- ADF2 BRG
	table.insert(flightData,string.format("ID_ADF_2_BEARING=%.4f", get("sim/cockpit2/radios/indicators/adf2_bearing_deg_mag")))
	
	-- ADF2 FREQUENCY
	table.insert(flightData,string.format("ID_ADF_2_FREQUENCY=%.4f", get("sim/cockpit/radios/adf2_freq_hz")))

	-- LOCALIZER DEFLECTION +-100 
	table.insert(flightData,string.format("ID_ILS_1_LOCALIZE_DEVIATION=%.4f", get("sim/cockpit/radios/nav1_hdef_dot")*100))
	
	-- GLIDESLOPE DEFLECTION +-100 
	table.insert(flightData,string.format("ID_ILS_1_GLIDESLOPE_DEVIATION=%.4f", get("sim/cockpit/radios/nav1_vdef_dot")*100))

	-- LATITUDE
	table.insert(flightData,string.format("ID_INS_AIRCRAFT_LATITUDE=%.8f", get("sim/flightmodel/position/latitude")))

	-- LONGITUDE
	table.insert(flightData,string.format("ID_INS_AIRCRAFT_LONGITUDE=%.8f", get("sim/flightmodel/position/longitude")))

	-- COM1 Frequency
	table.insert(flightData,string.format("ID_VHF_1_COM_FREQUENCY=%.8f", get("sim/cockpit/radios/com1_freq_hz")/100))

	-- COM2 Frequency
	table.insert(flightData,string.format("ID_VHF_2_COM_FREQUENCY=%.8f", get("sim/cockpit/radios/com2_freq_hz")/100))
	
	-- Turn and Slip CANAerospace from -1 to +1
	table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", get("sim/cockpit2/gauges/indicators/slip_deg") * -100))	
	table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f", get("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_pilot") * 0.03))
	
	-- Temperature K
	table.insert(flightData, string.format("ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f", get("sim/flightmodel/engine/ENGN_ITT_c",0) + 273.15))
	table.insert(flightData, string.format("ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f", get("sim/flightmodel/engine/ENGN_ITT_c",1) + 273.15))
	
	-- ERPM %
	table.insert(flightData, string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/N2_percent",0)))
	table.insert(flightData, string.format("ID_ENGINE_2_N2_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/N2_percent",1)))
 
	-- Fuel Flow l/h
	table.insert(flightData, string.format("ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/fuel_flow_kg_sec",0) * 3600))
	table.insert(flightData, string.format("ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/fuel_flow_kg_sec",1) * 3600))
	
	-- OIL Pressure hPa
	table.insert(flightData,string.format("ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/oil_pressure_psi", 0) * 68.9475))
 	table.insert(flightData,string.format("ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/oil_pressure_psi", 1) * 68.9475))

	-- LAMPS_0_31

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
	
	--draw_string(10, 10, var, "red")

	lp = { 
	1,																-- 1 LT0 GAUGES LIGHTS
	get("sim/cockpit/warnings/annunciators/master_warning"), 		-- 2 LT1 
	get("sim/cockpit/warnings/annunciators/master_caution"),		-- 3 LT2
	get("sim/cockpit/warnings/annunciators/autopilot_disconnect"),		-- 4 LT3
	get("sim/cockpit/warnings/annunciators/low_vacuum"),			-- 5 LT4
	get("sim/cockpit/warnings/annunciators/low_voltage"),			-- 6 LT5
	get("sim/cockpit/warnings/annunciators/fuel_quantity"),			-- 7 LT6
	get("sim/cockpit/warnings/annunciators/hydraulic_pressure"),		-- 8 LT7

	get("sim/cockpit/warnings/annunciators/speedbrake"),			-- 9  LT8
	math.floor(get("sim/flightmodel2/gear/deploy_ratio", 0)),		-- 10 LEFT
	math.floor(get("sim/flightmodel2/gear/deploy_ratio", 1)),		-- 11 NOSE
	math.floor(get("sim/flightmodel2/gear/deploy_ratio", 2)),		-- 12 RIGHT
	0,									-- 13 
	0,									-- 14 
	0,									-- 15 
	0,									-- 16 

	flag_fd,								-- 17 EADI flag_fd
	flag_ap,								-- 18 EADI flag_ap
	flag_hdg,								-- 19 EADI flag_hdg
	flag_vs,								-- 20 EADI flag_vs
	flag_alt,								-- 21 EADI flag_alt
	flag_loc,								-- 22 EADI flag_loc
	1,									-- 23 EADI resv
	1,									-- 24 EADI resv

	1,									-- 25 EHSI flag_vor1
	0,									-- 26 EHSI flag_vor2
	1,									-- 27 EHSI flag_dme1
	1,									-- 28 EHSI flag_adf1
	0,									-- 29 EHSI flag_adf2
	flag_gs,								-- 30 EHSI flag_gs
	0,									-- 31 EHSI flag_to_from
	0 									-- 32 EHSI resv
	}

	table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
	
------------------------------------------------------------------------------------------------------------------------
-- TX Data
------------------------------------------------------------------------------------------------------------------------
	for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
	socket.try(con:send(string.upper(packet)))
	--socket.try(aux:send(string.upper(packet)))
	
------------------------------------------------------------------------------------------------------------------------
-- RX Data
------------------------------------------------------------------------------------------------------------------------
	local data = con:receive()
	if data then
		
		NODE_ID 		= string.byte(data, 1) 	-- NODE ID RESERVED ALWAYS 0
		DATA_TYPE 		= string.byte(data, 2) 	-- DATA TYPE ALWAYS BCHAR
		SERVICE_CODE 	= string.byte(data, 3) 	-- SERVICE CODE DEVICE TYPE 0 UNKNOWN, 1 SWITCH, 2 ENCODER, 3 ANALOG
		MESSAGE_CODE 	= string.byte(data, 4) 	-- MESSAGE CODE COUNTER 0 - 255
		DATA0 			= string.byte(data, 5) 	-- ATA CHAPTER
		DATA1 			= string.byte(data, 6) 	-- ATA SUBCHAPTER
		DATA2 			= string.byte(data, 7) 	-- DEVICE NUMBER BUTTON0, BUTTON1, ENCODER2, ANALOG HSB
		DATA3 			= string.byte(data, 8) 	-- DEVICE VALUE ON/OFF, ENC LEFT/RIGHT , ANALOG LSB
		
		if SERVICE_CODE == 1 or SERVICE_CODE == 2 then -- SWITCH/ENCODER DEVICE
		
			if canOpsTable[((DATA0 * (16^6)) + (DATA1 * (16^4)) + (DATA2 * (16^2)) + DATA3)] ~= nil then
				canOpsTable[((DATA0 * (16^6)) + (DATA1 * (16^4)) + (DATA2 * (16^2)) + DATA3)]()
			end
		
		elseif SERVICE_CODE == 3 then -- ANALOG DEVICE
		
			if canOpsTable[(DATA0 * (16^2)) + DATA1] ~= nil then
				canOpsTable[(DATA0 * (16^2)) + DATA1]((DATA2 * (16^2)) + DATA3)
			end
		
		end
		
	end	
	
end

do_every_draw("loop()")
