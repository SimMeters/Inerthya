------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0229.jal 1.0 01/01/2015 (Heating System Panel UH-1D project)

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
var volatile rs5p rs00 = new_rs5p(p05, p06, p07, p08, p09, P14, CABIN_HEATING_OFF, CABIN_HEATING_POS1, CABIN_HEATING_POS2, CABIN_HEATING_POS3, CABIN_HEATING_POS4) -- CABIN HEATING
-- var volatile rs4p rs01 = new_rs4p(p10, p11, p12, p32, P14, 0x00000000, 0x00000000, 0x00000000, 0x00000000) -- AFT OUTLET NOT IMPLEMMENTED

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("pnl_0229")

    -- process objects
    process_rs5p(rs00)

end loop