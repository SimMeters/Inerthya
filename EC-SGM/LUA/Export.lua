------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2020, SimMeters.
-- All rights reserved. Released under the BSD license.
-- Export.lua 1.0 01/01/2020 (Export/Import Script DCS FW109)

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
-- Input Devices
------------------------------------------------------------------------------------------------------------------------
canOpsTable = {}

  -- C 100 - Navigation Lights CB ho han canviat una mica bastant axio pero basicament lo important es el device.FUSEBOX i el Button_6
           -- elements["C100"] = default_2_position_tumb(_("Cockpit.Bf109K4.cb_c100"), devices.FUSEBOX, device_commands.Button_6, 116)
            --elements["C100"].sound = {{SOUND_CB_RESET, SOUND_CB_ON}, {SOUND_CB_RESET, SOUND_CB_ON}}
            --elements["C100_1"] = default_1_position_tumb(_("Cockpit.Bf109K4.cb_c100_1"), devices.FUSEBOX, device_commands.Button_8, 116, 1, {1, 1})
            --elements["C100_1"].sound = {{SOUND_NOSOUND, SOUND_NOSOUND}}
            --elements["C100_0"] = default_button(_("Cockpit.Bf109K4.cb_c100_0"), devices.FUSEBOX, device_commands.Button_84, 153)
            --elements["C100_0"].sound = {{SOUND_NOSOUND, SOUND_NOSOUND}}


--3000 + button = 6 = 3006 provem aixo es mes prova i error que la exportacio O_O

-- Devices.lua el fusebox es el primer elemtn del array = 1

canOpsTable[0xA1000000] = function() GetDevice(1):performClickableAction(3006, 0) end -- SW1 OFF posem algun input de prova per que vegis d on ho agafem
canOpsTable[0xA1000001] = function() GetDevice(1):performClickableAction(3006, 1) end -- SW1 ON
canOpsTable[0xA2000000] = function() GetDevice(1):performClickableAction(3008, 0) end -- SW2 OFF
canOpsTable[0xA2000001] = function() GetDevice(1):performClickableAction(3008, 1) end -- SW2 ON
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
canOpsTable[0xE0000002] = function() end -- EN0 DEC
canOpsTable[0xE0000003] = function() end -- EN0 INC

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
-- LuaExportStart()
------------------------------------------------------------------------------------------------------------------------
function LuaExportStart()

	package.path  = package.path..";.\\LuaSocket\\?.lua"
	package.cpath = package.cpath..";.\\LuaSocket\\?.dll"

	socket = require("socket")

	con = socket.try(socket.udp())
	socket.try(con:settimeout(.001))
	socket.try(con:setpeername("172.16.1.100", 6060))

	aux = socket.try(socket.udp())
	socket.try(aux:settimeout(.001))
	socket.try(aux:setpeername("127.0.0.1", 6060))

end

------------------------------------------------------------------------------------------------------------------------
-- LuaExportBeforeNextFrame()
------------------------------------------------------------------------------------------------------------------------
function LuaExportBeforeNextFrame()

	-- Export Data
	local packet = ""
	local flightData = {}

	local mp = GetDevice(0)
	if mp then
		
		-- Update Data
		mp:update_arguments()

		-- Indicated Airspeed m/s
		arg = mp:get_argument_value(2)
		var = arg * 1000 -- km/h (scale) 1 = 1000 km/h
		var = var * 0.277778 -- m/s
		table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f", var))

		-- Flaps (N/A) no he trobat pero aquest bichu te flaps no ??si 
		table.insert(flightData,string.format("ID_FLAPS_LEVER_POSITION=%.4f", 0))
		
		-- Pitch aquest d aqui hem de veure si es 180 o 360 etc.... aqui amb el workspace hem de veure que sigui ok
		arg = mp:get_argument_value(5)
		var = arg * 180 -- deg/3 (scale?)
		table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f", var))
	
		-- Bank idem
		arg = mp:get_argument_value(4)
		var = arg * 180 -- deg (scale?)
		table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f", var))

		-- Heading idem 
		arg = mp:get_argument_value(13)
		var = arg * 360 -- deg (scale?)
		table.insert(flightData,string.format("ID_HEADING_ANGLE=%.4f", var))

		-- Heading Bug (Course) idem 
		arg = mp:get_argument_value(12)
		var = arg * 360 -- deg (scale?)
		table.insert(flightData,string.format("ID_DESIRED_TRACK_ANGLE=%.4f", var))

		-- SlipBall CANAerospace from -1 to +1 ok
		arg = mp:get_argument_value(6)
		var = arg -- +/- 1
		table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", var))	

		-- TurnRate CANAerospace from -1 to +1 ok
		arg = mp:get_argument_value(3)
		var = arg -- +/- 1
		table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f", var))	

		-- Barometric Altimeter Pressure Setting CANAerospace hPa
		arg = mp:get_argument_value(10)
		var = 712.56 + (arg * 67.51) -- (780.07 - 712.56)
		var = var * 1000 -- mbar to hPa
		table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f", var))

		-- Barometric Altimeter Altitude CANAerospace m
		arg = mp:get_argument_value(9)
		var = arg * 13000
		table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f", var))

		-- Variometer CANAerospace m/s units
		arg = mp:get_argument_value(36)
		var = arg * 100
		table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f", var))

		-- Coolant Temperature K left
		arg = mp:get_argument_value(27)
		var = (arg * 130) + 273.15 -- ºC to K
		table.insert(flightData, string.format("ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f", var))

		-- Oil Temperature K right
		arg = mp:get_argument_value(28)
		var = (arg * 130) + 273.15 -- ºC to K
		table.insert(flightData, string.format("ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f", var))
	
		-- Engine RPM 3600 to 100% 3600 rpm es el 100%
		arg = mp:get_argument_value(29)
		var = arg * 100
		--log.info(string.format("VAR=%.4f", var))
		--var = var * 36 -- ?? a veure que surt
		--var = 400 + (var * (3600 - 400))
		--segueix fixe a 100
		--var = var / 100 -- 3600 = 36% provem aixi a veure que surt
		--print(string.format("RPM=%.4f", arg))
	--	print(string.format("RPM=%.4f", .. arg)) --?
		--fet, agulla fixa al 100 
		table.insert(flightData, string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f", var))
		table.insert(flightData, string.format("ID_ENGINE_2_N2_ECS_CHANNEL_A=%.4f", 50))
 
		--Engine_RPM                          = CreateGauge()
		--Engine_RPM.arg_number               = 29
		--Engine_RPM.input                    = {400.0, 3600.0} 0 = 400 1 = 3600
		--Engine_RPM.output                   = {0.0, 1.0}
		--Engine_RPM.controller               = controllers.Engine_RPM
 
		-- Fuel Flow l/h (N/A)
		table.insert(flightData, string.format("ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f", 0))
		table.insert(flightData, string.format("ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f", 0))
	
		-- OIL Pressure hPa
		arg = mp:get_argument_value(26)
		var = arg * 10 -- scale
		var = arg * 980.665 -- Kg/cm2 to hPa
		table.insert(flightData,string.format("ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A=%.4f", var))
		table.insert(flightData,string.format("ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A=%.4f", 0))

		-- propeller pitch format horari 12.30 etc
		arg = mp:get_argument_value(30)
		var = arg * 12 -- scale small pointer
		table.insert(flightData,string.format("ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_A=%.4f", var))

		arg = mp:get_argument_value(31)
		var = arg * 60 -- scale big pointer
		table.insert(flightData,string.format("ID_ENGINE_1_CONDITION_LEVER_POSITION_ECS_CHANNEL_B=%.4f", var))
		
		
		--ok la formula del big pointer estaba malamanet ja esta. provem
		
		-- fuel quantity en kg (L)
		--fuel system
		--Fuel_Tank_Fuselage              	= CreateGauge()
		--Fuel_Tank_Fuselage.arg_number   	= 33
		--Fuel_Tank_Fuselage.input        	= {-1.0,  0.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0,  400.0} -- Liters
		--Fuel_Tank_Fuselage.output       	= {-1.0,  0.0,  0.07, 0.175,  0.31,  0.52,  0.73,  0.88,    1.0}
		--Fuel_Tank_Fuselage.controller   	= controllers.Fuel_Tank_Fuselage
		--fara falta formula per el disseny de la escala
		arg = mp:get_argument_value(33)
		var =  250 -- per exemple   es en kg es per que provis que el opengl es ok --arg * 400 -- 1 = 400 -- ara ho posem directe
		table.insert(flightData,string.format("ID_FUEL_TANK_1_QUANTITY=%.4f", var))

		-- LAMPS_0_31
		lp = { 
		1,	-- 1 LT0 GAUGES LIGHTS
		math.floor(mp:get_argument_value(135)),	-- 2 LT1 (FUEL RESERVE)
		0,	-- 3 LT2
		0,	-- 4 LT3
		0,	-- 5 LT4
		0,	-- 6 LT5
		0,	-- 7 LT6
		0,	-- 8 LT7
		0,	-- 9  LT8
		math.floor(mp:get_argument_value(57)),	-- 10 LEFT
		math.floor(mp:get_argument_value(56)),	-- 11 NOSE
		math.floor(mp:get_argument_value(58)),	-- 12 RIGHT
		0,	-- 13 
		0,	-- 14 
		0,	-- 15 
		0,	-- 16 

		0,	-- 17 
		0,	-- 18 
		0,	-- 19 
		0,	-- 20 
		0,	-- 21 
		0,	-- 22 
		0,	-- 23 
		0,	-- 24 

		0,	-- 25 
		0,	-- 26 
		0,	-- 27 
		0,	-- 28 
		0,	-- 29 
		0,	-- 30 
		0,	-- 31 
		0 	-- 32 
		}

		table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
	
------------------------------------------------------------------------------------------------------------------------
-- TX Data
------------------------------------------------------------------------------------------------------------------------
		for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
		socket.try(con:send(string.upper(packet)))
		socket.try(aux:send(string.upper(packet)))
	
	end
	
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

------------------------------------------------------------------------------------------------------------------------
-- LuaExportAfterNextFrame()
------------------------------------------------------------------------------------------------------------------------
function LuaExportAfterNextFrame()
end

------------------------------------------------------------------------------------------------------------------------
-- LuaExportStop()
------------------------------------------------------------------------------------------------------------------------
function LuaExportStop()

	socket.try(con:close())
	socket.try(aux:close())

end
