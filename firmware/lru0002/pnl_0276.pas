------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0276.jal 1.0 01/01/2015 (A-10C HARS Panel)
-- Notes: The common goes to ground because ISR Encoders Output 26 is really unused

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
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile en2p en00 = new_en2p(p32, p33, HARS_SYNC_DEC, HARS_SYNC_INC)
var volatile sw2p sw00 = new_sw2p(p34, p26, HARS_SYNC_ON, HARS_SYNC_OFF)
var volatile sw3p sw01 = new_sw3p(p35, p36, p26, HARS_MAGVAR_INC, HARS_MAGVAR_OFF, HARS_MAGVAR_DEC)
var volatile sw2p sw02 = new_sw2p(p37, p26, HARS_DG_N, HARS_DG_S)
var volatile sw2p sw03 = new_sw2p(p38, p26, HARS_SLAVE_ON, HARS_SLAVE_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Process encoders
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoders
procedure isr_encoder_process() is pragma interrupt

    if (INTCON_TMR0IF) then

		process_en2p(en00)
        isr_encoder_reset()

	end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0276")

    -- process devices
    process_sw2p(sw00)
    process_sw3p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)

end loop