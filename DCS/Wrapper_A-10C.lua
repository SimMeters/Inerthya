------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2015, SimMeters.
-- All rights reserved. Released under the BSD license.
-- Wrapper_A-10C.lua 1.1 01/10/2015 (Import/Export script for SimMeters Workspace DCS Wrapper)

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
-- Variables Declaration
ils_mhz = 0
canOpsTable = {}

-- MIP -- LRU_PNL_239
canOpsTable[HDG_BUG_DEC] = function() GetDevice(45):performClickableAction(3001, -0.01) end
canOpsTable[HDG_BUG_INC] = function() GetDevice(45):performClickableAction(3001, 0.01) end
canOpsTable[CRS_BUG_DEC] = function() GetDevice(45):performClickableAction(3002, -0.01) end
canOpsTable[CRS_BUG_INC] = function() GetDevice(45):performClickableAction(3002, 0.01) end
canOpsTable[ADI_SET_DEC] = function() GetDevice(47):performClickableAction(3001, -0.01) end
canOpsTable[ADI_SET_INC] = function() GetDevice(47):performClickableAction(3001, 0.01) end
canOpsTable[QNH_ENC_DEC] = function() GetDevice(35):performClickableAction(3001, -0.01) end 
canOpsTable[QNH_ENC_INC] = function() GetDevice(35):performClickableAction(3001, 0.01) end
canOpsTable[EXT_STORES_JETT_ON] = function() GetDevice(12):performClickableAction(3001, 1) end
canOpsTable[EXT_STORES_JETT_OFF] = function() GetDevice(12):performClickableAction(3001, 0) end
canOpsTable[FIRE_LENG_PULL_ON] = function() GetDevice(50):performClickableAction(3001, 1) end
canOpsTable[FIRE_LENG_PULL_OFF] = function() GetDevice(50):performClickableAction(3001, 0) end
canOpsTable[FIRE_APU_PULL_ON] = function() GetDevice(50):performClickableAction(3002, 1) end
canOpsTable[FIRE_APU_PULL_OFF] = function() GetDevice(50):performClickableAction(3002, 0) end
canOpsTable[FIRE_RENG_PULL_ON] = function() GetDevice(50):performClickableAction(3003, 1) end
canOpsTable[FIRE_RENG_PULL_OFF] = function() GetDevice(50):performClickableAction(3003, 0) end
canOpsTable[FIRE_ENG_DISC_OFF] = function() GetDevice(50):performClickableAction(3004, 0) end
canOpsTable[FIRE_LENG_DISC_ON] = function() GetDevice(50):performClickableAction(3004, -1) end
canOpsTable[FIRE_RENG_DISC_ON] = function() GetDevice(50):performClickableAction(3004, 1) end
canOpsTable[HARS_FAST_ERECT_ON] = function() GetDevice(44):performClickableAction(3001, 1) end
canOpsTable[HARS_FAST_ERECT_OFF] = function() GetDevice(44):performClickableAction(3001, 0) end

-- UFC -- LRU_PNL_240
canOpsTable[UFC_OSB_MASTER_ON] = function() GetDevice(24):performClickableAction(3001, 1) end
canOpsTable[UFC_OSB_MASTER_OFF] = function() GetDevice(24):performClickableAction(3001, 0) end
canOpsTable[UFC_OSB_1_ON] = function() GetDevice(8):performClickableAction(3001, 1) end
canOpsTable[UFC_OSB_1_OFF] = function() GetDevice(8):performClickableAction(3001, 0) end
canOpsTable[UFC_OSB_2_ON] = function() GetDevice(8):performClickableAction(3002, 1) end
canOpsTable[UFC_OSB_2_OFF] = function() GetDevice(8):performClickableAction(3002, 0) end
canOpsTable[UFC_OSB_3_ON] = function() GetDevice(8):performClickableAction(3003, 1) end
canOpsTable[UFC_OSB_3_OFF] = function() GetDevice(8):performClickableAction(3003, 0) end
canOpsTable[UFC_OSB_4_ON] = function() GetDevice(8):performClickableAction(3004, 1) end
canOpsTable[UFC_OSB_4_OFF] = function() GetDevice(8):performClickableAction(3004, 0) end
canOpsTable[UFC_OSB_5_ON] = function() GetDevice(8):performClickableAction(3005, 1) end
canOpsTable[UFC_OSB_5_OFF] = function() GetDevice(8):performClickableAction(3005, 0) end
canOpsTable[UFC_OSB_6_ON] = function() GetDevice(8):performClickableAction(3006, 1) end
canOpsTable[UFC_OSB_6_OFF] = function() GetDevice(8):performClickableAction(3006, 0) end
canOpsTable[UFC_OSB_7_ON] = function() GetDevice(8):performClickableAction(3007, 1) end
canOpsTable[UFC_OSB_7_OFF] = function() GetDevice(8):performClickableAction(3007, 0) end
canOpsTable[UFC_OSB_8_ON] = function() GetDevice(8):performClickableAction(3008, 1) end
canOpsTable[UFC_OSB_8_OFF] = function() GetDevice(8):performClickableAction(3008, 0) end
canOpsTable[UFC_OSB_9_ON] = function() GetDevice(8):performClickableAction(3009, 1) end
canOpsTable[UFC_OSB_9_OFF] = function() GetDevice(8):performClickableAction(3009, 0) end
canOpsTable[UFC_OSB_0_ON] = function() GetDevice(8):performClickableAction(3010, 1) end
canOpsTable[UFC_OSB_0_OFF] = function() GetDevice(8):performClickableAction(3010, 0) end
canOpsTable[UFC_OSB_SPC_ON] = function() GetDevice(8):performClickableAction(3011, 1) end
canOpsTable[UFC_OSB_SPC_OFF] = function() GetDevice(8):performClickableAction(3011, 0) end
canOpsTable[UFC_OSB_HACK_ON] = function() GetDevice(8):performClickableAction(3012, 1) end
canOpsTable[UFC_OSB_HACK_OFF] = function() GetDevice(8):performClickableAction(3012, 0) end
canOpsTable[UFC_OSB_FUNC_ON] = function() GetDevice(8):performClickableAction(3013, 1) end
canOpsTable[UFC_OSB_FUNC_OFF] = function() GetDevice(8):performClickableAction(3013, 0) end
canOpsTable[UFC_OSB_LTR_ON] = function() GetDevice(8):performClickableAction(3014, 1) end
canOpsTable[UFC_OSB_LTR_OFF] = function() GetDevice(8):performClickableAction(3014, 0) end
canOpsTable[UFC_OSB_CLR_ON] = function() GetDevice(8):performClickableAction(3015, 1) end
canOpsTable[UFC_OSB_CLR_OFF] = function() GetDevice(8):performClickableAction(3015, 0) end
canOpsTable[UFC_OSB_ENT_ON] = function() GetDevice(8):performClickableAction(3016, 1) end
canOpsTable[UFC_OSB_ENT_OFF] = function() GetDevice(8):performClickableAction(3016, 0) end
canOpsTable[UFC_OSB_MK_ON] = function() GetDevice(8):performClickableAction(3017, 1) end
canOpsTable[UFC_OSB_MK_OFF] = function() GetDevice(8):performClickableAction(3017, 0) end
canOpsTable[UFC_OSB_ALT_ON] = function() GetDevice(8):performClickableAction(3018, 1) end
canOpsTable[UFC_OSB_ALT_OFF] = function() GetDevice(8):performClickableAction(3018, 0) end
canOpsTable[UFC_STEER_INC_ON] = function() GetDevice(8):performClickableAction(3020, 1) end
canOpsTable[UFC_STEER_INC_OFF] = function() GetDevice(8):performClickableAction(3020, 0) end
canOpsTable[UFC_STEER_DEC_ON] = function() GetDevice(8):performClickableAction(3021, 1) end
canOpsTable[UFC_STEER_DEC_OFF] = function() GetDevice(8):performClickableAction(3021, 0) end
canOpsTable[UFC_DATA_INC_ON] = function() GetDevice(8):performClickableAction(3022, 1) end
canOpsTable[UFC_DATA_INC_OFF] = function() GetDevice(8):performClickableAction(3022, 0) end
canOpsTable[UFC_DATA_DEC_ON] = function() GetDevice(8):performClickableAction(3023, 1) end
canOpsTable[UFC_DATA_DEC_OFF] = function() GetDevice(8):performClickableAction(3023, 0) end
canOpsTable[UFC_SEL_INC_ON] = function() GetDevice(8):performClickableAction(3024, 1) end
canOpsTable[UFC_SEL_INC_OFF] = function() GetDevice(8):performClickableAction(3024, 0) end
canOpsTable[UFC_SEL_DEC_ON] = function() GetDevice(8):performClickableAction(3025, 1) end
canOpsTable[UFC_SEL_DEC_OFF] = function() GetDevice(8):performClickableAction(3025, 0) end
canOpsTable[UFC_DEPR_INC_ON] = function() GetDevice(8):performClickableAction(3026, 1) end
canOpsTable[UFC_DEPR_INC_OFF] = function() GetDevice(8):performClickableAction(3026, 0) end
canOpsTable[UFC_DEPR_DEC_ON] = function() GetDevice(8):performClickableAction(3027, 1) end
canOpsTable[UFC_DEPR_DEC_OFF] = function() GetDevice(8):performClickableAction(3027, 0) end
canOpsTable[UFC_INTEN_INC_ON] = function() GetDevice(8):performClickableAction(3028, 1) end
canOpsTable[UFC_INTEN_INC_OFF] = function() GetDevice(8):performClickableAction(3028, 0) end
canOpsTable[UFC_INTEN_DEC_ON] = function() GetDevice(8):performClickableAction(3029, 1) end
canOpsTable[UFC_INTEN_DEC_OFF] = function() GetDevice(8):performClickableAction(3029, 0) end

-- CMS -- LRU_PNL_0241 WORK IN PROGRESS

-- LEFT MFCD -- LRU_PNL_242
canOpsTable[LMFCD_OSB0_OFF] = function() GetDevice(2):performClickableAction(3001, 0) end
canOpsTable[LMFCD_OSB0_ON] = function() GetDevice(2):performClickableAction(3001, 1) end
canOpsTable[LMFCD_OSB1_OFF] = function() GetDevice(2):performClickableAction(3002, 0) end
canOpsTable[LMFCD_OSB1_ON] = function() GetDevice(2):performClickableAction(3002, 1) end
canOpsTable[LMFCD_OSB2_OFF] = function() GetDevice(2):performClickableAction(3003, 0) end
canOpsTable[LMFCD_OSB2_ON] = function() GetDevice(2):performClickableAction(3003, 1) end
canOpsTable[LMFCD_OSB3_OFF] = function() GetDevice(2):performClickableAction(3004, 0) end
canOpsTable[LMFCD_OSB3_ON] = function() GetDevice(2):performClickableAction(3004, 1) end
canOpsTable[LMFCD_OSB4_OFF] = function() GetDevice(2):performClickableAction(3005, 0) end
canOpsTable[LMFCD_OSB4_ON] = function() GetDevice(2):performClickableAction(3005, 1) end
canOpsTable[LMFCD_OSB5_OFF] = function() GetDevice(2):performClickableAction(3006, 0) end
canOpsTable[LMFCD_OSB5_ON] = function() GetDevice(2):performClickableAction(3006, 1) end
canOpsTable[LMFCD_OSB6_OFF] = function() GetDevice(2):performClickableAction(3007, 0) end
canOpsTable[LMFCD_OSB6_ON] = function() GetDevice(2):performClickableAction(3007, 1) end
canOpsTable[LMFCD_OSB7_OFF] = function() GetDevice(2):performClickableAction(3008, 0) end
canOpsTable[LMFCD_OSB7_ON] = function() GetDevice(2):performClickableAction(3008, 1) end
canOpsTable[LMFCD_OSB8_OFF] = function() GetDevice(2):performClickableAction(3009, 0) end
canOpsTable[LMFCD_OSB8_ON] = function() GetDevice(2):performClickableAction(3009, 1) end
canOpsTable[LMFCD_OSB9_OFF] = function() GetDevice(2):performClickableAction(3010, 0) end
canOpsTable[LMFCD_OSB9_ON] = function() GetDevice(2):performClickableAction(3010, 1) end
canOpsTable[LMFCD_OSB10_OFF] = function() GetDevice(2):performClickableAction(3011, 0) end
canOpsTable[LMFCD_OSB10_ON] = function() GetDevice(2):performClickableAction(3011, 1) end
canOpsTable[LMFCD_OSB11_OFF] = function() GetDevice(2):performClickableAction(3012, 0) end
canOpsTable[LMFCD_OSB11_ON] = function() GetDevice(2):performClickableAction(3012, 1) end
canOpsTable[LMFCD_OSB12_OFF] = function() GetDevice(2):performClickableAction(3013, 0) end
canOpsTable[LMFCD_OSB12_ON] = function() GetDevice(2):performClickableAction(3013, 1) end
canOpsTable[LMFCD_OSB13_OFF] = function() GetDevice(2):performClickableAction(3014, 0) end
canOpsTable[LMFCD_OSB13_ON] = function() GetDevice(2):performClickableAction(3014, 1) end
canOpsTable[LMFCD_OSB14_OFF] = function() GetDevice(2):performClickableAction(3015, 0) end
canOpsTable[LMFCD_OSB14_ON] = function() GetDevice(2):performClickableAction(3015, 1) end
canOpsTable[LMFCD_OSB15_OFF] = function() GetDevice(2):performClickableAction(3016, 0) end
canOpsTable[LMFCD_OSB15_ON] = function() GetDevice(2):performClickableAction(3016, 1) end
canOpsTable[LMFCD_OSB16_OFF] = function() GetDevice(2):performClickableAction(3017, 0) end
canOpsTable[LMFCD_OSB16_ON] = function() GetDevice(2):performClickableAction(3017, 1) end
canOpsTable[LMFCD_OSB17_OFF] = function() GetDevice(2):performClickableAction(3018, 0) end
canOpsTable[LMFCD_OSB17_ON] = function() GetDevice(2):performClickableAction(3018, 1) end
canOpsTable[LMFCD_OSB18_OFF] = function() GetDevice(2):performClickableAction(3019, 0) end
canOpsTable[LMFCD_OSB18_ON] = function() GetDevice(2):performClickableAction(3019, 1) end
canOpsTable[LMFCD_OSB19_OFF] = function() GetDevice(2):performClickableAction(3020, 0) end
canOpsTable[LMFCD_OSB19_ON] = function() GetDevice(2):performClickableAction(3020, 1) end
canOpsTable[LMFCD_INC_ADJ_ON] = function() GetDevice(2):performClickableAction(3021, 1) end
canOpsTable[LMFCD_DEC_ADJ_ON] = function() GetDevice(2):performClickableAction(3022, 1) end
canOpsTable[LMFCD_INC_ADJ_OFF] = function() GetDevice(2):performClickableAction(3023, 1) GetDevice(2):performClickableAction(3023, 0) end
canOpsTable[LMFCD_DEC_ADJ_OFF] = function() GetDevice(2):performClickableAction(3023, 1) GetDevice(2):performClickableAction(3023, 0) end
canOpsTable[LMFCD_INC_DSP_ON] = function() GetDevice(2):performClickableAction(3024, 1) end
canOpsTable[LMFCD_DEC_DSP_ON] = function() GetDevice(2):performClickableAction(3025, 1) end
canOpsTable[LMFCD_INC_DSP_OFF] = function() GetDevice(2):performClickableAction(3026, 1) GetDevice(2):performClickableAction(3026, 0) end
canOpsTable[LMFCD_DEC_DSP_OFF] = function() GetDevice(2):performClickableAction(3026, 1) GetDevice(2):performClickableAction(3026, 0) end
canOpsTable[LMFCD_INC_BRT_ON] = function() GetDevice(2):performClickableAction(3027, 1) end
canOpsTable[LMFCD_DEC_BRT_ON] = function() GetDevice(2):performClickableAction(3028, 1) end
canOpsTable[LMFCD_INC_BRT_OFF] = function() GetDevice(2):performClickableAction(3029, 1) GetDevice(2):performClickableAction(3029, 0) end
canOpsTable[LMFCD_DEC_BRT_OFF] = function() GetDevice(2):performClickableAction(3029, 1) GetDevice(2):performClickableAction(3029, 0) end
canOpsTable[LMFCD_INC_CON_ON] = function() GetDevice(2):performClickableAction(3030, 1) end
canOpsTable[LMFCD_DEC_CON_ON] = function() GetDevice(2):performClickableAction(3031, 1) end
canOpsTable[LMFCD_INC_CON_OFF] = function() GetDevice(2):performClickableAction(3032, 1) GetDevice(2):performClickableAction(3032, 0) end
canOpsTable[LMFCD_DEC_CON_OFF] = function() GetDevice(2):performClickableAction(3032, 1) GetDevice(2):performClickableAction(3032, 0) end
canOpsTable[LMFCD_INC_SYM_ON] = function() GetDevice(2):performClickableAction(3033, 1) end
canOpsTable[LMFCD_DEC_SYM_ON] = function() GetDevice(2):performClickableAction(3034, 1) end
canOpsTable[LMFCD_INC_SYM_OFF] = function() GetDevice(2):performClickableAction(3035, 1) GetDevice(2):performClickableAction(3035, 0) end
canOpsTable[LMFCD_DEC_SYM_OFF] = function() GetDevice(2):performClickableAction(3035, 1) GetDevice(2):performClickableAction(3035, 0) end
canOpsTable[LMFCD_SEL_OFF] = function() GetDevice(2):performClickableAction(3036, 0.0) end
canOpsTable[LMFCD_SEL_NIGHT] = function() GetDevice(2):performClickableAction(3036, 0.1) end
canOpsTable[LMFCD_SEL_DAY] = function() GetDevice(2):performClickableAction(3036, 0.2) end

-- RIGHT MFCD -- LRU_PNL_0243
canOpsTable[RMFCD_OSB0_OFF] = function() GetDevice(3):performClickableAction(3001, 0) end
canOpsTable[RMFCD_OSB0_ON] = function() GetDevice(3):performClickableAction(3001, 1) end
canOpsTable[RMFCD_OSB1_OFF] = function() GetDevice(3):performClickableAction(3002, 0) end
canOpsTable[RMFCD_OSB1_ON] = function() GetDevice(3):performClickableAction(3002, 1) end
canOpsTable[RMFCD_OSB2_OFF] = function() GetDevice(3):performClickableAction(3003, 0) end
canOpsTable[RMFCD_OSB2_ON] = function() GetDevice(3):performClickableAction(3003, 1) end
canOpsTable[RMFCD_OSB3_OFF] = function() GetDevice(3):performClickableAction(3004, 0) end
canOpsTable[RMFCD_OSB3_ON] = function() GetDevice(3):performClickableAction(3004, 1) end
canOpsTable[RMFCD_OSB4_OFF] = function() GetDevice(3):performClickableAction(3005, 0) end
canOpsTable[RMFCD_OSB4_ON] = function() GetDevice(3):performClickableAction(3005, 1) end
canOpsTable[RMFCD_OSB5_OFF] = function() GetDevice(3):performClickableAction(3006, 0) end
canOpsTable[RMFCD_OSB5_ON] = function() GetDevice(3):performClickableAction(3006, 1) end
canOpsTable[RMFCD_OSB6_OFF] = function() GetDevice(3):performClickableAction(3007, 0) end
canOpsTable[RMFCD_OSB6_ON] = function() GetDevice(3):performClickableAction(3007, 1) end
canOpsTable[RMFCD_OSB7_OFF] = function() GetDevice(3):performClickableAction(3008, 0) end
canOpsTable[RMFCD_OSB7_ON] = function() GetDevice(3):performClickableAction(3008, 1) end
canOpsTable[RMFCD_OSB8_OFF] = function() GetDevice(3):performClickableAction(3009, 0) end
canOpsTable[RMFCD_OSB8_ON] = function() GetDevice(3):performClickableAction(3009, 1) end
canOpsTable[RMFCD_OSB9_OFF] = function() GetDevice(3):performClickableAction(3010, 0) end
canOpsTable[RMFCD_OSB9_ON] = function() GetDevice(3):performClickableAction(3010, 1) end
canOpsTable[RMFCD_OSB10_OFF] = function() GetDevice(3):performClickableAction(3011, 0) end
canOpsTable[RMFCD_OSB10_ON] = function() GetDevice(3):performClickableAction(3011, 1) end
canOpsTable[RMFCD_OSB11_OFF] = function() GetDevice(3):performClickableAction(3012, 0) end
canOpsTable[RMFCD_OSB11_ON] = function() GetDevice(3):performClickableAction(3012, 1) end
canOpsTable[RMFCD_OSB12_OFF] = function() GetDevice(3):performClickableAction(3013, 0) end
canOpsTable[RMFCD_OSB12_ON] = function() GetDevice(3):performClickableAction(3013, 1) end
canOpsTable[RMFCD_OSB13_OFF] = function() GetDevice(3):performClickableAction(3014, 0) end
canOpsTable[RMFCD_OSB13_ON] = function() GetDevice(3):performClickableAction(3014, 1) end
canOpsTable[RMFCD_OSB14_OFF] = function() GetDevice(3):performClickableAction(3015, 0) end
canOpsTable[RMFCD_OSB14_ON] = function() GetDevice(3):performClickableAction(3015, 1) end
canOpsTable[RMFCD_OSB15_OFF] = function() GetDevice(3):performClickableAction(3016, 0) end
canOpsTable[RMFCD_OSB15_ON] = function() GetDevice(3):performClickableAction(3016, 1) end
canOpsTable[RMFCD_OSB16_OFF] = function() GetDevice(3):performClickableAction(3017, 0) end
canOpsTable[RMFCD_OSB16_ON] = function() GetDevice(3):performClickableAction(3017, 1) end
canOpsTable[RMFCD_OSB17_OFF] = function() GetDevice(3):performClickableAction(3018, 0) end
canOpsTable[RMFCD_OSB17_ON] = function() GetDevice(3):performClickableAction(3018, 1) end
canOpsTable[RMFCD_OSB18_OFF] = function() GetDevice(3):performClickableAction(3019, 0) end
canOpsTable[RMFCD_OSB18_ON] = function() GetDevice(3):performClickableAction(3019, 1) end
canOpsTable[RMFCD_OSB19_OFF] = function() GetDevice(3):performClickableAction(3020, 0) end
canOpsTable[RMFCD_OSB19_ON] = function() GetDevice(3):performClickableAction(3020, 1) end
canOpsTable[RMFCD_INC_ADJ_ON] = function() GetDevice(3):performClickableAction(3021, 1) end
canOpsTable[RMFCD_DEC_ADJ_ON] = function() GetDevice(3):performClickableAction(3022, 1) end
canOpsTable[RMFCD_INC_ADJ_OFF] = function() GetDevice(3):performClickableAction(3023, 1) GetDevice(3):performClickableAction(3023, 0) end
canOpsTable[RMFCD_DEC_ADJ_OFF] = function() GetDevice(3):performClickableAction(3023, 1) GetDevice(3):performClickableAction(3023, 0) end
canOpsTable[RMFCD_INC_DSP_ON] = function() GetDevice(3):performClickableAction(3024, 1) end
canOpsTable[RMFCD_DEC_DSP_ON] = function() GetDevice(3):performClickableAction(3025, 1) end
canOpsTable[RMFCD_INC_DSP_OFF] = function() GetDevice(3):performClickableAction(3026, 1) GetDevice(3):performClickableAction(3026, 0) end
canOpsTable[RMFCD_DEC_DSP_OFF] = function() GetDevice(3):performClickableAction(3026, 1) GetDevice(3):performClickableAction(3026, 0) end
canOpsTable[RMFCD_INC_BRT_ON] = function() GetDevice(3):performClickableAction(3027, 1) end
canOpsTable[RMFCD_DEC_BRT_ON] = function() GetDevice(3):performClickableAction(3028, 1) end
canOpsTable[RMFCD_INC_BRT_OFF] = function() GetDevice(3):performClickableAction(3029, 1) GetDevice(3):performClickableAction(3029, 0) end
canOpsTable[RMFCD_DEC_BRT_OFF] = function() GetDevice(3):performClickableAction(3029, 1) GetDevice(3):performClickableAction(3029, 0) end
canOpsTable[RMFCD_INC_CON_ON] = function() GetDevice(3):performClickableAction(3030, 1) end
canOpsTable[RMFCD_DEC_CON_ON] = function() GetDevice(3):performClickableAction(3031, 1) end
canOpsTable[RMFCD_INC_CON_OFF] = function() GetDevice(3):performClickableAction(3032, 1) GetDevice(3):performClickableAction(3032, 0) end
canOpsTable[RMFCD_DEC_CON_OFF] = function() GetDevice(3):performClickableAction(3032, 1) GetDevice(3):performClickableAction(3032, 0) end
canOpsTable[RMFCD_INC_SYM_ON] = function() GetDevice(3):performClickableAction(3033, 1) end
canOpsTable[RMFCD_DEC_SYM_ON] = function() GetDevice(3):performClickableAction(3034, 1) end
canOpsTable[RMFCD_INC_SYM_OFF] = function() GetDevice(3):performClickableAction(3035, 1) GetDevice(3):performClickableAction(3035, 0) end
canOpsTable[RMFCD_DEC_SYM_OFF] = function() GetDevice(3):performClickableAction(3035, 1) GetDevice(3):performClickableAction(3035, 0) end
canOpsTable[RMFCD_SEL_OFF] = function() GetDevice(3):performClickableAction(3036, 0.0) end
canOpsTable[RMFCD_SEL_NIGHT] = function() GetDevice(3):performClickableAction(3036, 0.1) end
canOpsTable[RMFCD_SEL_DAY] = function() GetDevice(3):performClickableAction(3036, 0.2) end

-- CPT MECH LANDING GEAR -- LRU_PNL_0244
canOpsTable[ANTI_SKID_OFF] = function() GetDevice(38):performClickableAction(3028, 0) end
canOpsTable[ANTI_SKID_ON] = function() GetDevice(38):performClickableAction(3028, 1) end
canOpsTable[LAND_LIGHT_OFF] = function() GetDevice(49):performClickableAction(3014, 0.1) end
canOpsTable[LAND_LIGHT_ON] = function() GetDevice(49):performClickableAction(3014, 0.2) end
canOpsTable[LAND_LIGHT_TAXI] = function() GetDevice(49):performClickableAction(3014, 0.0) end
canOpsTable[DOWNLOCK_OVERRIDE_OFF] = function() GetDevice(39):performClickableAction(3003, 0) end
canOpsTable[DOWNLOCK_OVERRIDE_ON] = function() GetDevice(39):performClickableAction(3003, 1) end
canOpsTable[LANDING_GEAR_UP] = function() GetDevice(39):performClickableAction(3001, 0) end
canOpsTable[LANDING_GEAR_DOWN] = function() GetDevice(39):performClickableAction(3001, 1) end

-- AHCP -- LRU_PNL_0245
canOpsTable[MASTER_ARM_ON] = function() GetDevice(7):performClickableAction(3001, 0.2) end
canOpsTable[MASTER_ARM_SAFE] = function() GetDevice(7):performClickableAction(3001, 0.1) end
canOpsTable[MASTER_ARM_TRAIN] = function() GetDevice(7):performClickableAction(3001, 0.0) end
canOpsTable[GUNPAC_ARM] = function() GetDevice(7):performClickableAction(3002, 0.2) end
canOpsTable[GUNPAC_SAFE] = function() GetDevice(7):performClickableAction(3002, 0.1) end
canOpsTable[GUNPAC_GUNARM] = function() GetDevice(7):performClickableAction(3002, 0.0) end
canOpsTable[LASER_ARM] = function() GetDevice(7):performClickableAction(3003, 0.2) end
canOpsTable[LASER_SAFE] = function() GetDevice(7):performClickableAction(3003, 0.1) end
canOpsTable[LASER_TRAIN] = function() GetDevice(7):performClickableAction(3003, 0.0) end
canOpsTable[TGP_ON] = function() GetDevice(7):performClickableAction(3004, 1) end
canOpsTable[TGP_OFF] = function() GetDevice(7):performClickableAction(3004, 0) end
canOpsTable[ALT_SCE_BARO] = function() GetDevice(7):performClickableAction(3005, 0.2) end
canOpsTable[ALT_SCE_DELTA] = function() GetDevice(7):performClickableAction(3005, 0.1) end
canOpsTable[ALT_SCE_RADAR] = function() GetDevice(7):performClickableAction(3005, 0.0) end
canOpsTable[HUD_MODE_DAY] = function() GetDevice(7):performClickableAction(3006, 1) end
canOpsTable[HUD_MODE_NIGHT] = function() GetDevice(7):performClickableAction(3006, 0) end
canOpsTable[HUD_MODE_NORMAL] = function() GetDevice(7):performClickableAction(3007, 1) end
canOpsTable[HUD_MODE_STBY] = function() GetDevice(7):performClickableAction(3007, 0) end
canOpsTable[CICU_ON] = function() GetDevice(7):performClickableAction(3008, 1) end
canOpsTable[CICU_OFF] = function() GetDevice(7):performClickableAction(3008, 0) end
canOpsTable[JTRS_ON] = function() GetDevice(7):performClickableAction(3009, 1) end
canOpsTable[JTRS_OFF] = function() GetDevice(7):performClickableAction(3009, 0) end
canOpsTable[IFCC_ON] = function() GetDevice(7):performClickableAction(3010, 0.2) end
canOpsTable[IFCC_TEST] = function() GetDevice(7):performClickableAction(3010, 0.1) end
canOpsTable[IFCC_OFF] = function() GetDevice(7):performClickableAction(3010, 0.0) end

-- NMSP -- LRU_PNL_0246
canOpsTable[NMSP_HARS_ON] = function() GetDevice(46):performClickableAction(3001, 1) end
canOpsTable[NMSP_HARS_OFF] = function() GetDevice(46):performClickableAction(3001, 0) end
canOpsTable[NMSP_PTR_ABLE] = function() GetDevice(46):performClickableAction(3008, 2) end
canOpsTable[NMSP_PTR_OFF] = function() GetDevice(46):performClickableAction(3008, 1) end
canOpsTable[NMSP_PTR_STOW] = function() GetDevice(46):performClickableAction(3008, 0) end
canOpsTable[NMSP_EGI_ON] = function() GetDevice(46):performClickableAction(3002, 1) end
canOpsTable[NMSP_EGI_OFF] = function() GetDevice(46):performClickableAction(3002, 0) end
canOpsTable[NMSP_TISL_ON] = function() GetDevice(46):performClickableAction(3003, 1) end
canOpsTable[NMSP_TISL_OFF] = function() GetDevice(46):performClickableAction(3003, 0) end
canOpsTable[NMSP_STEER_ON] = function() GetDevice(46):performClickableAction(3004, 1) end
canOpsTable[NMSP_STEER_OFF] = function() GetDevice(46):performClickableAction(3004, 0) end
canOpsTable[NMSP_ANCHR_ON] = function() GetDevice(46):performClickableAction(3005, 1) end
canOpsTable[NMSP_ANCHR_OFF] = function() GetDevice(46):performClickableAction(3005, 0) end
canOpsTable[NMSP_TCN_ON] = function() GetDevice(46):performClickableAction(3006, 1) end
canOpsTable[NMSP_TCN_OFF] = function() GetDevice(46):performClickableAction(3006, 0) end
canOpsTable[NMSP_ILS_ON] = function() GetDevice(46):performClickableAction(3007, 1) end
canOpsTable[NMSP_ILS_OFF] = function() GetDevice(46):performClickableAction(3007, 0) end

-- FUEL PANEL -- LRU_PNL_0247
canOpsTable[FUEL_DISPLAY_SEL_INT] = function() GetDevice(36):performClickableAction(3017, 0.0) end
canOpsTable[FUEL_DISPLAY_SEL_MAIN] = function() GetDevice(36):performClickableAction(3017, 0.1) end
canOpsTable[FUEL_DISPLAY_SEL_WING] = function() GetDevice(36):performClickableAction(3017, 0.2) end
canOpsTable[FUEL_DISPLAY_SEL_EXT_WING] = function() GetDevice(36):performClickableAction(3017, 0.3) end
canOpsTable[FUEL_DISPLAY_SEL_EXT_CTR] = function() GetDevice(36):performClickableAction(3017, 0.4) end
canOpsTable[FUEL_DISPLAY_TEST_IND_OFF] = function() GetDevice(36):performClickableAction(3018, 0.0) end
canOpsTable[FUEL_DISPLAY_TEST_IND_ON] = function() GetDevice(36):performClickableAction(3018, 1.0) end

-- TISL PANEL -- LRU_PNL_0248 WORK IN PROGRESS

-- FUEL PANEL -- LRU_PNL_0251
canOpsTable[EXT_TKS_WING_ON] = function() GetDevice(36):performClickableAction(3001, 1) end
canOpsTable[EXT_TKS_WING_OFF] = function() GetDevice(36):performClickableAction(3001,0) end
canOpsTable[EXT_TKS_FUS_ON] = function() GetDevice(36):performClickableAction(3002, 1) end
canOpsTable[EXT_TKS_FUS_OFF] = function() GetDevice(36):performClickableAction(3002, 0) end
canOpsTable[SIGN_AMPL_NORM_ON] = function() GetDevice(36):performClickableAction(3009, 1) end
canOpsTable[SIGN_AMPL_NORM_OFF] = function() GetDevice(36):performClickableAction(3009, 0) end
canOpsTable[LINE_CHECK_ON] = function() GetDevice(36):performClickableAction(3010, 1) end
canOpsTable[LINE_CHECK_OFF] = function() GetDevice(36):performClickableAction(3010, 0) end
canOpsTable[TK_GATE_OPEN] = function() GetDevice(36):performClickableAction(3003, 1) end
canOpsTable[TK_GATE_CLOSE] = function() GetDevice(36):performClickableAction(3003, 0) end
canOpsTable[CROSS_FEED_ON] = function() GetDevice(36):performClickableAction(3004, 1) end
canOpsTable[CROSS_FEED_OFF] = function() GetDevice(36):performClickableAction(3004, 0) end
canOpsTable[RCVR_LT_ON] = function() GetDevice(49):performClickableAction(3018, 0) end
canOpsTable[RCVR_LT_OFF] = function() GetDevice(49):performClickableAction(3018, 1) end
canOpsTable[BOOST_PUMPS_WING_L_ON] = function() GetDevice(36):performClickableAction(3005, 1) end
canOpsTable[BOOST_PUMPS_WING_L_OFF] = function() GetDevice(36):performClickableAction(3005, 0) end
canOpsTable[BOOST_PUMPS_WING_R_ON] = function() GetDevice(36):performClickableAction(3006, 1) end
canOpsTable[BOOST_PUMPS_WING_R_OFF] = function() GetDevice(36):performClickableAction(3006, 0) end
canOpsTable[FILL_DISABLE_WING_L_ON] = function() GetDevice(36):performClickableAction(3012, 1) end
canOpsTable[FILL_DISABLE_WING_L_OFF] = function() GetDevice(36):performClickableAction(3012, 0) end
canOpsTable[FILL_DISABLE_WING_R_ON] = function() GetDevice(36):performClickableAction(3013, 1) end
canOpsTable[FILL_DISABLE_WING_R_OFF] = function() GetDevice(36):performClickableAction(3013, 0) end
canOpsTable[BOOST_PUMPS_MAIN_L_ON] = function() GetDevice(36):performClickableAction(3007, 1) end
canOpsTable[BOOST_PUMPS_MAIN_L_OFF] = function() GetDevice(36):performClickableAction(3007, 0) end
canOpsTable[BOOST_PUMPS_MAIN_R_ON] = function() GetDevice(36):performClickableAction(3008, 1) end
canOpsTable[BOOST_PUMPS_MAIN_R_OFF] = function() GetDevice(36):performClickableAction(3008, 0) end
canOpsTable[FILL_DISABLE_MAIN_L_ON] = function() GetDevice(36):performClickableAction(3014, 1) end
canOpsTable[FILL_DISABLE_MAIN_L_OFF] = function() GetDevice(36):performClickableAction(3014, 0) end
canOpsTable[FILL_DISABLE_MAIN_R_ON] = function() GetDevice(36):performClickableAction(3015, 1) end
canOpsTable[FILL_DISABLE_MAIN_R_OFF] = function() GetDevice(36):performClickableAction(3015, 0) end
canOpsTable[RCVR_OPEN] = function() GetDevice(36):performClickableAction(3016, 0) end
canOpsTable[RCVR_CLOSE] = function() GetDevice(36):performClickableAction(3016, 1) end

-- AUX LIGHTS -- LRU_PNL_0252
canOpsTable[NVIS_LIGHTS_TOP] = function() GetDevice(49):performClickableAction(3017, 0.2) end
canOpsTable[NVIS_LIGHTS_ALL] = function() GetDevice(49):performClickableAction(3017, 0.1) end
canOpsTable[NVIS_LIGHTS_OFF] = function() GetDevice(49):performClickableAction(3017, 0.0) end
canOpsTable[HARS_SAS_SWITCH_NORM] = function() GetDevice(38):performClickableAction(3031, 0) end
canOpsTable[HARS_SAS_SWITCH_OVERRIDE] = function() GetDevice(38):performClickableAction(3031, 1) end
canOpsTable[SIGNAL_LIGHTS_TEST_OFF] = function() GetDevice(24):performClickableAction(3002, 0) end
canOpsTable[SIGNAL_LIGHTS_TEST_ON] = function() GetDevice(24):performClickableAction(3002, 1) end
canOpsTable[BLEED_AIR_TEST_OFF] = function() GetDevice(24):performClickableAction(3004, 0) end
canOpsTable[BLEED_AIR_TEST_ON] = function() GetDevice(24):performClickableAction(3004, 1) end
-- elements["PTR-ALCP-RSIL"]	= default_axis(_("Refuel Status Indexer Lights"), devices.LIGHT_SYSTEM, device_commands.Button_15, 193, 0.0)
-- elements["PTR-ALCP-WPNSTA"]	= default_axis(_("Weapon Station Lights. No function"), devices.LIGHT_SYSTEM, device_commands.Button_16, 195, 0.0) -- No function in A-10C

-- THROTTLE PANEL -- LRU_PNL_0253
-- elements["PTR-LG-WRN-SILENCE"]		= default_button(_("Landing Gear Horn Silence Button"),devices.SYS_CONTROLLER,device_commands.Button_3,127)

-- YAW / SAS PANEL -- LRU_PNL_0254
canOpsTable[YAW_SAS_L_ENGAGE] = function() GetDevice(38):performClickableAction(3003, 1) end
canOpsTable[YAW_SAS_L_OFF] = function() GetDevice(38):performClickableAction(3003, 0) end
canOpsTable[YAW_SAS_R_ENGAGE] = function() GetDevice(38):performClickableAction(3005, 1) end
canOpsTable[YAW_SAS_R_OFF] = function() GetDevice(38):performClickableAction(3005, 0) end
canOpsTable[PITCH_SAS_L_ENGAGE] = function() GetDevice(38):performClickableAction(3007, 1) end
canOpsTable[PITCH_SAS_L_OFF] = function() GetDevice(38):performClickableAction(3007, 0) end
canOpsTable[PITCH_SAS_R_ENGAGE] = function() GetDevice(38):performClickableAction(3009, 1) end
canOpsTable[PITCH_SAS_R_OFF] = function() GetDevice(38):performClickableAction(3009, 0) end
--canOpsTable[YAW_TRIM] = function() GetDevice(38):performClickableAction(3013, 0) end
--canOpsTable[YAW_TRIM] = function() GetDevice(38):performClickableAction(3014, 0) end
canOpsTable[SAS_MONITOR_TEST_L] = function() GetDevice(38):performClickableAction(3011, 1) end
canOpsTable[SAS_MONITOR_TEST_OFF] = function() GetDevice(38):performClickableAction(3011, 0) end
canOpsTable[SAS_MONITOR_TEST_R] = function() GetDevice(38):performClickableAction(3011, -1) end
canOpsTable[TAKE_OFF_TRIM_BTTN_PUSHED] = function() GetDevice(38):performClickableAction(3012, 1) end
canOpsTable[TAKE_OFF_TRIM_BTTN_RELEASED] = function() GetDevice(38):performClickableAction(3012, 0) end

--canOpsTable[0xBEEF] = function(val) TO CHECK !!
--	if(val < 2048) then GetDevice(38):performClickableAction(3013, -1 + (val / 2048)) end
--	if(val > 2048) then GetDevice(38):performClickableAction(3014, -1 + ((val-2048) / 2048)) end
--end

-- LASTE PANEL -- LRU_PNL_0255
canOpsTable[AUTOPILOT_EAC_OFF] = function() GetDevice(38):performClickableAction(3026, 0) end
canOpsTable[AUTOPILOT_EAC_ARM] = function() GetDevice(38):performClickableAction(3026, 1) end
canOpsTable[AUTOPILOT_RALT_DIS] = function() GetDevice(67):performClickableAction(3001, 0) end
canOpsTable[AUTOPILOT_RALT_NRM] = function() GetDevice(67):performClickableAction(3001, 1) end
canOpsTable[AUTOPILOT_OFF] = function() GetDevice(38):performClickableAction(3002, 0) end -- firmware check only push sw2p
canOpsTable[AUTOPILOT_ON] = function() GetDevice(38):performClickableAction(3002, 1) end -- firmware check only push sw2p
canOpsTable[AUTOPILOT_PATH] = function() GetDevice(38):performClickableAction(3001, 1) end
canOpsTable[AUTOPILOT_ALT_HDG] = function() GetDevice(38):performClickableAction(3001, 0) end
canOpsTable[AUTOPILOT_ALT] = function() GetDevice(38):performClickableAction(3001, -1) end

-- IFF PANEL -- LRU_PNL_0256
--elements["PTR-IFFCP-CODE"]				= IFF_multiposition_spring_switch(_("Code"), devices.IFF, device_commands.Button_7,199)
--elements["PTR-IFFCP-MASTER"]			= multiposition_switch(_("Master"), devices.IFF, device_commands.Button_8, 200, 5, 0.1)
--elements["PTR-IFFCP-OUT-AUDIO-LIGHT"]	= default_3_position_tumb(_("Audio/light") ,devices.IFF,device_commands.Button_9,201)
--elements["PTR-IFFCP-TEST-M-1"]			= default_springloaded_switch(_("Test M-1") ,devices.IFF,device_commands.Button_10,device_commands.Button_10,-1,0,1,202)
--elements["PTR-IFFCP-TEST-M-2"]			= default_springloaded_switch(_("Test M-2") ,devices.IFF,device_commands.Button_11,device_commands.Button_11,-1,0,1,203)
--elements["PTR-IFFCP-TEST-M-3A"]			= default_springloaded_switch(_("Test M-3A") ,devices.IFF,device_commands.Button_12,device_commands.Button_12,-1,0,1,204)
--elements["PTR-IFFCP-TEST-M-C"]			= default_springloaded_switch(_("Test M-C") ,devices.IFF,device_commands.Button_13,device_commands.Button_13,-1,0,1,205)
--elements["PTR-IFFCP-RADTEST"]			= default_springloaded_switch(_("RAD Test/Mon") ,devices.IFF,device_commands.Button_14,device_commands.Button_14,-1,0,1,206)
--elements["PTR-IFFCP-ON-OUT"]			= default_2_position_tumb(_("IFF On/Out") ,devices.IFF,device_commands.Button_16,208)
--elements["PTR-IFFCP-MIC-IDENT"]			= default_springloaded_switch(_("Ident/Mic") ,devices.IFF,device_commands.Button_15,device_commands.Button_15,-1,0,1,207)
--elements["PTR-IFFCP-MODE1-WHEEL1"]		= multiposition_switch(_("MODE1-WHEEL1") ,devices.IFF,device_commands.Button_1,209,8,0.1)
--elements["PTR-IFFCP-MODE1-WHEEL2"]		= multiposition_switch(_("MODE1-WHEEL2") ,devices.IFF,device_commands.Button_2,210,4,0.1)
--elements["PTR-IFFCP-MODE3A-WHEEL1"]		= multiposition_switch(_("MODE3A-WHEEL1"),devices.IFF,device_commands.Button_3,211,8,0.1)
--elements["PTR-IFFCP-MODE3A-WHEEL2"]		= multiposition_switch(_("MODE3A-WHEEL2"),devices.IFF,device_commands.Button_4,212,8,0.1)
--elements["PTR-IFFCP-MODE3A-WHEEL3"]		= multiposition_switch(_("MODE3A-WHEEL3"),devices.IFF,device_commands.Button_5,213,8,0.1)
--elements["PTR-IFFCP-MODE3A-WHEEL4"]		= multiposition_switch(_("MODE3A-WHEEL4"),devices.IFF,device_commands.Button_6,214,8,0.1)
--elements["PTR-BTN-PANIFF-REPLY"]		= default_button_axis(_("Reply test"),devices.IFF,device_commands.Button_17,device_commands.Button_20,795,900)
--elements["PTR-BTN-PANIFF-TEST"]			= default_button_axis(_("Test test"),devices.IFF,device_commands.Button_18,device_commands.Button_21,796,901)

-- UHF PANEL -- LRU_PNL_0257
--elements["PTR-ANARC164-CHANNEL-SELECTOR"] 	= multiposition_switch_limited(_("Preset Channel Selector"), devices.UHF_RADIO, device_commands.Button_1, 161,20,0.05)
--elements["PTR-ANARC164-100MHZ-SELECTOR"] 	= multiposition_switch_limited(_("100 MHz Selector") , devices.UHF_RADIO, device_commands.Button_2, 162, 3, 0.1)
--elements["PTR-ANARC164-10MHZ-SELECTOR"] 	= multiposition_switch_limited(_("10 MHz Selector"), devices.UHF_RADIO, device_commands.Button_3, 163, 10, 0.1)
--elements["PTR-ANARC164-1MHZ-SELECTOR"] 		= multiposition_switch_limited(_("1 MHz Selector"), devices.UHF_RADIO, device_commands.Button_4, 164, 10, 0.1)
--elements["PTR-ANARC164-0.1MHZ-SELECTOR"] 	= multiposition_switch_limited(_("0.1 MHz Selector"), devices.UHF_RADIO, device_commands.Button_5, 165, 10, 0.1)
--elements["PTR-ANARC164-0.025MHZ-SELECTOR"] 	= multiposition_switch_limited(_("0.025 MHz Selector"), devices.UHF_RADIO, device_commands.Button_6, 166, 4, 0.1)
--elements["PTR-ANARC164-FREQMODE"] = multiposition_switch(_("Frequency Mode Dial") , devices.UHF_RADIO, device_commands.Button_7, 167, 3, 0.1)
--elements["PTR-ANARC164-FUNCTION"] = multiposition_switch(_("Function Dial") , devices.UHF_RADIO, device_commands.Button_8, 168, 4, 0.1)
--elements["PTR-ANARC164-T-TONE"]	= {class = {class_type.BTN,class_type.BTN}	, hint  = _("T-Tone"), device = devices.UHF_RADIO, action = {device_commands.Button_9 ,device_commands.Button_9}, stop_action = {device_commands.Button_9,device_commands.Button_9}, arg = {169,169}, arg_value = {-1,1}, arg_lim = {{-1, 0},{0, 1}}}
--elements["PTR-ANARC164-SQUELCH"] = default_2_position_tumb(_("Squelch"), devices.UHF_RADIO, device_commands.Button_10, 170)
--elements["PTR-ANARC164-VOLUME"] = default_axis(_("Volume"), devices.UHF_RADIO, device_commands.Button_11, 171)
--elements["PTR-ANARC164-TEST-DISPLAY"] = default_button(_("Test Display"), devices.UHF_RADIO, device_commands.Button_12, 172, 1, {0, 1})
--elements["PTR-ANARC164-STATUS"] = default_button(_("Status"), devices.UHF_RADIO, device_commands.Button_13, 173, 1, {0, 1})
--elements["PTR-ANARC164-LOAD"] = default_button(_("Load button"), devices.UHF_RADIO, device_commands.Button_15, 735, 1, {0, 1})
--elements["PTR-ANARC164-COVER"]		= 	{class  	= {class_type.TUMB,class_type.TUMB},hint   	= _("Cover"), device 	= devices.UHF_RADIO,action 	= {device_commands.Button_14,device_commands.Button_14},arg 		= {734,734},arg_value 	= {1,-1},arg_lim 	= {{0,1},{0,1}},updatable  = true, gain 		= {0.1,0.1},animated 	= {true,true},animation_speed = {5.5,5.5},cycle = true}

-- EMERGENCY FLIGHT CONTROL PANEL -- LRU_PNL_0258
canOpsTable[SPEED_BRK_EMER_RETR_ON] = function() GetDevice(38):performClickableAction(3015, 1) end
canOpsTable[SPEED_BRK_EMER_RETR_OFF] = function() GetDevice(38):performClickableAction(3015,0) end
canOpsTable[PITCH_ROLL_TRIM_NORM] = function() GetDevice(38):performClickableAction(3016, 1) end
canOpsTable[PITCH_ROLL_TRIM_OVERRIDE] = function() GetDevice(38):performClickableAction(3016, 0) end
canOpsTable[TRIM_BUTTON_NOSE_DN_EXECUTE] = function() GetDevice(38):performClickableAction(3020, 0.1) end
canOpsTable[TRIM_BUTTON_NOSE_DN_STOP] = function() GetDevice(38):performClickableAction(3025, 0) end
canOpsTable[TRIM_BUTTON_R_WING_DN_EXECUTE] = function() GetDevice(38):performClickableAction(3018, 0.2) end
canOpsTable[TRIM_BUTTON_R_WING_DN_STOP] = function() GetDevice(38):performClickableAction(3025, 0) end
canOpsTable[TRIM_BUTTON_NOSE_UP_EXECUTE] = function() GetDevice(38):performClickableAction(3019, 0.3) end
canOpsTable[TRIM_BUTTON_NOSE_UP_STOP] = function() GetDevice(38):performClickableAction(3025, 0) end
canOpsTable[TRIM_BUTTON_L_WING_DN_EXECUTE] = function() GetDevice(38):performClickableAction(3020, 0.4) end
canOpsTable[TRIM_BUTTON_L_WING_DN_STOP] = function() GetDevice(38):performClickableAction(3025, 0) end
canOpsTable[AILERON_EMERG_DISENG_L] = function() GetDevice(38):performClickableAction(3021, 1) end
canOpsTable[AILERON_EMERG_DISENG_STOP] = function() GetDevice(38):performClickableAction(3021, 0) end
canOpsTable[AILERON_EMERG_DISENG_R] = function() GetDevice(38):performClickableAction(3021, -1) end
canOpsTable[ELEVATOR_EMERG_DISENG_L] = function() GetDevice(38):performClickableAction(3022, 1) end
canOpsTable[ELEVATOR_EMERG_DISENG_STOP] = function() GetDevice(38):performClickableAction(3022, 0) end
canOpsTable[ELEVATOR_EMERG_DISENG_R] = function() GetDevice(38):performClickableAction(3022, -1) end
canOpsTable[FLAPS_EMERG_RETRACT_ON] = function() GetDevice(38):performClickableAction(3023, 1) end
canOpsTable[FLAPS_EMERG_RETRACT_OFF] = function() GetDevice(38):performClickableAction(3023, 0) end
canOpsTable[MRFC_PITCH_YAW_CTRL_NORM] = function() GetDevice(38):performClickableAction(3024, 1) end
canOpsTable[MRFC_PITCH_YAW_CTRL_MAN_REV] = function() GetDevice(38):performClickableAction(3024, 0) end

-- VHF Radio CHECK PANELS -- LRU_PNL_0259 / LRU_PNL_0261
--elements["PTR-ANARC186-VHFAM-PRESET"] = { class  		 = {class_type.TUMB, class_type.TUMB},  hint   		 = _("Preset Channel Selector"),device 		 = devices.VHF_AM_RADIO,action 		 = {device_commands.Button_1, device_commands.Button_2}, arg 			 = {137, 137},arg_value 		 = {0.01, -0.01},arg_lim   		 = {{0, 0.2}, {0, 0.2}},relative		 = {true, true},animated        = {true, true},animation_speed = {0.05, 0.05}}
--elements["PTR-ANARC186-VHFAM-MODE"] 			= multiposition_switch(_("Frequency Mode Dial") , devices.VHF_AM_RADIO, device_commands.Button_3, 138, 3, 0.1)
--elements["PTR-ANARC186-VHFAM-FREQEMER-CONTROL"] = multiposition_switch(_("Frequency Selection Dial") , devices.VHF_AM_RADIO, device_commands.Button_4, 135, 4, 0.1)
--elements["PTR-ANARC186-VHFAM-VOLUME"]			= default_axis(_("Volume"), devices.VHF_AM_RADIO, device_commands.Button_5, 133)
--elements["PTR-ANARC186-VHFAM-LOAD"]			 	= default_button(_("Load"), devices.VHF_AM_RADIO, device_commands.Button_6, 136, 1, {0, 1})
--elements["PTR-ANARC186-VHFAM-SQUELCH"] = {class  		 = {class_type.TUMB, class_type.BTN}, hint   		 = _("Squelch / TONE"),device 		 = devices.VHF_AM_RADIO,action 		 = {device_commands.Button_7, device_commands.Button_8}, stop_action  = {0, device_commands.Button_8}, arg 		 = {134, 134},arg_value 	 = {1, 1},arg_lim   	 = {{-1, 0}, {0, 1}},use_release_message = {false, true}}
--elements["PTR-ANARC186-VHFAM-FREQ-1"] = radio_wheel(_("Frequency Selector the 1nd"), devices.VHF_AM_RADIO, device_commands.Button_9, device_commands.Button_10, 139,{-0.1, 0.1}, 143,{0.125,0.775},0.5)
--elements["PTR-ANARC186-VHFAM-FREQ-2"] = radio_wheel(_("Frequency Selector the 2nd"), devices.VHF_AM_RADIO, device_commands.Button_11, device_commands.Button_12, 140,{-0.1, 0.1}, 144,{0.0,1.0},1.0)
--elements["PTR-ANARC186-VHFAM-FREQ-3"] = radio_wheel(_("Frequency Selector the 3rd"), devices.VHF_AM_RADIO, device_commands.Button_13, device_commands.Button_14, 141,{-0.1, 0.1}, 145,{0.0,1.0},1.0)
--elements["PTR-ANARC186-VHFAM-FREQ-4"] = radio_wheel(_("Frequency Selector the 4th"), devices.VHF_AM_RADIO, device_commands.Button_15, device_commands.Button_16, 142,{-0.25, 0.25}, 146,{0.0,1.0},1.0)

-- VHF FM
--elements["PTR-ANARC186-VHFFM-PRESET"] = {class  		 = {class_type.TUMB, class_type.TUMB}, hint   		 = _("Preset Channel Selector"),device 		 = devices.VHF_FM_RADIO,action 		 = {device_commands.Button_1, device_commands.Button_2}, arg 			 = {151, 151},arg_value 		 = {0.01, -0.01},arg_lim   		 = {{0, 0.199}, {0, 0.199}},relative		 = {true, true},animated        = {true, true},animation_speed = {0.05, 0.05}}
--elements["PTR-ANARC186-VHFFM-FREQ-1"] = radio_wheel(_("Frequency Selector the 1nd"), devices.VHF_FM_RADIO, device_commands.Button_9, device_commands.Button_10, 153,{-0.1, 0.1}, 157,{0.125,0.775},0.5)
--elements["PTR-ANARC186-VHFFM-FREQ-2"] = radio_wheel(_("Frequency Selector the 2nd"), devices.VHF_FM_RADIO, device_commands.Button_11, device_commands.Button_12, 154,{-0.1, 0.1}, 158,{0.0,1.0},1.0)
--elements["PTR-ANARC186-VHFFM-FREQ-3"] = radio_wheel(_("Frequency Selector the 3rd"), devices.VHF_FM_RADIO, device_commands.Button_13, device_commands.Button_14, 155,{-0.1, 0.1}, 159,{0.0,1.0},1.0)
--elements["PTR-ANARC186-VHFFM-FREQ-4"] = radio_wheel(_("Frequency Selector the 4th"), devices.VHF_FM_RADIO, device_commands.Button_15, device_commands.Button_16, 156,{-0.25, 0.25}, 160,{0.0,1.0},1.0)
--elements["PTR-ANARC186-VHFFM-MODE"] = multiposition_switch(_("Frequency Mode Dial") , devices.VHF_FM_RADIO, device_commands.Button_3, 152, 3, 0.1)
--elements["PTR-ANARC186-VHFFM-FREQEMER-CONTROL"] = multiposition_switch(_("Frequency Selection Dial") , devices.VHF_FM_RADIO, device_commands.Button_4, 149, 4, 0.1)
--elements["PTR-ANARC186-VHFFM-VOLUME"] = default_axis(_("Volume"), devices.VHF_FM_RADIO, device_commands.Button_5, 147)
--elements["PTR-ANARC186-VHFFM-LOAD"] = default_button(_("Load"), devices.VHF_FM_RADIO, device_commands.Button_6, 150, 1, {0, 1})
--elements["PTR-ANARC186-VHFFM-SQUELCH"] = {class  		 = {class_type.TUMB, class_type.BTN}, hint   		 = _("Squelch / TONE"),device 		 = devices.VHF_FM_RADIO,action 		 = {device_commands.Button_7, device_commands.Button_8}, stop_action  = {0, device_commands.Button_8}, arg 		 = {148, 148},arg_value 	 = {1, 1},arg_lim   	 = {{-1, 0}, {0, 1}},use_release_message = {false, true}}

-- INTERCOM PANEL -- LRU_PNL_0260 --
--elements["PTR-INTERCOM-INT"]	= intercom_rotate_tumb(_("INT Switch"),devices.INTERCOM,device_commands.Button_1,device_commands.Button_2, 222, 221)
--elements["PTR-INTERCOM-FM"]		= intercom_rotate_tumb(_("FM Switch"),devices.INTERCOM,device_commands.Button_3,device_commands.Button_4, 224, 223)
--elements["PTR-INTERCOM-VHF"]	= intercom_rotate_tumb(_("VHF Switch"),devices.INTERCOM,device_commands.Button_5,device_commands.Button_6, 226, 225)
--elements["PTR-INTERCOM-UHF"]	= intercom_rotate_tumb(_("UHF Switch"),devices.INTERCOM,device_commands.Button_7,device_commands.Button_8, 228, 227)
--elements["PTR-INTERCOM-AIM"]	= intercom_rotate_tumb(_("AIM Switch"),devices.INTERCOM,device_commands.Button_9,device_commands.Button_10, 230, 229)
--elements["PTR-INTERCOM-IFF"]	= intercom_rotate_tumb(_("IFF Switch"),devices.INTERCOM,device_commands.Button_11,device_commands.Button_12, 232, 231)
--elements["PTR-INTERCOM-ILS"]	= intercom_rotate_tumb(_("ILS Switch"),devices.INTERCOM,device_commands.Button_13,device_commands.Button_14, 234, 233)
--elements["PTR-INTERCOM-TCN"]	= intercom_rotate_tumb(_("TCN Switch"),devices.INTERCOM,device_commands.Button_15,device_commands.Button_16, 236, 235)
--elements["PTR-INTERCOM-HM"]		= default_2_position_tumb(_("HM Switch"),devices.INTERCOM,device_commands.Button_17,237)
--elements["PTR-INTERCOM-VOL"]	= default_axis(_("Intercom volume"),devices.INTERCOM,device_commands.Button_18,238)
--elements["PTR-INTERCOM-MODE"] 	= multiposition_switch_intercom(_("Selector switch") , devices.INTERCOM, device_commands.Button_19, 239, 5, 0.1)
--elements["PTR-INTERCOM-CALL"] 	= default_button(_("Call button"), devices.INTERCOM, device_commands.Button_20, 240,1, {0,1})

canOpsTable[ENABLE_INT] = function() GetDevice(58):performClickableAction(3001, 1) end 
canOpsTable[DISABLE_INT] = function() GetDevice(58):performClickableAction(3001, 0) end 

canOpsTable[ENABLE_FM] = function() GetDevice(58):performClickableAction(3003, 1) end 
canOpsTable[DISABLE_FM] = function() GetDevice(58):performClickableAction(3003, 0) end 

canOpsTable[ENABLE_VHF] = function() GetDevice(58):performClickableAction(3005, 1) end 
canOpsTable[DISABLE_VHF] = function() GetDevice(58):performClickableAction(3005, 0) end 

canOpsTable[ENABLE_UHF] = function() GetDevice(58):performClickableAction(3007, 1) end 
canOpsTable[DISABLE_UHF] = function() GetDevice(58):performClickableAction(3007, 0) end 

canOpsTable[ENABLE_AIM] = function() GetDevice(58):performClickableAction(3009, 1) end 
canOpsTable[DISABLE_AIM] = function() GetDevice(58):performClickableAction(3009, 0) end 

canOpsTable[ENABLE_IFF] = function() GetDevice(58):performClickableAction(3011, 1) end 
canOpsTable[DISABLE_IFF] = function() GetDevice(58):performClickableAction(3011, 0) end 

canOpsTable[ENABLE_ILS] = function() GetDevice(58):performClickableAction(3013, 1) end 
canOpsTable[DISABLE_ILS] = function() GetDevice(58):performClickableAction(3013, 0) end 

canOpsTable[ENABLE_TCN] = function() GetDevice(58):performClickableAction(3015, 1) end 
canOpsTable[DISABLE_TCN] = function() GetDevice(58):performClickableAction(3015, 0) end 

canOpsTable[ENABLE_HM] = function() GetDevice(58):performClickableAction(3017, 1) end 
canOpsTable[DISABLE_HM] = function() GetDevice(58):performClickableAction(3017, 0) end 

canOpsTable[0xA005] = function(value) --INTERCOM_VOLUME_GENERAL
	local arg = value/670
	if(arg>1) then arg = 1 end
GetDevice(58):performClickableAction(3018,arg)
end


canOpsTable[INTERCOM_MODE_HF] = function() GetDevice(58):performClickableAction(3019, .3) end 
canOpsTable[INTERCOM_MODE_VHF] = function() GetDevice(58):performClickableAction(3019, .2) end 
canOpsTable[INTERCOM_MODE_FM] = function() GetDevice(58):performClickableAction(3019, .1) end 
canOpsTable[INTERCOM_MODE_INT] = function() GetDevice(58):performClickableAction(3019, 0) end 

canOpsTable[GENERAL_CALL_ON] = function() GetDevice(58):performClickableAction(3020, 1) end 
canOpsTable[GENERAL_CALL_OFF] = function() GetDevice(58):performClickableAction(3020, 0) end 
--]]
-- ANTENNA SELECT PANEL -- LRU_PNL_0262 --
canOpsTable[IFF_ANT_BOTH] = function() GetDevice(43):performClickableAction(3019, 0.5) end 
canOpsTable[IFF_ANT_UPPER] = function() GetDevice(43):performClickableAction(3019, 1) end 
canOpsTable[IFF_ANT_LOWER] = function() GetDevice(43):performClickableAction(3019, 0) end 
canOpsTable[SAT_ANT_OFF] = function() GetDevice(54):performClickableAction(3016, 0.5) end 
canOpsTable[SAT_ANT_HIGH] = function() GetDevice(54):performClickableAction(3016, 1) end 
canOpsTable[SAT_ANT_LOW] = function() GetDevice(54):performClickableAction(3016, 0) end 
canOpsTable[EGI_HQ_TOD_ARC_164] = function() GetDevice(54):performClickableAction(3017, 0) end
canOpsTable[EGI_HQ_TOD_ARC_210] = function() GetDevice(54):performClickableAction(3017, 1) end

-- SECURE VOICE COMMS PANEL -- LRU_PNL_0263 --
canOpsTable[SECURE_VOICE_CONTROL_ZEROIZE_ON] = function() GetDevice(69):performClickableAction(3002, 1) end
canOpsTable[SECURE_VOICE_CONTROL_ZEROIZE_OFF] = function() GetDevice(69):performClickableAction(3002, 0) end
canOpsTable[SECURE_VOICE_CONTROL_RADIO_SELECT_CRAD1] = function() GetDevice(69):performClickableAction(3004, 0.0) end 
canOpsTable[SECURE_VOICE_CONTROL_RADIO_SELECT_PLAIN] = function() GetDevice(69):performClickableAction(3004, 0.1) end 
canOpsTable[SECURE_VOICE_CONTROL_RADIO_SELECT_CRAD2] = function() GetDevice(69):performClickableAction(3004, 0.2) end 
canOpsTable[SECURE_VOICE_CONTROL_MODE_OP] = function() GetDevice(69):performClickableAction(3006, 0.0) end 
canOpsTable[SECURE_VOICE_CONTROL_MODE_LD] = function() GetDevice(69):performClickableAction(3006, 0.1) end 
canOpsTable[SECURE_VOICE_CONTROL_MODE_RV] = function() GetDevice(69):performClickableAction(3006, 0.2) end 
canOpsTable[SECURE_VOICE_CONTROL_DELAY_ON] = function() GetDevice(69):performClickableAction(3003, 1) end 
canOpsTable[SECURE_VOICE_CONTROL_DELAY_OFF] = function() GetDevice(69):performClickableAction(3003, 0) end 
canOpsTable[SECURE_VOICE_CONTROL_ENCRYPTION_CODE1] = function() GetDevice(69):performClickableAction(3005, 0.0) end 
canOpsTable[SECURE_VOICE_CONTROL_ENCRYPTION_CODE2] = function() GetDevice(69):performClickableAction(3005, 0.1) end 
canOpsTable[SECURE_VOICE_CONTROL_ENCRYPTION_CODE3] = function() GetDevice(69):performClickableAction(3005, 0.2) end 
canOpsTable[SECURE_VOICE_CONTROL_ENCRYPTION_CODE4] = function() GetDevice(69):performClickableAction(3005, 0.3) end 
canOpsTable[SECURE_VOICE_CONTROL_ENCRYPTION_CODE5] = function() GetDevice(69):performClickableAction(3005, 0.4) end
canOpsTable[SECURE_VOICE_CONTROL_ENCRYPTION_CODE6] = function() GetDevice(69):performClickableAction(3005, 0.5) end
canOpsTable[SECURE_VOICE_CONTROL_POWER_ON] = function() GetDevice(69):performClickableAction(3007, 1) end 
canOpsTable[SECURE_VOICE_CONTROL_POWER_OFF] = function() GetDevice(69):performClickableAction(3007, 0) end 

-- STALL PANEL -- LRU_PNL_0264 --
--elements["PTR-STALLWCP-STALL"] 				= default_axis(_("Stall Volume"), devices.STALL, device_commands.Button_1, 704)
--elements["PTR-STALLWCP-PEAK"] 				= default_axis(_("Peak Volume"), devices.STALL, device_commands.Button_2, 705)

-- CMSP PANEL -- LRU_PNL_0265 --
canOpsTable[EW_OSB1_ON] = function() GetDevice(4):performClickableAction(3001, 1) end
canOpsTable[EW_OSB1_OFF] = function() GetDevice(4):performClickableAction(3001, 0) end
canOpsTable[EW_OSB2_ON] = function() GetDevice(4):performClickableAction(3002, 1) end
canOpsTable[EW_OSB2_OFF] = function() GetDevice(4):performClickableAction(3002, 0) end
canOpsTable[EW_OSB3_ON] = function() GetDevice(4):performClickableAction(3003, 1) end
canOpsTable[EW_OSB3_OFF] = function() GetDevice(4):performClickableAction(3003, 0) end
canOpsTable[EW_OSB4_ON] = function() GetDevice(4):performClickableAction(3004, 1) end
canOpsTable[EW_OSB4_OFF] = function() GetDevice(4):performClickableAction(3004, 0) end
canOpsTable[EW_NXT_UP_ON] = function() GetDevice(4):performClickableAction(3005, 1) end
canOpsTable[EW_NXT_UP_OFF] = function() GetDevice(4):performClickableAction(3005, 0) end
canOpsTable[EW_NXT_DOWN_ON] = function() GetDevice(4):performClickableAction(3006, -1) end
canOpsTable[EW_NXT_DOWN_OFF] = function() GetDevice(4):performClickableAction(3006, 0) end
canOpsTable[EW_RTN_ON] = function() GetDevice(4):performClickableAction(3007, 1) end
canOpsTable[EW_RTN_OFF] = function() GetDevice(4):performClickableAction(3007, 0) end
canOpsTable[EW_JTSN_ON] = function() GetDevice(4):performClickableAction(3008, 1) end
canOpsTable[EW_JTSN_OFF] = function() GetDevice(4):performClickableAction(3008, 0) end
canOpsTable[EW_MWS_UP] = function() GetDevice(4):performClickableAction(3010, 0.2) end
canOpsTable[EW_MWS_CENTER] = function() GetDevice(4):performClickableAction(3010, 0.1) end
canOpsTable[EW_MWS_DOWN] = function() GetDevice(4):performClickableAction(3010, 0.0) end
canOpsTable[EW_JMR_UP] = function() GetDevice(4):performClickableAction(3012, 0.2) end
canOpsTable[EW_JMR_CENTER] = function() GetDevice(4):performClickableAction(3012, 0.1) end
canOpsTable[EW_JMR_DOWN] = function() GetDevice(4):performClickableAction(3012, 0.0) end
canOpsTable[EW_RWR_UP] = function() GetDevice(4):performClickableAction(3014, 0.2) end
canOpsTable[EW_RWR_CENTER] = function() GetDevice(4):performClickableAction(3014, 0.1) end
canOpsTable[EW_RWR_DOWN] = function() GetDevice(4):performClickableAction(3014, 0.0) end
canOpsTable[EW_DISP_UP] = function() GetDevice(4):performClickableAction(3016, 0.2) end
canOpsTable[EW_DISP_CENTER] = function() GetDevice(4):performClickableAction(3016, 0.1) end
canOpsTable[EW_DISP_DOWN] = function() GetDevice(4):performClickableAction(3016, 0.0) end
canOpsTable[EW_MODE_OFF] = function() GetDevice(4):performClickableAction(3018, 0.0) end
canOpsTable[EW_MODE_STBY] = function() GetDevice(4):performClickableAction(3018, 0.1) end
canOpsTable[EW_MODE_MAN] = function() GetDevice(4):performClickableAction(3018, 0.2) end
canOpsTable[EW_MODE_SEMI] = function() GetDevice(4):performClickableAction(3018, 0.3) end
canOpsTable[EW_MODE_AUTO] = function() GetDevice(4):performClickableAction(3018, 0.4) end

-- ANNUNCIATOR PANEL -- LRU_PNL_0267 -- ON LIGHTS EXPORT SECTION

-- ELECTRICAL PANEL -- LRU_PNL_0268 --
canOpsTable[APU_GENERATOR_OFF] = function() GetDevice(1):performClickableAction(3001, 0) end
canOpsTable[APU_GENERATOR_ON] = function() GetDevice(1):performClickableAction(3001, 1) end
canOpsTable[INVERTER_OFF] = function() GetDevice(1):performClickableAction(3002, 0) end
canOpsTable[INVERTER_STANDBY] = function() GetDevice(1):performClickableAction(3002, 1) end
canOpsTable[INVERTER_TEST] = function() GetDevice(1):performClickableAction(3002, -1) end
canOpsTable[AC_GENERATION_LEFT_OFF] = function() GetDevice(1):performClickableAction(3004, 0) end
canOpsTable[AC_GENERATION_LEFT_ON] = function() GetDevice(1):performClickableAction(3004, 1) end
canOpsTable[AC_GENERATION_RIGHT_OFF] = function() GetDevice(1):performClickableAction(3005, 0) end
canOpsTable[AC_GENERATION_RIGHT_ON] = function() GetDevice(1):performClickableAction(3005, 1) end
canOpsTable[BATTERY_POWER_OFF] = function() GetDevice(1):performClickableAction(3006, 0) end
canOpsTable[BATTERY_POWER_ON] = function() GetDevice(1):performClickableAction(3006, 1) end
canOpsTable[EMERGENCY_FLOOD_OFF] = function() GetDevice(49):performClickableAction(3007, 0) end
canOpsTable[EMERGENCY_FLOOD_ON] = function() GetDevice(49):performClickableAction(3007, 1) end

-- CDU -- LRU_PNL_0269 --
canOpsTable[CDU_OSB_L0_OFF] = function() GetDevice(9):performClickableAction(3001, 0) end
canOpsTable[CDU_OSB_L0_ON] = function() GetDevice(9):performClickableAction(3001, 1) end
canOpsTable[CDU_OSB_L1_OFF] = function() GetDevice(9):performClickableAction(3002, 0) end
canOpsTable[CDU_OSB_L1_ON] = function() GetDevice(9):performClickableAction(3002, 1) end
canOpsTable[CDU_OSB_L2_OFF] = function() GetDevice(9):performClickableAction(3003, 0) end
canOpsTable[CDU_OSB_L2_ON] = function() GetDevice(9):performClickableAction(3003, 1) end
canOpsTable[CDU_OSB_L3_OFF] = function() GetDevice(9):performClickableAction(3004, 0) end
canOpsTable[CDU_OSB_L3_ON] = function() GetDevice(9):performClickableAction(3004, 1) end
canOpsTable[CDU_OSB_R0_OFF] = function() GetDevice(9):performClickableAction(3005, 0) end
canOpsTable[CDU_OSB_R0_ON] = function() GetDevice(9):performClickableAction(3005, 1) end
canOpsTable[CDU_OSB_R1_OFF] = function() GetDevice(9):performClickableAction(3006, 0) end
canOpsTable[CDU_OSB_R1_ON] = function() GetDevice(9):performClickableAction(3006, 1) end
canOpsTable[CDU_OSB_R2_OFF] = function() GetDevice(9):performClickableAction(3007, 0) end
canOpsTable[CDU_OSB_R2_ON] = function() GetDevice(9):performClickableAction(3007, 1) end
canOpsTable[CDU_OSB_R3_OFF] = function() GetDevice(9):performClickableAction(3008, 0) end
canOpsTable[CDU_OSB_R3_ON] = function() GetDevice(9):performClickableAction(3008, 1) end
canOpsTable[CDU_OSB_SYS_OFF] = function() GetDevice(9):performClickableAction(3009, 0) end
canOpsTable[CDU_OSB_SYS_ON] = function() GetDevice(9):performClickableAction(3009, 1) end
canOpsTable[CDU_OSB_NAV_OFF] = function() GetDevice(9):performClickableAction(3010, 0) end
canOpsTable[CDU_OSB_NAV_ON] = function() GetDevice(9):performClickableAction(3010, 1) end
canOpsTable[CDU_OSB_WP_OFF] = function() GetDevice(9):performClickableAction(3011, 0) end
canOpsTable[CDU_OSB_WP_ON] = function() GetDevice(9):performClickableAction(3011, 1) end
canOpsTable[CDU_OSB_OSET_OFF] = function() GetDevice(9):performClickableAction(3012, 0) end
canOpsTable[CDU_OSB_OSET_ON] = function() GetDevice(9):performClickableAction(3012, 1) end
canOpsTable[CDU_OSB_FPM_OFF] = function() GetDevice(9):performClickableAction(3013, 0) end
canOpsTable[CDU_OSB_FPM_ON] = function() GetDevice(9):performClickableAction(3013, 1) end
canOpsTable[CDU_OSB_PREV_OFF] = function() GetDevice(9):performClickableAction(3014, 0) end
canOpsTable[CDU_OSB_PREV_ON] = function() GetDevice(9):performClickableAction(3014, 1) end
canOpsTable[CDU_OSB_1_OFF] = function() GetDevice(9):performClickableAction(3015, 0) end
canOpsTable[CDU_OSB_1_ON] = function() GetDevice(9):performClickableAction(3015, 1) end
canOpsTable[CDU_OSB_2_OFF] = function() GetDevice(9):performClickableAction(3016, 0) end
canOpsTable[CDU_OSB_2_ON] = function() GetDevice(9):performClickableAction(3016, 1) end
canOpsTable[CDU_OSB_3_OFF] = function() GetDevice(9):performClickableAction(3017, 0) end
canOpsTable[CDU_OSB_3_ON] = function() GetDevice(9):performClickableAction(3017, 1) end
canOpsTable[CDU_OSB_4_OFF] = function() GetDevice(9):performClickableAction(3018, 0) end
canOpsTable[CDU_OSB_4_ON] = function() GetDevice(9):performClickableAction(3018, 1) end
canOpsTable[CDU_OSB_5_OFF] = function() GetDevice(9):performClickableAction(3019, 0) end
canOpsTable[CDU_OSB_5_ON] = function() GetDevice(9):performClickableAction(3019, 1) end
canOpsTable[CDU_OSB_6_OFF] = function() GetDevice(9):performClickableAction(3020, 0) end
canOpsTable[CDU_OSB_6_ON] = function() GetDevice(9):performClickableAction(3020, 1) end
canOpsTable[CDU_OSB_7_OFF] = function() GetDevice(9):performClickableAction(3021, 0) end
canOpsTable[CDU_OSB_7_ON] = function() GetDevice(9):performClickableAction(3021, 1) end
canOpsTable[CDU_OSB_8_OFF] = function() GetDevice(9):performClickableAction(3022, 0) end
canOpsTable[CDU_OSB_8_ON] = function() GetDevice(9):performClickableAction(3022, 1) end
canOpsTable[CDU_OSB_9_OFF] = function() GetDevice(9):performClickableAction(3023, 0) end
canOpsTable[CDU_OSB_9_ON] = function() GetDevice(9):performClickableAction(3023, 1) end
canOpsTable[CDU_OSB_0_OFF] = function() GetDevice(9):performClickableAction(3024, 0) end
canOpsTable[CDU_OSB_0_ON] = function() GetDevice(9):performClickableAction(3024, 1) end
canOpsTable[CDU_OSB_DOT_OFF] = function() GetDevice(9):performClickableAction(3025, 0) end
canOpsTable[CDU_OSB_DOT_ON] = function() GetDevice(9):performClickableAction(3025, 1) end
canOpsTable[CDU_OSB_SLASH_OFF] = function() GetDevice(9):performClickableAction(3026, 0) end
canOpsTable[CDU_OSB_SLASH_ON] = function() GetDevice(9):performClickableAction(3026, 1) end
canOpsTable[CDU_OSB_A_OFF] = function() GetDevice(9):performClickableAction(3027, 0) end
canOpsTable[CDU_OSB_A_ON] = function() GetDevice(9):performClickableAction(3027, 1) end
canOpsTable[CDU_OSB_B_OFF] = function() GetDevice(9):performClickableAction(3028, 0) end
canOpsTable[CDU_OSB_B_ON] = function() GetDevice(9):performClickableAction(3028, 1) end
canOpsTable[CDU_OSB_C_OFF] = function() GetDevice(9):performClickableAction(3029, 0) end
canOpsTable[CDU_OSB_C_ON] = function() GetDevice(9):performClickableAction(3029, 1) end
canOpsTable[CDU_OSB_D_OFF] = function() GetDevice(9):performClickableAction(3030, 0) end
canOpsTable[CDU_OSB_D_ON] = function() GetDevice(9):performClickableAction(3030, 1) end
canOpsTable[CDU_OSB_E_OFF] = function() GetDevice(9):performClickableAction(3031, 0) end
canOpsTable[CDU_OSB_E_ON] = function() GetDevice(9):performClickableAction(3031, 1) end
canOpsTable[CDU_OSB_F_OFF] = function() GetDevice(9):performClickableAction(3032, 0) end
canOpsTable[CDU_OSB_F_ON] = function() GetDevice(9):performClickableAction(3032, 1) end
canOpsTable[CDU_OSB_G_OFF] = function() GetDevice(9):performClickableAction(3033, 0) end
canOpsTable[CDU_OSB_G_ON] = function() GetDevice(9):performClickableAction(3033, 1) end
canOpsTable[CDU_OSB_H_OFF] = function() GetDevice(9):performClickableAction(3034, 0) end
canOpsTable[CDU_OSB_H_ON] = function() GetDevice(9):performClickableAction(3034, 1) end
canOpsTable[CDU_OSB_I_OFF] = function() GetDevice(9):performClickableAction(3035, 0) end
canOpsTable[CDU_OSB_I_ON] = function() GetDevice(9):performClickableAction(3035, 1) end
canOpsTable[CDU_OSB_J_OFF] = function() GetDevice(9):performClickableAction(3036, 0) end
canOpsTable[CDU_OSB_J_ON] = function() GetDevice(9):performClickableAction(3036, 1) end
canOpsTable[CDU_OSB_K_OFF] = function() GetDevice(9):performClickableAction(3037, 0) end
canOpsTable[CDU_OSB_K_ON] = function() GetDevice(9):performClickableAction(3037, 1) end
canOpsTable[CDU_OSB_L_OFF] = function() GetDevice(9):performClickableAction(3038, 0) end
canOpsTable[CDU_OSB_L_ON] = function() GetDevice(9):performClickableAction(3038, 1) end
canOpsTable[CDU_OSB_M_OFF] = function() GetDevice(9):performClickableAction(3039, 0) end
canOpsTable[CDU_OSB_M_ON] = function() GetDevice(9):performClickableAction(3039, 1) end
canOpsTable[CDU_OSB_N_OFF] = function() GetDevice(9):performClickableAction(3040, 0) end
canOpsTable[CDU_OSB_N_ON] = function() GetDevice(9):performClickableAction(3040, 1) end
canOpsTable[CDU_OSB_O_OFF] = function() GetDevice(9):performClickableAction(3041, 0) end
canOpsTable[CDU_OSB_O_ON] = function() GetDevice(9):performClickableAction(3041, 1) end
canOpsTable[CDU_OSB_P_OFF] = function() GetDevice(9):performClickableAction(3042, 0) end
canOpsTable[CDU_OSB_P_ON] = function() GetDevice(9):performClickableAction(3042, 1) end
canOpsTable[CDU_OSB_Q_OFF] = function() GetDevice(9):performClickableAction(3043, 0) end
canOpsTable[CDU_OSB_Q_ON] = function() GetDevice(9):performClickableAction(3043, 1) end
canOpsTable[CDU_OSB_R_OFF] = function() GetDevice(9):performClickableAction(3044, 0) end
canOpsTable[CDU_OSB_R_ON] = function() GetDevice(9):performClickableAction(3044, 1) end
canOpsTable[CDU_OSB_S_OFF] = function() GetDevice(9):performClickableAction(3045, 0) end
canOpsTable[CDU_OSB_S_ON] = function() GetDevice(9):performClickableAction(3045, 1) end
canOpsTable[CDU_OSB_T_OFF] = function() GetDevice(9):performClickableAction(3046, 0) end
canOpsTable[CDU_OSB_T_ON] = function() GetDevice(9):performClickableAction(3046, 1) end
canOpsTable[CDU_OSB_U_OFF] = function() GetDevice(9):performClickableAction(3047, 0) end
canOpsTable[CDU_OSB_U_ON] = function() GetDevice(9):performClickableAction(3047, 1) end
canOpsTable[CDU_OSB_V_OFF] = function() GetDevice(9):performClickableAction(3048, 0) end
canOpsTable[CDU_OSB_V_ON] = function() GetDevice(9):performClickableAction(3048, 1) end
canOpsTable[CDU_OSB_W_OFF] = function() GetDevice(9):performClickableAction(3049, 0) end
canOpsTable[CDU_OSB_W_ON] = function() GetDevice(9):performClickableAction(3049, 1) end
canOpsTable[CDU_OSB_X_OFF] = function() GetDevice(9):performClickableAction(3050, 0) end
canOpsTable[CDU_OSB_X_ON] = function() GetDevice(9):performClickableAction(3050, 1) end
canOpsTable[CDU_OSB_Y_OFF] = function() GetDevice(9):performClickableAction(3051, 0) end
canOpsTable[CDU_OSB_Y_ON] = function() GetDevice(9):performClickableAction(3051, 1) end
canOpsTable[CDU_OSB_Z_OFF] = function() GetDevice(9):performClickableAction(3052, 0) end
canOpsTable[CDU_OSB_Z_ON] = function() GetDevice(9):performClickableAction(3052, 1) end
canOpsTable[CDU_OSB_BLK0_OFF] = function() GetDevice(9):performClickableAction(3053, 0) end
canOpsTable[CDU_OSB_BLK0_ON] = function() GetDevice(9):performClickableAction(3053, 1) end
canOpsTable[CDU_OSB_BLK1_OFF] = function() GetDevice(9):performClickableAction(3054, 0) end
canOpsTable[CDU_OSB_BLK1_ON] = function() GetDevice(9):performClickableAction(3054, 1) end
canOpsTable[CDU_OSB_MK_OFF] = function() GetDevice(9):performClickableAction(3055, 0) end
canOpsTable[CDU_OSB_MK_ON] = function() GetDevice(9):performClickableAction(3055, 1) end
canOpsTable[CDU_OSB_BCK_OFF] = function() GetDevice(9):performClickableAction(3056, 0) end
canOpsTable[CDU_OSB_BCK_ON] = function() GetDevice(9):performClickableAction(3056, 1) end
canOpsTable[CDU_OSB_SPC_OFF] = function() GetDevice(9):performClickableAction(3057, 0) end
canOpsTable[CDU_OSB_SPC_ON] = function() GetDevice(9):performClickableAction(3057, 1) end
canOpsTable[CDU_OSB_CLR_OFF] = function() GetDevice(9):performClickableAction(3058, 0) end
canOpsTable[CDU_OSB_CLR_ON] = function() GetDevice(9):performClickableAction(3058, 1) end
canOpsTable[CDU_OSB_FA_OFF] = function() GetDevice(9):performClickableAction(3059, 0) end
canOpsTable[CDU_OSB_FA_ON] = function() GetDevice(9):performClickableAction(3059, 1) end
canOpsTable[CDU_OSB_DIM_ON] = function() GetDevice(9):performClickableAction(3060, -1) end
canOpsTable[CDU_OSB_DIM_OFF] = function() GetDevice(9):performClickableAction(3060, 0) end
canOpsTable[CDU_OSB_BRT_OFF] = function() GetDevice(9):performClickableAction(3061, 0) end
canOpsTable[CDU_OSB_BRT_ON] = function() GetDevice(9):performClickableAction(3061, 1) end
canOpsTable[CDU_OSB_P_UP_ON] = function() GetDevice(9):performClickableAction(3062, 1) end
canOpsTable[CDU_OSB_P_UP_OFF] = function() GetDevice(9):performClickableAction(3062, 0) end
canOpsTable[CDU_OSB_G_DOWN_OFF] = function() GetDevice(9):performClickableAction(3063, 0) end
canOpsTable[CDU_OSB_G_DOWN_ON] = function() GetDevice(9):performClickableAction(3063, -1) end
canOpsTable[CDU_OSB_LEFT_ON] = function() GetDevice(9):performClickableAction(3064, -1) end
canOpsTable[CDU_OSB_LEFT_OFF] = function() GetDevice(9):performClickableAction(3064, 0) end
canOpsTable[CDU_OSB_RIGHT_OFF] = function() GetDevice(9):performClickableAction(3065, 0) end
canOpsTable[CDU_OSB_RIGHT_ON] = function() GetDevice(9):performClickableAction(3065, 1) end
canOpsTable[CDU_OSB_INC_ON] = function() GetDevice(9):performClickableAction(3066, 1) end
canOpsTable[CDU_OSB_INC_OFF] = function() GetDevice(9):performClickableAction(3066, 0) end
canOpsTable[CDU_OSB_DEC_OFF] = function() GetDevice(9):performClickableAction(3067, 0) end
canOpsTable[CDU_OSB_DEC_ON] = function() GetDevice(9):performClickableAction(3067, -1) end

-- OXYGEN PANEL -- LRU_PNL_0270 -- NO FUNCTION

-- AAP -- LRU_PNL_0271 --
canOpsTable[CDU_POWER_ON] = function() GetDevice(22):performClickableAction(3005, 1) end
canOpsTable[CDU_POWER_OFF] = function() GetDevice(22):performClickableAction(3005, 0) end
canOpsTable[EGI_POWER_ON] = function() GetDevice(22):performClickableAction(3006, 1) end
canOpsTable[EGI_POWER_OFF] = function() GetDevice(22):performClickableAction(3006, 0) end
canOpsTable[STEER_FLTPLAN] = function() GetDevice(22):performClickableAction(3001, 0.0) end
canOpsTable[STEER_MARK] = function() GetDevice(22):performClickableAction(3001, 0.1) end
canOpsTable[STEER_MISSION] = function() GetDevice(22):performClickableAction(3001, 0.2) end
canOpsTable[PAGE_OTHER] = function() GetDevice(22):performClickableAction(3004, 0.0) end
canOpsTable[PAGE_POSITION] = function() GetDevice(22):performClickableAction(3004, 0.1) end
canOpsTable[PAGE_STEER] = function() GetDevice(22):performClickableAction(3004, 0.2) end
canOpsTable[PAGE_WAYPT] = function() GetDevice(22):performClickableAction(3004, 0.3) end
canOpsTable[STEER_UP] = function() GetDevice(22):performClickableAction(3002, 1) end
canOpsTable[STEER_OFF] = function() GetDevice(22):performClickableAction(3002, 0) end
canOpsTable[STEER_DOWN] = function() GetDevice(22):performClickableAction(3003, -1) end
canOpsTable[STEER_OFF] = function() GetDevice(22):performClickableAction(3003, 0) end

-- ENVIRONMENT CONTROL PANEL -- LRU_PNL_0272 -- WIP CHANGES TODO IN PANEL HARDWARE
canOpsTable[OXY_IND_TEST_ON] = function() GetDevice(41):performClickableAction(3001, 1) end
canOpsTable[OXY_IND_TEST_OFF] = function() GetDevice(41):performClickableAction(3001, 0) end
canOpsTable[WINDSHIELD_DEICE_ON] = function() GetDevice(41):performClickableAction(3002, 1) end
canOpsTable[WINDSHIELD_DEICE_OFF] = function() GetDevice(41):performClickableAction(3002, 0) end
canOpsTable[WINDSHIELD_MODE_OFF] = function() GetDevice(41):performClickableAction(3004, 0) end
canOpsTable[WINDSHIELD_MODE_RAIN] = function() GetDevice(41):performClickableAction(3004, 1) end
canOpsTable[WINDSHIELD_MODE_WASH] = function() GetDevice(41):performClickableAction(3004, -1) end
canOpsTable[PITOT_HEAT_ON] = function() GetDevice(41):performClickableAction(3005, 1) end
canOpsTable[PITOT_HEAT_OFF] = function() GetDevice(41):performClickableAction(3005, 0) end
canOpsTable[BLEED_AIR_ON] = function() GetDevice(41):performClickableAction(3006, 1) end
canOpsTable[BLEED_AIR_OFF] = function() GetDevice(41):performClickableAction(3006, 0) end
canOpsTable[TEMP_PRESS_NORM] = function() GetDevice(41):performClickableAction(3007, -1) end
canOpsTable[TEMP_PRESS_RAM] = function() GetDevice(41):performClickableAction(3007, 0) end
canOpsTable[MAIN_SUPPLY_ON] = function() GetDevice(41):performClickableAction(3008, 1) end
canOpsTable[MAIN_SUPPLY_OFF] = function() GetDevice(41):performClickableAction(3008, 0) end
canOpsTable[MODE_AUTO] = function() GetDevice(41):performClickableAction(3010, 1) end
canOpsTable[MODE_MANUAL] = function() GetDevice(41):performClickableAction(3010, 0) end

-- TACAN -- LRU_PNL_0273 -- 
--elements["PTR-TACAN-CHANNEL-SELECTOR-1"] = { class  		 	= {class_type.LEV},  hint   		 	= _("Channel Selector (Tens). Rotate mouse wheel to select"), device 		 	= devices.TACAN, action 		 	= {device_commands.Button_1},  arg 			= {256}, arg_value 		= {0.1}, arg_lim   		= {{0.0, 1.0}}, relative		= {true}, animated   		= {true}, animation_speed = {0.7}, gain 			= {0.1}}
--elements["PTR-TACAN-CHANNEL-SELECTOR-2"] = { class  		 	= {class_type.LEV, class_type.TUMB},  hint   		 	= _("Channel Selector (Ones) / X/Y Mode. Right mouse click to select X/Y. Rotate mouse wheel to make channel selection"), device 		 	= devices.TACAN, action 		 	= {device_commands.Button_3, device_commands.Button_5},  arg 			= {257, 258}, arg_value 		= {0.1, 0.93}, arg_lim   		= {{0.0, 1.0}, {0.87, 0.93}}, relative		= {true, false}, animated   		= {true, false}, animation_speed = {0.7, 0.0}, gain 			= {0.1, 1}}
--elements["PTR-TACAN-TEST"]				= default_button(_("Test TACAN Signal on HSI"), devices.TACAN, device_commands.Button_6, 259, 1, {0, 1})
--elements["PTR-TACAN-VOL"] 				= default_axis(_("Signal Volume"), devices.TACAN, device_commands.Button_7, 261)
--elements["PTR-TACAN-MODE"]				= multiposition_switch(_("Mode Dial"), devices.TACAN, device_commands.Button_8, 262, 5, 0.1)

-- ILS PANEL -- LRU_PNL_0274 --
--canOpsTable[0xFFFF0101] = function() GetDevice(53):performClickableAction(3001, 1) end -- ILS ON
--canOpsTable[0xFFFF0100] = function() GetDevice(53):performClickableAction(3001, 0) end -- ILS OFF
canOpsTable[0xFFFF0201] = -- ILS MHZ DEC (DCS BUG)
function() 
	ils_mhz = (ils_mhz - 0.033)
	if(ils_mhz < 0) then ils_mhz = 0 end
	GetDevice(53):performClickableAction(3002, ils_mhz) 
end 

canOpsTable[0xFFFF0202] = -- ILS MHZ INC (DCS BUG)
function() 
	ils_mhz = (ils_mhz + 0.033)
	if(ils_mhz > 0.3) then ils_mhz = 0.3 end
	GetDevice(53):performClickableAction(3002, ils_mhz) 
end 
--canOpsTable[0xFFFF0301] = function() GetDevice(53):performClickableAction(3003, -0.05) end -- ILS KHZ DEC
--canOpsTable[0xFFFF0302] = function() GetDevice(53):performClickableAction(3003, 0.05) end -- ILS KHZ INC
--ILS
--elements["PTR-ILSCP-PWR"] = {
--	class = {class_type.LEV, class_type.TUMB},
--	hint = _("ILS Frequency MHz / Power. Right mouse click to cycle power. Rotate mouse wheel to change frequency value"),
--	device = devices.ILS,
--	action = {device_commands.Button_2,device_commands.Button_1},
--	arg = {248, 247},
--	arg_value = {0.1, 1},
--	arg_lim = {{0.0, 0.30}, {0.0, 1.0}},
--	relative = {false, false},
--	animated   = {true, false},
--	animation_speed = {0.5,0.0},
--	gain = {0.1, 1.0}
--}
--elements["PTR-ILSCP-VOL"] = {
--	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
--	hint = _("ILS Frequency kHz / Volume. Rotate mouse wheel to change frequency value. Left or Right click and hold while moving mouse to adjust volume "),
--	device = devices.ILS,
--	action = {device_commands.Button_5, device_commands.Button_4, device_commands.Button_3},
--	arg = {250, 250, 249},
--	arg_value = {-0.1, 0.1, 0.1},
--	arg_lim = {{0.0, 1.0}, {0.0, 1.0}, {0.0, 0.9}},
--	relative = {false, false, false},
--	animated   = {true, true, true},
--	animation_speed = {0.7, 0.7, 0.5},
--	gain = {0.05, 0.05, 0.1},
--	cycle = false
--}

-- EXT/INT LIGHT SYSTEM CONTROL PANEL -- LRU_PNL_0275 -- POTS ILUM LINE DIM
canOpsTable[POSITION_FLASH] = function() GetDevice(49):performClickableAction(3008, 1) end
canOpsTable[POSITION_OFF] = function() GetDevice(49):performClickableAction(3008, 0) end
canOpsTable[POSITION_STEADY] = function() GetDevice(49):performClickableAction(3008, -1) end
canOpsTable[ANTICOLLISION_ON] = function() GetDevice(49):performClickableAction(3010, 1) end
canOpsTable[ANTICOLLISION_OFF] = function() GetDevice(49):performClickableAction(3010, 0) end
canOpsTable[NOSE_ON] = function() GetDevice(49):performClickableAction(3012, 1) end
canOpsTable[NOSE_OFF] = function() GetDevice(49):performClickableAction(3012, 0) end
canOpsTable[SIGNAL_BRT] = function() GetDevice(49):performClickableAction(3013, 1) end
canOpsTable[SIGNAL_DIM] = function() GetDevice(49):performClickableAction(3013, 0) end
canOpsTable[ACCELCOMP_ON] = function() GetDevice(49):performClickableAction(3004, 1) end
canOpsTable[ACCELCOMP_OFF] = function() GetDevice(49):performClickableAction(3004, 0) end

-- HARS -- LRU_PNL_0276
canOpsTable[HARS_SYNC_ON] = function() GetDevice(44):performClickableAction(3006, 1) end
canOpsTable[HARS_SYNC_OFF] = function() GetDevice(44):performClickableAction(3006, 0) end
canOpsTable[HARS_SYNC_DEC] = function() GetDevice(44):performClickableAction(3007, -1) end
canOpsTable[HARS_SYNC_INC] = function() GetDevice(44):performClickableAction(3007, 1) end
canOpsTable[HARS_MAGVAR_INC] = function() GetDevice(44):performClickableAction(3004, 1) end
canOpsTable[HARS_MAGVAR_OFF] = function() GetDevice(44):performClickableAction(3004, 0) end
canOpsTable[HARS_MAGVAR_DEC] = function() GetDevice(44):performClickableAction(3004, -1) end
canOpsTable[HARS_DG_N] = function() GetDevice(44):performClickableAction(3003, 1) end
canOpsTable[HARS_DG_S] = function() GetDevice(44):performClickableAction(3003, 0) end
canOpsTable[HARS_SLAVE_ON] = function() GetDevice(44):performClickableAction(3002, 1) end
canOpsTable[HARS_SLAVE_OFF] = function() GetDevice(44):performClickableAction(3002, 0) end
	
do

	local PrevLuaExportStart = LuaExportStart;
	LuaExportStart = function()

		-- Configure Network
		package.path  = package.path..";.\\LuaSocket\\?.lua"
		package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
		port = 6060
		host = "192.168.1.100"
		socket = require("socket")
		con = socket.try(socket.udp())
		socket.try(con:settimeout(.001))
		socket.try(con:setpeername(host,port))
		if PrevLuaExportStart then PrevLuaExportStart(); end
	
	end

end

do

	local PrevLuaExportBeforeNextFrame = LuaExportBeforeNextFrame;
	LuaExportBeforeNextFrame = function()

		-- Export Data
		local packet = ""
		local flightData = {}

		local mp = GetDevice(0)
		if mp then
		
			-- Update Data
			mp:update_arguments()

			-- Accelerometer
			arg = mp:get_argument_value(15)
			var = ((arg * 15) - 5)
			table.insert(flightData,string.format("ID_BODY_NORMAL_ACCELERATION=%.4f",var))

			-- Standby magnetic compass
			arg = mp:get_argument_value(6)
			var = (arg * 360)
			table.insert(flightData,string.format("ID_MAGNETIC_HEADING=%.4f",var))
			
			-- Variometer CANAerospace m/s units
			arg = mp:get_argument_value(12)
			if (arg > 0    	and arg <= 0.29) or (arg < 0 and arg >= -0.29) then var = (arg * 3448.27) end
			if (arg > 0.29 	and arg <= 0.5) 	then var = (1000 + ((arg - 0.29) * 4761.9)) end
			if (arg > 0.5  	and arg <= 1.0) 	then var = (2000 + ((arg - 0.5) * 8000)) end
			if (arg < -0.29 and arg >= -0.5) 	then var = (-1000 + ((arg + 0.29) * 4761.9)) end
			if (arg < -0.5  and arg >= -1) 		then var = (-2000 + ((arg + 0.5) * 8000)) end
			var = (var * 0.00508)
			table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f",var))
			
			-- Airspeed Indicator CANAerospace m/s
			arg = mp:get_argument_value(48)
			if (arg > 0     and arg <= 0.053) then var = (arg * 943.39) end
			if (arg > 0.053 and arg <= 0.146) then var = (50  + ((arg - 0.053) * 537.63)) end
			if (arg > 0.146 and arg <= 0.234) then var = (100 + ((arg - 0.146) * 568.18)) end
			if (arg > 0.234 and arg <= 0.322) then var = (150 + ((arg - 0.234) * 568.18)) end
			if (arg > 0.322 and arg <= 0.412) then var = (200 + ((arg - 0.322) * 555.55)) end
			if (arg > 0.412 and arg <= 0.517) then var = (250 + ((arg - 0.412) * 476.19)) end
			if (arg > 0.517 and arg <= 0.620) then var = (300 + ((arg - 0.517) * 485.43)) end
			if (arg > 0.620 and arg <= 0.719) then var = (350 + ((arg - 0.620) * 505.05)) end
			if (arg > 0.719 and arg <= 0.811) then var = (400 + ((arg - 0.719) * 543.47)) end
			if (arg > 0.811 and arg <= 0.906) then var = (450 + ((arg - 0.811) * 526.31)) end
			if (arg > 0.906 and arg <= 1.0)   then var = (500 + ((arg - 0.906) * 531.91)) end
			if (arg > 1.0) then var = 550 end
			var = (var * 0.5144)
			table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f",var))
			
			-- Max Airspeed Indicator CANAerospace m/s
			arg = mp:get_argument_value(50)
			if (arg > 0     and arg <= 0.053) then var = (arg * 943.39) end
			if (arg > 0.053 and arg <= 0.146) then var = (50  + ((arg - 0.053) * 537.63)) end
			if (arg > 0.146 and arg <= 0.234) then var = (100 + ((arg - 0.146) * 568.18)) end
			if (arg > 0.234 and arg <= 0.322) then var = (150 + ((arg - 0.234) * 568.18)) end
			if (arg > 0.322 and arg <= 0.412) then var = (200 + ((arg - 0.322) * 555.55)) end
			if (arg > 0.412 and arg <= 0.517) then var = (250 + ((arg - 0.412) * 476.19)) end
			if (arg > 0.517 and arg <= 0.620) then var = (300 + ((arg - 0.517) * 485.43)) end
			if (arg > 0.620 and arg <= 0.719) then var = (350 + ((arg - 0.620) * 505.05)) end
			if (arg > 0.719 and arg <= 0.811) then var = (400 + ((arg - 0.719) * 543.47)) end
			if (arg > 0.811 and arg <= 0.906) then var = (450 + ((arg - 0.811) * 526.31)) end
			if (arg > 0.906 and arg <= 1.0)   then var = (500 + ((arg - 0.906) * 531.91)) end
			if (arg > 1.0) then var = 550 end
			var = (var * 0.5144)
			table.insert(flightData,string.format("ID_CALIBRATED_AIRSPEED=%.4f",var))
			
			-- ADI Pitch CANAerospace degrees
			arg = mp:get_argument_value(17) -- ADI Pitch CANAerospace degrees {-math.pi/2.0,math.pi/2.0}{1.0,-1.0}
			var = (arg * 180)
			table.insert(flightData,string.format("ID_BODY_PITCH_ANGLE=%.4f",var))							

			-- ADI_Bank CANAerospace degrees
			arg = mp:get_argument_value(18) 
			var = (arg * -180)
			table.insert(flightData,string.format("ID_BODY_ROLL_ANGLE=%.4f",var))							
			
			-- ADI_TurnNeedle CANAerospace deg/s
			arg = mp:get_argument_value(23) 
			var = (arg * 12)
			table.insert(flightData,string.format("ID_TURN_COORDINATION_RATE=%.4f",var))
			
			-- ADI_Slipball CANAerospace degrees
			arg = mp:get_argument_value(24) 
			var = arg
			table.insert(flightData,string.format("ID_BODY_SIDESLIP=%.4f",var))							
			
			-- ADI_pitch_steering_bar
			arg = mp:get_argument_value(21)
			var = (arg * -100)
			table.insert(flightData,string.format("ID_FLIGHT_DIRECTOR_1_PITCH_DEVIATION=%.4f",var))							
			
			-- ADI_bank_steering_bar
			arg = mp:get_argument_value(20) 
			var = (arg * 100)
			table.insert(flightData,string.format("ID_FLIGHT_DIRECTOR_1_ROLL_DEVIATION=%.4f",var))							
			
			-- ADI_glide_slope_indicator
			arg = mp:get_argument_value(27) 
			var = (arg * -50)
			table.insert(flightData,string.format("ID_ILS_1_GLIDESLOPE_DEVIATION=%.4f",var))							

			-- ADI_course_warning_flag {0.0,1.0}{0.0,1.0}
			-- arg = mp:get_argument_value(19) 
			-- var = arg
			-- table.insert(flightData,string.format("ID_NOTDEF=%.4f",var))							
			
			-- ADI_attitude_warning_flag {0.0,1.0}{0.0,1.0}
			-- arg = mp:get_argument_value(25) 
			-- var = arg
			-- table.insert(flightData,string.format("ID_NOTDEF=%.4f",var))							
			
			-- ADI_glide_slope_flag {0.0,1.0}{0.0,1.0}
			-- arg = mp:get_argument_value(26) -- ADI_glide_slope_flag {0.0,1.0}{0.0,1.0}
			-- var = arg
			-- table.insert(flightData,string.format("ID_NOTDEF=%.4f",var))							
			
			-- Barometric Altimeter Pressure Setting CANAerospace hPa
			arg_3 = math.floor(mp:get_argument_value(56) * 100)
			arg_2 = math.floor(mp:get_argument_value(57) * 10)
			arg_1 = mp:get_argument_value(58)
			arg_0 = mp:get_argument_value(59) * 0.1
			var = ((arg_3 + arg_2 + arg_1 + arg_0) * 33.86389)
			table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f",var))
			
			-- Barometric Altimeter Altitude CANAerospace m
			arg_10000 = math.floor(mp:get_argument_value(52) * 10) * 10000
			arg_1000  = math.floor((mp:get_argument_value(53) + 0.0000001) * 10) * 1000
			arg_100   = mp:get_argument_value(54) * 1000
			var = ((arg_10000 + arg_1000 + arg_100) * 0.3048)
			table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f",var))
			
			-- Angle of Attack Indicator CANAerospace degrees AOA_Units {0.0,30.0}{0.0,1.0}
			arg = mp:get_argument_value(4)
			var = (arg * 30)															
			table.insert(flightData,string.format("ID_PORT_SIDE_ANGLE_OF_ATTACK=%.4f",var))

			-- HSI_heading {0.0,math.pi * 2.0}{0.0,1.0}
			hdg = mp:get_argument_value(34)
			hdg = (360 - (hdg * 360))
			table.insert(flightData,string.format("ID_HEADING_ANGLE=%.4f",hdg))

			-- HSI_heading_marker {0.0,math.pi * 2.0}{0.0,1.0}
			arg = mp:get_argument_value(36) 
			var = ((hdg + (arg * 360)) % 360)
			table.insert(flightData,string.format("ID_DESIRED_TRACK_ANGLE=%.4f",var))

			-- HSI_course_arrow {0.0,math.pi * 2.0}{0.0,1.0}
			arg = mp:get_argument_value(47) 
			var = ((hdg + (arg * 360)) % 360)
			table.insert(flightData,string.format("ID_SELECTED_COURSE=%.4f",var))

			-- HSI_deviation {-1.0,1.0}{-1.0,1.0} COURSE DEVIATION NOT IMPLEMENTED ON CANAerospace
			--arg = mp:get_argument_value(41) 
			--var = (arg * 60)															
			--table.insert(flightData,string.format("ID_NOTDEF=%.4f",var))

			-- HSI_to_from_1 {0.0,1.0}{0.0,1.0} TO FROM NOT IMPLEMENTED ON CANAerospace
			--arg = mp:get_argument_value(42) 
			--var = arg
			--table.insert(flightData,string.format("ID_NOTDEF=%.4f",var)) 

			-- HSI_bearing_no1 {0.0,math.pi * 2.0}{0.0,1.0}
			arg = mp:get_argument_value(33) 
			var = ((hdg + (arg * 360)) % 360)
			table.insert(flightData,string.format("ID_VOR_1_RADIAL=%.4f",var)) 

			-- HSI_bearing_no2 {0.0,math.pi * 2.0}{0.0,1.0}
			arg = mp:get_argument_value(35) 
			var = ((hdg + (arg * 360)) % 360)
			table.insert(flightData,string.format("ID_ADF_1_BEARING=%.4f",var)) 

			-- HSI_DISTANCE
			var = ((mp:get_argument_value(30) * 100) + (mp:get_argument_value(31) * 10))
			var = (var * 1852)
			table.insert(flightData,string.format("ID_DME_1_DISTANCE=%.4f",var)) 
			
			-- LATITUDE
			var = LoGetSelfData().LatLongAlt.Lat
			table.insert(flightData,string.format("ID_INS_AIRCRAFT_LATITUDE=%.8f",var)) 

			-- LONGITUDE
			var = LoGetSelfData().LatLongAlt.Long
			table.insert(flightData,string.format("ID_INS_AIRCRAFT_LONGITUDE=%.8f",var)) 
			
			-- HSI_bearing_flag {0.0,1.0}{0.0,1.0}
			-- arg = mp:get_argument_value(46) 
			-- var = arg
			-- table.insert(flightData,string.format("ID_NOTDEF=%.4f",var)) 

			-- HSI_range_flag {0.0,1.0}{0.0,1.0}
			-- arg = mp:get_argument_value(32) 
			-- var = arg
			-- table.insert(flightData,string.format("ID_NOTDEF=%.4f",var)) 
		
			-- Apu RPM {0.0,120.0}{0.0,1.0}
			arg = mp:get_argument_value(13) 
			var = (arg * 120)															
			table.insert(flightData,string.format("ID_ENGINE_1_N1_ECS_CHANNEL_B=%.4f",var))
			
			-- APU EGT Temperature {0.0,1000.0}{0.0,1.0} to Kelvin
			arg = mp:get_argument_value(14) 
			var = ((arg * 1000) + 273.15) 														
			table.insert(flightData,string.format("ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_B=%.4f",var))

			-- Engine 1 Oil Pressure {0.0,100.0}{0.0,1.0} hPa			
			arg = mp:get_argument_value(82) 
			var = ((arg * 100) * 68.9475)
			table.insert(flightData,string.format("ID_ENGINE_1_OIL_PRESSURE_ECS_CHANNEL_A=%.4f",var))

			-- Engine 2 Oil Pressure {0.0,100.0}{0.0,1.0} hPa
			arg = mp:get_argument_value(83) 
			var = ((arg * 100) * 68.9475)
			table.insert(flightData,string.format("ID_ENGINE_2_OIL_PRESSURE_ECS_CHANNEL_A=%.4f",var))
			
			-- Left Engine Fuel Flow {0.0,5000.0}{0.0,1.0} to l/h
			arg = mp:get_argument_value(84) 
			var = ((arg * 5000) * 0.6134)
			table.insert(flightData,string.format("ID_ENGINE_1_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f",var))
			
			-- Right Engine Fuel Flow {0.0,5000.0}{0.0,1.0} to l/h
			arg = mp:get_argument_value(85) 
			var = ((arg * 5000) * 0.6134)
			table.insert(flightData,string.format("ID_ENGINE_2_FUEL_FLOW_RATE_ECS_CHANNEL_A=%.4f",var))
			
			-- Left Engine N2 %RPM {0.0,100.0}{0.0,1.0}
			arg = mp:get_argument_value(78) 
			var = (arg * 100)
			table.insert(flightData,string.format("ID_ENGINE_1_N2_ECS_CHANNEL_A=%.4f",var))

			-- Right Engine N2 %RPM {0.0,100.0}{0.0,1.0}
			arg = mp:get_argument_value(80) 
			var = (arg * 100)
			table.insert(flightData,string.format("ID_ENGINE_2_N2_ECS_CHANNEL_A=%.4f",var))
			
			-- Left Engine Fan N1 %RPM EngineLeftFanSpeed {0,25,50,75,80,85,90,95,100}{0.0,1/8,2/8,3/8,4/8,5/8,6/8,7/8,1}
			arg = mp:get_argument_value(76) 
			if (arg >= 0    and arg <= 0.375) 	then var = (arg * 200) end
			if (arg > 0.375 and arg <= 1)		then var = (75 + ((arg - 0.375) * 40)) end
			if (arg > 1.0)						then var = 100 end
			table.insert(flightData,string.format("ID_ENGINE_1_N1_ECS_CHANNEL_A=%.4f",var))
			
			-- Right Engine Fan N1 %RPM EngineRightFanSpeed {0,25,50,75,80,85,90,95,100}{0.0,1/8,2/8,3/8,4/8,5/8,6/8,7/8,1}
			arg = mp:get_argument_value(77) 
			if (arg >= 0    and arg <= 0.375) 	then var = (arg * 200) end
			if (arg > 0.375 and arg <= 1)		then var = (75 + ((arg - 0.375) * 40)) end
			if (arg > 1.0)						then var = 100 end
			table.insert(flightData,string.format("ID_ENGINE_2_N1_ECS_CHANNEL_A=%.4f",var))
			
			-- Left Engine Temperature {100,200,300,400,500,600,700,800,900,1000,1100}{0.005,0.095,0.183,0.275,0.365,0.463,0.560,0.657,0.759,0.855,0.995} to Kelvin
			arg = mp:get_argument_value(70)	
			if (arg >= 0    and arg <= 0.005) then var =  (arg * 20000) end
			if (arg > 0.005 and arg <= 0.095) then var =  (100  + ((arg - 0.005) * 1111.11)) end
			if (arg > 0.095 and arg <= 0.183) then var =  (200  + ((arg - 0.095) * 1136.36)) end
			if (arg > 0.183 and arg <= 0.275) then var =  (300  + ((arg - 0.183) * 1086.95)) end
			if (arg > 0.275 and arg <= 0.365) then var =  (400  + ((arg - 0.275) * 1111.11)) end
			if (arg > 0.365 and arg <= 0.463) then var =  (500  + ((arg - 0.365) * 1020.40)) end
			if (arg > 0.463 and arg <= 0.560) then var =  (600  + ((arg - 0.463) * 1030.92)) end
			if (arg > 0.560 and arg <= 0.657) then var =  (700  + ((arg - 0.560) * 1030.92)) end
			if (arg > 0.657 and arg <= 0.759) then var =  (800  + ((arg - 0.657) * 980.39))  end
			if (arg > 0.759 and arg <= 0.855) then var =  (900  + ((arg - 0.759) * 1041.66)) end
			if (arg > 0.855 and arg <= 0.995) then var =  (1000 + ((arg - 0.855) * 714.28))  end
			if (arg > 0.995) then var = 1100 end
			var = (var + 273.15)
			table.insert(flightData,string.format("ID_ENGINE_1_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))
			
			-- Right Engine Temperature {100,200,300,400,500,600,700,800,900,1000,1100}{0.005,0.095,0.183,0.275,0.365,0.463,0.560,0.657,0.759,0.855,0.995} to Kelvin
			arg = mp:get_argument_value(73) 
			if (arg >= 0    and arg <= 0.005) then var =  (arg * 20000) end
			if (arg > 0.005 and arg <= 0.095) then var =  (100  + ((arg - 0.005) * 1111.11)) end
			if (arg > 0.095 and arg <= 0.183) then var =  (200  + ((arg - 0.095) * 1136.36)) end
			if (arg > 0.183 and arg <= 0.275) then var =  (300  + ((arg - 0.183) * 1086.95)) end
			if (arg > 0.275 and arg <= 0.365) then var =  (400  + ((arg - 0.275) * 1111.11)) end
			if (arg > 0.365 and arg <= 0.463) then var =  (500  + ((arg - 0.365) * 1020.40)) end
			if (arg > 0.463 and arg <= 0.560) then var =  (600  + ((arg - 0.463) * 1030.92)) end
			if (arg > 0.560 and arg <= 0.657) then var =  (700  + ((arg - 0.560) * 1030.92)) end
			if (arg > 0.657 and arg <= 0.759) then var =  (800  + ((arg - 0.657) * 980.39)) end
			if (arg > 0.759 and arg <= 0.855) then var =  (900  + ((arg - 0.759) * 1041.66)) end
			if (arg > 0.855 and arg <= 0.995) then var =  (1000 + ((arg - 0.855) * 714.28)) end
			if (arg > 0.995) then var = 1100 end
			var = (var + 273.15)
			table.insert(flightData,string.format("ID_ENGINE_2_TURBINE_OUTLET_TEMPERATURE_ECS_CHANNEL_A=%.4f",var))

			-- Flap Indicator {0,20,30}{0,2/3,1}
			arg = mp:get_argument_value(653)
			if (arg >= 0   and arg <= 0.6) then var = (arg * 33.3) end
			if (arg > 0.6  and arg <= 1)   then var = (20 + ((arg - 0.6) * 25)) end
			if (arg > 1.0) then var = 30 end
			table.insert(flightData,string.format("ID_FLAPS_LEVER_POSITION=%.4f",var))
		
			-- Hydraulic Pressure Left {0.0,4000.0}{0.0,1.0}
			arg = mp:get_argument_value(647)
			var = (arg * 4000)
			table.insert(flightData,string.format("ID_HYDRAULIC_SYSTEM_1_PRESSURE=%.4f",var))
			
			-- Hydraulic Pressure Right {0.0,4000.0}{0.0,1.0}
			arg = mp:get_argument_value(648)
			var = (arg * 4000)
			table.insert(flightData,string.format("ID_HYDRAULIC_SYSTEM_2_PRESSURE=%.4f",var))
		
			-- Fuel Quantity Left {0.0,6000.0}{0.0,1.0}
			arg = mp:get_argument_value(88)
			var = (arg * 6000)
			table.insert(flightData,string.format("ID_FUEL_TANK_1_QUANTITY=%.4f",var))

			-- Fuel Quantity Right {0.0,6000.0}{0.0,1.0}
			arg = mp:get_argument_value(89)
			var = (arg * 6000)
			table.insert(flightData,string.format("ID_FUEL_TANK_2_QUANTITY=%.4f",var))

			-- Oxygen Volume {0.0, 10.0} {0.0, 1.0} liters
			arg = mp:get_argument_value(274)
			var = (arg * 10)
			table.insert(flightData,string.format("ID_OXYGEN_VOLUME=%.4f",var))
			
			-- Cabin Press Altitude {0.0, 50000.0} {0.0, 1.0}
			arg = mp:get_argument_value(281)
			var = (arg * 50000) / 3.2808
			table.insert(flightData,string.format("ID_CABIN_ALTITUDE=%.4f",var))
			
			-- RADIO UHF TODO
			--var = (GetDevice(54):get_frequency() / 1000000)
			--print(string.format("ID_UHF_1_COM_FREQUENCY=%.6f",var))

			-- RADIO VHF_AM
			var = (GetDevice(55):get_frequency() / 1000000)
			table.insert(flightData,string.format("ID_VHF_1_COM_FREQUENCY=%.4f",var))
			
			-- RADIO VHF_FM
			var = (GetDevice(56):get_frequency() / 1000000)
			table.insert(flightData,string.format("ID_VHF_2_COM_FREQUENCY=%.4f",var))

			-- ILS FREQUENCY
			--MHrz = mp:get_argument_value(251) 
			--KHrz = mp:get_argument_value(252) 
			--if (MHrz == 0.0) then var = 108 end
			--if (MHrz == 0.1) then var = 109 end
			--if (MHrz == 0.2) then var = 110 end
			--if (MHrz == 0.3) then var = 111 end
			--if (KHrz == 0.0) then var = var + 0.10 end
			--if (KHrz == 0.1) then var = var + 0.15 end
			--if (KHrz == 0.2) then var = var + 0.30 end
			--if (KHrz == 0.3) then var = var + 0.35 end
			--if (KHrz == 0.4) then var = var + 0.50 end
			--if (KHrz == 0.5) then var = var + 0.55 end
			--if (KHrz == 0.6) then var = var + 0.70 end
			--if (KHrz == 0.7) then var = var + 0.75 end
			--if (KHrz == 0.8) then var = var + 0.90 end
			--if (KHrz == 0.9) then var = var + 0.95 end
			--table.insert(flightData,string.format("ID_VOR_ILS_1_FREQUENCY=%.2f",var))
			--var = GetDevice(53):get_frequency()
			--print("ILS" .. var)
			
			-- TACAN USES CAN AEROSPACE ADF2 000.0 = X 000.1 = Y
			--table.insert(flightData,"263=" .. mp:get_argument_value(263)) 							-- TACAN_digit_pos.hundreds){0.0, 10.0}{0.0, 1.0}
			--table.insert(flightData,"264=" .. mp:get_argument_value(264)) 							-- TACAN_digit_pos.tens){0.0, 10.0}{0.0, 1.0}
			--table.insert(flightData,"265=" .. mp:get_argument_value(265)) 							-- TACAN_digit_pos.ones){0.0, 10.0}{0.0, 1.0}
			--table.insert(flightData,"266=" .. mp:get_argument_value(266)) 							-- XYwheel{0.0, 1.0}{0.0, 1.0}
			var = mp:get_argument_value(263) * 100
			var = var + mp:get_argument_value(264) * 10
			var = var + mp:get_argument_value(265)
			var = var + mp:get_argument_value(266)
			table.insert(flightData,string.format("ID_ADF_2_FREQUENCY=%.2f",var))

			-- GROUP LAMPS_0_31
			lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			lp[1] = mp:get_argument_value(292) -- PANEL LIGHTS (BACKLIGHTING)
			lp[2] = mp:get_argument_value(404) -- MASTER_WARNING_STUB MASTER WARNING
			lp[3] = mp:get_argument_value(480) -- CAUTION LIGHT PANEL (ENG_START_CYCLE) 
			lp[4] = mp:get_argument_value(481) -- CAUTION LIGHT PANEL (L_HYD_PRESS)
			lp[5] = mp:get_argument_value(482) -- CAUTION LIGHT PANEL (R_HYD_PRESS) 
			lp[6] = mp:get_argument_value(483) -- CAUTION LIGHT PANEL (GUN_UNSAFE) 
			lp[7] = mp:get_argument_value(484) -- CAUTION LIGHT PANEL (ANTISKID) 
			lp[8] = mp:get_argument_value(485) -- CAUTION LIGHT PANEL (L_HYD_RES) 
			lp[9] = mp:get_argument_value(486) -- CAUTION LIGHT PANEL (R_HYD_RES) 
			lp[10] = mp:get_argument_value(487) -- CAUTION LIGHT PANEL (OXY_LOW) 
			lp[11] = mp:get_argument_value(488) -- CAUTION LIGHT PANEL (ELEV_DISENG) 
			lp[12] = mp:get_argument_value(489) -- CAUTION LIGHT PANEL (VOID1) 
			lp[13] = mp:get_argument_value(490) -- CAUTION LIGHT PANEL (SEAT_NOT_ARMED)
			lp[14] = mp:get_argument_value(491) -- CAUTION LIGHT PANEL (BLEED_AIR_LEAK) 
			lp[15] = mp:get_argument_value(492) -- CAUTION LIGHT PANEL (AIL_DISENG) 
			lp[16] = mp:get_argument_value(493) -- CAUTION LIGHT PANEL (L_AIL_TAB) 
			lp[17] = mp:get_argument_value(494) -- CAUTION LIGHT PANEL (R_AIL_TAB) 
			lp[18] = mp:get_argument_value(495) -- CAUTION LIGHT PANEL (SERVICE_AIR_HOT)
			lp[19] = mp:get_argument_value(496) -- CAUTION LIGHT PANEL (PITCH_SAS)
			lp[20] = mp:get_argument_value(497) -- CAUTION LIGHT PANEL (L_ENG_HOT)
			lp[21] = mp:get_argument_value(498) -- CAUTION LIGHT PANEL (R_ENG_HOT)
			lp[22] = mp:get_argument_value(499) -- CAUTION LIGHT PANEL (WINDSHIELD_HOT)
			lp[23] = mp:get_argument_value(500) -- CAUTION LIGHT PANEL (YAW_SAS) 
			lp[24] = mp:get_argument_value(501) -- CAUTION LIGHT PANEL (L_ENG_OIL_PRESS)
			lp[25] = mp:get_argument_value(502) -- CAUTION LIGHT PANEL (R_ENG_OIL_PRESS)
			lp[26] = mp:get_argument_value(503) -- CAUTION LIGHT PANEL (CICU)
			lp[27] = mp:get_argument_value(504) -- CAUTION LIGHT PANEL (GCAS)
			lp[28] = mp:get_argument_value(505) -- CAUTION LIGHT PANEL (L_MAIN_PUMP) 
			lp[29] = mp:get_argument_value(506) -- CAUTION LIGHT PANEL (R_MAIN_PUMP)
			lp[30] = mp:get_argument_value(507) -- CAUTION LIGHT PANEL (VOID2)
			lp[31] = mp:get_argument_value(508) -- CAUTION LIGHT PANEL (LASTE)
			lp[32] = mp:get_argument_value(509) -- CAUTION LIGHT PANEL (L_WING_PUMP)
			table.insert(flightData,string.format("ID_LAMPS_0_31=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
			
			-- GROUP LAMPS_32_63
			lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			lp[1] = mp:get_argument_value(510) -- CAUTION LIGHT PANEL (R_WING_PUMP) 
			lp[2] = mp:get_argument_value(511) -- CAUTION LIGHT PANEL (HARS) 
			lp[3] = mp:get_argument_value(512) -- CAUTION LIGHT PANEL (IFF_MODE_4) 
			lp[4] = mp:get_argument_value(513) -- CAUTION LIGHT PANEL (L_MAIN_FUEL_LOW) 
			lp[5] = mp:get_argument_value(514) -- CAUTION LIGHT PANEL (R_MAIN_FUEL_LOW) 
			lp[6] = mp:get_argument_value(515) -- CAUTION LIGHT PANEL (L_R_TKS_UNEQUAL)
			lp[7] = mp:get_argument_value(516) -- CAUTION LIGHT PANEL (EAC)
			lp[8] = mp:get_argument_value(517) -- CAUTION LIGHT PANEL (L_FUEL_PRESS)
			lp[9] = mp:get_argument_value(518) -- CAUTION LIGHT PANEL (R_FUEL_PRESS)
			lp[10] = mp:get_argument_value(519) -- CAUTION LIGHT PANEL (NAV)
			lp[11] = mp:get_argument_value(520) -- CAUTION LIGHT PANEL (STALL_SYS)
			lp[12] = mp:get_argument_value(521) -- CAUTION LIGHT PANEL (L_CONV) 
			lp[13] = mp:get_argument_value(522) -- CAUTION LIGHT PANEL (R_CONV) 
			lp[14] = mp:get_argument_value(523) -- CAUTION LIGHT PANEL (CADC) 
			lp[15] = mp:get_argument_value(524) -- CAUTION LIGHT PANEL (APU_GEN) 
			lp[16] = mp:get_argument_value(525) -- CAUTION LIGHT PANEL (L_GEN) 
			lp[17] = mp:get_argument_value(526) -- CAUTION LIGHT PANEL (R_GEN) 
			lp[18] = mp:get_argument_value(527) -- CAUTION LIGHT PANEL (INST_INV) 
			lp[19] = mp:get_argument_value(606) -- NMSP HARS
			lp[20] = mp:get_argument_value(608) -- NMSP EGI
			lp[21] = mp:get_argument_value(610) -- NMSP TISL
			lp[22] = mp:get_argument_value(612) -- NMSP STRPT
			lp[23] = mp:get_argument_value(614) -- NMSP ANCHR
			lp[24] = mp:get_argument_value(616) -- NMSP TCN
			lp[25] = mp:get_argument_value(618) -- NMSP ILS
			lp[26] = mp:get_argument_value(619) -- NMSP UHF
			lp[27] = mp:get_argument_value(620) -- NMSP FM
			lp[28] = mp:get_argument_value(798) -- IFF REPLY LAMP
			lp[29] = mp:get_argument_value(799) -- IFF TEST LAMP
			lp[30] = mp:get_argument_value(191) -- MISC LAMP TAKE_OFF_TRIM
			lp[31] = mp:get_argument_value(665) -- MISC LAMP CANOPY_UNLOCKED			
			lp[32] = mp:get_argument_value(737) -- MISC LAMP HANDLE_GEAR_WARNING
			table.insert(flightData,string.format("ID_LAMPS_32_63=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))
			
			-- GROUP LAMPS_64_95
			lp = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
			lp[1] = mp:get_argument_value(659) -- MISC LAMP LANDING_GEAR_N_SAFE
			lp[2] = mp:get_argument_value(660) -- MISC LAMP LANDING_GEAR_L_SAFE
			lp[3] = mp:get_argument_value(661) -- MISC LAMP LANDING_GEAR_R_SAFE
			lp[4] = mp:get_argument_value(663) -- MISC LAMP NOSEWHEEL_STEERING
			lp[5] = mp:get_argument_value(215) -- MISC LAMP L_ENG_FIRE
			lp[6] = mp:get_argument_value(216) -- MISC LAMP APU_FIRE
			lp[7] = mp:get_argument_value(217) -- MISC LAMP R_ENG_FIRE
			lp[8] = mp:get_argument_value(664) -- MISC LAMP MARKER_BEACON
			lp[9] = mp:get_argument_value(730) -- MISC LAMP AIR_REFUEL_READY
			lp[10] = mp:get_argument_value(731) -- MISC LAMP AIR_REFUEL_LATCHED
			lp[11] = mp:get_argument_value(732) -- MISC LAMP AIR_REFUEL_DISCONNECT
			lp[12] = mp:get_argument_value(178) -- MISC LAMP L_AILERON_EMER_DISENGAGE
			lp[13] = mp:get_argument_value(179) -- MISC LAMP R_AILERON_EMER_DISENGAGE
			lp[14] = mp:get_argument_value(181) -- MISC LAMP L_ELEVATOR_EMER_DISENGAGE
			lp[15] = mp:get_argument_value(182) -- MISC LAMP R_ELEVATOR_EMER_DISENGAGE
			lp[16] = mp:get_argument_value(662) -- MISC LAMP GUN_READY
			lp[17] = mp:get_argument_value(372) -- CMSC MissileLaunchIndicator
			lp[18] = mp:get_argument_value(373) -- CMSC PriorityStatusIndicator
			lp[19] = mp:get_argument_value(374) -- CMSC UnknownStatusIndicator
			lp[20] = mp:get_argument_value(260) -- TACAN_test_light{0.0, 1.0}{0.0, 1.0}
			table.insert(flightData,string.format("ID_LAMPS_64_95=%u", (lp[32] * (2^31) + lp[31] * (2^30) + lp[30] * (2^29) + lp[29] * (2^28) + lp[28] * (2^27) + lp[27] * (2^26) + lp[26] * (2^25) + lp[25] * (2^24) + lp[24] * (2^23) + lp[23] * (2^22) + lp[22] * (2^21) + lp[21] * (2^20) + lp[20] * (2^19) + lp[19] * (2^18) + lp[18] * (2^17) + lp[17] * (2^16) + lp[16] * (2^15) + lp[15] * (2^14) + lp[14] * (2^13) + lp[13] * (2^12) + lp[12] * (2^11) + lp[11] * (2^10) + lp[10] * (2^9) + lp[9] * (2^8) + lp[8] * (2^7) + lp[7] * (2^6) + lp[6] * (2^5) + lp[5] * (2^4) + lp[4] * (2^3) + lp[3] * (2^2) + lp[2] * (2^1) + lp[1])))

			-- TX Data
			for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
			socket.try(con:send(string.upper(packet)))
			
		end
		
		-- RX Data
		local data = con:receive()
		if data then
		
			NODE_ID 		= string.byte(data,1) 	-- NODE ID RESERVED ALWAYS 0
			DATA_TYPE 		= string.byte(data,2) 	-- DATA TYPE ALWAYS BCHAR
			SERVICE_CODE 	= string.byte(data,3) 	-- SERVICE CODE DEVICE TYPE 0 UNKNOWN, 1 SWITCH, 2 ENCODER, 3 ANALOG
			MESSAGE_CODE 	= string.byte(data,4) 	-- MESSAGE CODE COUNTER 0 - 255
			DATA0 			= string.byte(data,5) 	-- ATA CHAPTER
			DATA1 			= string.byte(data,6) 	-- ATA SUBCHAPTER
			DATA2 			= string.byte(data,7) 	-- DEVICE NUMBER BUTTON0, BUTTON1, ENCODER2, ANALOG HSB
			DATA3 			= string.byte(data,8) 	-- DEVICE VALUE ON/OFF, ENC LEFT/RIGHT , ANALOG LSB
		
			if SERVICE_CODE == 1 or SERVICE_CODE == 2 then -- SWITCH/ENCODER DEVICE
				canOpsTable[((DATA0 * (16^6)) + (DATA1 * (16^4)) + (DATA2 * (16^2)) + DATA3)]()
			elseif SERVICE_CODE == 3 then -- ANALOG DEVICE
				canOpsTable[(DATA0 * (16^2)) + DATA1]((DATA2 * (16^2)) + DATA3)
			end
		
		end
			
		if PrevLuaExportBeforeNextFrame then PrevLuaExportBeforeNextFrame(); end

	end

end

do
	
	local PrevLuaExportStop = LuaExportStop;
	LuaExportStop = function()

		socket.try(con:close())
		if PrevLuaExportStop then PrevLuaExportStop(); end

	end

end