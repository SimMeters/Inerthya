------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- lru_0000.jal 1.0 01/01/2015 (Default firmware loaded on lru-0000)

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

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000) -- 1sec delay on start

setup_can_init()
add_can_rxfilter(id_request_bootloader) -- add support for CANBus firmware upgrade
setup_can_end()

set_pin(P21, low) -- set green led off
set_pin(P22, low) -- set red led off

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    request_bootloader("lru_0000") -- add support for CANBus firmware upgrade by name

    set_pin(P21, high)
    _usec_delay(100000)
    set_pin(P21, low)
    _usec_delay(100000)
    set_pin(P21, high)
    _usec_delay(100000)
    set_pin(P21, low)
    _usec_delay(200000)

    set_pin(P22, high)
    _usec_delay(100000)
    set_pin(P22, low)
    _usec_delay(100000)
    set_pin(P22, high)
    _usec_delay(100000)
    set_pin(P22, low)
    _usec_delay(200000)

end loop