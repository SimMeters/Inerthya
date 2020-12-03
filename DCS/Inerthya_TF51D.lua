------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2020, SimMeters.com
-- All rights reserved. Released under the BSD license.
-- Inerthya_TF51D.lua 1.0 01/12/2020 (Export/Import Script P51D DCS Inerthya LUA)

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
package.path  = package.path..";.\\LuaSocket\\?.lua"
package.cpath = package.cpath..";.\\LuaSocket\\?.dll"

------------------------------------------------------------------------------------------------------------------------
-- Input Devices Example
------------------------------------------------------------------------------------------------------------------------
canOpsTable = {}
canOpsTable[0x00000000] = function() GetDevice(0):performClickableAction(3000, 0) end

------------------------------------------------------------------------------------------------------------------------
-- Hook PrevLuaExportStart
------------------------------------------------------------------------------------------------------------------------
do

	local PrevLuaExportStart = LuaExportStart;
	LuaExportStart = function()
		
		socket = require("socket")
		con = socket.try(socket.udp())
		socket.try(con:setpeername("127.0.0.1", 6060))
		socket.try(con:settimeout(0))
		-- socket.try(con:settimeout(.001))
		if PrevLuaExportStart then PrevLuaExportStart(); end
	
	end

end

------------------------------------------------------------------------------------------------------------------------
-- Hook PrevLuaExportBeforeNextFrame
------------------------------------------------------------------------------------------------------------------------
do

	local PrevLuaExportBeforeNextFrame = LuaExportBeforeNextFrame;
	LuaExportBeforeNextFrame = function()

		local dataIn = ""
		local dataOut = ""
		local mp = GetDevice(0)

		if mp then
		
			mp:update_arguments()
			
			-- RMI Radial
			arg = mp:get_argument_value(1)
			var = arg * 360
			dataOut = dataOut..packFloat(CA_VOR_1_RADIAL, NODE_AHRS, SC0, var)
		
			-- RMI Course
			arg = mp:get_argument_value(2)
			var = arg * 360
			dataOut = dataOut..packFloat(CA_SELECTED_COURSE, NODE_AHRS, SC0, var)

			-- Clock hours todo CA_UTC ??
			--arg = mp:get_argument_value(4)
			--var = arg * 12
			--dataOut = dataOut..packFloat(CA_?????, NODE_AHRS, SC0, var)

			-- Clock minutes todo CA_UTC ??
			--arg = mp:get_argument_value(5)
			--var = arg * 60
			--dataOut = dataOut..packFloat(CA_?????, NODE_AHRS, SC0, var)

			-- Clock seconds todo CA_UTC ??
			--arg = mp:get_argument_value(6)
			--var = arg * 60
			--dataOut = dataOut..packFloat(CA_?????, NODE_AHRS, SC0, var)

			-- Vacuum Suction Indicator
			arg = mp:get_argument_value(9)
			var = arg * 10
			dataOut = dataOut..packFloat(CA_STATIC_PRESSURE, NODE_AHRS, SC0, var)
			
			-- Manifold Pressure Indicator
			arg = mp:get_argument_value(10)
			var = (10 + (arg * 65))
			dataOut = dataOut..packFloat(CA_ENGINE_1_MANIFOLD_PRESSURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var)
			
			-- Airspeed Indicator
			arg = mp:get_argument_value(11)
			var = ((arg * 1000) * 0.5144)
			dataOut = dataOut..packFloat(CA_INDICATED_AIRSPEED, NODE_AHRS, SC0, var)
			
			-- Heading Indicator
			arg = mp:get_argument_value(12)
			var = (arg * 360)
			dataOut = dataOut..packFloat(CA_MAGNETIC_HEADING, NODE_AHRS, SC0, var)
			
			-- Roll
			arg = mp:get_argument_value(14)
			var = (arg * 180)
			dataOut = dataOut..packFloat(CA_BODY_ROLL_ANGLE, NODE_AHRS, SC0, var)

			-- Pitch
			arg = mp:get_argument_value(15)
			var = (arg * 180)
			dataOut = dataOut..packFloat(CA_BODY_PITCH_ANGLE, NODE_AHRS, SC0, var)
			
			-- Carburator Temp Indicator
			arg = mp:get_argument_value(21)
			var = ((arg * 230) - 80)
			dataOut = dataOut..packFloat(CA_ENGINE_1_CYLINDER_HEAD_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var)

			-- Coolant Temp Indicator
			arg = mp:get_argument_value(22)
			var = ((arg * 230) -80)
			dataOut = dataOut..packFloat(CA_ENGINE_1_COOLANT_TEMPERATURE_ECS_CHANNEL_A, NODE_AHRS, SC0, var)
			
			-- RPM Indicator
			arg = mp:get_argument_value(23)
			var = (arg * 4500)
			dataOut = dataOut..packFloat(CA_ENGINE_1_N2_ECS_CHANNEL_A, NODE_AHRS, SC0, var)

			-- Turn
			arg = mp:get_argument_value(27)
			var = arg
			dataOut = dataOut..packFloat(CA_TURN_COORDINATION_RATE, NODE_AHRS, SC0, var)

			-- Slip
			arg = mp:get_argument_value(28)
			var = arg
			dataOut = dataOut..packFloat(CA_BODY_SIDESLIP, NODE_AHRS, SC0, var)
			
			-- Vertical Speed Indicator
			arg = mp:get_argument_value(29)
			var = ((arg * 10000) * 0.00508)
			dataOut = dataOut..packFloat(CA_ALTITUDE_RATE, NODE_AHRS, SC0, var)

			-- Triple Gauge Temp Indicator NIL VALUE ??
			-- arg = mp:get_argument_value(30)
			-- var = (arg * 100)
			-- dataOut = dataOut..packFloat(CA_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A, SC0, var)

			-- Triple Gauge Oil Pressure NIL VALUE ??
			-- arg = mp:get_argument_value(31)
			-- var = (arg * 200)
			-- dataOut = dataOut..packFloat(CA_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A, SC0, var)

			-- Triple Gauge Fuel Pressure NIL VALUE ??
			-- arg = mp:get_argument_value(32)
			-- var = (arg * 25)
			-- dataOut = dataOut..packFloat(CA_FUEL_SYSTEM_1_PRESSURE, SC0, var) 
			
			-- Altitude
			arg = mp:get_argument_value(96)
			var = ((arg * 100000) * 0.3048)
			dataOut = dataOut..packFloat(CA_BARO_CORRECTED_ALTITUDE, NODE_AHRS, SC0, var)

			-- QNH
			arg = mp:get_argument_value(97)
			var = ((28.1 + (arg * 2.9)) * 33.7685)
			dataOut = dataOut..packFloat(CA_BARO_CORRECTION, NODE_AHRS, SC0, var)

			-- Accelerometer
			arg = mp:get_argument_value(175)
			var = ((arg * 17) - 5)
			dataOut = dataOut..packFloat(CA_BODY_NORMAL_ACCELERATION, NODE_AHRS, SC0, var)

			-- GROUP LAMPS_0_31
			lp = { 
				mp:get_argument_value(161), 	-- TailRadarWarning
				mp:get_argument_value(122), 	-- A_channel_light
				mp:get_argument_value(123), 	-- B_channel_light
				mp:get_argument_value(124), 	-- C_channel_light
				mp:get_argument_value(125), 	-- D_channel_light
				mp:get_argument_value(126), 	-- Transmit_light
				mp:get_argument_value(80), 		-- LandingGearGreenLight
				mp:get_argument_value(82), 		-- LandingGearRedLight
				mp:get_argument_value(164), 	-- Left_Fluor_Light
				mp:get_argument_value(165), 	-- Right_Fluor_Light
				mp:get_argument_value(59), 		-- Hight_Blower_Lamp
				mp:get_argument_value(185), 	-- Left_cockpit_light
				mp:get_argument_value(186), 	-- Right_cockpit_light
				mp:get_argument_value(190), 	-- warEmergencyPowerLimWire
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0,								-- N/A
				0								-- N/A
			}
			
			var = string.format("%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1]))
			dataOut = dataOut..packUint32(UD_FLAGS_0_31, NODE_AHRS, SC0, var * 1)
		
		end
		
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
		
		if PrevLuaExportBeforeNextFrame then PrevLuaExportBeforeNextFrame(); end

	end

end

------------------------------------------------------------------------------------------------------------------------
-- Hook PrevLuaExportStop
------------------------------------------------------------------------------------------------------------------------
do

	local PrevLuaExportStop = LuaExportStop;

	LuaExportStop = function()

		socket.try(con:close())
		if PrevLuaExportStop then PrevLuaExportStop(); end

	end

end