------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- rpm_0008.jal 1.0 01/01/2014 (NR & N2 RPM UH1D 78MM AZ)

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
include atachapters  -- Library for ATA Chapters constants
include canaerospace -- Library for CAN Aerospace constants
include lru0178      -- Include For LRU Gauge Device Type
include canbus       -- Library for CANBus

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var float rot = 0.0
var float eng = 0.0

------------------------------------------------------------------------------------------------------------------------
-- Init
------------------------------------------------------------------------------------------------------------------------
src1    = 0
dst1    = 7560
setMOTD2()
src1    = 7560
dst1    = 0
setMOTD2()
src1    = 0
dst1    = 0

src2    = 0
dst2    = 7560
setMOTD2()
src2    = 7560
dst2    = 0
setMOTD2()
src2    = 0
dst2    = 0

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_lamps_0_31)
add_can_rxfilter(id_rotor_1_rpm)
add_can_rxfilter(id_engine_1_n2_ecs_channel_a)
setup_can_end()

led_l   = off
led_r   = off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("rpm_0008")

    cf = get_can_frame(id_lamps_0_31)
    if(cf.dlc > 0) then
    
        led_l = ((get_can_uint32(cf) & mask_lamp_00) != 0)
        led_r = ((get_can_uint32(cf) & mask_lamp_00) != 0)
    
    end if

    cf = get_can_frame(id_rotor_1_rpm)
    if(cf.dlc > 0) then

        rot = get_can_float(cf) * float(0.01) -- Rotor RPM U/min / 100

        if (rot <= float(0)) then
            dst1 = 0
        elsif (rot > float(0) & rot <= float(3.5)) then
            dst1 = dword(rot * 1920)
        elsif (rot > float(3.5)) then
            dst1 = 6720
        end if

    end if

    cf = get_can_frame(id_engine_1_n2_ecs_channel_a)
    if(cf.dlc > 0) then

        eng = get_can_float(cf) * float(0.01) -- Engine RPM U/min / 100

        if (eng <= float(0)) then
            dst2 = 0
        elsif (eng > float(0) & eng <= float(70)) then
            dst2 = dword(eng * 93.6)
        elsif (rot > float(70)) then
            dst2 = 6552
        end if

    end if

    setMOTD2()

end loop