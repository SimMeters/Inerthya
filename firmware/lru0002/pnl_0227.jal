------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0227.jal 1.0 01/01/2015 (WIPERS PANEL UH-1D project)

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
include atachapters
include canaerospace
include lru0002
include canbus
include objects

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf

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
--var volatile sw3p sw00 = new_sw3p(p05, p06, P14, WIPER_PILOT, WIPER_BOTH, WIPER_COPILOT)        -- WIPER
--var volatile rs5p rs00 = new_rs5p(p07, p08, p09, p10, p11, P14, WIPER_SEL_PARK, WIPER_SEL_OFF, WIPER_SEL_LOW, WIPER_SEL_MED, WIPER_SEL_HIGH) -- WIPER_SEL
--var volatile sw2p sw01 = new_sw2p(p12, P14, 0x00000000, 0x00000000)                                   -- CARGO NOT IMPLEMENTED
var volatile sw3p sw00 = new_sw3p(p05, p06, P14, WIPER_PILOT, WIPER_BOTH, WIPER_COPILOT)        -- WIPER
var volatile sw2p sw01 = new_sw2p(p07, P14,  WIPER_SEL_PARK, WIPER_SEL_OFF) 	-- WIPER
var volatile sw2p sw02 = new_sw2p(p09, P14,  WIPER_SEL_LOW, WIPER_SEL_OFF) 	-- WIPER
var volatile sw3p sw03 = new_sw3p(p10, p11, P14, WIPER_SEL_MED, WIPER_SEL_HIGH,  WIPER_SEL_HIGH) -- WIPER_SEL
--var volatile sw2p sw01 = new_sw2p(p12, P14, 0x00000000, 0x00000000)                                   -- CARGO NOT IMPLEMENTED

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("pnl_0227")

    --process objects
	--process_sw3p(sw00)
	--process_rs5p(rs00)
    process_sw3p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw3p(sw03)

end loop