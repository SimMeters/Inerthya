------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- zsniffer.jal 1.0 01/01/2015 (Display Test and Sniffer for CANBus Data)

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
include spidisplay

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
add_can_rxfilter(id_baro_corrected_altitude)
setup_can_end()

spi_enable()                                                -- enable SPI for display control
set_pin(p14, high)                                          -- display output pin control
_usec_delay(1000000)                                        -- 1sec delay display init

spi_clear_screen(p14)                                       -- clear screen
spi_set_font(p14, 0)                                        -- set font 0 default
spi_print_string(p14, 0, 0, "ID_BARO_CORRECTED_ALTITUDE")   -- print id

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    -- request bootloader for auto update (do not remove)
    request_bootloader("zsniffer")

    -- process data from canbus
    cf = get_can_frame(id_baro_corrected_altitude)
    if(cf.dlc > 0) then

		spi_print_float(P14, 0, 2, 2, get_can_float(cf))

	end if

end loop