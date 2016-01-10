------------------------------------------------------------------------------------------------------------------------
-- Copyright(c) 2014 SimMeters.com. All Rights Reserved.
-- adi_0000.jal 1.0 01/01/2014 (Attitude Indicator 2 Servos RC on PORTA0 and PORTA1)
------------------------------------------------------------------------------------------------------------------------
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
add_can_rxfilter(id_body_pitch_angle)
add_can_rxfilter(id_body_roll_angle)
setup_can_end()

set_pin(P21, low)
set_pin(P22, high)

------------------------------------------------------------------------------------------------------------------------
-- Variables
------------------------------------------------------------------------------------------------------------------------
var can_frame cf
var dword cnt   = 0
var dword dst1  = 0
var dword dst2  = 0
var float pit   = 0
var float bnk   = 0

------------------------------------------------------------------------------------------------------------------------
-- Process servos
------------------------------------------------------------------------------------------------------------------------
isr_servo_enable() -- because we use servos
procedure isr_servo_process() is pragma interrupt

    if (INTCON_TMR0IF) then

        isr_servo_reset()
        cnt = cnt + 1

        if(cnt >= 2000) then
            cnt = 0
        else

            -- pitch angle
            if (cnt < dst1) then
                LATA_LATA0 = high
            elsif (cnt == dst1) then
                LATA_LATA0 = low
            end if

            -- bank angle
            if (cnt < dst2) then
                LATA_LATA1 = high
            elsif (cnt == dst2) then
                LATA_LATA1 = low
            end if

        end if

    end if

end procedure

------------------------------------------------------------------------------------------------------------------------
-- Main loop
------------------------------------------------------------------------------------------------------------------------
forever loop

    -- request bootloader for auto update (do not remove)
    request_bootloader("adi_0000")

    -- pitch angle
    cf = get_can_frame(id_body_pitch_angle)
    if(cf.dlc > 0) then

        pit = get_can_float(cf) + float(25) -- CANAerospace pitch data
        if(pit >= float(0) & pit <= float(50)) then
            pit = (pit - float(25))
            dst1 = dword((pit * float(-0.5)) + float(127))
        end if

    end if

    -- bank angle
    cf = get_can_frame(id_body_roll_angle)
    if(cf.dlc > 0) then

        bnk = get_can_float(cf) + float(45) -- CANAerospace bank data
        if(bnk >= float(0) & bnk <= float(90)) then
            bnk = (bnk - float(45))
            dst2 = dword((bnk * float(-1.0)) + float(127))
        end if

    end if

end loop