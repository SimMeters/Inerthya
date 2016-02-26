------------------------------------------------------------------------------------------------------------------------
-- Copyright(c) 2016, SimMeters.com
-- All rights reserved. Released under the BSD license.
-- EC120B.lua 1.0 02/01/2016 (Import/Export script for Inerthya EC120B FTD)

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
-- Includes and Variables
------------------------------------------------------------------------------------------------------------------------
dofile("INERTHYA.lua") -- SimMeters INERTHYA System LUA Implementation

uhf_mod	= 0 	 -- MHZ
uhf_frq = 320.00 -- KHZ
uhf_chn = 5

------------------------------------------------------------------------------------------------------------------------
-- Network Configuration
------------------------------------------------------------------------------------------------------------------------
socket = require("socket")
con = socket.try(socket.udp())
cmd = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("169.254.2.33", 6060))
socket.try(cmd:setpeername("192.168.1.100", 6060)) -- change this ip by the software and port running VEMD software

------------------------------------------------------------------------------------------------------------------------
-- Input Commands
------------------------------------------------------------------------------------------------------------------------
canOpsTable = {}

-- Set Barometric Pressure
canOpsTable[0x220A0801] = function() ipc.writeUW(0x0330, ipc.readUW(0x0330) - 1) end
canOpsTable[0x220A0802] = function() ipc.writeUW(0x0330, ipc.readUW(0x0330) + 1) end

-- VEMD Keys
canOpsTable[0x1F0A0A00] = function() socket.try(cmd:send("VEMD_1_OFF\n"))		end -- VEMD_1_OFF
canOpsTable[0x1F0A0A01] = function() socket.try(cmd:send("VEMD_1_ON\n")) 		end -- VEMD_1_ON
canOpsTable[0x1F0A0B00] = function() socket.try(cmd:send("VEMD_2_OFF\n")) 		end -- VEMD_2_OFF
canOpsTable[0x1F0A0B01] = function() socket.try(cmd:send("VEMD_2_ON\n")) 		end -- VEMD_2_ON
canOpsTable[0x1F0A0C00] = function() socket.try(cmd:send("VEMD_SCROLL_OFF\n")) 	end -- VEMD_SCROLL_OFF
canOpsTable[0x1F0A0C01] = function() socket.try(cmd:send("VEMD_SCROLL_ON\n")) 	end -- VEMD_SCROLL_ON
canOpsTable[0x1F0A0D00] = function() socket.try(cmd:send("VEMD_RESET_OFF\n")) 	end -- VEMD_RESET_OFF
canOpsTable[0x1F0A0D01] = function() socket.try(cmd:send("VEMD_RESET_ON\n")) 	end -- VEMD_RESET_ON
canOpsTable[0x1F0A0E00] = function() socket.try(cmd:send("VEMD_SELECT_OFF\n")) 	end -- VEMD_SELECT_OFF
canOpsTable[0x1F0A0E01] = function() socket.try(cmd:send("VEMD_SELECT_ON\n")) 	end -- VEMD_SELECT_ON
canOpsTable[0x1F0A0F00] = function() socket.try(cmd:send("VEMD_INC_OFF\n")) 	end -- VEMD_INC_OFF
canOpsTable[0x1F0A0F01] = function() socket.try(cmd:send("VEMD_INC_ON\n")) 		end -- VEMD_INC_ON
canOpsTable[0x1F0A1000] = function() socket.try(cmd:send("VEMD_DEC_OFF\n")) 	end -- VEMD_DEC_OFF
canOpsTable[0x1F0A1001] = function() socket.try(cmd:send("VEMD_DEC_ON\n")) 		end -- VEMD_DEC_ON
canOpsTable[0x1F0A1100] = function() socket.try(cmd:send("VEMD_ENTER_OFF\n")) 	end -- VEMD_ENTER_OFF
canOpsTable[0x1F0A1101] = function() socket.try(cmd:send("VEMD_ENTER_ON\n")) 	end -- VEMD_ENTER_ON
canOpsTable[0x1F0A1200] = function() socket.try(cmd:send("VEMD_BRT_INC_OFF\n")) end -- VEMD_BRT_INC_OFF
canOpsTable[0x1F0A1201] = function() socket.try(cmd:send("VEMD_BRT_INC_ON\n")) 	end -- VEMD_BRT_INC_ON
canOpsTable[0x1F0A1300] = function() socket.try(cmd:send("VEMD_BRT_DEC_OFF\n")) end -- VEMD_BRT_DEC_OFF
canOpsTable[0x1F0A1301] = function() socket.try(cmd:send("VEMD_BRT_DEC_ON\n")) 	end -- VEMD_BRT_DEC_ON

-- UHF Module Input Events
canOpsTable[0x2C1E1902] = function() uhf_frq = uhf_frq + 0.25 end 	-- UHF_FREQUENCY_INC
canOpsTable[0x2C1E1901] = function() uhf_frq = uhf_frq - 0.25 end 	-- UHF_FREQUENCY_DEC
canOpsTable[0x2C1E1A02] = function() return end 					-- UHF_CHANNEL_INC
canOpsTable[0x2C1E1A01] = function() return end 					-- UHF_CHANNEL_DEC
canOpsTable[0x2C1E1B00] = function() return end 					-- UHF_MODE_OFF
canOpsTable[0x2C1E1B01] = function() return end 					-- UHF_MODE_ON
canOpsTable[0x2C1E1C01] = function() uhf_chn = 0 end 				-- UHF_MODE_LSB
canOpsTable[0x2C1E1C02] = function() uhf_chn = 1 end 				-- UHF_MODE_USB
canOpsTable[0x2C1E1C03] = function() uhf_chn = 2 end 				-- UHF_MODE_AM
canOpsTable[0x2C1E1C04] = function() uhf_chn = 3 end 				-- UHF_MODE_TEL
canOpsTable[0x2C1E1D00] = function() return end 					-- UHF_STD_OFF
canOpsTable[0x2C1E1D01] = function() uhf_mod = uhf_mod + 1 if uhf_mod > 9 then uhf_mod = 0 end end -- UHF_STD_ON
canOpsTable[0x2C1E1E00] = function() return end 					-- UHF_TONE_OFF
canOpsTable[0x2C1E1E01] = function() return end 					-- UHF_TONE_ON
canOpsTable[0x2C1E1F00] = function() return end 					-- UHF_TEST_OFF
canOpsTable[0x2C1E1F01] = function() return end 					-- UHF_TEST_ON

-- COMM1 Module Input Events
canOpsTable[0x2C1E0001] = function() -- COM1_MHZ_DEC STBY

	var_sby_mhz = string.format("%04x",ipc.readUW(0x311A)) * 1
	if(var_sby_mhz > 1900) then
		ipc.writeUW(0x311A, "0x"..(var_sby_mhz - 100))
	end

end 

canOpsTable[0x2C1E0002] = function()  -- COM1_MHZ_INC STBY
	
	var_sby_mhz = string.format("%04x",ipc.readUW(0x311A)) * 1 
	if(var_sby_mhz <= 3600) then 
		ipc.writeUW(0x311A, "0x"..(var_sby_mhz + 100))
	end

end

canOpsTable[0x2C1E0101] = function() -- COM1_KHZ_DEC STBY

	var_sby_mhz = string.format("%04x",ipc.readUW(0x311A)) * 1
	var_sby_khz = string.format("%i",var_sby_mhz % 100)
	if(var_sby_khz % 10 == 0 or var_sby_khz % 10 == 5) then
		var_sby_khz = var_sby_khz * 10
	else
		var_sby_khz = (var_sby_khz * 10) + 5
	end

	var_sby_khz = var_sby_khz - 25

	if(var_sby_khz < 0) then var_sby_khz = 975 end
	if(var_sby_khz >= 100) then
		var_sby_khz = string.format("%i",var_sby_khz / 10)
	else
		var_sby_khz = string.format("0%i",var_sby_khz / 10)
	end
	var_sby_mhz = string.format("%i",var_sby_mhz / 100)
	ipc.writeUW(0x311A, "0x"..var_sby_mhz..var_sby_khz)

end

canOpsTable[0x2C1E0102] = function() -- COM1_KHZ_INC STBY

	var_sby_mhz = string.format("%04x",ipc.readUW(0x311A)) * 1
	var_sby_khz = string.format("%i",var_sby_mhz % 100)
	if(var_sby_khz % 10 == 0 or var_sby_khz % 10 == 5) then
		var_sby_khz = var_sby_khz * 10
	else
		var_sby_khz = (var_sby_khz * 10) + 5
	end

	var_sby_khz = var_sby_khz + 25

	if(var_sby_khz > 975) then var_sby_khz = 0 end
	if(var_sby_khz >= 100) then
		var_sby_khz = string.format("%i",var_sby_khz / 10)
	else
		var_sby_khz = string.format("0%i",var_sby_khz / 10)
	end
	var_sby_mhz = string.format("%i",var_sby_mhz / 100)
	ipc.writeUW(0x311A, "0x"..var_sby_mhz..var_sby_khz)

end

canOpsTable[0x2C1E0200] = function() return end 					-- COM1_PUSH_TEST_OFF
canOpsTable[0x2C1E0201] = function() sound.play("squelch")  end 	-- COM1_PUSH_TEST_ON
canOpsTable[0x2C1E0300] = function() ipc.writeUB(0x3123, 0) end 	-- COM1_ACT_SBY_TOGGLE_OFF
canOpsTable[0x2C1E0301] = function() ipc.writeUB(0x3123, 8) end 	-- COM1_ACT_SBY_TOGGLE_ON
canOpsTable[0x2C1E0400] = function() return end 					-- COM1_CHANNEL_OFF
canOpsTable[0x2C1E0401] = function() return end 					-- COM1_CHANNEL_ON
canOpsTable[0x2C1E0500] = function() return end 					-- COM1_PUSH_K_OFF
canOpsTable[0x2C1E0501] = function() return end 					-- COM1_PUSH_K_ON
canOpsTable[0xA0070000] = function(val) return end 					-- COMM1_VOLUME

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
while true do
	
	local flightData = ""

	-- Master Battery (Used as Service Code)
	var_bat = ipc.readUD(0x281C)

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

	-- Engine1 N2 Percent RPM
	var_n2 = ipc.readUW(0x0896) * 0.0061
	flightData = flightData..packFloat(CA_ENGINE_1_N2_ECS_CHANNEL_A, NODE_AHRS, var_bat, var_n2)

	-- Rotor Percent RPM
	var_rot = ipc.readUD(0x0908) * 0.0061
	flightData = flightData..packFloat(CA_ROTOR_1_RPM, NODE_AHRS, var_bat, var_rot)

	-- COMM1 active freq
	var_act = string.format("1%04x", ipc.readUW(0x034E)) * 1
	if(var_act % 10 == 0 or var_act % 10 == 5) then
		var_act = string.format("1%04x0", ipc.readUW(0x034E)) * 1
	else
		var_act = string.format("1%04x5", ipc.readUW(0x034E)) * 1
	end
	flightData = flightData..packFloat(CA_VHF_1_COM_FREQUENCY, NODE_AHRS, var_bat, var_act)

	-- COMM1 standby freq
	var_sby = string.format("1%04x", ipc.readUW(0x311A)) * 1
	if(var_sby % 10 == 0 or var_sby % 10 == 5) then
		var_sby = string.format("1%04x0", ipc.readUW(0x311A)) * 1
	else
		var_sby = string.format("1%04x5", ipc.readUW(0x311A)) * 1
	end
	flightData = flightData..packFloat(CA_VHF_3_COM_FREQUENCY, NODE_AHRS, var_bat, var_sby)

	-- Export UHF Test Data Used STD CANAerospace Variables
	flightData = flightData..packFloat(CA_DME_4_CHANNEL, NODE_AHRS, var_bat, uhf_chn)
	flightData = flightData..packFloat(CA_TRANSPONDER_4_CODE, NODE_AHRS, var_bat, uhf_mod)
	flightData = flightData..packFloat(CA_ADF_4_FREQUENCY, NODE_AHRS, var_bat, uhf_frq)
	
------------------------------------------------------------------------------------------------------------------------
-- TX Data
------------------------------------------------------------------------------------------------------------------------
	socket.try(con:send(flightData))
	
------------------------------------------------------------------------------------------------------------------------
-- RX Data
------------------------------------------------------------------------------------------------------------------------
	local data = con:receive()
	if data then

		CAN_IDH 		= string.byte(data,  1) -- CAN_IDH
		CAN_IDL 		= string.byte(data,  2) -- CAN_IDL
		NODE_ID 		= string.byte(data,  3) -- NODE ID RESERVED ALWAYS 0
		DATA_TYPE 		= string.byte(data,  4) -- DATA TYPE ALWAYS BCHAR
		SERVICE_CODE 	= string.byte(data,  5) -- SERVICE CODE DEVICE TYPE 0 UNKNOWN, 1 SWITCH, 2 ENCODER, 3 ANALOG
		MESSAGE_CODE 	= string.byte(data,  6) -- MESSAGE CODE COUNTER 0 - 255
		DATA3 			= string.byte(data,  7) -- ATA CHAPTER
		DATA2 			= string.byte(data,  8) -- ATA SUBCHAPTER
		DATA1 			= string.byte(data,  9) -- DEVICE NUMBER BUTTON0, BUTTON1, ENCODER2, ANALOG HSB
		DATA0 			= string.byte(data, 10) -- DEVICE VALUE ON/OFF, ENC LEFT/RIGHT , ANALOG LSB

		if SERVICE_CODE == SC1 or SERVICE_CODE == SC2 then 	-- SWITCH/ENCODER DEVICE
			canOpsTable[((DATA3 * (16^6)) + (DATA2 * (16^4)) + (DATA1 * (16^2)) + DATA0)]()
		elseif SERVICE_CODE == SC3 then 					-- ANALOG DEVICE
			canOpsTable[(DATA3 * (16^2)) + DATA2]((DATA1 * (16^2)) + DATA0)
		end

	end
	
	ipc.sleep(25)

end
