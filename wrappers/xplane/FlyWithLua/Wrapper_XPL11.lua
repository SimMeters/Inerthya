-- Copyright(c) 2019 Simmeters GPL license.
-- Wrapper_XPL11.lua 1.0 01/05/2019 (Import/Export script for SimMeters Workspace LUA Wrapper XPLANE11)
-- For check updated version and more information please go to https://github.com/SimMeters/Lua

canOpsTable = {}
package.path  = "Resources\\plugins\\FlyWithLua\\Internals\\?.lua"
package.cpath = "Resources\\plugins\\FlyWithLua\\Internals\\?.dll"

-- Configure Network
socket = require("socket")
con = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("127.0.0.1", 6060))

-- Analog devices
--canOpsTable[0xA000] = function(value) set("sim/cockpit/electrical/HUD_brightness", value/4096) end -- TEST HUD BRIGHTNESS RATIO ANALOG FROM 0 - 4096

-- Input devices
--canOpsTable[0xAA000001] = function() set("sim/cockpit/electrical/avionics_on", 0) 						end -- MASTER AVIONICS OFF
--canOpsTable[0xAA000000] = function() set("sim/cockpit/electrical/avionics_on", 1) 						end -- MASTER AVIONICS ON
--canOpsTable[0xAA000101] = function() set("sim/cockpit/electrical/beacon_lights_on", 0) 					end -- BEACON/STROBE OFF
--canOpsTable[0xAA000100] = function() set("sim/cockpit/electrical/beacon_lights_on", 1) 					end -- BEACON/STROBE ON
--canOpsTable[0xAA000201] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 0) 				end -- PUMP OFF
--canOpsTable[0xAA000200] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 1) 				end -- PUMP ON
--canOpsTable[0xAA000301] = function() set_array("sim/cockpit/electrical/generator_on", 0, 0) 				end -- ALTERNATOR OFF
--canOpsTable[0xAA000300] = function() set_array("sim/cockpit/electrical/generator_on", 0, 1) 				end -- ALTERNATOR ON
--canOpsTable[0xAA000401] = function() set("sim/cockpit2/switches/clutch_engage", 0) 						end -- CLUTCH OFF
--canOpsTable[0xAA000400] = function() set("sim/cockpit2/switches/clutch_engage", 1) 						end -- CLUTCH ON
--canOpsTable[0xAA000501] = function() set("sim/cockpit2/switches/navigation_lights_on", 0) 				end -- NAV LIGHTS OFF
--canOpsTable[0xAA000500] = function() set("sim/cockpit2/switches/navigation_lights_on", 1) 				end -- NAV LIGHTS ON
--canOpsTable[0xAA000601] = function() set("sim/cockpit2/switches/landing_lights_on", 0) 					end -- LANDING LIGHTS OFF
--canOpsTable[0xAA000600] = function() set("sim/cockpit2/switches/landing_lights_on", 1) 					end -- LANDING LIGHTS ON
--canOpsTable[0xAA000701] = function() set_array("sim/cockpit2/engine/actuators/carb_heat_ratio",0, 0.0) 	end -- CARBURATOR COLD
--canOpsTable[0xAA000700] = function() set_array("sim/cockpit2/engine/actuators/carb_heat_ratio",0, 1.0) 	end -- CARBURATOR HOT
--canOpsTable[0x220A0801] = function() set("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") - 0.01) end -- QNH_DEC
--canOpsTable[0x220A0802] = function() set("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") + 0.01) end -- QNH_INC

-- Main Loop
function loop()

	local packet = ""
	local flightData = {}

	-- Pitch
	table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f",get("sim/cockpit/gyros/the_ind_deg3")))
	
	-- Roll
	table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f",get("sim/cockpit/gyros/phi_ind_deg3")))

	-- Heading
	table.insert(flightData,string.format("ID_HEADING_ANGLE=%.4f", get("sim/cockpit2/gauges/indicators/heading_electric_deg_mag_pilot")))
	
	-- Airspeed Indicator CANAerospace knots to m/s units
	table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f", get("sim/cockpit2/gauges/indicators/airspeed_kts_pilot") * 0.5144))

	-- Vertical Speed Indicator CANAerospace fpm to m/s units
	table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f", get("sim/cockpit2/gauges/indicators/vvi_fpm_pilot") * 0.00508))
	
	-- Barometric Altimeter Pressure Setting CANAerospace hPa
	table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") * 33.8638))

	-- Indicated Altitude CANAerospace m units
	table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f", get("sim/cockpit2/gauges/indicators/altitude_ft_pilot") * 0.3048))

	-- Turn and Slip CANAerospace from -1 to +1
	table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", get("sim/cockpit2/gauges/indicators/slip_deg") * -0.25))	
	table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f", get("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_pilot") * 0.03))
	
	-- ERPM %
	table.insert(flightData,string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/N2_percent",0)))
	table.insert(flightData,string.format("ID_ROTOR_1_RPM=%.4f", get("sim/cockpit2/engine/indicators/prop_speed_rpm",0) * 0.26))

	-- Flaps 
 	table.insert(flightData,string.format("ID_FLAPS_LEVER_POSITION=%.4f", get("sim/flightmodel2/wing/flap1_deg")))
 	--table.insert(flightData,string.format("ID_FLAPS_LEVER_POSITION=%.4f", get("sim/flightmodel2/wing/flap2_deg")))
 
	-- Fuel Pressure 
 	table.insert(flightData,string.format("ID_FUEL_SYSTEM_1_PRESSURE=%.4f", get("sim/cockpit2/engine/indicators/fuel_pressure_psi", 0)))
 	table.insert(flightData,string.format("ID_FUEL_SYSTEM_2_PRESSURE=%.4f", get("sim/cockpit2/engine/indicators/fuel_pressure_psi", 1)))
	-- draw_string(10, 10, string.format("ID_FUEL_SYSTEM_1_PRESSURE=%.4f", get("sim/cockpit2/engine/indicators/fuel_pressure_psi", 0)), "green")
	
	-- Export LAMPS_0_31
	lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	lp[1] = 1																-- GAUGES LIGHTS (1 ON) (0 OFF)
	lp[2] = get("sim/cockpit2/annunciators/igniter_on", 0) 					-- STARTER
	lp[3] = 1 - get("sim/cockpit2/engine/actuators/governor_on", 0) 		-- GOV. OFF
	lp[4] = get("sim/cockpit2/switches/rotor_brake", 0) 					-- ROTOR BRAKE
	lp[5] = get("sim/cockpit2/annunciators/oil_pressure_low", 0) 			-- OIL PRESSURE CHECK
	lp[6] = get("sim/cockpit2/transmissions/indicators/oil_temperature") 	-- OIL TRANSMISSION TEMP
	lp[7] = get("sim/cockpit/warnings/annunciators/fuel_quantity", 0) 		-- LOW FUEL
	lp[8] = get("sim/cockpit/warnings/annunciators/generator", 0) 			-- ALTERNATOR
	lp[9] = get("sim/cockpit2/annunciators/high_rotor", 0) 					-- HIGH RPM
	lp[10] = 0 																-- UNKOWN LIGHT IN THE MIDDLE
	lp[11] = get("sim/cockpit2/annunciators/low_rotor", 0) 					-- LOW RPM OK
	lp[12] = 1 - get("sim/cockpit2/switches/clutch_engage", 0) 				-- CLUTCH OK
	table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
	
	-- TX Data
	for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
	socket.try(con:send(string.upper(packet)))
	
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