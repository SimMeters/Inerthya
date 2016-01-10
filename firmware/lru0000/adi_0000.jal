------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- adi_0000.jal 1.0 01/01/2015 (Mecahnical Attitude Indicator)

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
include canaerospace -- Include library for CANAerospace ID's
include lru0000      -- Include library for LRU Type
include canbus       -- Include library for CANBus
include xl320        -- Include library for Dynamixel Test

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000) -- 1sec delay on start

var can_frame cf
var float pit   = 0
var float bnk   = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader) -- add support for CANBus firmware upgrade
add_can_rxfilter(id_body_pitch_angle)
add_can_rxfilter(id_body_roll_angle)
setup_can_end()

xl320_enable() -- pinout 01 VDD / 02 GND / 06 DATA
--xl320_set_id(0x02) -- plug only one servo to set id 0x02

xl320_set_led(0x01, 0x01) -- pitch
xl320_set_position(0x01, 512) -- center position

xl320_set_led(0x02, 0x02) -- bank
xl320_set_position(0x02, 512) -- center position

set_pin(P21, high) -- set green led off
set_pin(P22, low) -- set red led off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("adi_0000") -- add support for CANBus firmware upgrade by name

    -- pitch angle
    cf = get_can_frame(id_body_pitch_angle)
    if(cf.dlc > 0) then

        pit = get_can_float(cf) + float(150) -- CANAerospace pitch data -150 +150

        if(pit >= float(0) & pit <= float(300)) then
            
            xl320_set_position(0x01, dword(pit * float(3.41)))

        end if

    end if

    -- bank angle
    cf = get_can_frame(id_body_roll_angle)
    if(cf.dlc > 0) then

        bnk = get_can_float(cf) + float(150) -- CANAerospace bank data -150 +150

        if(bnk >= float(0) & bnk <= float(300)) then

            xl320_set_position(0x02, dword(bnk * float(3.41)))

        end if

    end if

end loop