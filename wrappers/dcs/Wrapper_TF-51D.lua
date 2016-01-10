------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2014, SimMeters.
-- All rights reserved. Released under the BSD license.
-- Wrapper_TF-51D.lua 1.0 01/01/2014 (Import/Export script for SimMeters Workspace DCS Wrapper)

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
-- Variables Declaration
canOpsTable = {}

-- INPUT COMMANDS TODO
canOpsTable[0x00000000] = function() GetDevice(0):performClickableAction(3000, 0) end

do

	local PrevLuaExportStart = LuaExportStart;
	LuaExportStart = function()

		-- Configure Network
		package.path  = package.path..";.\\LuaSocket\\?.lua"
		package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
		port = 6060
		host = "127.0.0.1"
		socket = require("socket")
		con = socket.try(socket.udp())
		socket.try(con:settimeout(.001))
		socket.try(con:setpeername(host,port))
		
		-- Function Hook
		if PrevLuaExportStart then PrevLuaExportStart(); end
	
	end

end

do

	local PrevLuaExportBeforeNextFrame = LuaExportBeforeNextFrame;
	LuaExportBeforeNextFrame = function()

		-- Export Data
		local packet = ""
		local flightData = {}

		local mp = GetDevice(0)
		if mp then
		
			-- Update Data
			mp:update_arguments()

			-- RMI Indicator
			arg = mp:get_argument_value(1)
			var = (arg * 360)
			table.insert(flightData,string.format("ID_VOR_1_RADIAL=%.4f",var))
			
			arg = mp:get_argument_value(2)
			var = (arg * 360)
			table.insert(flightData,string.format("ID_SELECTED_COURSE=%.4f",var))
			
			-- Clock TODO
			--arg = mp:get_argument_value(4)
			--var = (arg * 12)
			--table.insert(flightData,string.format("XXX=%.4f",var))
			
			--arg = mp:get_argument_value(5)
			--var = (arg * 60)
			--table.insert(flightData,string.format("XXX=%.4f",var))

			--arg = mp:get_argument_value(6)
			--var = (arg * 60)
			--table.insert(flightData,string.format("XXX=%.4f",var))

			-- Vacuum Suction Indicator
			arg = mp:get_argument_value(9)
			var = (arg * 10)
			table.insert(flightData,string.format("ID_STATIC_PRESSURE=%.4f",var))
			
			-- Manifold Pressure Indicator
			arg = mp:get_argument_value(10)
			var = (10 + (arg * 65))
			table.insert(flightData,string.format("ID_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A=%.4f",var))
			
			-- Airspeed Indicator
			arg = mp:get_argument_value(11)
			var = ((arg * 1000) * 0.5144)
			table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f",var))
			
			-- Heading Indicator
			arg = mp:get_argument_value(12)
			var = (var * 360)
			table.insert(flightData,string.format("ID_MAGNETIC_HEADING=%.4f",var))
			
			-- Attitude Indicator
			arg = mp:get_argument_value(15)
			var = (var * 180)
			table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f",var))
			
			arg = mp:get_argument_value(14)
			var = (var * 180)
			table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f",var))
			
			-- Coolant Temp Indicator
			arg = mp:get_argument_value(22)
			var = ((arg * 230) -80)
			table.insert(flightData,string.format("ID_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))
			
			-- Carburator Temp Indicator
			arg = mp:get_argument_value(21)
			var = ((arg * 230) -80)
			table.insert(flightData,string.format("ID_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))
			
			-- RPM Indicator
			arg = mp:get_argument_value(23)
			var = (arg * 4500)
			table.insert(flightData,string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f",var))
			
			-- Altimeter
			arg = mp:get_argument_value(96)
			var = ((arg * 100000) * 0.3048)
			table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f",var))

			arg = mp:get_argument_value(97)
			var = ((28.1 + (arg * 2.9)) * 33.7685)
			table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f",var))
			
			-- Turn and Slip
			arg = mp:get_argument_value(27)
			var = arg
			table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f",var))

			arg = mp:get_argument_value(28)
			var = arg
			table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f",var))
			
			-- Vertical Speed Indicator
			arg = mp:get_argument_value(29)
			var = ((arg * 10000) * 0.00508)
			table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f",var))
			
			-- Accelerometer
			arg = mp:get_argument_value(175)
			var = ((arg * 17) - 5)
			table.insert(flightData,string.format("ID_BODY_NORMAL_ACCELERATION=%.4f",var))
			
			-- Triple Gauge Temp Indicator / Oil Pess / Fuel Press
			arg = mp:get_argument_value(30)
			var = (arg * 100)
			table.insert(flightData,string.format("ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))

			arg = mp:get_argument_value(31)
			var = (arg * 200)
			table.insert(flightData,string.format("ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A=%.4f",var))
			
			arg = mp:get_argument_value(32)
			var = (arg * 25)
			table.insert(flightData,string.format("ID_FUEL_SYSTEM_1_PRESSURE=%.4f",var))

			-- GROUP LAMPS_0_31
			lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			lp[1] = mp:get_argument_value(161) 	-- TailRadarWarning
			lp[2] = mp:get_argument_value(122) 	-- A_channel_light
			lp[3] = mp:get_argument_value(123) 	-- B_channel_light
			lp[4] = mp:get_argument_value(124) 	-- C_channel_light
			lp[5] = mp:get_argument_value(125) 	-- D_channel_light
			lp[6] = mp:get_argument_value(126) 	-- Transmit_light
			lp[7] = mp:get_argument_value(80)	-- LandingGearGreenLight
			lp[8] = mp:get_argument_value(82) 	-- LandingGearRedLight
			lp[9] = mp:get_argument_value(164) 	-- Left_Fluor_Light
			lp[10] = mp:get_argument_value(165) 	-- Right_Fluor_Light
			lp[11] = mp:get_argument_value(59) 	-- Hight_Blower_Lamp
			lp[12] = mp:get_argument_value(185) 	-- Left_cockpit_light
			lp[13] = mp:get_argument_value(186) 	-- Right_cockpit_light
			lp[14] = mp:get_argument_value(190) 	-- warEmergencyPowerLimWire
			table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))

			-- TX Data
			for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
			socket.try(con:send(string.upper(packet)))
			
		end
		
		-- RX Data
		local data = con:receive()
		if data then
		
			NODE_ID 		= string.byte(data,1) 	-- NODE ID RESERVED ALWAYS 0
			DATA_TYPE 		= string.byte(data,2) 	-- DATA TYPE ALWAYS BCHAR
			SERVICE_CODE 	= string.byte(data,3) 	-- SERVICE CODE DEVICE TYPE 0 UNKNOWN, 1 SWITCH, 2 ENCODER, 3 ANALOG
			MESSAGE_CODE 	= string.byte(data,4) 	-- MESSAGE CODE COUNTER 0 - 255
			DATA0 			= string.byte(data,5) 	-- ATA CHAPTER
			DATA1 			= string.byte(data,6) 	-- ATA SUBCHAPTER
			DATA2 			= string.byte(data,7) 	-- DEVICE NUMBER BUTTON0, BUTTON1, ENCODER2, ANALOG HSB
			DATA3 			= string.byte(data,8) 	-- DEVICE VALUE ON/OFF, ENC LEFT/RIGHT , ANALOG LSB
		
			if SERVICE_CODE == 1 or SERVICE_CODE == 2 then -- SWITCH/ENCODER DEVICE
				canOpsTable[((DATA0 * (16^6)) + (DATA1 * (16^4)) + (DATA2 * (16^2)) + DATA3)]()
			elseif SERVICE_CODE == 3 then -- ANALOG DEVICE
				canOpsTable[(DATA0 * (16^2)) + DATA1]((DATA2 * (16^2)) + DATA3)
			end
		
		end
			
		-- Function Hook
		if PrevLuaExportBeforeNextFrame then PrevLuaExportBeforeNextFrame(); end

	end

end

do
	
	local PrevLuaExportStop = LuaExportStop;
	LuaExportStop = function()

		socket.try(con:close())
	
		-- Function Hook
		if PrevLuaExportStop then PrevLuaExportStop(); end

	end

end
