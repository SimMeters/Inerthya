------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0273.jal 1.0 01/01/2015 (A-10C TACAN Panel)
-- Notes: The common goes to ground because ISR Encoders Output 14 is really unused
-- Todo uses display on spi map inputs to lua

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
include sgcdisplay       -- Library for Display

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
setup_can_end()

-- uploadFont(201, font2)
-- displayConfig(false)
-- displayStartScreen(false)
-- clearScreen()
-- setFont(120)
-- prints(0,0,"000X")

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile en2p en00 = new_en2p(p05, p06, 0xFFFF0001, 0xFFFF0002)
var volatile sw2p sw00 = new_sw2p(p07, P14, 0xFFFF0101, 0xFFFF0100)
var volatile rs2p rs00 = new_rs2p(p08, p09, P14, 0xFFFF0201, 0xFFFF0202)
var volatile en2p en01 = new_en2p(p10, p11, 0xFFFF0301, 0xFFFF0302)
var volatile rs5p rs01 = new_rs5p(p12, p32, p33, p34, p35, P14, 0xFFFF0401, 0xFFFF0402, 0xFFFF0403, 0xFFFF0404, 0xFFFF0405)

------------------------------------------------------------------------------------------------------------------------
-- Process encoders
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoders
procedure isr_encoder_process() is pragma interrupt

    if (INTCON_TMR0IF) then

		process_en2p(en00)
        process_en2p(en01)
        isr_endoder_reset()
    
	end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0273")

    -- process devices
    process_sw2p(sw00)
    process_rs2p(rs00)
    process_rs5p(rs01)

end loop