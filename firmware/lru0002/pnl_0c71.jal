------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0c71.jal 1.0 01/01/2015 (General Aviation BOX LRU3 Do-27 project)

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
var word analog_value   = 0
var word pt00_value     = 0
var word pt01_value     = 0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
setup_can_end()

set_pin(p21, low)
set_pin(p22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile pot pt00 = new_pot(p18, 0x00000000) -- BRAKE_L
var volatile pot pt01 = new_pot(p23, 0x00000000) -- BRAKE_R
var volatile rs3p rs00 = new_rs3p(p32, p33, p34, p26, FLAPS_UP, FLAPS_2, FLAPS_3) -- FLAPS

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0c71")

    -- process buttons to canbus input
    process_rs3p(rs00)

    -- process pt00
    analog_value = get_value(pt00.pin_analog)
    
    if(analog_value > 3000) then 
        pt00_value = 1 
    else 
        pt00_value = 0 
    end if
    
    if(pt00_value > pt00.analog_latch) then
        send_can_data(200, DEVICE_SWITCH, BRAKE_LEFT_ON)
    elsif(pt00_value < pt00.analog_latch) then
        send_can_data(200, DEVICE_SWITCH, BRAKE_LEFT_OFF)
    end if
    
    pt00.analog_latch = pt00_value

    -- process pt01
    analog_value = get_value(pt01.pin_analog)
    
    if(analog_value > 3000) then 
        pt01_value = 1 
    else 
        pt01_value = 0 
    end if
    
    if(pt01_value > pt01.analog_latch) then
        send_can_data(200, DEVICE_SWITCH, BRAKE_RIGHT_ON)
    elsif(pt01_value < pt01.analog_latch) then
        send_can_data(200, DEVICE_SWITCH, BRAKE_RIGHT_OFF)
    end if
    
    pt01.analog_latch = pt01_value

end loop