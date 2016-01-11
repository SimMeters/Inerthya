------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0258.jal 1.0 01/01/2015 (A-10C Emergency Panel)

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
include atachapters  -- Constants for ATA Chapters
include canaerospace -- Constants for CANAerospace
include lru0002      -- Include For LRU Device Type
include canbus       -- CanBus Library
include objects      -- Objects Library

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_64_95)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword lamps_64_95

var volatile lamp lp00 = new_lamp(p27, mask_lamp_11) -- MISC LAMP L_AILERON_EMER_DISENGAGE
var volatile lamp lp01 = new_lamp(p28, mask_lamp_12) -- MISC LAMP R_AILERON_EMER_DISENGAGE
var volatile lamp lp02 = new_lamp(p29, mask_lamp_13) -- MISC LAMP L_ELEVATOR_EMER_DISENGAGE
var volatile lamp lp03 = new_lamp(p30, mask_lamp_14) -- MISC LAMP R_ELEVATOR_EMER_DISENGAGE

var volatile sw2p sw00 = new_sw2p(p05, p26, SPEED_BRK_EMER_RETR_ON, SPEED_BRK_EMER_RETR_OFF)
var volatile sw2p sw01 = new_sw2p(p06, p26, PITCH_ROLL_TRIM_NORM, PITCH_ROLL_TRIM_OVERRIDE)
var volatile sw2p sw02 = new_sw2p(p07, p26, TRIM_BUTTON_NOSE_DN_EXECUTE, TRIM_BUTTON_NOSE_DN_STOP) --up
var volatile sw2p sw03 = new_sw2p(p08, p26, TRIM_BUTTON_NOSE_UP_EXECUTE, TRIM_BUTTON_NOSE_UP_STOP) --down
var volatile sw2p sw04 = new_sw2p(p10, p26, TRIM_BUTTON_R_WING_DN_EXECUTE, TRIM_BUTTON_R_WING_DN_STOP) -- right
var volatile sw2p sw05 = new_sw2p(p36, p26, TRIM_BUTTON_L_WING_DN_EXECUTE, TRIM_BUTTON_L_WING_DN_STOP) -- left
var volatile sw3p sw06 = new_sw3p(p11, p12, p26, AILERON_EMERG_DISENG_L, AILERON_EMERG_DISENG_STOP, AILERON_EMERG_DISENG_R)
var volatile sw3p sw07 = new_sw3p(p32, p33, p26, ELEVATOR_EMERG_DISENG_L, ELEVATOR_EMERG_DISENG_STOP, ELEVATOR_EMERG_DISENG_R)
var volatile sw2p sw08 = new_sw2p(p34, p26, FLAPS_EMERG_RETRACT_ON, FLAPS_EMERG_RETRACT_OFF)
var volatile sw2p sw09 = new_sw2p(p35, p26, MRFC_PITCH_YAW_CTRL_NORM, MRFC_PITCH_YAW_CTRL_MAN_REV)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0258")

    -- process lamps
    cf = get_can_frame(id_lamps_64_95)
    if(cf.dlc > 0) then

        lamps_64_95 = get_can_uint32(cf)
        process_lamp(lp00, lamps_64_95)
        process_lamp(lp01, lamps_64_95)
        process_lamp(lp02, lamps_64_95)
        process_lamp(lp03, lamps_64_95)

    end if

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw3p(sw06)
    process_sw3p(sw07)
    process_sw2p(sw08)
    process_sw2p(sw09)

end loop