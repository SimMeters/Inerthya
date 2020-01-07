------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2020, SimMeters.
-- All rights reserved. Released under the BSD license.
-- FSX.lua 1.0 01/01/2020 (Generic Export/Import Script on FSUIPC)

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
-- Configure Network
------------------------------------------------------------------------------------------------------------------------
socket = require("socket")

con = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("172.16.1.100", 6060))

aux = socket.try(socket.udp())
socket.try(aux:settimeout(.001))
socket.try(aux:setpeername("127.0.0.1", 6060))

------------------------------------------------------------------------------------------------------------------------
-- Input Devices
------------------------------------------------------------------------------------------------------------------------
canOpsTable[0xA1000000] = function() end -- SW1 OFF
canOpsTable[0xA1000001] = function() end -- SW1 ON
canOpsTable[0xA2000000] = function() end -- SW2 OFF
canOpsTable[0xA2000001] = function() end -- SW2 ON
canOpsTable[0xA3000000] = function() end -- SW3 OFF
canOpsTable[0xA3000001] = function() end -- SW3 ON
canOpsTable[0xA4000000] = function() end -- SW4 OFF
canOpsTable[0xA4000001] = function() end -- SW4 ON
canOpsTable[0xA5000000] = function() end -- SW5 OFF
canOpsTable[0xA5000001] = function() end -- SW5 ON
canOpsTable[0xA6000000] = function() end -- SW6 OFF
canOpsTable[0xA6000001] = function() end -- SW6 ON
canOpsTable[0xA7000000] = function() end -- SW7 OFF
canOpsTable[0xA7000001] = function() end -- SW7 ON
canOpsTable[0xA8000000] = function() end -- SW8 OFF
canOpsTable[0xA8000001] = function() end -- SW8 ON
canOpsTable[0xA9000000] = function() end -- SW9 OFF
canOpsTable[0xA9000001] = function() end -- SW9 UP
canOpsTable[0xA9000002] = function() end -- SW9 DOWN 

canOpsTable[0xE0000000] = function() end -- EN0 OFF (RESERVED)
canOpsTable[0xE0000001] = function() end -- EN0 ON  (RESERVED)
canOpsTable[0xE0000002] = function() ipc.writeUW(0x0330, ipc.readUW(0x0330) - 1) end -- EN0 DEC
canOpsTable[0xE0000003] = function() ipc.writeUW(0x0330, ipc.readUW(0x0330) + 1) end -- EN0 INC

canOpsTable[0xE1000000] = function() end -- EN1 OFF
canOpsTable[0xE1000001] = function() end -- EN1 ON
canOpsTable[0xE1000002] = function() end -- EN1 DEC
canOpsTable[0xE1000003] = function() end -- EN1 INC

canOpsTable[0xE2000000] = function() end -- EN2 OFF
canOpsTable[0xE2000001] = function() end -- EN2 ON
canOpsTable[0xE2000002] = function() end -- EN2 DEC
canOpsTable[0xE2000003] = function() end -- EN2 INC

canOpsTable[0xE3000000] = function() end -- EN3 OFF
canOpsTable[0xE3000001] = function() end -- EN3 ON
canOpsTable[0xE3000002] = function() end -- EN3 DEC
canOpsTable[0xE3000003] = function() end -- EN3 INC

canOpsTable[0xE4000000] = function() end -- EN4 OFF
canOpsTable[0xE4000001] = function() end -- EN4 ON
canOpsTable[0xE4000002] = function() end -- EN4 DEC
canOpsTable[0xE4000003] = function() end -- EN4 INC

canOpsTable[0xE5000000] = function() end -- EN5 OFF
canOpsTable[0xE5000001] = function() end -- EN5 ON
canOpsTable[0xE5000002] = function() end -- EN5 DEC
canOpsTable[0xE5000003] = function() end -- EN5 INC

canOpsTable[0xE6000000] = function() end -- EN6 OFF
canOpsTable[0xE6000001] = function() end -- EN6 ON
canOpsTable[0xE6000002] = function() end -- EN6 DEC
canOpsTable[0xE6000003] = function() end -- EN6 INC

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
while true do

	local packet = ""
	local flightData = {}

	-- Airspeed Indicator CANAerospace knots to m/s units
	var_ias = (ipc.readSD(0x02BC) / 128) * 0.5144
	table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f", var_ias))

	-- Flaps (TODO) 
 	-- table.insert(flightData,string.format("ID_FLAPS_LEVER_POSITION=%.4f", get("sim/flightmodel2/wing/flap1_deg")))

	-- Barometric Altimeter Pressure Setting CANAerospace hPa
	var_qnh = ipc.readUW(0x0330) / 16
	table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f", var_qnh))

	-- Indicated Altitude CANAerospace m units
	var_alt = ipc.readSD(0x3324) * 0.3048
	table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f", var_alt))

	-- Vertical Speed Indicator CANAerospace fpm to m/s units
	var_vvi = ipc.readSD(0x02C8) / 256
	table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f", var_vvi))

	-- Pitch
	var_pit = ipc.readDBL(0x2F70)
	table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f", var_pit))
	
	-- Roll
	var_rol = ipc.readDBL(0x2F78)
	table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f", var_rol))

	-- Heading
	--table.insert(flightData,string.format("ID_HEADING_ANGLE=%.4f", get("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot")))

	-- Heading Bug
	--table.insert(flightData,string.format("ID_DESIRED_TRACK_ANGLE=%.4f", get("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot")))

	-- CRS
	--table.insert(flightData,string.format("ID_SELECTED_COURSE=%.4f", get("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot")))

	-- Turn and Slip CANAerospace from -1 to +1
	--table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", get("sim/cockpit2/gauges/indicators/slip_deg") * -0.25))	
	--table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f", get("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_pilot") * 0.03))
	
	-- Temperature K
	--table.insert(flightData, string.format("ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f", get("sim/flightmodel/engine/ENGN_ITT_c",0) + 273.15))
	--table.insert(flightData, string.format("ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f", get("sim/flightmodel/engine/ENGN_ITT_c",1) + 273.15))
	
	-- ERPM %
	--table.insert(flightData, string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/N2_percent",0)))
	--table.insert(flightData, string.format("ID_ENGINE_2_N2_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/N2_percent",1)))
 
	-- Fuel Flow l/h
	--table.insert(flightData, string.format("ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/fuel_flow_kg_sec",0) * 3600))
	--table.insert(flightData, string.format("ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/fuel_flow_kg_sec",1) * 3600))
	
	-- OIL Pressure hPa
	--table.insert(flightData,string.format("ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/oil_pressure_psi", 0) * 68.9475))
 	--table.insert(flightData,string.format("ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/oil_pressure_psi", 1) * 68.9475))
	
	

	-- LAMPS_0_31
	lp = { 
	1,	-- 1 LT0 GAUGES LIGHTS
	0, 		-- 2 LT1 
	0,		-- 3 LT2
	0,	-- 4 LT3
	0,			-- 5 LT4
	0,			-- 6 LT5
	0,			-- 7 LT6
	0,	-- 8 LT7

	0,			-- 9  LT8
	0,		-- 10 LEFT
	0,		-- 11 NOSE
	0,		-- 12 RIGHT
	0,																-- 13 
	0,																-- 14 
	0,																-- 15 
	0,																-- 16 

	0,																-- 17 
	0,																-- 18 
	0,																-- 19 
	0,																-- 20 
	0,																-- 21 
	0,																-- 22 
	0,																-- 23 
	0,																-- 24 

	0,																-- 25 
	0,																-- 26 
	0,																-- 27 
	0,																-- 28 
	0,																-- 29 
	0,																-- 30 
	0,																-- 31 
	0 																-- 32 
	}

	table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
	
------------------------------------------------------------------------------------------------------------------------
-- TX Data
------------------------------------------------------------------------------------------------------------------------
	for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
	socket.try(con:send(string.upper(packet)))
	socket.try(aux:send(string.upper(packet)))
	
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

	ipc.sleep(50)

end