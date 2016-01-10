------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2014, SimMeters.
-- All rights reserved. Released under the BSD license.
-- Wrapper_FA18.lua 1.0 01/01/2014 (Import/Export script for SimMeters Workspace FA18 FSX Superbug Add-On)

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
-- Load atachapters definition file
dofile('atachapters.lua')

-- Variables Declaration
canOpsTable = {}

-- Configure Network
socket = require("socket")
con = socket.try(socket.udp())
socket.try(con:settimeout(.001))
socket.try(con:setpeername("127.0.0.1", 6060))

-- Input devices LVARS List
--SW RDDI PB -> RDDI - Populate with a number (1-20) corresponding to the PB you want to press
--SW LDDI PB -> LDDI - Populate with a number (1-20) corresponding to the PB you want to press
--SW MPCD PB -> MPCD - Populate with a number (1-20) corresponding to the PB you want to press
--SW LT FORM -> Formation light brightness switch
--SW LT WARN -> Warning/caution light brightness knob
--SW LT NVG -> NVG mode switch
--SW MASTER CAUTION -> Master Caution button
--SW CSEL -> Course select switch
--SW ELEC RESET -> ELEC reset button
--SW T/O TRIM -> T/O trim button
--SW MASTER MODE -> Master mode switch (tristate)
--SW ECM JETT -> ECM JETT button
--SW IFF ID -> ID button
--SW EMCON -> EMCON button
--SW MPCD CNT -> MPCD contrast knob
--SW MPCD -> MPCD brightness knob
--SW LDDI -> LDDI mode knob
--SW LDDI CNT -> LDDI contrast knob
--SW LDDI BRT -> LDDI brightness knob
--SW RDDI -> RDDI mode knob
--SW RDDI CNT -> RDDI contrast knob
--SW RDDI BRT -> RDDI brightness knob
--SW CABIN TEMP -> CABIN TEMP knob. Not modeled.
--SW BLEED AIR MODE -> Bleed air mode knob (4-pos)
--SW BLEED AIR AUG -> Bleed air AUG PULL switch
--SW STROBE PATTERN -> Strobe pattern knob
--SW LT NAV -> Nav lights knob
--SW EFD -> EFD brightness knob
--SW EFD MODE -> EFD mode switch
--SW BINGO -> BINGO level knob
--SW LT CONSOLE -> Console lights knob
--SW LT FLOOD -> Flood lights knob
--SW LT INST -> Instrument panel lights knob
--SW LT CHART -> Chart lights knob. Not modeled.
--SW AOA -> AOA brightness knob
--SW HUD -> HUD power/brightness knob
--SW HUD HUE -> HUD hue knob
--SW BLK LVL -> HUD NVIS black level knob
--SW UFCD BRT -> UFCD brightness knob
--SW UFCD CNT -> UFCD contrast knob
--SW UFCD SYM -> UFCD SYM knob
--SW COM1 -> COM1 volume knob
--COM1 CHAN -> COM1 channel knob
--SW COM2 -> COM2 volume knob
--COM2 CHAN -> COM2 channel knob
--SW RDR PWR -> Radar power knob (tristate)
--SW INS -> INS alignment mode knob. Not modeled.
--SW VOX VOL -> VOX Volume knob
--SW WPN VOL -> WPN Volume knob
--SW ICS VOL -> ICS Volume knob
--SW AUR VOL -> AUR Volume knob
--SW RWR VOL -> RWR Volume knob
--SW TCN VOL -> TCN Volume knob
--SW AUX VOL -> AUX Volume knob
--SW FCS BIT -> FCS BIT consent button
--SW LT TEST -> LT TEST switch
--SW WINGFOLD -> Wingfold switch (tristate)
--SW AV COOL -> AV emergency cooling switch
--SW ALE50 -> ALE50 power switch
--SW ALE47 -> ALE47 power switch
--SW RWR -> RWR power switch
--SW AUX REL -> AUX REL button
--SW CMWS -> CMWS power switch
--SW CMDS -> CMDS program execute button (left canopy sil)
--SW FLIR -> FLIR Switch
--SW LTD -> LTD Switch
--SW LST -> LST Switch
--SW GND PWR -> GND PWR switch (tristate)
--SW FIRE TEST -> FIRE TEST switch (tristate)
--SW BRK PRESS -> BRK PRESS switch
--SW WINDSHIELD -> WINDSHIELD switch. Not modeled)
--SW APU -> APU power switch
--SW ENG STARTER -> ENG CRANK switch (tristate)
--SW IFF MODE4 -> IFF MODE4 audio switch (tristate)
--SW IR COOL -> IR COOL. Not modeled
--SW SPIN ORIDE -> SPIN ORIDE. Pro only.
--SW HUD VIDEO -> HUD VIDEO. Not modeled
--SW HSEL -> HSEL switch
--SW MASTER ARM -> Master ARM switch
--SW FCS GAIN -> FCS GAIN override switch. Pro-only.
--SW GEN TIE -> GEN TIE switch
--SW LT STROBE -> Strobe light switch
--SW IFR PROBE -> IFR Probe switch (tristate)
--SW FUEL DUMP -> FUEL DUMP switch
--SW EXT MID XFER -> LM/RM switch (EXT TANKS)
--SW EXT IN XFER -> LI/RI switch (EXT TANKS)
--SW EXT CTR XFER -> CTR switch (EXT TANKS)
--SW PITOT HEAT -> PITOT HEAT switch
--SW ANTI ICE -> ANTI ICE switch (tristate)
--SW ECS MODE -> ECS MODE switch (tristate)
--SW CABIN PRESS -> CABIN PRESS switch
--SW FLAPS -> FLAPS switch (tristate)
--SW HOOK BYPASS -> HOOK BYPASS switch (FIELD/CARRIER)
--SW ANTISKID -> ANTI SKID switch
--SW LT LANDING -> Landing light switch
--SW LBAR -> LBAR switch
--SW ARS CUT ENABLE -> ARS CUT ENABLE (guard)
--SW SEAT ARM -> Ejection seat arming switch
--SW SEAT ORIDE -> Seat manual override handle
--SW EJECT -> Ejection handle
--SW CANOPY JETT -> CANOPY JETT handle
--SW TAILHOOK -> Tailhook handle
--SW ARS BRT -> ARS Brightness
--SW ARS DISPLAY -> ARS DISPLAY
--SW ARS PWR -> ARS Power
--SW ARS STORE -> ARS STORE
--SW ARS DEPLOY -> ARS DEPLOY
--SW ARS XFR -> ARS XFR
--SW ARS SLEW -> ARS SLEW
--SW ARS CUT -> ARS CUT
--SW AUTOPILOT -> This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW MC1 -> MC1 Power. Not currently modeled in VC.
--SW MC2 -> MC2 Power. Not currently modeled in VC.
--SW IFF -> IFF Power. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW ILS -> ILS Power. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW TCN -> TCN Power. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW ASPJ -> ASPJ Power.
--SW EXT LT -> EXT LT Switch
--SW ALT WARN -> This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW ICS -> ICS Power. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW SDC REFUEL -> This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW ATC -> ATC Toggle (HOTAS)
--SW LT ALL -> All lights toggle. Equivalent to the default FSX "L" function. Not modeled in the VC, nor should it be.
--SW HYD ISO -> HYD ISO switch. Not physically modeled in VC, but operationally modeled.
--SW NWS -> NWS enable/disable. Modeled as part of paddle switch operation.
--SW GLIM OVRD -> G-Limit Override. This applies only to Pro, and when modeled will be part of the paddle switch function.
--SW FLARE -> Drop Flare. HOTAS
--SW CHAFF -> Drop Chaff Bundle. HOTAS
--SW ASPJ JAM -> ASPJ jam switch. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW ALE50 DEPLOY -> ALE50 Deploy. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW ALE50 JAM -> ALE50 jam switch. This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW EMERG GEAR -> emergency gear extension. This is part of the gear handle operation and is not modeled
--SW ALE50 CUT -> ALE50 cut switch
--SW SDC RESET -> This is an avionic switch and should not be physically modeled or used in a HOTAS setup.
--SW UFCD -> UFCD brightness switch
--SW LGCU SIL -> landing gear control unit warning tone silence
--SW JETT MODE -> selective jettison mode dial
--SW JETT SEL:2 -> Left outer jettison select button
--SW JETT SEL:10 -> Right outer jettison select button
--SW JETT SEL:3 -> Left midboard jettison select button
--SW JETT SEL:9 -> Right midboard jettison select button
--SW JETT SEL:4 -> Left inner jettison select button
--SW JETT SEL:8 -> Right inner jettison select button
--SW JETT SEL:6 -> Center jettison select button
--SW FCS RESET -> FCS reset button
--SW FIRE EXTH -> fire extinguisher switch
--SW EMERG JETT -> emergency jettison button
--SW JETT -> selective jettison button
--SW HUD MODE -> HUD night/day mode switch
--SW VOICE VOL -> Voice volume knob
--SW CANOPY -> Canopy open/close switch
--SW ATT SEL -> attitude mode switch (tri-state)
--SW WING INHIBIT -> wing fuel inhibit switch

-- Work in Progress
--canOpsTable[0x220A0801] = function() ipc.writeLvar("L:SW RDDI PB", 6) end
--canOpsTable[0x220A0802] = function() ipc.writeLvar("L:SW RDDI PB", 7) end
-- canOpsTable[0x220A0801] = function() ipc.writeLvar("L:SW MASTER ARM", 1) ipc.display("MASTER ARM ON") end
-- canOpsTable[0x220A0802] = function() ipc.writeLvar("L:SW MASTER ARM", 0) ipc.display("MASTER ARM OFF") end
--canOpsTable[0x220A0801] = function() ipc.writeLvar("L:SW HUD MODE", 1) ipc.display("left") end
--canOpsTable[0x220A0802] = function() ipc.writeLvar("L:SW HUD MODE", 0) ipc.display("right") end

-- Main Loop
while true do

	local packet = ""
	local flightData = {}

	-- Brake Accumulator Pressure Indicator in PSI PER 1000
	var = ipc.readDBL(0x3820)
-- var = ipc.readUB(0x66EB)
--  ipc.display(var)
	-- table.insert(flightData,string.format("ID_?????=%.4f", var))

-------------------------------------------------------------------------
	
	
	-- Barometric altitude metres (hud display)
--	var = ipc.readSD(0x3324) * 0.3048
	-- Barometric altitude feet (hud display)
	var = ipc.readSD(0x3324)
-- ipc.display(var)
	table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f", var))

	-- Barometric pressure CANAerospace hPa (ok)
	var = ipc.readSB(0x0330) / 16
-- ipc.display(var)
	table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f", var))

	-- Turn Co-ordinator slip ball (not simulated)
	var = ipc.readSB(0x036E)
-- ipc.display(var)
	table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f", var))	

	-- Calibrated Airspeed used for Barber Pole m/s
	var = (ipc.readSD(0x02C4) / 128)* 0.5144
-- ipc.display(var)
	table.insert(flightData,string.format("ID_CALIBRATED_AIRSPEED=%.4f", var))

	-- Indicated Airspeed m/s
	var = (ipc.readSD(0x02BC) / 128)* 0.5144
-- ipc.display(var)
	table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f", var))
	
	-- True Airspeed m/s
	var = (ipc.readSD(0x02B8) / 128)* 0.5144
-- ipc.display(var)
	table.insert(flightData,string.format("ID_TRUE_AIRSPEED=%.4f", var))



	-- Cabin altitude(ok) 32-bit integer
	var = ipc.readSD(0x0318)
-- ipc.display(var) -- show on feets
	var = var * 0.3048 -- feets to meters
	table.insert(flightData,string.format("ID_CABIN_ALTITUDE=%.4f", var))

	-- Vertical speed CANAerospace (ok)
	-- in m/s /256
	-- in ft/min *60 *3.08284 / 256
	var = ipc.readSD(0x02C8) *60 *3.08284 / 256
-- ipc.display(var)
	table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f", var))
	

	-- Accelerometer CANAerospace m/s2 (ok)
	var = ipc.readDBL(0x1140)
-- ipc.display(var)
	table.insert(flightData, string.format("ID_BODY_NORMAL_ACCELERATION=%.4f", var))

	-- Mach Number (ok)
	var = ipc.readDBL(0x35A0)
-- ipc.display(var)
	table.insert(flightData,string.format("ID_MACH_NUMBER=%.4f", var))

	-- Roll (OK)
	var = ipc.readDBL(0x2F78)
-- ipc.display(var)
	table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f", var ))

	-- Pitch Degrees CANAerospace (OK)
	var = (-1)*ipc.readDBL(0x2F70) 
-- ipc.display(var)
	table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f", var))

	-- standby altimeter feet (OK)
	--var = ipc.readSD(0x3544)
-- ipc.display(var)
	--table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f", var))

	-- System Battery DC (ok)
	var = ipc.readDBL(0x2840)
-- ipc.display(var)
	table.insert(flightData,string.format("ID_DC_SYSTEM_1_VOLTAGE=%.4f", var))

	-- System Hydraulics (ok)
	var = ipc.readDBL(0x2b08)
-- ipc.display(var)
	table.insert(flightData,string.format("ID_HYDRAULIC_SYSTEM_1_PRESSURE=%.4f", var))

	-- System Clock (ok)
	hour = ipc.readUB(0x0238)
	minute = ipc.readUB(0x0239)
	second = ipc.readUB(0x023A)

	var = (hour * 3600) + (minute * 60) + second

	table.insert(flightData,string.format("ID_UTC=%.4f", var))
	ipc.display(var)

	-- Export LAMPS_0_31
	lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	lp[1] = 1 -- GAUGES LIGHTS (1 ON) (0 OFF)
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
			canOpsTable[((DATA0 * (16^6)) + (DATA1 * (16^4)) + (DATA2 * (16^2)) + DATA3)]()
		elseif SERVICE_CODE == 3 then -- ANALOG DEVICE
			canOpsTable[(DATA0 * (16^2)) + DATA1]((DATA2 * (16^2)) + DATA3)
		end
		
	end
	
end