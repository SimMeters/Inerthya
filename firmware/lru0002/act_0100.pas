------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- act_0100.jal 1.0 01/01/2015 (A.Bonaiti Actuator Speed)

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
include canaerospace -- Constants for CANAerospace
include lru0002      -- Include For LRU Device Type
include canbus       -- CanBus Library 

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf

var byte val
var byte latch

var dword src = 0
var dword dst = 0
var float asi = 0.0

const byte SHAFT_IN     = 0b00000101
const byte SHAFT_OUT    = 0b00000011
const byte SHAFT_STOP   = 0b00000000

------------------------------------------------------------------------------------------------------------------------
-- Setup CANBUS
------------------------------------------------------------------------------------------------------------------------
setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_indicated_airspeed)
setup_can_end()

------------------------------------------------------------------------------------------------------------------------
-- Initialization Set to 0 position
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

while(!PORTB_RB0) loop
    LATA = SHAFT_IN
end loop
LATA = SHAFT_STOP

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Move Shaft
------------------------------------------------------------------------------------------------------------------------
procedure setPosition() is

    while (src != dst) loop

        if (src < dst) then 
            LATA = SHAFT_OUT
        elsif ((src > dst) & !PORTB_RB0) then 
            LATA = SHAFT_IN
        end if
        
        val = PORTB_RB1
        if(val != latch) then

            if (src < dst) then 
                src = src + 1
            elsif (src > dst) then 
                src = src - 1 
            end if

            latch = val

        end if

    end loop

    LATA = SHAFT_STOP

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("act_0100")

    cf = get_can_frame(id_indicated_airspeed)
    if(cf.dlc > 0) then
         
        asi = get_can_float(cf) * float(3.6) -- m/s to km/h

        -- fixed scale
        if ((asi >= float(0)) & (asi <= float(50))) then
            dst = 0
        elsif ((asi > float(50)) & (asi <= float(100))) then
            dst = 200
        elsif ((asi > float(100)) & (asi <= float(150))) then
            dst = 400
        elsif ((asi > float(150)) & (asi <= float(200))) then
            dst = 600
        elsif ((asi > float(200)) & (asi <= float(250))) then
            dst = 800
        elsif (asi > float(250)) then
            dst = 1000
        end if

        setPosition()
    
    end if    
    
end loop