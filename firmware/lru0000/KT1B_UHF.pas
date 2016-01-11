------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.com
-- All rights reserved. Released under the BSD license.
-- KT1B_UHF.jal 1.0 01/01/2015 (KT1B UHF Radio)

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

-- Requirements
-- Potentiometer need to make on/off the radio need internal state for on/off
-- Switch of the potentiometer launch lua sound.play("squelch")
-- Battery need to make on/off the radio to the internal state
-- Frequency OK outter and inner knob changed in lua
-- Modes and Channels need to define actions maybe in lua
------------------------------------------------------------------------------------------------------------------------
include atachapters     -- Constants for ATA Chapters
include canaerospace    -- Constants for CANAerospace
include lru0000         -- Include For LRU Device Type
include canbus          -- CanBus Library
include objects         -- Objects Library
include spidisplay      -- Library for Display

------------------------------------------------------------------------------------------------------------------------
-- Initialization
------------------------------------------------------------------------------------------------------------------------
_usec_delay(1000000)

setup_can_init()
add_can_rxfilter(id_request_bootloader)     -- used for flash firmware
add_can_rxfilter(id_dme_4_channel)          -- used as UHF channel
add_can_rxfilter(id_transponder_4_code)     -- used as UHF mode
add_can_rxfilter(id_adf_4_frequency)        -- used as UHF frequency
setup_can_end()

-- init screen
spi_enable(3)
spi_clear_screen(p31)
--spi_set_font(p31, 200)
spi_print_string(p31, 0, 0, "CH00")
spi_print_string(p31, 10, 0, "M0")
spi_print_string(p31, 4, 2, "000.00")

set_pin(P21, high)  -- set green led on
set_pin(P22, low)   -- set red led off

------------------------------------------------------------------------------------------------------------------------
-- Objects Definition
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var byte uhf_pwr        = 0
var byte uhf_pwr_lat    = 0
var dword uhf_chn       = 0
var dword uhf_chn_lat   = 0
var dword uhf_mod       = 0
var dword uhf_mod_lat   = 0
var dword uhf_frq       = 0
var dword uhf_frq_lat   = 0

var volatile en2p en00 = new_en2p(p05, p06, UHF_FREQUENCY_DEC, UHF_FREQUENCY_INC)   -- inner encoder
var volatile en2p en01 = new_en2p(p07, p08, UHF_CHANNEL_DEC, UHF_CHANNEL_INC)       -- outer encoder
var volatile sw2p sw00 = new_sw2p(p09, P19, UHF_TONE_ON, UHF_TONE_OFF)              -- switch tone
var volatile sw2p sw01 = new_sw2p(p10, P19, UHF_MODE_ON, UHF_MODE_OFF)              -- switch mode
var volatile sw2p sw02 = new_sw2p(p11, P19, UHF_TEST_ON, UHF_TEST_OFF)              -- switch test

------------------------------------------------------------------------------------------------------------------------
-- Process encoders
------------------------------------------------------------------------------------------------------------------------
isr_encoder_enable() -- because we use encoders
procedure isr_encoder_process() is pragma interrupt

    if (INTCON_TMR0IF) then
        
		process_en2p(en00)
        process_en2p(en01)
        isr_encoder_reset()
    
	end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update
    request_bootloader("KT1B_UHF")

    -- read UHF channel
    cf = get_can_frame(id_dme_4_channel)
    if(cf.dlc > 0) then uhf_chn = dword(get_can_float(cf) * float(1)) end if

    -- read UHF mode
    cf = get_can_frame(id_transponder_4_code)
    if(cf.dlc > 0) then uhf_mod = dword(get_can_float(cf) * float(1)) end if

    -- read UHF frequency
    cf = get_can_frame(id_adf_4_frequency)
    if(cf.dlc > 0) then uhf_frq = dword(get_can_float(cf) * float(1000)) end if

    -- check PWR status
    -- from the last canbus packet we got data2 -> service code we use it for [battery status] on all the canbus frames
    -- also read position value from the POT on pin P18 if greater than 500 consider radio UHF ON
    -- if (cf.data2 == 1) & (get_value(p18) > 500) then
    if (cf.data2 == 1) then
        uhf_pwr = 1
    else
        uhf_pwr = 0
    end if
    
    -- render UHF data
    if(uhf_pwr != uhf_pwr_lat | uhf_chn != uhf_chn_lat | uhf_mod != uhf_mod_lat | uhf_frq != uhf_frq_lat) then
    
        uhf_pwr_lat = uhf_pwr
        uhf_chn_lat = uhf_chn
        uhf_mod_lat = uhf_mod
        uhf_frq_lat = uhf_frq
    
        if uhf_pwr == 0 then
        
            spi_clear_screen(p31) -- power UHF OFF clear screen
            set_pin(p22, low)
        
        else
            
            -- render data
            set_pin(p22, high)
            --spi_set_font(p31, 200)

            -- render channel
            case uhf_chn_lat of
                0: spi_print_string(p31, 0, 0, "CH00")
                1: spi_print_string(p31, 0, 0, "CH01")
                2: spi_print_string(p31, 0, 0, "CH02")
                3: spi_print_string(p31, 0, 0, "CH03")
                4: spi_print_string(p31, 0, 0, "CH04")
                5: spi_print_string(p31, 0, 0, "CH05")
                6: spi_print_string(p31, 0, 0, "CH06")
                7: spi_print_string(p31, 0, 0, "CH07")
                8: spi_print_string(p31, 0, 0, "CH08")
                9: spi_print_string(p31, 0, 0, "CH09")
                10: spi_print_string(p31, 0, 0, "CH10")
                otherwise spi_print_string(p31, 0, 0, "CH00")
            end case

            -- render mode
            case uhf_mod_lat of
                0: spi_print_string(p31, 10, 0, "M0")
                1: spi_print_string(p31, 10, 0, "M1")
                2: spi_print_string(p31, 10, 0, "M2")
                3: spi_print_string(p31, 10, 0, "M3")
                4: spi_print_string(p31, 10, 0, "M4")
                5: spi_print_string(p31, 10, 0, "M5")
                6: spi_print_string(p31, 10, 0, "M6")
                7: spi_print_string(p31, 10, 0, "M7")
                8: spi_print_string(p31, 10, 0, "M8")
                9: spi_print_string(p31, 10, 0, "M9")
                otherwise spi_print_string(p31, 10, 0, "M0")
            end case

            -- render frequency
            spi_print_mhz(p31, 4, 2, uhf_frq_lat)
        
        end if

    end if

    -- process devices
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)

end loop