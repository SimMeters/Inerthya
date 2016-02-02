------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0251.jal 1.0 01/01/2015 (A-10C Fuel Panel)
-- Todo map inputs

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
include lru0002       -- Include For LRU Device Type
include canbus       -- CanBus Library
include objects      -- Objects Library

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000) -- 1 second pause

setup_can_init()
add_can_rxfilter(id_request_bootloader)
setup_can_end()

set_pin(P21, low) --red led
set_pin(P22, high) -- green led

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
-----------------------------------------------------------------------------------------------------------------------
var volatile sw2p sw00 = new_sw2p(p05, P14, EXT_TKS_WING_ON, EXT_TKS_WING_OFF) -- EXT TNK WING LEFT
var volatile sw2p sw01 = new_sw2p(p06, P14, EXT_TKS_FUS_ON, EXT_TKS_FUS_OFF) -- EXT TNK WING RIGHT
var volatile sw2p sw02 = new_sw2p(p07, P14, SIGN_AMPL_NORM_ON, SIGN_AMPL_NORM_OFF)
var volatile sw2p sw03 = new_sw2p(p08, P14, LINE_CHECK_ON, LINE_CHECK_OFF)
var volatile sw2p sw04 = new_sw2p(p09, P14, TK_GATE_OPEN, TK_GATE_CLOSE)
var volatile sw2p sw05 = new_sw2p(p10, P14, CROSS_FEED_ON, CROSS_FEED_OFF)
var volatile sw2p sw06 = new_sw2p(p11, P14, RCVR_LT_ON, RCVR_LT_OFF)
var volatile sw2p sw07 = new_sw2p(p12, P14, BOOST_PUMPS_WING_L_ON, BOOST_PUMPS_WING_L_OFF)
var volatile sw2p sw08 = new_sw2p(p32, P14, BOOST_PUMPS_WING_R_ON, BOOST_PUMPS_WING_R_OFF)
var volatile sw2p sw09 = new_sw2p(p33, P14, FILL_DISABLE_WING_L_ON, FILL_DISABLE_WING_L_OFF)
var volatile sw2p sw10 = new_sw2p(p34, P14, FILL_DISABLE_WING_R_ON, FILL_DISABLE_WING_R_OFF)
var volatile sw2p sw11 = new_sw2p(p35, P14, BOOST_PUMPS_MAIN_L_ON, BOOST_PUMPS_MAIN_L_OFF)
var volatile sw2p sw12 = new_sw2p(p36, P14, BOOST_PUMPS_MAIN_R_ON, BOOST_PUMPS_MAIN_R_OFF)
var volatile sw2p sw13 = new_sw2p(p37, P14, FILL_DISABLE_MAIN_L_ON, FILL_DISABLE_MAIN_L_OFF)
var volatile sw2p sw14 = new_sw2p(p38, P14, FILL_DISABLE_MAIN_R_ON, FILL_DISABLE_MAIN_R_OFF)
var volatile sw2p sw15 = new_sw2p(p39, P14, RCVR_OPEN, RCVR_CLOSE)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0251")

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)
    process_sw2p(sw08)
    process_sw2p(sw09)
    process_sw2p(sw10)
    process_sw2p(sw11)
    process_sw2p(sw12)
    process_sw2p(sw13)
    process_sw2p(sw14)
    process_sw2p(sw15)

end loop