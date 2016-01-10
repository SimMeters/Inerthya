-- Copyright(c) 2014 SimSystems GmbH GPL license.
-- Wrapper_EC135.lua 1.0 01/01/2014 (Import/Export script for SimMeters Workspace EC135 RotorSim)
-- For check updated version and more information please go to https://github.com/SimMeters/Lua

canOpsTable = {}
package.path  = "Resources\\plugins\\FlyWithLua\\Internals\\?.lua"
package.cpath = "Resources\\plugins\\FlyWithLua\\Internals\\?.dll"

-- Configure Network
socket = require("socket")
con = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("127.0.0.1", 6060))

-- Analog devices 0 - 4096
canOpsTable[0xA000] = function(value) set("rotorsim/ec135/instrument_brightness_pfd_pilot", value/670) end -- PFD BRIGHTNESS RATIO ANALOG FROM 0 - 4096
canOpsTable[0xA001] = function(value) set("rotorsim/ec135/instrument_brightness_nd_pilot", value/4096) end -- PFD BRIGHTNESS RATIO ANALOG FROM 0 - 4096
-- canOpsTable[0xA002] = function(value) set("rotorsim/ec135/instrument_brightness_nd_pilot", value/4096) end -- WXR GAIN FROM 0 - 4096
-- canOpsTable[0xA003] = function(value) set("rotorsim/ec135/instrument_brightness_nd_pilot", value/4096) end -- WXR TILT ANALOG FROM 0 - 4096

-- Input devices
--canOpsTable[0xAA000001] = function() set("sim/cockpit/electrical/avionics_on", 0) 						end -- MASTER AVIONICS OFF
--canOpsTable[0xAA000000] = function() set("sim/cockpit/electrical/avionics_on", 1) 						end -- MASTER AVIONICS ON
--canOpsTable[0xAA000101] = function() set("sim/cockpit/electrical/beacon_lights_on", 0) 					end -- BEACON/STROBE OFF
--canOpsTable[0xAA000100] = function() set("sim/cockpit/electrical/beacon_lights_on", 1) 					end -- BEACON/STROBE ON
--canOpsTable[0xAA000201] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 0) 				end -- PUMP OFF
--canOpsTable[0xAA000200] = function() set("sim/cockpit2/engine/actuators/fuel_pump_on", 1) 				end -- PUMP ON
--canOpsTable[0xAA000301] = function() set_array("sim/cockpit/electrical/generator_on", 0, 0) 			end -- ALTERNATOR OFF
--canOpsTable[0xAA000300] = function() set_array("sim/cockpit/electrical/generator_on", 0, 1) 			end -- ALTERNATOR ON
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

-- Engine Control Panel
canOpsTable[0x31140000] = function() set_array("rotorsim/ec135/main_switch", 0, 0) 						end -- ENG_MAIN_SW1_OFF
canOpsTable[0x31140001] = function() set_array("rotorsim/ec135/main_switch", 0, 1) 						end -- ENG_MAIN_SW1_IDLE
canOpsTable[0x31140002] = function() set_array("rotorsim/ec135/main_switch", 0, 2) 						end -- ENG_MAIN_SW1_FLIGHT
canOpsTable[0x31140100] = function() set_array("rotorsim/ec135/main_switch", 1, 0) 						end -- ENG_MAIN_SW2_OFF
canOpsTable[0x31140101] = function() set_array("rotorsim/ec135/main_switch", 1, 1) 						end -- ENG_MAIN_SW2_IDLE
canOpsTable[0x31140102] = function() set_array("rotorsim/ec135/main_switch", 1, 2) 						end -- ENG_MAIN_SW2_FLIGHT
canOpsTable[0x313C0000] = function() set_array("sim/cockpit2/engine/actuators/fadec_on", 0, 1)			end -- FADEC_1_OFF
canOpsTable[0x313C0001] = function() set_array("sim/cockpit2/engine/actuators/fadec_on", 0, 0)			end -- FADEC_1_ON
canOpsTable[0x313C0100] = function() set_array("sim/cockpit2/engine/actuators/fadec_on", 1, 1)			end -- FADEC_2_OFF
canOpsTable[0x313C0101] = function() set_array("sim/cockpit2/engine/actuators/fadec_on", 1, 0)			end -- FADEC_2_ON
canOpsTable[0x18140102] = function() set_array("rotorsim/ec135/generator", 0, 2) 						end -- AC_GENERATION_LEFT_ON
canOpsTable[0x18140100] = function() set_array("rotorsim/ec135/generator", 0, 1) 						end -- AC_GENERATION_LEFT_OFF 
canOpsTable[0x18140101] = function() set_array("rotorsim/ec135/generator", 0, 0) 						end -- AC_GENERATION_LEFT_RESET
canOpsTable[0x18140202] = function() set_array("rotorsim/ec135/generator", 1, 2) 						end -- AC_GENERATION_RIGHT_ON 
canOpsTable[0x18140200] = function() set_array("rotorsim/ec135/generator", 1, 1) 						end -- AC_GENERATION_RIGHT_OFF
canOpsTable[0x18140201] = function() set_array("rotorsim/ec135/generator", 1, 0) 						end -- AC_GENERATION_RIGHT_RESET
canOpsTable[0x181E0002] = function() set("rotorsim/ec135/battery", 2) 									end -- BATTERY_POWER_ON
canOpsTable[0x181E0000] = function() set("rotorsim/ec135/battery", 1) 									end -- BATTERY_POWER_OFF
canOpsTable[0x181E0001] = function() set("rotorsim/ec135/battery", 0) 									end -- BATTERY_POWER_RESET
	

-- Display PFP/ND
canOpsTable[0x1F0A0000] = function() end -- EMPTY PFD_PILOT_OFF
canOpsTable[0x1F0A0001] = function() command_once("ec135/cpds/pfdpilot_off") end -- PFD_PILOT_Pushbutton
canOpsTable[0x1F0A0200] = function() end -- EMPTY ND_PILOT_OFF
canOpsTable[0x1F0A0201] = function() command_once("ec135/cpds/ndpilot_off") end -- ND_PILOT_Pushbutton
-- Display CAD
canOpsTable[0x1F0A0500] = function() end -- EMPTY_CAD_OFF
canOpsTable[0x1F0A0501] = function() command_once("ec135/cpds/cad_off") end -- CAD_PILOT_OFF_Pushbutton
canOpsTable[0x1F0A0600] = function() end -- EMPTY_CAD_scroll
canOpsTable[0x1F0A0601] = function() command_once("ec135/cpds/cad_scroll") end -- CAD_PILOT_SCROLL_Pushbutton
canOpsTable[0x1F0A0700] = function() end -- EMPTY_CAD_Master caution
canOpsTable[0x1F0A0701] = function() command_once("sim/annunciator/clear_master_caution") end -- CAD_CLEAR_MASTER_Caution
canOpsTable[0x1F0A0800] = function() end -- EMPTY_CAD_BRT UP
canOpsTable[0x1F0A0801] = function() command_once("ec135/cpds/cad_brt_up") end -- CAD_BRT_UP_Pushbutton
canOpsTable[0x1F0A0900] = function() end -- EMPTY_CAD_BRT DWN
canOpsTable[0x1F0A0901] = function() command_once("ec135/cpds/cad_brt_down") end -- CAD_BRT_DWN_Pushbutton
-- Display VEMD
canOpsTable[0x1F0A0A00] = function() end -- EMPTY_VEMD1_OFF
canOpsTable[0x1F0A0A01] = function() command_once("ec135/cpds/fli_off") end -- VEMD1_ON_Pushbutton
canOpsTable[0x1F0A0B00] = function() end -- EMPTY_VEMD2_OFF
canOpsTable[0x1F0A0B01] = function() command_once("ec135/cpds/elec_off") end -- VEMD2_ON_Pushbutton
canOpsTable[0x1F0A0C00] = function() end -- EMPTY_VEMD_SCROLL_OFF
canOpsTable[0x1F0A0C01] = function() command_once("ec135/cpds/vemd_scroll") end -- VEMD_SCROLL_ON_Pushbutton
canOpsTable[0x1F0A0D00] = function() end -- EMPTY_VEMD_RESET_OFF
canOpsTable[0x1F0A0D01] = function() command_once("ec135/cpds/vemd_reset") end -- EMPTY_VEMD_RESET_OFF
canOpsTable[0x1F0A0E00] = function() end -- EMPTY_VEMD_SELECT_OFF (not applicable)
canOpsTable[0x1F0A0E01] = function() end -- EMPTY_VEMD_SELECT_ON (not applicable)
canOpsTable[0x1F0A0F00] = function() end -- EMPTY_VEMD_PLUS_OFF
canOpsTable[0x1F0A0F01] = function() command_once("ec135/cpds/vemd_plus") end -- EMPTY_VEMD_PLUS_OFF
canOpsTable[0x1F0A1000] = function() end -- EMPTY_VEMD_MINUS_OFF
canOpsTable[0x1F0A1001] = function() command_once("ec135/cpds/vemd_plus") end -- EMPTY_VEMD_MINUS_OFF
canOpsTable[0x1F0A1100] = function() end -- EMPTY_VEMD_ENTER_OFF (not applicable)
canOpsTable[0x1F0A1101] = function() end -- EMPTY_VEMD_ENTER_ON (not applicable)
canOpsTable[0x1F0A1200] = function() end -- EMPTY_VEMD_BRT_INC_OFF
canOpsTable[0x1F0A1201] = function() command_once("ec135/cpds/vemd_brt_up") end -- VEMD_BRT_INC_ON
canOpsTable[0x1F0A1300] = function() end -- EMPTY_VEMD_BRT_DEC_OFF
canOpsTable[0x1F0A1301] = function() command_once("ec135/cpds/vemd_brt_down") end -- VEMD_BRT_DEC_On
-- ICP Panel
canOpsTable[0x1F140000] = function() set("sim/cockpit2/gauges/actuators/radio_altimeter_bug_ft_pilot", get("sim/cockpit2/gauges/actuators/radio_altimeter_bug_ft_pilot") - 10) end -- RADIO ALT_DEC
canOpsTable[0x1F140001] = function() set("sim/cockpit2/gauges/actuators/radio_altimeter_bug_ft_pilot", get("sim/cockpit2/gauges/actuators/radio_altimeter_bug_ft_pilot") + 10) end -- RADIO ALT_INC
canOpsTable[0x220A0801] = function() set("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") - 0.01) end -- QNH_DEC
canOpsTable[0x220A0802] = function() set("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot", get("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot") + 0.01) end -- QNH_INC
canOpsTable[0x16140101] = function() set("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot", get("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot") - 1) end -- CRS_DEC
canOpsTable[0x16140102] = function() set("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot", get("sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot") + 1) end -- CRS_INC
canOpsTable[0x1F140100] = function() set("sim/cockpit2/gauges/actuators/artificial_horizon_adjust_deg_pilot", get("sim/cockpit2/gauges/actuators/artificial_horizon_adjust_deg_pilot") - 1) end -- POS-ATI_DEC
canOpsTable[0x1F140101] = function() set("sim/cockpit2/gauges/actuators/artificial_horizon_adjust_deg_pilot", get("sim/cockpit2/gauges/actuators/artificial_horizon_adjust_deg_pilot") + 1) end -- POS_ATI_INC

canOpsTable[0x1F0A1A00] = function() end -- EMPTY_ZOOM_OUT_OFF
canOpsTable[0x1F0A1A01] = function() command_once("sim/instruments/map_zoom_out") end -- ZOOM_OUT_ON
canOpsTable[0x1F0A1800] = function() end -- EMPTY_EXT_OFF
canOpsTable[0x1F0A1801] = function() command_once("ec135/icp/ext_pilot") end -- EXT_ON
canOpsTable[0x1F0A1900] = function() end -- EMPTY_NAV_SOURCE_OFF
canOpsTable[0x1F0A1901] = function() command_once("ec135/icp/nav_pilot") end -- NAV_SOURCE_ON
canOpsTable[0x1F0A1400] = function() end -- EMPTY_PFD_OFF
canOpsTable[0x1F0A1401] = function() command_once("ec135/icp/pfd_pilot") end -- PFD_ON
canOpsTable[0x1F0A1B00] = function() end -- EMPTY_ZOOM_IN_OFF
canOpsTable[0x1F0A1B01] = function() command_once("sim/instruments/map_zoom_in") end -- ZOOM_IN_ON
canOpsTable[0x1F0A1600] = function() end -- EMPTY_ARROW1_OFF
canOpsTable[0x1F0A1601] = function() command_once("ec135/icp/arrow_1_pilot") end -- ARROW1_ON
canOpsTable[0x1F0A1700] = function() end -- EMPTY_ARROW2_OFF
canOpsTable[0x1F0A1701] = function() command_once("ec135/icp/arrow_2_pilot") end -- ARROW2_ON
canOpsTable[0x1F0A1500] = function() end -- EMPTY_ND_OFF
canOpsTable[0x1F0A1501] = function() command_once("ec135/icp/nd_pilot") end -- PFD_ON

-- AP Panel

canOpsTable[0x160A0401] = function() set("sim/cockpit2/autopilot/altitude_dial_ft", get("sim/cockpit2/autopilot/altitude_dial_ft") - 10) end -- HDG_DEC
canOpsTable[0x160A0400] = function() set("sim/cockpit2/autopilot/altitude_dial_ft", get("sim/cockpit2/autopilot/altitude_dial_ft") + 10) end -- HDG_INC
canOpsTable[0x160A0501] = function() set("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot", get("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot") - 1) end -- ALT.A_DEC
canOpsTable[0x160A0500] = function() set("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot", get("sim/cockpit2/autopilot/heading_dial_deg_mag_pilot") + 1) end -- ALT.A_INC

canOpsTable[0x160A0200] = function() end -- EMPTY_AP_OFF
canOpsTable[0x160A0201] = function() command_once("ec135/autopilot/ap_on") end -- AP_ON
-- canOpsTable[0x160A0A00] = function() end -- EMPTY_A-TRIM_OFF
canOpsTable[0x160A0A00] = function() command_once("ec135/autopilot/a_trim") end -- A.TRIM_ON
canOpsTable[0x160A0D00] = function() end -- EMPTY_TEST
canOpsTable[0x160A0D01] = function() command_once("ec135/autopilot/test") end -- TEST_ON
-- canOpsTable[0x160A0900] = function() end -- EMPTY_APP
canOpsTable[0x160A0900] = function() command_once("ec135/autopilot/app") end -- APP_ON
-- canOpsTable[0x160A0300] = function() end -- EMPTY_HDG
canOpsTable[0x160A0300] = function() command_once("ec135/autopilot/hdg") end -- HDG_ON
-- canOpsTable[0x160A0600] = function() end -- EMPTY_NAV_OFF
canOpsTable[0x160A0600] = function() command_once("ec135/autopilot/nav") end -- NAV_ON
-- canOpsTable[0x160A0700] = function() end -- EMPTY_ALT_A._OFF
canOpsTable[0x160A0700] = function() command_once("ec135/autopilot/alta") end -- ALT_A._ON
-- canOpsTable[0x160A0C00] = function() end -- EMPTY_GS_OFF
canOpsTable[0x160A0C00] = function() command_once("ec135/autopilot/gs") end -- GS_ON
-- canOpsTable[0x160A0B00] = function() end -- EMPTY_VS_OFF
canOpsTable[0x160A0B00] = function() command_once("ec135/autopilot/vs") end -- VS_ON
-- canOpsTable[0x160A0800] = function() end -- EMPTY_IAS_OFF
canOpsTable[0x160A0800] = function() command_once("ec135/autopilot/ias") end -- IAS_ON
-- canOpsTable[0x160A0302] = function() end -- EMPTY_ALT_OFF
canOpsTable[0x160A0302] = function() command_once("ec135/autopilot/alt") end -- ALT_ON

-- WXR PANEL


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
	
	-- Clock
	hours = get("sim/cockpit2/clock_timer/local_time_hours") * 3600
	minutes = get("sim/cockpit2/clock_timer/local_time_minutes") * 60
	seconds = get("sim/cockpit2/clock_timer/local_time_seconds")
	utc = hours + minutes + seconds
	table.insert(flightData,string.format("ID_UTC=%.4f", utc))
	draw_string(10,10,utc,"green")
	
	-- Turn and Slip
	-- table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f", get("sim/cockpit2/gauges/indicators/turn_rate_roll_deg_pilot") / 20))	
	-- table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", get("sim/cockpit2/gauges/indicators/slip_deg") / 45))	

	-- Turn and Slip CANAerospace from -1 to +1
	table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", get("sim/cockpit2/gauges/indicators/slip_deg") * -0.25))	
	table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f", get("sim/cockpit2/gauges/indicators/turn_rate_heading_deg_pilot") * 0.03))
	
	-- ERPM %
	table.insert(flightData,string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f", get("sim/cockpit2/engine/indicators/N2_percent",0)))
	table.insert(flightData,string.format("ID_ROTOR_1_RPM=%.4f", get("sim/cockpit2/engine/indicators/prop_speed_rpm",0) * 0.26))

	-- Export LAMPS_0_31
	lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	lp[1] = 1																-- GAUGES LIGHTS (1 ON) (0 OFF) MASK_LAMP_00 see atachapters for mask on the group
	lp[2] = get("sim/cockpit2/annunciators/igniter_on", 0) 					-- STARTER
	lp[3] = 1 - get("sim/cockpit2/engine/actuators/governor_on", 0) 		-- GOV. OFF
	lp[4] = get("sim/cockpit2/switches/rotor_brake", 0) 					-- ROTOR BRAKE
	lp[5] = get("sim/cockpit2/annunciators/oil_pressure_low", 0) 			-- OIL PRESSURE CHECK
	lp[6] = get("sim/cockpit2/annunciators/oil_temperature", 0) 			-- OIL TRANSMISSION TEMP
	lp[7] = get("sim/cockpit/warnings/annunciators/fuel_quantity", 0) 		-- LOW FUEL
	lp[8] = get("sim/cockpit/warnings/annunciators/generator", 0) 			-- ALTERNATOR
	lp[9] = get("sim/cockpit2/annunciators/high_rotor", 0) 					-- HIGH RPM
	lp[10] = 0 																-- UNKOWN LIGHT IN THE MIDDLE
	lp[11] = get("sim/cockpit2/annunciators/low_rotor", 0) 					-- LOW RPM OK
	lp[12] = get("sim/cockpit2/switches/clutch_engage", 0) 				-- CLUTCH OK
	lp[13] = get("rotorsim/ec135/afcs_indications", 1) 						-- AP INDICATOR 																
	lp[14] = get("rotorsim/ec135/afcs_indications",2)						-- AP A TRIM INDICATOR
	lp[15] = get("rotorsim/ec135/afcs_indications",3)						-- AP TEST INDICATOR
	
	if(get("rotorsim/ec135/afcs_indications",4) == 1) or (get("rotorsim/ec135/afcs_indications",4) == 2)  then
		lp[16] = 1	-- AP APP INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",6) == 1) or (get("rotorsim/ec135/afcs_indications",6) == 2) then
		lp[17] = 1  -- AP NAV INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",9) == 1) or (get("rotorsim/ec135/afcs_indications",9) == 2) then
		lp[18] = 1  -- AP GS INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",10) == 1) or (get("rotorsim/ec135/afcs_indications",10) == 2) then
		lp[19] = 1  -- AP VS INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",11) == 1) or (get("rotorsim/ec135/afcs_indications",11) == 2) then
		lp[20] = 1  -- AP IAS INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",12) == 1) or (get("rotorsim/ec135/afcs_indications",12) == 2)  then
		lp[21] = 1	-- AP ALT INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",5) == 1) or (get("rotorsim/ec135/afcs_indications",5) == 2)  then
		lp[22] = 1 -- AP HDG INDICATOR
	end
	if(get("rotorsim/ec135/afcs_indications",7) == 1) or (get("rotorsim/ec135/afcs_indications",7) == 2)  then
		lp[23] = 1	-- AP ALT A. INDICATOR
	end
	
	lp[24] = get("rotorsim/ec135/emer_off_active")					-- WL EMER OFF ACTIVE 1 oder 2 ?????
	lp[25] = get("rotorsim/ec135/emer_off_active")					-- WL EMER OFF ACTIVE 1 oder 2 ?????
	lp[26] = get("rotorsim/ec135/fire_warning",0)					-- WL FIRE WARNING ENG 1
	lp[27] = get("rotorsim/ec135/fire_warning",1)					-- WL FIRE WARNING ENG 2
	lp[28] = get("rotorsim/ec135/master_caution")					-- WL MASTER CAUTION
	lp[29] = get("rotorsim/ec135/ann_rotor_rpm")					-- WL ROTOR RPM
	lp[30] = get("rotorsim/ec135/xmsn_oilp_warning")				-- WL XMSN OIL P
	lp[31] = get("rotorsim/ec135/battery_discharge_warning")		-- WL BATT DISCH
	lp[32] = get("rotorsim/ec135/battery_overheat_warning")			-- WL BATT OVERHEAT
	
	table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))

	-- Export LAMPS_32_63
	lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	lp[1] = get("rotorsim/ec135/lowfuel_warning", 0)			-- WL LOW FUEL 1
	lp[2] = get("rotorsim/ec135/lowfuel_warning", 1)			-- WL LOW FUEL 2
	lp[3] = get("rotorsim/ec135/afcs_indications", 0)			-- WL AP A.TRIM
	lp[4] = get("rotorsim/ec135/afcs_indications")				-- WL ALT INDICATOR
	lp[5] = get("rotorsim/ec135/dummy_warning")					-- WL CARGO FIRE
	lp[6] = get("rotorsim/ec135/cat_a_switch_ann")				-- WL CAT A INDICATOR
	lp[7] = get("rotorsim/ec135/hinr_on")						-- WL HI NR INDICATOR
	table.insert(flightData,string.format("ID_LAMPS_32_63=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
	
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
			canOpsTable[((DATA0 * (16^6)) + (DATA1 * (16^4)) + (DATA2 * (16^2)) + DATA3)]()
		elseif SERVICE_CODE == 3 then -- ANALOG DEVICE
			canOpsTable[(DATA0 * (16^2)) + DATA1]((DATA2 * (16^2)) + DATA3)
		end
		
	end
	
end

do_every_draw("loop()")