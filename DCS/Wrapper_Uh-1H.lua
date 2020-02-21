------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2014, SimMeters.
-- All rights reserved. Released under the BSD license.
-- Wrapper_Uh-1H.lua 1.0 01/01/2014 (Import/Export script for SimMeters Workspace)

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

-- PNL_0210 MIP
canOpsTable[QNH_ENC_INC] = function() GetDevice(18):performClickableAction(3001,  0.05) end
canOpsTable[QNH_ENC_DEC] = function() GetDevice(18):performClickableAction(3001, -0.05) end
canOpsTable[FUEL_DISPLAY_TEST_IND_ON] = function() GetDevice(2):performClickableAction(3002, 1) end
canOpsTable[FUEL_DISPLAY_TEST_IND_OFF] = function() GetDevice(2):performClickableAction(3002, 0) end
canOpsTable[FIRE_DETECTOR_TEST_ON] = function() GetDevice(3):performClickableAction(3023, 1) end
canOpsTable[FIRE_DETECTOR_TEST_OFF] = function() GetDevice(3):performClickableAction(3023, 0) end

-- PNL_0211 AN/APX-72 Transponder

-- PNL_0212 Miscellaneous Control Panel
canOpsTable[CHIP_DET_XSMN] = function() GetDevice(3):performClickableAction(3013,  1) end
canOpsTable[CHIP_DET_BOTH] = function() GetDevice(3):performClickableAction(3013,  0) end
canOpsTable[CHIP_DET_TAIL] = function() GetDevice(3):performClickableAction(3013, -1) end
canOpsTable[FORCE_TRIM_OFF] = function() GetDevice(4):performClickableAction(3004,  0) end
canOpsTable[FORCE_TRIM_ON] = function() GetDevice(4):performClickableAction(3004,  1) end
canOpsTable[HYD_CONT_OFF] = function() GetDevice(4):performClickableAction(3003,  0) end
canOpsTable[HYD_CONT_ON] = function() GetDevice(4):performClickableAction(3003,  1) end

-- PNL_0213 AN/ARN-81 VHF NAV Radio

-- PNL_0214 Caution Lights Panel
canOpsTable[ANUNCIATOR_CTL_RESET] = function() GetDevice(15):performClickableAction(3001,  1) end
canOpsTable[ANUNCIATOR_CTL_OFF] = function() GetDevice(15):performClickableAction(3001,  0) end
canOpsTable[ANUNCIATOR_CTL_TEST] = function() GetDevice(15):performClickableAction(3001, -1) end
canOpsTable[ANUNCIATOR_LGT_BRIGHT] = function() GetDevice(15):performClickableAction(3002,  1) end
canOpsTable[ANUNCIATOR_LGT_OFF] = function() GetDevice(15):performClickableAction(3002,  0) end
canOpsTable[ANUNCIATOR_LGT_DIM] = function() GetDevice(15):performClickableAction(3002, -1) end

-- PNL_0215 AN/ARC-134 VHF COMM Radio

-- PNL_0216 Engine Control Panel
canOpsTable[LOW_RPM_ALERT_OFF] = function() GetDevice(3):performClickableAction(3021, 0) end
canOpsTable[LOW_RPM_ALERT_ON] = function() GetDevice(3):performClickableAction(3021, 1) end
canOpsTable[FUEL_OFF] = function() GetDevice(2):performClickableAction(3001, 0) end
canOpsTable[FUEL_ON] = function() GetDevice(2):performClickableAction(3001, 1) end
canOpsTable[DEICE_OFF] = function() GetDevice(3):performClickableAction(3002, 0) end
canOpsTable[DEICE_ON] = function() GetDevice(3):performClickableAction(3002, 1) end
canOpsTable[GOVERNOR_OFF] = function() GetDevice(3):performClickableAction(3014, 0) end
canOpsTable[GOVERNOR_ON] = function() GetDevice(3):performClickableAction(3014, 1) end

-- PNL_0217 AN/ARC-51BX UHF Radio

-- PNL_0218 AN/ARC-131 FM Radio

-- PNL_0219 C-1611/AIC Signal Distribution Panel

-- PNL_0220 AN/ARN-83 ADF Radio

-- PNL_0221 Armament Control Panel

-- PNL_0222 CMS Panel

-- PNL_0223 Dome Light Panel
canOpsTable[DOME_WHITE] = function() GetDevice(7):performClickableAction(3021,  1) end
canOpsTable[DOME_OFF] = function() GetDevice(7):performClickableAction(3021,  0) end
canOpsTable[DOME_GREEN] = function() GetDevice(7):performClickableAction(3021, -1) end
canOpsTable[PITOT_HEAT_OFF] = function() GetDevice(1):performClickableAction(3016,  0) end
canOpsTable[PITOT_HEAT_ON] = function() GetDevice(1):performClickableAction(3016,  1) end

-- PNL_0224 Instrument Lighting Panel

-- PNL_0225 External Lights
canOpsTable[POSITION_FLASH] = function() GetDevice(7):performClickableAction(3002,  1) end
canOpsTable[POSITION_OFF] = function() GetDevice(7):performClickableAction(3002,  0) end
canOpsTable[POSITION_STEADY] = function() GetDevice(7):performClickableAction(3002, -1) end
canOpsTable[POSITION_BRIGHT] = function() GetDevice(7):performClickableAction(3003,  0) end
canOpsTable[POSITION_DIM] = function() GetDevice(7):performClickableAction(3003,  1) end
canOpsTable[ANTICOLLISION_OFF] = function() GetDevice(7):performClickableAction(3004,  0) end
canOpsTable[ANTICOLLISION_ON] = function() GetDevice(7):performClickableAction(3004,  1) end

-- PNL_0226 AC Power Panel
canOpsTable[INVERTER_BUS_AB] = function() GetDevice(1):performClickableAction(3007, 0.0) end
canOpsTable[INVERTER_BUS_AC] = function() GetDevice(1):performClickableAction(3007, 0.1) end
canOpsTable[INVERTER_BUS_BC] = function() GetDevice(1):performClickableAction(3007, 0.2) end
canOpsTable[INVERTER_MAIN] = function() GetDevice(1):performClickableAction(3008,   1) end
canOpsTable[INVERTER_OFF] = function() GetDevice(1):performClickableAction(3008,   0) end
canOpsTable[INVERTER_SPARE] = function() GetDevice(1):performClickableAction(3008,  -1) end

-- PNL_0227 Wipers Panel Check WIPER SELECTOR
canOpsTable[WIPER_PILOT] = function() GetDevice(12):performClickableAction(3002,   1) end
canOpsTable[WIPER_BOTH] = function() GetDevice(12):performClickableAction(3002,   0) end
canOpsTable[WIPER_COPILOT] = function() GetDevice(12):performClickableAction(3002,  -1) end
canOpsTable[WIPER_SEL_PARK] = function() GetDevice(12):performClickableAction(3001, 0.0) end
canOpsTable[WIPER_SEL_OFF] = function() GetDevice(12):performClickableAction(3001, 0.1) end
canOpsTable[WIPER_SEL_LOW] = function() GetDevice(12):performClickableAction(3001, 0.2) end
canOpsTable[WIPER_SEL_MED] = function() GetDevice(12):performClickableAction(3001, 0.3) end
canOpsTable[WIPER_SEL_HIGH] = function() GetDevice(12):performClickableAction(3001, 0.4) end

-- PNL_0228 DC Power Panel
canOpsTable[MAIN_GENERATOR_RESET] = function() GetDevice(1):performClickableAction(3002,   0) end
canOpsTable[MAIN_GENERATOR_OFF] = function() GetDevice(1):performClickableAction(3002,   1) end
canOpsTable[MAIN_GENERATOR_ON] = function() GetDevice(1):performClickableAction(3002,  -1) end
canOpsTable[VM_BUS_BAT] = function() GetDevice(1):performClickableAction(3004, 0.4) end
canOpsTable[VM_BUS_MAIN_GEN] = function() GetDevice(1):performClickableAction(3004, 0.3) end
canOpsTable[VM_BUS_STBY_GEN] = function() GetDevice(1):performClickableAction(3004, 0.2) end
canOpsTable[VM_BUS_ESS_BUS] = function() GetDevice(1):performClickableAction(3004, 0.1) end
canOpsTable[VM_BUS_NONESS_BUS] = function() GetDevice(1):performClickableAction(3004, 0.0) end
canOpsTable[BATTERY_POWER_OFF] = function() GetDevice(1):performClickableAction(3001,   0) end
canOpsTable[BATTERY_POWER_ON] = function() GetDevice(1):performClickableAction(3001,   1) end
canOpsTable[GENERATOR_START] = function() GetDevice(1):performClickableAction(3003,   0) end
canOpsTable[GENERATOR_STBY] = function() GetDevice(1):performClickableAction(3003,   1) end
canOpsTable[BUS_NONESS_MANUAL] = function() GetDevice(1):performClickableAction(3005,   0) end
canOpsTable[BUS_NONESS_NORMAL] = function() GetDevice(1):performClickableAction(3005,   1) end

-- PNL_0229 Cabin Heating Panel
canOpsTable[CABIN_HEATING_OFF] = function() GetDevice(47):performClickableAction(3001, 0.0) end
canOpsTable[CABIN_HEATING_POS1] = function() GetDevice(47):performClickableAction(3001, 0.1) end
canOpsTable[CABIN_HEATING_POS2] = function() GetDevice(47):performClickableAction(3001, 0.2) end
canOpsTable[CABIN_HEATING_POS3] = function() GetDevice(47):performClickableAction(3001, 0.3) end
canOpsTable[CABIN_HEATING_POS4] = function() GetDevice(47):performClickableAction(3001, 0.4) end

-- PNL_0231 NVG Position Lights Panel

-- PNL_0232 Collective and Cyclic
canOpsTable[SEARCH_LIGHT_ON] = function() GetDevice(7):performClickableAction(3006, 1) end
canOpsTable[SEARCH_LIGHT_OFF] = function() GetDevice(7):performClickableAction(3006, 0) end
canOpsTable[SEARCH_LIGHT_STOW] = function() GetDevice(7):performClickableAction(3006, -1) end
canOpsTable[LAND_LIGHT_ON] = function() GetDevice(7):performClickableAction(3005, 1) end
canOpsTable[LAND_LIGHT_OFF] = function() GetDevice(7):performClickableAction(3005, 0) end
canOpsTable[GOVERNOR_INC] = function() GetDevice(3):performClickableAction(3015, 1) end
canOpsTable[GOVERNOR_NOP] = function() GetDevice(3):performClickableAction(3015, 0) end
canOpsTable[GOVERNOR_DEC] = function() GetDevice(3):performClickableAction(3015, -1) end
canOpsTable[LAND_LIGHT_EXTR] = function() GetDevice(7):performClickableAction(3007, 1) end
canOpsTable[LAND_LIGHT_NOP] = function() GetDevice(7):performClickableAction(3007, 0) end
canOpsTable[LAND_LIGHT_RETR] = function() GetDevice(7):performClickableAction(3007, -1) end
canOpsTable[RELEASE_STARTER_ENG_1_ON] = function() GetDevice(3):performClickableAction(3027, 1) end
canOpsTable[RELEASE_STARTER_ENG_1_OFF] = function() GetDevice(3):performClickableAction(3027, 0) end
canOpsTable[FORCE_TRIM_ON] = function() GetDevice(41):performClickableAction(3001, 1) end
canOpsTable[FORCE_TRIM_OFF] = function() GetDevice(41):performClickableAction(3001, 0) end
canOpsTable[RADIO_ICS_ON] = function() GetDevice(21):performClickableAction(3009, 1) end
canOpsTable[RADIO_ICS_OFF] = function() GetDevice(21):performClickableAction(3009, 0) end

do

	local PrevLuaExportStart = LuaExportStart;
	LuaExportStart = function()
		
		package.path  = package.path..";.\\LuaSocket\\?.lua"
		package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
		socket = require("socket")
		con = socket.try(socket.udp())
		socket.try(con:settimeout(.001))
		socket.try(con:setpeername("127.0.0.1", 6060))
		if PrevLuaExportStart then PrevLuaExportStart(); end
	
	end

end

do

	local PrevLuaExportBeforeNextFrame = LuaExportBeforeNextFrame;
	LuaExportBeforeNextFrame = function()

		local packet = ""
		local flightData = {}
		local mp = GetDevice(0)

		if mp then
		
			-- Update Data
			mp:update_arguments()

			-- ADI Pitch CANAerospace degrees {-math.pi/2.0,math.pi/2.0}{1.0,-1.0}
			arg = mp:get_argument_value(143)
			var = (arg * -90)
			table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f", var))       
 
			-- ADI_Bank CANAerospace degrees {0.0,math.pi*2.0}{-1.0,1.0}
			arg = mp:get_argument_value(142) 
			var = (arg * 180)
			table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f", var))     

			-- Radio Compass Digital to PFD
			-- Course Deviation Indicator to PFD

			-- Airspeed CANAerospace m/s
			arg = mp:get_argument_value(117)
			if (arg >= 0.00 and arg <= 0.075) then var = (arg * 266.66) end
			if (arg > 0.075 and arg <= 0.190) then var = (20  + ((arg - 0.075) * 86.95))  end
			if (arg > 0.190 and arg <= 0.320) then var = (30 + ((arg - 0.190)  * 76.92))  end
			if (arg > 0.320 and arg <= 0.395) then var = (40 + ((arg - 0.320) * 133.33))  end
			if (arg > 0.395 and arg <= 0.440) then var = (50 + ((arg - 0.395) * 222.22))  end
			if (arg > 0.440 and arg <= 0.550) then var = (60 + ((arg - 0.440) * 181.81))   end
			if (arg > 0.550 and arg <= 0.825) then var = (80 + ((arg - 0.550) * 145.45))   end
			if (arg > 0.825 and arg <= 1.000) then var = (120 + ((arg - 0.825) * 171.42)) end
			if (arg > 1.000) then var = 150 end
			var = (var * 0.5144)
			table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f",var))

			-- Altimeter (Altitude ASL) CANAerospace meters
			arg = mp:get_argument_value(179)
			var = arg * 3048
			table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f",var))

			-- Barometric Pressure CANAerospace hPa
			arg = mp:get_argument_value(182)
			var = (28.1 + (arg * 2.9)) * 33.8638
			table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f",var))

			-- Radar Altimeter (Altitude AGL) CANAerospace meters
			var = LoGetAltitudeAboveGroundLevel()
			table.insert(flightData,string.format("ID_RADIO_HEIGHT=%.4f",var))

			-- Vertical Velocity Indicator CANAerospace m/s {-4000.0, -3000.0, -1500.0, -1000.0, 1000.0, 1500.0, 3000.0, 4000.0}{-1.0, -0.81,  -0.54, -0.36, 0.36, 0.54, 0.81, 1.0}
			arg = mp:get_argument_value(134)
			if (arg < -1.0) then var = -4000 end
			if (arg < -0.81 and arg >= -1.00) then var = (-3000 + ((arg + 0.81) * 5263.15))  end
			if (arg < -0.54 and arg >= -0.81) then var = (-1500 + ((arg + 0.54) * 5555.55))  end
			if (arg >= -0.54 and arg <= 0.54) then var = (arg * 2777.77)  end
			if (arg > 0.54 and arg <= 0.81) then var = (1500 + ((arg - 0.54) * 5555.55))  end
			if (arg > 0.81 and arg <= 1.00) then var = (3000 + ((arg - 0.81) * 5263.15))  end
			if (arg > 1.0) then var = 4000 end
			var = (var * 0.00508)
			table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f",var))

			-- Turn & Slip Indicator
			arg = mp:get_argument_value(132)
			var = arg
			table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f",var))

			arg = mp:get_argument_value(133)
			var = arg
			table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f",var))

			-- Engine / Rotor RPM Tachometer {0.0, 7200.0}{0.0, 1.0}
			arg = mp:get_argument_value(122) 
			var = (arg * 7200)
			table.insert(flightData,string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f",var))
			
			arg = mp:get_argument_value(123) 
			var = (arg * 360)
			table.insert(flightData,string.format("ID_ROTOR_1_RPM=%.4f",var))

			-- Fuel Pressure {-2.0, 0.0, 50.0}{0.0, 0.015, 1.0} CANAerospace hPa
			arg = mp:get_argument_value(126)
			var = 0.0
			if (arg >= 0.015 and arg <= 1.0) then var = (arg * 49.25) + 0.75 end
			var = (var * 68.9475) -- PSI to hPa 
			table.insert(flightData,string.format("ID_FUEL_SYSTEM_1_PRESSURE=%.4f",var))

			-- Fuel Quantity {0.0, 1580.0} {0.0, 1.0} CANAerospace lbs to Kg
			arg = mp:get_argument_value(239)
			var = (arg * 1580) * 0.4535
			table.insert(flightData,string.format("ID_FUEL_TANK_1_QUANTITY=%.4f",var))

			-- Engine Oil Pressure {-3.0, 0.0, 100.0} {0.0, 0.029, 1.0} CANAerospace hPa
			arg = mp:get_argument_value(113)
			var = 0.0
			if (arg >= 0.029 and arg <= 1.0) then var = (arg * 97.1) + 2.9 end
			var = (var * 68.9475) -- PSI to hPa 
			table.insert(flightData,string.format("ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A=%.4f",var))
			
			-- Engine Oil Temp {-70.0, -50.0, 0.0, 100.0, 150.0} {0.0, 0.13, 0.38, 0.71, 1.0} CANAerospace ºC
			arg = mp:get_argument_value(114)
			if (arg >= 0.00 and arg <= 0.13) then var = (-70  + (arg * 153.84))  end
			if (arg > 0.13 and arg <= 0.38) then var = (-50  + ((arg - 0.13) * 200))  end
			if (arg > 0.38 and arg <= 0.71) then var = (0  + ((arg - 0.38) * 303.03))  end
			if (arg > 0.71 and arg <= 1.0) then var = (0  + ((arg - 0.38) * 172.41))  end
			if (arg > 1.000) then var = 150 end
			table.insert(flightData,string.format("ID_ENGINE_1_OIL_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))

			-- Transmission Oil Pressure {-3.0, 0.0, 100.0} {0.0, 0.029, 1.0} CANAerospace hPa
			arg = mp:get_argument_value(115)
			var = 0.0
			if (arg >= 0.029 and arg <= 1.0) then var = (arg * 97.1) + 2.9 end
			var = (var * 68.9475) -- PSI to hPa 
			table.insert(flightData,string.format("ID_GEARBOX_1_OIL_PRESSURE=%.4f",var))
			
			-- Transmission Oil Temp {-70.0, -50.0, 0.0, 100.0, 150.0} {0.0, 0.13, 0.38, 0.71, 1.0} CANAerospace ºC
			arg = mp:get_argument_value(116)
			if (arg >= 0.00 and arg <= 0.13) then var = (-70  + (arg * 153.84))  end
			if (arg > 0.13 and arg <= 0.38) then var = (-50  + ((arg - 0.13) * 200))  end
			if (arg > 0.38 and arg <= 0.71) then var = (0  + ((arg - 0.38) * 303.03))  end
			if (arg > 0.71 and arg <= 1.0) then var = (0  + ((arg - 0.38) * 172.41))  end
			if (arg > 1.000) then var = 150 end
			table.insert(flightData,string.format("ID_GEARBOX_1_OIL_TEMPERATURE=%.4f",var))

			-- Torque Presure CANAerospace hPa {-3.0, 0.0, 100.0}{0.0, 0.029, 1.0}
			arg = mp:get_argument_value(124)
			var = 0.0
			if (arg >= 0.029 and arg <= 1.0) then var = (arg * 97.1) + 2.9 end
			var = (var * 68.9475) -- PSI to hPa 
			table.insert(flightData,string.format("ID_ENGINE_1_TORQUE_ECS_CHANNEL_A=%.4f",var))

			-- Gas Producer RPM N1 {0.0, 101.5} {0.0, 1.0}
			arg = mp:get_argument_value(119)
			var = (arg * 101.5)
			table.insert(flightData,string.format("ID_ENGINE_1_N1_ECS_CHANNEL_A=%.4f",var))
			
			-- Exhaust Gas Temperature CANAerospace ºC {0.0, 1000.0}{0.0, 1.0}
			arg = mp:get_argument_value(121)
			var = (arg * 1000) 
			table.insert(flightData,string.format("ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))
			
			-- GROUP LAMPS_0_31
			lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			lp[1] = 1							
			lp[2] = mp:get_argument_value(277) 	-- MASTER_CAUTION
			lp[3] = mp:get_argument_value(276) 	-- LOW_RPM
			lp[4] = mp:get_argument_value(275) 	-- FIRE
			lp[5] = mp:get_argument_value(91) 	-- ENGINE_OIL_PRESS
			lp[6] = mp:get_argument_value(92) 	-- ENGINE_ICING
			lp[7] = mp:get_argument_value(93) 	-- ENGINE_ICE_DET
			lp[8] = mp:get_argument_value(94) 	-- ENGINE_CHIP_DET
			lp[9] = mp:get_argument_value(95) 	-- LEFT_FUEL_BOOST
			lp[10] = mp:get_argument_value(97) 	-- ENG_FUEL_PUMP
			lp[11] = mp:get_argument_value(96) 	-- RIGHT_FUEL_BOOST
			lp[12] = mp:get_argument_value(98) 	-- 20_MINUTE_FUEL
			lp[13] = mp:get_argument_value(99) 	-- FUEL_FILTER
			lp[14] = mp:get_argument_value(100) -- GOV_EMERG
			lp[15] = mp:get_argument_value(101) -- AUX_FUEL_LOW
			lp[16] = mp:get_argument_value(102) -- XMSN_OIL_PRESS
			lp[17] = mp:get_argument_value(103) -- XMSN_OIL_HOT
			lp[18] = mp:get_argument_value(104) -- HYD_PRESSURE
			lp[19] = mp:get_argument_value(105) -- ENGINE_INLET_AIR
			lp[20] = mp:get_argument_value(106) -- INST_INVERTER
			lp[21] = mp:get_argument_value(107) -- DC_GENERATOR
			lp[22] = mp:get_argument_value(108) -- EXTERNAL_POWER
			lp[23] = mp:get_argument_value(109) -- CHIP_DETECTOR
			lp[24] = mp:get_argument_value(110) -- IFF
			lp[25] = mp:get_argument_value(76) 	-- IFF_REPLY
			lp[26] = mp:get_argument_value(77) 	-- IFF_TEST
			lp[27] = mp:get_argument_value(254) -- ARMED
			lp[28] = mp:get_argument_value(255) -- SAFE
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
			
		if PrevLuaExportBeforeNextFrame then PrevLuaExportBeforeNextFrame(); end

	end

end

do
	
	local PrevLuaExportStop = LuaExportStop;
	LuaExportStop = function()

		socket.try(con:close())
		if PrevLuaExportStop then PrevLuaExportStop(); end

	end

end
