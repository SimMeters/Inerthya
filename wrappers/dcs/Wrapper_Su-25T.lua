------------------------------------------------------------------------------------------------------------------------
-- Copyright (c) 2014, SimMeters.
-- All rights reserved. Released under the BSD license.
-- Wrapper_Su-25T.lua 1.0 01/01/2014 (Import/Export script for SimMeters Workspace DCS Wrapper)

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
canOpsTable = {}

-- Some analog joystick/mouse input commands:
----------------------------------------------------------------------------------------------------
canOpsTable[0x00000000] = function() LoSetCommand(1,0) end -- joystick pitch	
canOpsTable[0x00000000] = function() LoSetCommand(2,0) end -- joystick roll	
canOpsTable[0x00000000] = function() LoSetCommand(3,0) end -- joystick rudder	

-- Thrust values are inverted for some internal reasons, sorry.	
----------------------------------------------------------------------------------------------------
canOpsTable[0x00000000] = function() LoSetCommand(4,0) end   -- joystick thrust (both engines)
canOpsTable[0x00000000] = function() LoSetCommand(5,0) end   -- joystick left engine thrust
canOpsTable[0x00000000] = function() LoSetCommand(6,0) end   -- joystick right engine thrust
canOpsTable[0x00000000] = function() LoSetCommand(7,0) end   -- mouse camera rotate left/right 
canOpsTable[0x00000000] = function() LoSetCommand(8,0) end   -- mouse camera rotate up/down
canOpsTable[0x00000000] = function() LoSetCommand(9,0) end   -- mouse camera zoom 
canOpsTable[0x00000000] = function() LoSetCommand(10,0) end  -- joystick camera rotate left/right
canOpsTable[0x00000000] = function() LoSetCommand(11,0) end  -- joystick camera rotate up/down
canOpsTable[0x00000000] = function() LoSetCommand(12,0) end  -- joystick camera zoom 
canOpsTable[0x00000000] = function() LoSetCommand(13,0) end  -- mouse pitch
canOpsTable[0x00000000] = function() LoSetCommand(14,0) end  -- mouse roll
canOpsTable[0x00000000] = function() LoSetCommand(15,0) end  -- mouse rudder

-- Thrust values are inverted for some internal reasons, sorry.
----------------------------------------------------------------------------------------------------
canOpsTable[0x00000000] = function() LoSetCommand(16,0) end  -- mouse thrust (both engines)
canOpsTable[0x00000000] = function() LoSetCommand(17,0) end  -- mouse left engine thrust
canOpsTable[0x00000000] = function() LoSetCommand(18,0) end  -- mouse right engine thrust
canOpsTable[0x00000000] = function() LoSetCommand(19,0) end  -- mouse trim pitch
canOpsTable[0x00000000] = function() LoSetCommand(20,0) end  -- mouse trim roll
canOpsTable[0x00000000] = function() LoSetCommand(21,0) end  -- mouse trim rudder
canOpsTable[0x00000000] = function() LoSetCommand(22,0) end  -- joystick trim pitch
canOpsTable[0x00000000] = function() LoSetCommand(23,0) end  -- joystick trim roll
canOpsTable[0x00000000] = function() LoSetCommand(24,0) end  -- trim rudder
canOpsTable[0x00000000] = function() LoSetCommand(25,0) end  -- mouse rotate radar antenna left/right
canOpsTable[0x00000000] = function() LoSetCommand(26,0) end  -- mouse rotate radar antenna up/down
canOpsTable[0x00000000] = function() LoSetCommand(27,0) end  -- joystick rotate radar antenna left/right
canOpsTable[0x00000000] = function() LoSetCommand(28,0) end  -- joystick rotate radar antenna up/down
canOpsTable[0x00000000] = function() LoSetCommand(29,0) end  -- mouse MFD zoom
canOpsTable[0x00000000] = function() LoSetCommand(30,0) end  -- joystick MFD zoom
canOpsTable[0x00000000] = function() LoSetCommand(31,0) end  -- mouse move selecter left/right
canOpsTable[0x00000000] = function() LoSetCommand(32,0) end  -- mouse move selecter up/down
canOpsTable[0x00000000] = function() LoSetCommand(33,0) end  -- joystick move selecter left/right
canOpsTable[0x00000000] = function() LoSetCommand(34,0) end  -- joystick move selecter up/down

-- Some discrete keyboard input commands (value is absent):
----------------------------------------------------------------------------------------------------
canOpsTable[0x00000000] = function() LoSetCommand(7) end	-- Cockpit view
canOpsTable[0x00000000] = function() LoSetCommand(8) end	-- External
canOpsTable[0x00000000] = function() LoSetCommand(9) end	-- Fly-by view
canOpsTable[0x00000000] = function() LoSetCommand(10) end -- Ground units view	
canOpsTable[0x00000000] = function() LoSetCommand(11) end -- Civilian transport view 
canOpsTable[0x00000000] = function() LoSetCommand(12) end -- Chase view	
canOpsTable[0x00000000] = function() LoSetCommand(13) end -- Navy view	
canOpsTable[0x00000000] = function() LoSetCommand(14) end -- Close air combat view	
canOpsTable[0x00000000] = function() LoSetCommand(15) end -- Theater view	
canOpsTable[0x00000000] = function() LoSetCommand(16) end -- Airfield (free camera) view	
canOpsTable[0x00000000] = function() LoSetCommand(17) end --	Instruments panel view on
canOpsTable[0x00000000] = function() LoSetCommand(18) end -- Instruments panel view off	
canOpsTable[0x00000000] = function() LoSetCommand(19) end -- Padlock toggle	
canOpsTable[0x00000000] = function() LoSetCommand(20) end --	Stop padlock (in cockpit only)
canOpsTable[0x00000000] = function() LoSetCommand(21) end --	External view for my plane 
canOpsTable[0x00000000] = function() LoSetCommand(22) end --	Automatic chase mode for launched weapon
canOpsTable[0x00000000] = function() LoSetCommand(23) end --	View allies only filter 
canOpsTable[0x00000000] = function() LoSetCommand(24) end --	View enemies only filter 
canOpsTable[0x00000000] = function() LoSetCommand(26) end -- View allies & enemies filter 
canOpsTable[0x00000000] = function() LoSetCommand(28) end -- Rotate the camera left fast 
canOpsTable[0x00000000] = function() LoSetCommand(29) end -- Rotate the camera right fast 
canOpsTable[0x00000000] = function() LoSetCommand(30) end -- Rotate the camera up fast 
canOpsTable[0x00000000] = function() LoSetCommand(31) end -- Rotate the camera down fast 
canOpsTable[0x00000000] = function() LoSetCommand(32) end -- Rotate the camera left slow 
canOpsTable[0x00000000] = function() LoSetCommand(33) end -- Rotate the camera right slow 
canOpsTable[0x00000000] = function() LoSetCommand(34) end -- Rotate the camera up slow	
canOpsTable[0x00000000] = function() LoSetCommand(35) end -- Rotate the camera down slow	
canOpsTable[0x00000000] = function() LoSetCommand(36) end -- Return the camera to default position 
canOpsTable[0x00000000] = function() LoSetCommand(37) end --	View zoom in fast 
canOpsTable[0x00000000] = function() LoSetCommand(38) end -- View zoom out fast 
canOpsTable[0x00000000] = function() LoSetCommand(39) end -- View zoom in slow 
canOpsTable[0x00000000] = function() LoSetCommand(40) end -- View zoom out slow
canOpsTable[0x00000000] = function() LoSetCommand(41) end -- Pan the camera left 
canOpsTable[0x00000000] = function() LoSetCommand(42) end -- Pan the camera right 
canOpsTable[0x00000000] = function() LoSetCommand(43) end -- Pan the camera up 
canOpsTable[0x00000000] = function() LoSetCommand(44) end -- Pan the camera down 
canOpsTable[0x00000000] = function() LoSetCommand(45) end -- Pan the camera left slow 
canOpsTable[0x00000000] = function() LoSetCommand(46) end -- Pan the camera right slow 
canOpsTable[0x00000000] = function() LoSetCommand(47) end -- Pan the camera up slow 
canOpsTable[0x00000000] = function() LoSetCommand(48) end -- Pan the camera down slow 
canOpsTable[0x00000000] = function() LoSetCommand(49) end -- Disable panning the camera 
canOpsTable[0x00000000] = function() LoSetCommand(50) end -- Allies chat 
canOpsTable[0x00000000] = function() LoSetCommand(51) end -- Mission quit 
canOpsTable[0x00000000] = function() LoSetCommand(52) end -- Suspend/resume model time 
canOpsTable[0x00000000] = function() LoSetCommand(53) end -- Accelerate model time 
canOpsTable[0x00000000] = function() LoSetCommand(54) end -- Step by step simulation when model time is suspended 
canOpsTable[0x00000000] = function() LoSetCommand(55) end --	Take control in the track 
canOpsTable[0x00000000] = function() LoSetCommand(57) end -- Common chat	
canOpsTable[0x00000000] = function() LoSetCommand(59) end -- Altitude stabilization 
canOpsTable[0x00000000] = function() LoSetCommand(62) end -- Autopilot 
canOpsTable[0x00000000] = function() LoSetCommand(63) end -- Auto-thrust 
canOpsTable[0x00000000] = function() LoSetCommand(64) end -- Power up 
canOpsTable[0x00000000] = function() LoSetCommand(65) end -- Power down 
canOpsTable[0x00000000] = function() LoSetCommand(68) end -- Gear 
canOpsTable[0x00000000] = function() LoSetCommand(69) end -- Hook 
canOpsTable[0x00000000] = function() LoSetCommand(70) end -- Pack wings	
canOpsTable[0x00000000] = function() LoSetCommand(71) end -- Canopy 
canOpsTable[0x00000000] = function() LoSetCommand(72) end -- Flaps 
canOpsTable[0x00000000] = function() LoSetCommand(73) end -- Air brake 
canOpsTable[0x00000000] = function() LoSetCommand(74) end -- Wheel brakes on 
canOpsTable[0x00000000] = function() LoSetCommand(75) end -- Wheel brakes off 
canOpsTable[0x00000000] = function() LoSetCommand(76) end -- Release drogue chute 
canOpsTable[0x00000000] = function() LoSetCommand(77) end -- Drop snar 
canOpsTable[0x00000000] = function() LoSetCommand(78) end -- Wingtip smoke 
canOpsTable[0x00000000] = function() LoSetCommand(79) end -- Refuel on 
canOpsTable[0x00000000] = function() LoSetCommand(80) end -- Refuel off 
canOpsTable[0x00000000] = function() LoSetCommand(81) end -- Salvo 
canOpsTable[0x00000000] = function() LoSetCommand(82) end -- Jettison weapons 
canOpsTable[0x00000000] = function() LoSetCommand(83) end -- Eject 
canOpsTable[0x00000000] = function() LoSetCommand(84) end -- Fire on 
canOpsTable[0x00000000] = function() LoSetCommand(85) end -- Fire off 
canOpsTable[0x00000000] = function() LoSetCommand(86) end -- Radar 
canOpsTable[0x00000000] = function() LoSetCommand(87) end -- EOS 
canOpsTable[0x00000000] = function() LoSetCommand(88) end -- Rotate the radar antenna left 
canOpsTable[0x00000000] = function() LoSetCommand(89) end -- Rotate the radar antenna right 
canOpsTable[0x00000000] = function() LoSetCommand(90) end -- Rotate the radar antenna up 
canOpsTable[0x00000000] = function() LoSetCommand(91) end -- Rotate the radar antenna down 
canOpsTable[0x00000000] = function() LoSetCommand(92) end -- Center the radar antenna 
canOpsTable[0x00000000] = function() LoSetCommand(93) end -- Trim left 
canOpsTable[0x00000000] = function() LoSetCommand(94) end -- Trim right 
canOpsTable[0x00000000] = function() LoSetCommand(95) end -- Trim up 
canOpsTable[0x00000000] = function() LoSetCommand(96) end -- Trim down 
canOpsTable[0x00000000] = function() LoSetCommand(97) end -- Cancel trimming 
canOpsTable[0x00000000] = function() LoSetCommand(98) end -- Trim the rudder left 
canOpsTable[0x00000000] = function() LoSetCommand(99) end -- Trim the rudder right 
canOpsTable[0x00000000] = function() LoSetCommand(100) end -- Lock the target 
canOpsTable[0x00000000] = function() LoSetCommand(101) end -- Change weapon 
canOpsTable[0x00000000] = function() LoSetCommand(102) end -- Change target 
canOpsTable[0x00000000] = function() LoSetCommand(103) end -- MFD zoom in 
canOpsTable[0x00000000] = function() LoSetCommand(104) end -- MFD zoom out 
canOpsTable[0x00000000] = function() LoSetCommand(105) end -- Navigation mode 
canOpsTable[0x00000000] = function() LoSetCommand(106) end -- BVR mode 
canOpsTable[0x00000000] = function() LoSetCommand(107) end -- VS	mode 
canOpsTable[0x00000000] = function() LoSetCommand(108) end -- Bore mode 
canOpsTable[0x00000000] = function() LoSetCommand(109) end -- Helmet mode 
canOpsTable[0x00000000] = function() LoSetCommand(110) end -- FI0 mode 
canOpsTable[0x00000000] = function() LoSetCommand(111) end -- A2G mode 
canOpsTable[0x00000000] = function() LoSetCommand(112) end -- Grid mode 
canOpsTable[0x00000000] = function() LoSetCommand(113) end -- Cannon 
canOpsTable[0x00000000] = function() LoSetCommand(114) end -- Dispatch wingman - complete mission and RTB
canOpsTable[0x00000000] = function() LoSetCommand(115) end -- Dispatch wingman - complete mission and rejoin 
canOpsTable[0x00000000] = function() LoSetCommand(116) end -- Dispatch wingman - toggle formation 
canOpsTable[0x00000000] = function() LoSetCommand(117) end -- Dispatch wingman - join up formation 
canOpsTable[0x00000000] = function() LoSetCommand(118) end -- Dispatch wingman - attack my target 
canOpsTable[0x00000000] = function() LoSetCommand(119) end -- Dispatch wingman - cover my six 
canOpsTable[0x00000000] = function() LoSetCommand(120) end -- Take off from ship
canOpsTable[0x00000000] = function() LoSetCommand(121) end -- Cobra 
canOpsTable[0x00000000] = function() LoSetCommand(122) end -- Sound on/off 
canOpsTable[0x00000000] = function() LoSetCommand(123) end -- Sound recording on 
canOpsTable[0x00000000] = function() LoSetCommand(124) end -- Sound recording off 
canOpsTable[0x00000000] = function() LoSetCommand(125) end -- View right mirror on 
canOpsTable[0x00000000] = function() LoSetCommand(126) end -- View right mirror off 
canOpsTable[0x00000000] = function() LoSetCommand(127) end -- View left mirror on 
canOpsTable[0x00000000] = function() LoSetCommand(128) end -- View left mirror off 
canOpsTable[0x00000000] = function() LoSetCommand(129) end -- Natural head movement view	
canOpsTable[0x00000000] = function() LoSetCommand(131) end -- LSO view	
canOpsTable[0x00000000] = function() LoSetCommand(135) end -- Weapon to target view 
canOpsTable[0x00000000] = function() LoSetCommand(136) end -- Active jamming 
canOpsTable[0x00000000] = function() LoSetCommand(137) end -- Increase details level 
canOpsTable[0x00000000] = function() LoSetCommand(138) end -- Decrease details level 
canOpsTable[0x00000000] = function() LoSetCommand(139) end -- Scan zone left 
canOpsTable[0x00000000] = function() LoSetCommand(140) end -- Scan zone right 
canOpsTable[0x00000000] = function() LoSetCommand(141) end -- Scan zone up 
canOpsTable[0x00000000] = function() LoSetCommand(142) end -- Scan zone down 
canOpsTable[0x00000000] = function() LoSetCommand(143) end -- Unlock target 
canOpsTable[0x00000000] = function() LoSetCommand(144) end -- Reset master warning 
canOpsTable[0x00000000] = function() LoSetCommand(145) end -- Flaps on 
canOpsTable[0x00000000] = function() LoSetCommand(146) end -- Flaps off 
canOpsTable[0x00000000] = function() LoSetCommand(147) end -- Air brake on 
canOpsTable[0x00000000] = function() LoSetCommand(148) end -- Air brake off 
canOpsTable[0x00000000] = function() LoSetCommand(149) end -- Weapons view 
canOpsTable[0x00000000] = function() LoSetCommand(150) end -- Static objects view
canOpsTable[0x00000000] = function() LoSetCommand(151) end -- Mission targets view 
canOpsTable[0x00000000] = function() LoSetCommand(152) end -- Info bar details 
canOpsTable[0x00000000] = function() LoSetCommand(155) end -- Refueling boom 
canOpsTable[0x00000000] = function() LoSetCommand(156) end -- HUD color selection
canOpsTable[0x00000000] = function() LoSetCommand(158) end -- Jump to terrain view 
canOpsTable[0x00000000] = function() LoSetCommand(159) end -- Starts moving F11 camera forward 
canOpsTable[0x00000000] = function() LoSetCommand(160) end -- Starts moving F11 camera backward
canOpsTable[0x00000000] = function() LoSetCommand(161) end -- Power up left engine 
canOpsTable[0x00000000] = function() LoSetCommand(162) end -- Power down left engine 
canOpsTable[0x00000000] = function() LoSetCommand(163) end -- Power up right engine 
canOpsTable[0x00000000] = function() LoSetCommand(164) end -- Power down right engine 
canOpsTable[0x00000000] = function() LoSetCommand(169) end -- Immortal mode 
canOpsTable[0x00000000] = function() LoSetCommand(175) end -- On-board lights 
canOpsTable[0x00000000] = function() LoSetCommand(176) end -- Drop snar once 
canOpsTable[0x00000000] = function() LoSetCommand(177) end -- Default cockpit angle of view 
canOpsTable[0x00000000] = function() LoSetCommand(178) end -- Jettison fuel tanks 
canOpsTable[0x00000000] = function() LoSetCommand(179) end -- Wingmen commands panel
canOpsTable[0x00000000] = function() LoSetCommand(180) end -- Reverse objects switching in views
canOpsTable[0x00000000] = function() LoSetCommand(181) end -- Forward objects switching in views 
canOpsTable[0x00000000] = function() LoSetCommand(182) end -- Ignore current object in views 
canOpsTable[0x00000000] = function() LoSetCommand(183) end -- View all ignored objects in views again 
canOpsTable[0x00000000] = function() LoSetCommand(184) end -- Padlock terrain point 
canOpsTable[0x00000000] = function() LoSetCommand(185) end -- Reverse the camera 
canOpsTable[0x00000000] = function() LoSetCommand(186) end -- Plane up 
canOpsTable[0x00000000] = function() LoSetCommand(187) end -- Plane down 
canOpsTable[0x00000000] = function() LoSetCommand(188) end -- Bank left 
canOpsTable[0x00000000] = function() LoSetCommand(189) end -- Bank right
canOpsTable[0x00000000] = function() LoSetCommand(190) end -- Local camera rotation mode 
canOpsTable[0x00000000] = function() LoSetCommand(191) end -- Decelerate model time 
canOpsTable[0x00000000] = function() LoSetCommand(192) end -- Jump into the other plane 
canOpsTable[0x00000000] = function() LoSetCommand(193) end -- Nose down 
canOpsTable[0x00000000] = function() LoSetCommand(194) end -- Nose down end 
canOpsTable[0x00000000] = function() LoSetCommand(195) end -- Nose up 
canOpsTable[0x00000000] = function() LoSetCommand(196) end -- Nose up end 
canOpsTable[0x00000000] = function() LoSetCommand(197) end -- Bank left 
canOpsTable[0x00000000] = function() LoSetCommand(198) end -- Bank left end 
canOpsTable[0x00000000] = function() LoSetCommand(199) end -- Bank right 
canOpsTable[0x00000000] = function() LoSetCommand(200) end -- Bank right end 
canOpsTable[0x00000000] = function() LoSetCommand(201) end -- Rudder left 
canOpsTable[0x00000000] = function() LoSetCommand(202) end -- Rudder left end 
canOpsTable[0x00000000] = function() LoSetCommand(203) end -- Rudder right 
canOpsTable[0x00000000] = function() LoSetCommand(204) end -- Rudder right end 
canOpsTable[0x00000000] = function() LoSetCommand(205) end -- View up right 
canOpsTable[0x00000000] = function() LoSetCommand(206) end -- View down right 
canOpsTable[0x00000000] = function() LoSetCommand(207) end -- View down left 
canOpsTable[0x00000000] = function() LoSetCommand(208) end -- View up left 
canOpsTable[0x00000000] = function() LoSetCommand(209) end -- View stop 
canOpsTable[0x00000000] = function() LoSetCommand(210) end -- View up right slow 
canOpsTable[0x00000000] = function() LoSetCommand(211) end -- View down right slow 
canOpsTable[0x00000000] = function() LoSetCommand(212) end -- View down left slow 
canOpsTable[0x00000000] = function() LoSetCommand(213) end -- View up left slow 
canOpsTable[0x00000000] = function() LoSetCommand(214) end -- View stop slow 
canOpsTable[0x00000000] = function() LoSetCommand(215) end -- Stop trimming 
canOpsTable[0x00000000] = function() LoSetCommand(226) end -- Scan zone up right
canOpsTable[0x00000000] = function() LoSetCommand(227) end -- Scan zone down right 
canOpsTable[0x00000000] = function() LoSetCommand(228) end -- Scan zone down left 
canOpsTable[0x00000000] = function() LoSetCommand(229) end -- Scan zone up left 
canOpsTable[0x00000000] = function() LoSetCommand(230) end -- Scan zone stop 
canOpsTable[0x00000000] = function() LoSetCommand(231) end -- Radar antenna up right 
canOpsTable[0x00000000] = function() LoSetCommand(232) end -- Radar antenna down right
canOpsTable[0x00000000] = function() LoSetCommand(233) end -- Radar antenna down left 
canOpsTable[0x00000000] = function() LoSetCommand(234) end -- Radar antenna up left
canOpsTable[0x00000000] = function() LoSetCommand(235) end -- Radar antenna stop
canOpsTable[0x00000000] = function() LoSetCommand(236) end -- Save snap view angles 
canOpsTable[0x00000000] = function() LoSetCommand(237) end -- Cockpit panel view toggle 
canOpsTable[0x00000000] = function() LoSetCommand(245) end -- Coordinates units toggle
canOpsTable[0x00000000] = function() LoSetCommand(246) end -- Disable model time acceleration 
canOpsTable[0x00000000] = function() LoSetCommand(252) end -- Automatic spin recovery 
canOpsTable[0x00000000] = function() LoSetCommand(253) end -- Speed retention 
canOpsTable[0x00000000] = function() LoSetCommand(254) end -- Easy landing 
canOpsTable[0x00000000] = function() LoSetCommand(258) end -- Threat missile padlock 
canOpsTable[0x00000000] = function() LoSetCommand(259) end -- All missiles padlock
canOpsTable[0x00000000] = function() LoSetCommand(261) end -- Marker state 
canOpsTable[0x00000000] = function() LoSetCommand(262) end -- Decrease radar scan area 
canOpsTable[0x00000000] = function() LoSetCommand(263) end -- Increase radar scan area 
canOpsTable[0x00000000] = function() LoSetCommand(264) end -- Marker state plane 
canOpsTable[0x00000000] = function() LoSetCommand(265) end -- Marker state rocket 
canOpsTable[0x00000000] = function() LoSetCommand(266) end -- Marker state plane ship 
canOpsTable[0x00000000] = function() LoSetCommand(267) end -- Ask AWACS home airbase 
canOpsTable[0x00000000] = function() LoSetCommand(268) end -- Ask AWACS available tanker
canOpsTable[0x00000000] = function() LoSetCommand(269) end -- Ask AWACS nearest target 
canOpsTable[0x00000000] = function() LoSetCommand(270) end -- Ask AWACS declare target 
canOpsTable[0x00000000] = function() LoSetCommand(271) end -- Easy radar 
canOpsTable[0x00000000] = function() LoSetCommand(272) end -- Auto lock on nearest aircraft 
canOpsTable[0x00000000] = function() LoSetCommand(273) end -- Auto lock on center aircraft 
canOpsTable[0x00000000] = function() LoSetCommand(274) end -- Auto lock on next aircraft 
canOpsTable[0x00000000] = function() LoSetCommand(275) end -- Auto lock on previous aircraft 
canOpsTable[0x00000000] = function() LoSetCommand(276) end -- Auto lock on nearest surface target 
canOpsTable[0x00000000] = function() LoSetCommand(277) end -- Auto lock on center surface target 
canOpsTable[0x00000000] = function() LoSetCommand(278) end -- Auto lock on next surface target 
canOpsTable[0x00000000] = function() LoSetCommand(279) end -- Auto lock on previous surface target 
canOpsTable[0x00000000] = function() LoSetCommand(280) end -- Change cannon rate of fire
canOpsTable[0x00000000] = function() LoSetCommand(281) end -- Change ripple quantity 
canOpsTable[0x00000000] = function() LoSetCommand(282) end -- Change ripple interval 
canOpsTable[0x00000000] = function() LoSetCommand(283) end -- Switch master arm 
canOpsTable[0x00000000] = function() LoSetCommand(284) end -- Change release mode 
canOpsTable[0x00000000] = function() LoSetCommand(285) end -- Change radar mode RWS/TWS 
canOpsTable[0x00000000] = function() LoSetCommand(286) end -- Change RWR/SPO mode
canOpsTable[0x00000000] = function() LoSetCommand(288) end -- Flight clock reset 
canOpsTable[0x00000000] = function() LoSetCommand(289) end -- Zoom in slow stop 
canOpsTable[0x00000000] = function() LoSetCommand(290) end -- Zoom out slow stop
canOpsTable[0x00000000] = function() LoSetCommand(291) end -- Zoom in stop 
canOpsTable[0x00000000] = function() LoSetCommand(292) end -- Zoom out stop 
canOpsTable[0x00000000] = function() LoSetCommand(295) end -- View horizontal stop 
canOpsTable[0x00000000] = function() LoSetCommand(296) end -- View vertical stop 
canOpsTable[0x00000000] = function() LoSetCommand(298) end -- Jump to fly-by view 
canOpsTable[0x00000000] = function() LoSetCommand(299) end -- Camera jiggle 
canOpsTable[0x00000000] = function() LoSetCommand(300) end -- Cockpit illumination 
canOpsTable[0x00000000] = function() LoSetCommand(308) end -- Change ripple interval down 
canOpsTable[0x00000000] = function() LoSetCommand(309) end -- Engines start 
canOpsTable[0x00000000] = function() LoSetCommand(310) end -- Engines stop 
canOpsTable[0x00000000] = function() LoSetCommand(311) end -- Left engine start 
canOpsTable[0x00000000] = function() LoSetCommand(312) end -- Right engine start 
canOpsTable[0x00000000] = function() LoSetCommand(313) end -- Left engine stop 
canOpsTable[0x00000000] = function() LoSetCommand(314) end -- Right engine stop 
canOpsTable[0x00000000] = function() LoSetCommand(315) end -- Power on/off 
canOpsTable[QNH_ENC_INC] = function() LoSetCommand(316) end -- Altimeter pressure increase 
canOpsTable[QNH_ENC_DEC] = function() LoSetCommand(317) end -- Altimeter pressure decrease 
canOpsTable[0x00000000] = function() LoSetCommand(318) end -- Altimeter pressure stop 
canOpsTable[0x00000000] = function() LoSetCommand(321) end -- Fast mouse in views 
canOpsTable[0x00000000] = function() LoSetCommand(322) end -- Slow mouse in views
canOpsTable[0x00000000] = function() LoSetCommand(323) end -- Normal mouse in views 
canOpsTable[0x00000000] = function() LoSetCommand(326) end -- HUD only view 
canOpsTable[0x00000000] = function() LoSetCommand(327) end -- Recover my plane 
canOpsTable[0x00000000] = function() LoSetCommand(328) end -- Toggle gear light Near/Far/Off 
canOpsTable[0x00000000] = function() LoSetCommand(331) end -- Fast keyboard in views
canOpsTable[0x00000000] = function() LoSetCommand(332) end -- Slow keyboard in views 
canOpsTable[0x00000000] = function() LoSetCommand(333) end -- Normal keyboard in views 
canOpsTable[0x00000000] = function() LoSetCommand(334) end -- Zoom in for external views 
canOpsTable[0x00000000] = function() LoSetCommand(335) end -- Stop zoom in for external views 
canOpsTable[0x00000000] = function() LoSetCommand(336) end -- Zoom out for external views 
canOpsTable[0x00000000] = function() LoSetCommand(337) end -- Stop zoom out for external views 
canOpsTable[0x00000000] = function() LoSetCommand(338) end -- Default zoom in external views 
canOpsTable[0x00000000] = function() LoSetCommand(341) end -- A2G combat view 
canOpsTable[0x00000000] = function() LoSetCommand(342) end -- Camera view up-left
canOpsTable[0x00000000] = function() LoSetCommand(343) end -- Camera view up-right
canOpsTable[0x00000000] = function() LoSetCommand(344) end -- Camera view down-left
canOpsTable[0x00000000] = function() LoSetCommand(345) end -- Camera view down right
canOpsTable[0x00000000] = function() LoSetCommand(346) end -- Camera pan mode toggle
canOpsTable[0x00000000] = function() LoSetCommand(347) end -- Return the camera
canOpsTable[0x00000000] = function() LoSetCommand(348) end -- Trains/cars toggle
canOpsTable[0x00000000] = function() LoSetCommand(349) end -- Launch permission override
canOpsTable[0x00000000] = function() LoSetCommand(350) end -- Release weapon
canOpsTable[0x00000000] = function() LoSetCommand(351) end -- Stop release weapon
canOpsTable[0x00000000] = function() LoSetCommand(352) end -- Return camera base
canOpsTable[0x00000000] = function() LoSetCommand(353) end -- Camera view up-left slow
canOpsTable[0x00000000] = function() LoSetCommand(354) end -- Camera view up-right slow
canOpsTable[0x00000000] = function() LoSetCommand(355) end -- Camera view down-left slow
canOpsTable[0x00000000] = function() LoSetCommand(356) end -- Camera view down-right slow
canOpsTable[0x00000000] = function() LoSetCommand(357) end -- Drop flare once
canOpsTable[0x00000000] = function() LoSetCommand(358) end -- Drop chaff once
canOpsTable[0x00000000] = function() LoSetCommand(359) end -- Rear view
canOpsTable[0x00000000] = function() LoSetCommand(360) end -- Scores window
canOpsTable[0x00000000] = function() LoSetCommand(386) end -- PlaneStabPitchBank
canOpsTable[0x00000000] = function() LoSetCommand(387) end -- PlaneStabHbarBank
canOpsTable[0x00000000] = function() LoSetCommand(388) end -- PlaneStabHorizont
canOpsTable[0x00000000] = function() LoSetCommand(389) end -- PlaneStabHbar
canOpsTable[0x00000000] = function() LoSetCommand(390) end -- PlaneStabHrad
canOpsTable[0x00000000] = function() LoSetCommand(391) end -- Active IR jamming on/off
canOpsTable[0x00000000] = function() LoSetCommand(392) end -- Laser range-finder on/off
canOpsTable[0x00000000] = function() LoSetCommand(393) end -- Night TV on/off(IR or LLTV) 
canOpsTable[0x00000000] = function() LoSetCommand(394) end -- Change radar PRF 
canOpsTable[0x00000000] = function() LoSetCommand(395) end -- Keep F11 camera altitude over terrain
canOpsTable[0x00000000] = function() LoSetCommand(396) end -- SnapView0
canOpsTable[0x00000000] = function() LoSetCommand(397) end -- SnapView1
canOpsTable[0x00000000] = function() LoSetCommand(398) end -- SnapView2
canOpsTable[0x00000000] = function() LoSetCommand(399) end -- SnapView3
canOpsTable[0x00000000] = function() LoSetCommand(400) end -- SnapView4
canOpsTable[0x00000000] = function() LoSetCommand(401) end -- SnapView5
canOpsTable[0x00000000] = function() LoSetCommand(402) end -- SnapView6
canOpsTable[0x00000000] = function() LoSetCommand(403) end -- SnapView7
canOpsTable[0x00000000] = function() LoSetCommand(404) end -- SnapView8
canOpsTable[0x00000000] = function() LoSetCommand(405) end -- SnapView9
canOpsTable[0x00000000] = function() LoSetCommand(406) end -- SnapViewStop
canOpsTable[0x00000000] = function() LoSetCommand(407) end -- F11 view binocular mode
canOpsTable[0x00000000] = function() LoSetCommand(408) end -- PlaneStabCancel
canOpsTable[0x00000000] = function() LoSetCommand(409) end -- ThreatWarnSoundVolumeDown
canOpsTable[0x00000000] = function() LoSetCommand(410) end -- ThreatWarnSoundVolumeUp
canOpsTable[0x00000000] = function() LoSetCommand(411) end -- F11 binocular view laser illumination on/off
canOpsTable[0x00000000] = function() LoSetCommand(412) end -- PlaneIncreaseBase_Distance
canOpsTable[0x00000000] = function() LoSetCommand(413) end -- PlaneDecreaseBase_Distance
canOpsTable[0x00000000] = function() LoSetCommand(414) end -- PlaneStopBase_Distance
canOpsTable[0x00000000] = function() LoSetCommand(415) end -- F11 binocular view range-finder on
canOpsTable[0x00000000] = function() LoSetCommand(416) end -- F11 view range-finder off
canOpsTable[0x00000000] = function() LoSetCommand(425) end -- F11 binocular view IR mode on/off
canOpsTable[0x00000000] = function() LoSetCommand(426) end -- F8 view player targets / all targets
canOpsTable[0x00000000] = function() LoSetCommand(427) end -- Plane autopilot override on
canOpsTable[0x00000000] = function() LoSetCommand(428) end -- Plane autopilot override off

do

	local PrevLuaExportStart = LuaExportStart;
	LuaExportStart = function()

		-- Configure Network
		package.path  = package.path..";.\\LuaSocket\\?.lua"
		package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
		port = 6060
		host = "127.0.0.1"
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

	-- Variometer CANAerospace m/s units
	var = LoGetVerticalVelocity()
	table.insert(flightData,string.format("ID_ALTITUDE_RATE=%.4f",var))
			
	-- Barometric Altimeter Pressure Setting CANAerospace hPa
	var = LoGetBasicAtmospherePressure()
	table.insert(flightData,string.format("ID_BARO_CORRECTION=%.4f",var))

	-- Barometric Altimeter Altitude CANAerospace m
	var = LoGetAltitudeAboveSeaLevel()
	table.insert(flightData,string.format("ID_BARO_CORRECTED_ALTITUDE=%.4f",var))

	-- Indicated Airspeed m/s
	var = LoGetIndicatedAirSpeed()
	table.insert(flightData,string.format("ID_INDICATED_AIRSPEED=%.4f",var))

	-- True Airspeed m/s
	var = LoGetTrueAirSpeed()
	table.insert(flightData,string.format("ID_TRUE_AIRSPEED=%.4f",var))

	-- Mach Number
	var = LoGetMachNumber()
	table.insert(flightData,string.format("ID_MACH_NUMBER=%.4f",var))
	
	--table.insert(flightData,"XXX="..LoGetSelfData().LatLongAlt.Lat)  								-- LATITUDE
	--table.insert(flightData,"XXX="..LoGetSelfData().LatLongAlt.Long) 								-- LONGITUDE
	--table.insert(flightData,"ALT00="..LoGetAltitudeAboveSeaLevel()) 								-- ALTITUDE SEA LEVEL(FEETS)
	--table.insert(flightData,"XXX="..LoGetAltitudeAboveGroundLevel())						-- ALTITUDE GROUND LEVEL(MTS TO FT)
	--table.insert(flightData,"XXX="..LoGetBasicAtmospherePressure())						-- BAROMETRIC PRESSURE(MM TO IN) 
	--table.insert(flightData,"XXX="..LoGetTrueAirSpeed()) 									-- TRUE AIRSPEED (M/S TO KNOTS)
	--table.insert(flightData,"asi="..LoGetIndicatedAirSpeed()) 							-- INDICATED AIRSPEED (M/S TO KNOTS)
	--table.insert(flightData,"XXX="..LoGetMachNumber())	 										-- MACH
	--table.insert(flightData,"XXX="..LoGetVerticalVelocity())								-- VERTICAL SPEED (M/S TO FPM)
	--table.insert(flightData,"XXX="..pitch * 57.3) 												-- PITCH (RAD TO DEG)
	--table.insert(flightData,"XXX="..bank * 57.3) 													-- BANK (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetSelfData().Heading * 57.3) 								-- HEADING (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetSlipBallPosition()) 										-- SLIP BALL (-1 +1)
	--table.insert(flightData,"XXX="..LoGetAngleOfAttack() * 57.3)	 								-- ANGLE OF ATTACK AoA (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetAccelerationUnits().y)	 								-- G-LOAD
	--table.insert(flightData,"XXX="..LoGetNavigationInfo().Requirements.pitch * 57.3)				-- AP REQUIRED PITCH (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetNavigationInfo().Requirements.roll * 57.3)				-- AP REQUIRED BANK (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetNavigationInfo().Requirements.speed)				-- AP SPEED (M/S TO KNOTS)
	--table.insert(flightData,"XXX="..LoGetNavigationInfo().Requirements.altitude)			-- AP ALTITUDE (MTS TO FT)
	--table.insert(flightData,"XXX="..LoGetNavigationInfo().Requirements.vertical_speed)	-- AP VERTICAL SPEED (M/S TO FPM)
	--table.insert(flightData,"XXX="..LoGetSideDeviation())											-- VOR1 HORIZONTAL DEFLECTION (-1 +1)
	--table.insert(flightData,"XXX="..LoGetGlideDeviation())										-- VOR1 VERTICAL DEFLECTION (-1 +1)
	--table.insert(flightData,"XXX="..LoGetControlPanel_HSI().RMI * 57.3)							-- VOR1 OBS (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetControlPanel_HSI().ADF * 57.3)							-- ADF OBS (RAD TO DEG)
	--table.insert(flightData,"XXX="..LoGetEngineInfo().RPM.left)									-- ENG1 RPM %
	--table.insert(flightData,"XXX="..LoGetEngineInfo().RPM.right)									-- ENG2 RPM %
	--table.insert(flightData,"XXX="..LoGetEngineInfo().Temperature.left)							-- ENG1 EGT ºC
	--table.insert(flightData,"XXX="..LoGetEngineInfo().Temperature.right)							-- ENG2 EGT ºC
	--table.insert(flightData,"XXX="..LoGetEngineInfo().fuel_internal)						-- TANK1 (INT) (KG TO LBS)
	--table.insert(flightData,"XXX="..LoGetEngineInfo().fuel_external)						-- TANK2 (EXT) (KG TO LBS)

	-- TX Data
	for i = 1, #flightData do packet = packet .. flightData[i] .. ";" end
	socket.try(con:send(string.upper(packet)))

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
