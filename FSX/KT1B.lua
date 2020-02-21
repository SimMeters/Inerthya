------------------------------------------------------------------------------------------------------------------------
-- Copyright(c) 2016, SimMeters.com
-- All rights reserved. Released under the BSD license.
-- KT1B.lua 1.0 01/01/2016 (Import/Export script for Inerthya KT1B FTD)

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
-- Includes
------------------------------------------------------------------------------------------------------------------------
--require("ipc")
--require("table_ext")
--require("string_ext")
--require("string_indexing")
--require("math_ext")
--require("strbuf")
--require("classlib")
--require("event")
--require("com")
--require("common")
--require("actions")
--require ("wait")
--require ("EngSnd")
--require ("complex") --
--require ("dsp") --
dofile("inerthya.lua") -- SimMeters INERTHYA System LUA Implementation

------------------------------------------------------------------------------------------------------------------------
-- Network Configuration
------------------------------------------------------------------------------------------------------------------------
socket = require("socket")
con = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("192.168.1.100", 6060))
--socket.try(con:setpeername("169.254.2.33", 6060))

------------------------------------------------------------------------------------------------------------------------
-- Global Variables
------------------------------------------------------------------------------------------------------------------------
canOpsTable 	= {}
uhf_frq		= 320.00
uhf_chn 	= 1
uhf_mod 	= 0

------------------------------------------------------------------------------------------------------------------------
-- Input Commands
------------------------------------------------------------------------------------------------------------------------
canOpsTable[0x220A0801] = function() ipc.writeUW(0x0330, ipc.readUW(0x0330) - 1) end 	-- DECREASE QHN
canOpsTable[0x220A0802] = function() ipc.writeUW(0x0330, ipc.readUW(0x0330) + 1) end 	-- INCREASE QNH
canOpsTable[0x160A3001] = function() ipc.writeSD(0x02C4, ipc.readSD(0x02C4) - 50) end 	-- DECREASE IDX SPEED
canOpsTable[0x160A3002] = function() ipc.writeSD(0x02C4, ipc.readSD(0x02C4) + 50) end 	-- INCREASE IDX SPEED
canOpsTable[0x160A4001] = function() ipc.writeDBL(0x3428, ipc.readDBL(0x3428) - 1) end 	-- DECREASE DH
canOpsTable[0x160A4002] = function() ipc.writeDBL(0x3428, ipc.readDBL(0x3428) + 1) end 	-- INCREASE DH
canOpsTable[0x2C1E1902] = function() uhf_frq = uhf_frq + 0.25 end 			-- UHF_KHZ_FREQUENCY_INC
canOpsTable[0x2C1E1901] = function() uhf_frq = uhf_frq - 0.25 end 			-- UHF_KHZ_FREQUENCY_DEC
canOpsTable[0x2C1E1A02] = function() uhf_frq = uhf_frq + 1.0 end 			-- UHF_MHZ_FREQUENCY_INC
canOpsTable[0x2C1E1A01] = function() uhf_frq = uhf_frq - 1.0 end 			-- UHF_MHZ_FREQUENCY_DEC
canOpsTable[0x2C1E1B00] = function() return end 					-- UHF_MODE_OFF
canOpsTable[0x2C1E1B01] = function() uhf_mod = uhf_mod + 1 if uhf_mod > 9 then uhf_mod = 0 end end -- UHF_MODE_ON
canOpsTable[0x2C1E1C01] = function() return end 					-- UHF_MODE_LSB
canOpsTable[0x2C1E1C02] = function() return end 					-- UHF_MODE_USB
canOpsTable[0x2C1E1C03] = function() return end 					-- UHF_MODE_AM
canOpsTable[0x2C1E1C04] = function() return end 					-- UHF_MODE_TEL
canOpsTable[0x2C1E1D00] = function() return end 					-- UHF_STD_OFF
canOpsTable[0x2C1E1D01] = function() return end 					-- UHF_STD_ON
canOpsTable[0x2C1E1E00] = function() return end 					-- UHF_TONE_OFF
canOpsTable[0x2C1E1E01] = function() return end 					-- UHF_TONE_ON
canOpsTable[0x2C1E1F00] = function() return end 					-- UHF_TEST_OFF
canOpsTable[0x2C1E1F01] = function() sound.play("squelch") end				-- UHF_TEST_ON

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
while true do
	
	local flightData = ""
	
	-- Master Battery (Used as Service Code)
	var_bat = ipc.readUD(0x281C)
	
	-- Acceleration G's
	var_acc = ipc.readDBL(0x1140)
	flightData = flightData..packFloat(CA_BODY_NORMAL_ACCELERATION, NODE_AHRS, var_bat, var_acc)
	
	-- Attitude Pitch deg
	var_pit = ipc.readDBL(0x2F70)
	flightData = flightData..packFloat(CA_BODY_PITCH_ANGLE, NODE_AHRS, var_bat, var_pit)

	-- Attitude Roll deg
	var_rol = ipc.readDBL(0x2F78)
	flightData = flightData..packFloat(CA_BODY_ROLL_ANGLE, NODE_AHRS, var_bat, var_rol)

	-- Barometric Altitude m
	var_alt = ipc.readSD(0x3324) * 0.3048
	flightData = flightData..packFloat(CA_BARO_CORRECTED_ALTITUDE, NODE_AHRS, var_bat, var_alt)

	-- Barometric pressure hPa
	var_qnh = ipc.readUW(0x0330) / 16
	flightData = flightData..packFloat(CA_BARO_CORRECTION, NODE_AHRS, var_bat, var_qnh)
	
	-- Vertical Speed m/s
	var_vvi = ipc.readSD(0x02C8) / 256
	flightData = flightData..packFloat(CA_ALTITUDE_RATE, NODE_AHRS, var_bat, var_vvi)

	-- Indicated Airspeed m/s
	var_ias = (ipc.readSD(0x02BC) / 128) * 0.5144
	flightData = flightData..packFloat(CA_INDICATED_AIRSPEED, NODE_AHRS, var_bat, var_ias)

	-- Calibrated Airspeed m/s for Index Speed
	var_cas = (ipc.readSD(0x02C4) / 128) * 0.5144
	flightData = flightData..packFloat(CA_CALIBRATED_AIRSPEED, NODE_AHRS, var_bat, var_cas)

	-- Mach Number
	var_mac = ipc.readDBL(0x35A0)
	flightData = flightData..packFloat(CA_MACH_NUMBER, NODE_AHRS, var_bat, var_mac)

	-- Radio Height m
	var_rht = ipc.readSD(0x31E4) / 65536
	flightData = flightData..packFloat(CA_RADIO_HEIGHT, NODE_AHRS, var_bat, var_rht)
	
	-- Decision Height m
	var_dht = ipc.readDBL(0x3428)
	flightData = flightData..packFloat(CA_DECISION_HEIGHT, NODE_AHRS, var_bat, var_dht)

	-- Angle Of Attack
	var_aoa = (180 - ipc.readSD(0x11BE)) / 182
	flightData = flightData..packFloat(CA_PORT_SIDE_ANGLE_OF_ATTACK, NODE_AHRS, var_bat, var_aoa)

	-- Engine 1 Hydraulic Pressure PSI
	var_hyd = ipc.readUD(0x08D8) / 4
	flightData = flightData..packFloat(CA_HYDRAULIC_SYSTEM_1_PRESSURE, NODE_AHRS, var_bat, var_hyd)

	-- Oxygen Pressure PSI
	var_oxy = 1500
	flightData = flightData..packFloat(CA_CABIN_PRESSURE, NODE_AHRS, var_bat, var_oxy)
	
	-- Flap Indicator with surface transition and battery status
	var_flp = ipc.readUW(0x30E0) 									-- FLAP SURFACE POSITION
	if(var_bat == 1 and var_flp == 0) then
		flightData = flightData..packFloat(CA_FLAPS_LEVER_POSITION, NODE_AHRS, var_bat, 1.0) 	-- UP MARK
	elseif (var_bat == 1 and var_flp == 7537) then
		flightData = flightData..packFloat(CA_FLAPS_LEVER_POSITION, NODE_AHRS, var_bat, 2.0) 	-- TO MARK
	elseif (var_bat == 1 and var_flp == 16384) then
		flightData = flightData..packFloat(CA_FLAPS_LEVER_POSITION, NODE_AHRS, var_bat, 3.0) 	-- LD MARK
	else
		flightData = flightData..packFloat(CA_FLAPS_LEVER_POSITION, NODE_AHRS, var_bat, 4.0) 	-- BP MARK
	end

	-- Export UHF Test Data Used STD CANAerospace Variables
	flightData = flightData..packFloat(CA_DME_4_CHANNEL, NODE_AHRS, var_bat, uhf_chn)		-- UHF_CHANNEL
	flightData = flightData..packFloat(CA_TRANSPONDER_4_CODE, NODE_AHRS, var_bat, uhf_mod)		-- UHF_MODE
	flightData = flightData..packFloat(CA_ADF_4_FREQUENCY, NODE_AHRS, var_bat, uhf_frq)		-- UHF_FREQUENCY
	
	-- Export User Defined Flags UD_FLAGS_0_31							-- USE SERVICE CODE INSTEAD
	-- var_fl1 = 0											-- DEFAULT ALL FLAGS TO 0
	-- if(var_bat == 1) then 
	--	var_fl1 = sbit(var_fl1,  0)								-- SET FLAG GAUGES LIGHTS
	--	var_fl1 = sbit(var_fl1,  1)								-- SET FLAG MASTER BATTERY
	--	var_fl1 = sbit(var_fl1, 15)								-- SET FLAG UHF TEST LAMP
	-- end
	-- var_avc = ipc.readUD(0x2E80) 								-- MASTER AVIONICS
	-- if(var_avc ~=nil and var_avc == 1) then var_fl1 = sbit(var_fl1, 2) end			-- SET FLAG MASTER AVIONICS
	-- flightData = flightData..packUint32(UD_FLAGS_0_31, NODE_AHRS, var_bat, var_fl1)

------------------------------------------------------------------------------------------------------------------------
-- TX Data
------------------------------------------------------------------------------------------------------------------------
	socket.try(con:send(flightData))
	
------------------------------------------------------------------------------------------------------------------------
-- RX Data
------------------------------------------------------------------------------------------------------------------------
	local data = con:receive()
	if data then

		CAN_IDH 	= string.byte(data,  1) -- CAN_IDH
		CAN_IDL 	= string.byte(data,  2) -- CAN_IDL
		NODE_ID 	= string.byte(data,  3) -- NODE ID RESERVED ALWAYS 0
		DATA_TYPE 	= string.byte(data,  4) -- DATA TYPE ALWAYS BCHAR
		SERVICE_CODE 	= string.byte(data,  5) -- SERVICE CODE DEVICE TYPE 0 UNKNOWN, 1 SWITCH, 2 ENCODER, 3 ANALOG
		MESSAGE_CODE 	= string.byte(data,  6) -- MESSAGE CODE COUNTER 0 - 255
		DATA3 		= string.byte(data,  7) -- ATA CHAPTER
		DATA2 		= string.byte(data,  8) -- ATA SUBCHAPTER
		DATA1 		= string.byte(data,  9) -- DEVICE NUMBER BUTTON0, BUTTON1, ENCODER2, ANALOG HSB
		DATA0 		= string.byte(data, 10) -- DEVICE VALUE ON/OFF, ENC LEFT/RIGHT , ANALOG LSB

		if SERVICE_CODE == SC1 or SERVICE_CODE == SC2 then 	-- SWITCH/ENCODER DEVICE
			canOpsTable[((DATA3 * (16^6)) + (DATA2 * (16^4)) + (DATA1 * (16^2)) + DATA0)]()
		elseif SERVICE_CODE == SC3 then 					-- ANALOG DEVICE
			canOpsTable[(DATA3 * (16^2)) + DATA2]((DATA1 * (16^2)) + DATA0)
		end

	end
	
	ipc.sleep(50)

end
