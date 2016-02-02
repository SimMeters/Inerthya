------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- pnl_0269.jal 1.0 01/01/2015 (A-10C CDU)

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
include atachapters  -- Constants for ATA Chapters
include canaerospace -- Constants for CANAerospace
include lru0002       -- Include For LRU Device Type
include canbus       -- CanBus Library
include objects      -- Objects Library

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
var volatile sw2p sw00 = new_sw2p(p05, P14, CDU_OSB_L0_ON, CDU_OSB_L0_OFF)
var volatile sw2p sw01 = new_sw2p(p06, P14, CDU_OSB_L1_ON, CDU_OSB_L1_OFF)
var volatile sw2p sw02 = new_sw2p(p07, P14, CDU_OSB_L2_ON, CDU_OSB_L2_OFF)
var volatile sw2p sw03 = new_sw2p(p08, P14, CDU_OSB_L3_ON, CDU_OSB_L3_OFF)
var volatile sw2p sw04 = new_sw2p(p09, P14, CDU_OSB_R0_ON, CDU_OSB_R0_OFF)
var volatile sw2p sw05 = new_sw2p(p10, P14, CDU_OSB_R1_ON, CDU_OSB_R1_OFF)
var volatile sw2p sw06 = new_sw2p(p05, p15, CDU_OSB_R2_ON, CDU_OSB_R2_OFF)
var volatile sw2p sw07 = new_sw2p(p06, p15, CDU_OSB_R3_ON, CDU_OSB_R3_OFF)
var volatile sw2p sw08 = new_sw2p(p08, p16, CDU_OSB_SYS_ON, CDU_OSB_SYS_OFF)
var volatile sw2p sw09 = new_sw2p(p07, p16, CDU_OSB_NAV_ON, CDU_OSB_NAV_OFF)
var volatile sw2p sw10 = new_sw2p(p06, p16, CDU_OSB_WP_ON, CDU_OSB_WP_OFF)
var volatile sw2p sw11 = new_sw2p(p05, p16, CDU_OSB_OSET_ON, CDU_OSB_OSET_OFF)
var volatile sw2p sw12 = new_sw2p(p10, p15, CDU_OSB_FPM_ON, CDU_OSB_FPM_OFF)
var volatile sw2p sw13 = new_sw2p(p09, p15, CDU_OSB_PREV_ON, CDU_OSB_PREV_OFF)
var volatile sw2p sw14 = new_sw2p(p08, p15, CDU_OSB_DIM_ON, CDU_OSB_DIM_OFF)
var volatile sw2p sw15 = new_sw2p(p07, p15, CDU_OSB_BRT_ON, CDU_OSB_BRT_OFF)
var volatile sw2p sw16 = new_sw2p(p07, p27, CDU_OSB_0_ON, CDU_OSB_0_OFF)
var volatile sw2p sw17 = new_sw2p(p09, p16, CDU_OSB_1_ON, CDU_OSB_1_OFF)
var volatile sw2p sw18 = new_sw2p(p10, p16, CDU_OSB_2_ON, CDU_OSB_2_OFF)
var volatile sw2p sw19 = new_sw2p(p05, p17, CDU_OSB_3_ON, CDU_OSB_3_OFF)
var volatile sw2p sw20 = new_sw2p(p06, p18, CDU_OSB_4_ON, CDU_OSB_4_OFF)
var volatile sw2p sw21 = new_sw2p(p07, p18, CDU_OSB_5_ON, CDU_OSB_5_OFF)
var volatile sw2p sw22 = new_sw2p(p08, p18, CDU_OSB_6_ON, CDU_OSB_6_OFF)
var volatile sw2p sw23 = new_sw2p(p09, p23, CDU_OSB_7_ON, CDU_OSB_7_OFF)
var volatile sw2p sw24 = new_sw2p(p10, p23, CDU_OSB_8_ON, CDU_OSB_8_OFF)
var volatile sw2p sw25 = new_sw2p(p05, p26, CDU_OSB_9_ON, CDU_OSB_9_OFF)
var volatile sw2p sw26 = new_sw2p(p06, p27, CDU_OSB_DOT_ON, CDU_OSB_DOT_OFF)
var volatile sw2p sw27 = new_sw2p(p08, p27, CDU_OSB_SLASH_ON, CDU_OSB_SLASH_OFF)
var volatile sw2p sw28 = new_sw2p(p06, p17, CDU_OSB_A_ON, CDU_OSB_A_OFF)
var volatile sw2p sw29 = new_sw2p(p07, p17, CDU_OSB_B_ON, CDU_OSB_B_OFF)
var volatile sw2p sw30 = new_sw2p(p08, p17, CDU_OSB_C_ON, CDU_OSB_C_OFF)
var volatile sw2p sw31 = new_sw2p(p09, p17, CDU_OSB_D_ON, CDU_OSB_D_OFF)
var volatile sw2p sw32 = new_sw2p(p10, p17, CDU_OSB_E_ON, CDU_OSB_E_OFF)
var volatile sw2p sw33 = new_sw2p(p05, p18, CDU_OSB_F_ON, CDU_OSB_F_OFF)
var volatile sw2p sw34 = new_sw2p(p09, p18, CDU_OSB_G_ON, CDU_OSB_G_OFF)
var volatile sw2p sw35 = new_sw2p(p10, p18, CDU_OSB_H_ON, CDU_OSB_H_OFF)
var volatile sw2p sw36 = new_sw2p(p05, p23, CDU_OSB_I_ON, CDU_OSB_I_OFF)
var volatile sw2p sw37 = new_sw2p(p06, p23, CDU_OSB_J_ON, CDU_OSB_J_OFF)
var volatile sw2p sw38 = new_sw2p(p07, p23, CDU_OSB_K_ON, CDU_OSB_K_OFF)
var volatile sw2p sw39 = new_sw2p(p08, p23, CDU_OSB_L_ON, CDU_OSB_L_OFF)
var volatile sw2p sw40 = new_sw2p(p06, p26, CDU_OSB_M_ON, CDU_OSB_M_OFF)
var volatile sw2p sw41 = new_sw2p(p07, p26, CDU_OSB_N_ON, CDU_OSB_N_OFF)
var volatile sw2p sw42 = new_sw2p(p08, p26, CDU_OSB_O_ON, CDU_OSB_O_OFF)
var volatile sw2p sw43 = new_sw2p(p09, p26, CDU_OSB_P_ON, CDU_OSB_P_OFF)
var volatile sw2p sw44 = new_sw2p(p10, p26, CDU_OSB_Q_ON, CDU_OSB_Q_OFF)
var volatile sw2p sw45 = new_sw2p(p05, p27, CDU_OSB_R_ON, CDU_OSB_R_OFF)
var volatile sw2p sw46 = new_sw2p(p09, p27, CDU_OSB_S_ON, CDU_OSB_S_OFF)
var volatile sw2p sw47 = new_sw2p(p10, p27, CDU_OSB_T_ON, CDU_OSB_T_OFF)
var volatile sw2p sw48 = new_sw2p(p05, p28, CDU_OSB_U_ON, CDU_OSB_U_OFF)
var volatile sw2p sw49 = new_sw2p(p06, p28, CDU_OSB_V_ON, CDU_OSB_V_OFF)
var volatile sw2p sw50 = new_sw2p(p07, p28, CDU_OSB_W_ON, CDU_OSB_W_OFF)
var volatile sw2p sw51 = new_sw2p(p08, p28, CDU_OSB_X_ON, CDU_OSB_X_OFF)
var volatile sw2p sw52 = new_sw2p(p08, p29, CDU_OSB_Y_ON, CDU_OSB_Y_OFF)
var volatile sw2p sw53 = new_sw2p(p09, p29, CDU_OSB_Z_ON, CDU_OSB_Z_OFF)
var volatile sw2p sw54 = new_sw2p(p09, p28, CDU_OSB_P_UP_ON, CDU_OSB_P_UP_OFF)
var volatile sw2p sw55 = new_sw2p(p05, p30, CDU_OSB_G_DOWN_ON, CDU_OSB_G_DOWN_OFF)
var volatile sw2p sw56 = new_sw2p(p10, p28, CDU_OSB_BLK0_ON, CDU_OSB_BLK0_OFF)
var volatile sw2p sw57 = new_sw2p(p05, p29, CDU_OSB_BLK1_ON, CDU_OSB_BLK1_OFF)
var volatile sw2p sw58 = new_sw2p(p06, p29, CDU_OSB_BCK_ON, CDU_OSB_BCK_OFF)
var volatile sw2p sw59 = new_sw2p(p07, p29, CDU_OSB_SPC_ON, CDU_OSB_SPC_OFF)
var volatile sw2p sw60 = new_sw2p(p06, p30, CDU_OSB_MK_ON, CDU_OSB_MK_OFF)
var volatile sw2p sw61 = new_sw2p(p07, p30, CDU_OSB_LEFT_ON, CDU_OSB_LEFT_OFF)
var volatile sw2p sw62 = new_sw2p(p08, p30, CDU_OSB_RIGHT_ON, CDU_OSB_RIGHT_OFF)
var volatile sw2p sw63 = new_sw2p(p09, p30, CDU_OSB_CLR_ON, CDU_OSB_CLR_OFF)
var volatile sw2p sw64 = new_sw2p(p10, p30, CDU_OSB_FA_ON, CDU_OSB_FA_OFF)
var volatile sw2p sw65 = new_sw2p(p10, p29, CDU_OSB_INC_ON, CDU_OSB_INC_OFF)
var volatile sw2p sw66 = new_sw2p(p05, p31, CDU_OSB_DEC_ON, CDU_OSB_DEC_OFF)

------------------------------------------------------------------------------------------------------------------------
-- Main Loop
------------------------------------------------------------------------------------------------------------------------
forever loop 

    -- request bootloader for auto update (do not remove)
    request_bootloader("pnl_0269")

    -- process devices to canbus
    process_sw2p(sw00)
    process_sw2p(sw01)
    process_sw2p(sw02)
    process_sw2p(sw03)
    process_sw2p(sw04)
	process_sw2p(sw05)
	process_sw2p(sw06)
	process_sw2p(sw07)
	process_sw2p(sw08)
	process_sw2p(sw09)
	process_sw2p(sw10)
	process_sw2p(sw11)
	process_sw2p(sw12)
	process_sw2p(sw13)
	process_sw2p(sw14)
	process_sw2p(sw15)
	process_sw2p(sw16)
	process_sw2p(sw17)
	process_sw2p(sw18)
	process_sw2p(sw19)
	process_sw2p(sw20)
	process_sw2p(sw21)
	process_sw2p(sw22)
	process_sw2p(sw23)
	process_sw2p(sw24)
	process_sw2p(sw25)
	process_sw2p(sw26)
	process_sw2p(sw27)
	process_sw2p(sw28)
	process_sw2p(sw29)
	process_sw2p(sw30)
	process_sw2p(sw31)
	process_sw2p(sw32)
	process_sw2p(sw33)
	process_sw2p(sw34)
	process_sw2p(sw35)
	process_sw2p(sw36)
	process_sw2p(sw37)
	process_sw2p(sw38)
	process_sw2p(sw39)
	process_sw2p(sw40)
	process_sw2p(sw41)
	process_sw2p(sw42)
	process_sw2p(sw43)
	process_sw2p(sw44)
	process_sw2p(sw45)
	process_sw2p(sw46)
	process_sw2p(sw47)
	process_sw2p(sw48)
	process_sw2p(sw49)
	process_sw2p(sw50)
	process_sw2p(sw51)
	process_sw2p(sw52)
	process_sw2p(sw53)
	process_sw2p(sw54)
	process_sw2p(sw55)
	process_sw2p(sw56)
	process_sw2p(sw57)
	process_sw2p(sw58)
	process_sw2p(sw59)
	process_sw2p(sw60)
	process_sw2p(sw61)
	process_sw2p(sw62)
	process_sw2p(sw63)
	process_sw2p(sw64)
	process_sw2p(sw65)
	process_sw2p(sw66)

end loop