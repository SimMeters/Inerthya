------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pgx_0165.jal 1.0 01/01/2015 (COM/NAV MODULE 4 DISPLAYS SPI GX165)

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
include spidisplay

------------------------------------------------------------------------------------------------------------------------
-- Variables Declaration
------------------------------------------------------------------------------------------------------------------------
var can_frame cf

var dword com_act = 0
var dword com_act_latch = 0
var dword com_sby = 0
var dword com_sby_latch = 0
var dword nav_act = 0
var dword nav_act_latch = 0
var dword nav_sby = 0
var dword nav_sby_latch = 0

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)
add_can_rxfilter(id_vhf_1_com_frequency) -- COM_ACT
add_can_rxfilter(id_vhf_3_com_frequency) -- COM_SBY
add_can_rxfilter(id_vor_ils_1_frequency) -- NAV_ACT
add_can_rxfilter(id_vor_ils_3_frequency) -- NAV_SBY
setup_can_end()

set_pin(p17, high) -- COM_ACT
set_pin(p18, high) -- COM_SBY
set_pin(p26, high) -- NAV_ACT
set_pin(p27, high) -- NAV_SBY

spi_enable()

-- spi_display_config(p17, false) -- only one time
-- spi_display_start_screen(p17, false) -- only one time
-- spi_upload_user_font(p17, 200, DIGITAL20x30) -- only one time

-- spi_display_config(p18, false) -- only one time
-- spi_display_start_screen(p18, false) -- only one time
-- spi_upload_user_font(p18, 200, DIGITAL20x30) -- only one time

-- spi_display_config(p26, false) -- only one time
-- spi_display_start_screen(p26, false) -- only one time
-- spi_upload_user_font(p26, 200, DIGITAL20x30) -- only one time

-- spi_display_config(p27, false) -- only one time
-- spi_display_start_screen(p27, false) -- only one time
-- spi_upload_user_font(p27, 200, DIGITAL20x30) -- only one time

spi_clear_screen(p17)
spi_display_config(p17, false)
spi_set_font(p17, 200)
spi_print_string(p17, 0, 1, "000.00")

spi_clear_screen(p18)
spi_display_config(p18, false)
spi_set_font(p18, 200)
spi_print_string(p18, 0, 1, "000.00")

spi_clear_screen(p26)
spi_display_config(p26, false)
spi_set_font(p26, 200)
spi_print_string(p26, 0, 1, "000.00")

spi_clear_screen(p27)
spi_display_config(p27, false)
spi_set_font(p27, 200)
spi_print_string(p27, 0, 1, "000.00")

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var volatile en2p en00 = new_en2p(p05, p06, COM1_KHZ_DEC, COM1_KHZ_INC)
var volatile en2p en01 = new_en2p(p07, p08, COM1_MHZ_DEC, COM1_MHZ_INC)
var volatile sw2p sw00 = new_sw2p(p32, p16, COM1_PUSH_TEST_ON, COM1_PUSH_TEST_OFF)
var volatile sw2p sw01 = new_sw2p(p33, p16, COM1_ACT_SBY_TOGGLE_ON, COM1_ACT_SBY_TOGGLE_OFF)
var volatile sw2p sw02 = new_sw2p(p34, p16, COM1_CHANNEL_ON, COM1_CHANNEL_OFF)
var volatile sw2p sw03 = new_sw2p(p35, p16, COM1_PUSH_K_ON, COM1_PUSH_K_OFF)

var volatile en2p en02 = new_en2p(p09, p10, NAV1_KHZ_DEC, NAV1_KHZ_INC)
var volatile en2p en03 = new_en2p(p11, p12, NAV1_MHZ_DEC, NAV1_MHZ_INC)
var volatile sw2p sw04 = new_sw2p(p36, p16, NAV1_PUSH_IDENT_ON, NAV1_PUSH_IDENT_OFF)
var volatile sw2p sw05 = new_sw2p(p37, p16, NAV1_ACT_SBY_TOGGLE_ON, NAV1_ACT_SBY_TOGGLE_OFF)
var volatile sw2p sw06 = new_sw2p(p38, p16, NAV1_MODE_ON, NAV1_MODE_OFF)
var volatile sw2p sw07 = new_sw2p(p39, p16, NAV1_PUSH_OBS_ON, NAV1_PUSH_OBS_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Process Encoders
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoders
procedure isr_encoder_process() is pragma interrupt

    if (INTCON_TMR0IF) then
        
        process_en2p(en00)
        process_en2p(en01)
        process_en2p(en02)
        process_en2p(en03)
        isr_encoder_reset()
    
    end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    -- request bootloader for auto update (do not remove)
    request_bootloader("pgx_0165")

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
    process_sw2p(sw05)
    process_sw2p(sw06)
    process_sw2p(sw07)

    -- process devices from canbus
    cf = get_can_frame(id_vhf_1_com_frequency)
    if(cf.dlc > 0) then

        com_act = dword(get_can_float(cf) * float(1)) -- CANAerospace COM ACTIVE FREQ
        if(com_act != com_act_latch) then
            spi_clear_screen(p17)
            spi_set_font(p17, 200)
            spi_print_mhz(p17,0,1,com_act)
            com_act_latch = com_act
        end if

    end if

    cf = get_can_frame(id_vhf_3_com_frequency)
    if(cf.dlc > 0) then

        com_sby = dword(get_can_float(cf) * float(1)) -- CANAerospace COM SBY FREQ
        if(com_sby != com_sby_latch) then
            spi_clear_screen(p18)
            spi_set_font(p18, 200)
            spi_print_mhz(p18,0,1,com_sby)
            com_sby_latch = com_sby
        end if

    end if

    cf = get_can_frame(id_vor_ils_1_frequency)
    if(cf.dlc > 0) then

        nav_act = dword(get_can_float(cf) * float(1)) -- CANAerospace NAV ACT FREQ
        if(nav_act != nav_act_latch) then
            spi_clear_screen(p26)
            spi_set_font(p26, 200)
            spi_print_mhz(p26,0,1,nav_act)
            nav_act_latch = nav_act
        end if

    end if

    cf = get_can_frame(id_vor_ils_3_frequency)
    if(cf.dlc > 0) then

        nav_sby = dword(get_can_float(cf) * float(1)) -- CANAerospace NAV SBY FREQ
        if(nav_sby != nav_sby_latch) then
            spi_clear_screen(p27)
            spi_set_font(p27, 200)
            spi_print_mhz(p27,0,1,nav_sby)
            nav_sby_latch = nav_sby
        end if

    end if

end loop