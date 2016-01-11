------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- f18_0019.jal 1.0 01/01/2015 (SNSR Panel)

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
include lru0000
include canbus
include objects

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
setup_can_end()

set_pin(p21, high)
set_pin(p22, low)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile sw3p sw00 = new_sw3p(p05, p06, p19, 0xAA000001, 0xAA000000, 0xAA000002) -- FLIR : ON / STBY / OFF
var volatile sw2p sw01 = new_sw2p(p07, p19, 0xAA000101, 0xAA000100) -- LTDR : ARM / SAFE
var volatile sw2p sw02 = new_sw2p(p08, p19, 0xAA000201, 0xAA000200) -- LTS : ON / OFF
var volatile rs4p sw03 = new_rs4p(p09, p10, p11, p12, p19, 0xAA000301, 0xAA000302, 0xAA000303, 0xAA000304) -- RADAR : OFF / STBY / OPR / EMERG 
var volatile rs8p sw04 = new_rs8p(p13, p14, p15, p16, p17, p18, p20, p23, p19, 0xAA000401, 0xAA000402, 0xAA000403, 0xAA000404, 0xAA000405, 0xAA000406, 0xAA000407, 0xAA000408) -- INS

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("f18_0019")

    -- process devices
    process_sw3p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_rs4p(sw03)
    process_rs8p(sw04)
    
end loop