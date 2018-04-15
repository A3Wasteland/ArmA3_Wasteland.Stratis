/*
	----------------------------------------------------------------------------------------------
	
	Copyright © 2016 soulkobk (soulkobk.blogspot.com)

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.

	----------------------------------------------------------------------------------------------
	
	Name: outpostSoulSupplies.sqf
	Version: 1.0.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 2:14 PM 29/05/2016
	Modification Date: 2:14 PM 29/05/2016
	
	Description:
	For use with A3Wasteland 1.2b mission (A3Wasteland.com).
	
	Parameter(s): none

	Example: none
	
	Change Log:
	1.0.0 -	original base script.

	----------------------------------------------------------------------------------------------
*/

[

["Land_Cargo_HQ_V3_F",[2.375,-3.5,4.76837e-007],0],
["Land_Cargo_Patrol_V3_F",[2.5,7.5,4.76837e-007],180],
["Land_Cargo_House_V3_F",[-4.25,6.25,4.76837e-007],0],
["Land_HBarrier_5_F",[-8.5,8.5,4.76837e-007],90],
["Land_HBarrier_5_F",[6.875,8.5,4.76837e-007],90],
["Land_HBarrier_5_F",[-10.5,5,4.76837e-007],0],
["Land_HBarrier_5_F",[-6.5,12,4.76837e-007],0],
["Land_HBarrier_5_F",[10.5,-11.875,4.76837e-007],0],
["Land_HBarrier_5_F",[12.5,2.875,4.76837e-007],90],
["Land_HBarrier_5_F",[4.875,-11.875,4.76837e-007],0],
["Land_HBarrier_5_F",[-0.75,-11.875,4.76837e-007],0],
["Land_HBarrier_5_F",[-6.375,-11.875,4.76837e-007],0],
["Land_HBarrier_5_F",[4.75,12,4.76837e-007],0],
["Land_HBarrier_5_F",[12.5,-2.75,4.76837e-007],90],
["Land_HBarrier_5_F",[-8.375,-2.75,4.76837e-007],90],
["Land_HBarrier_5_F",[-0.875,12,4.76837e-007],0],
["Land_HBarrier_5_F",[12.5,-8.375,4.76837e-007],90],
["Land_HBarrier_5_F",[-10.5,0.75,4.76837e-007],0],
["Land_HBarrier_5_F",[-8.375,-8.375,4.76837e-007],90],
["Land_HBarrier_5_F",[9,5,4.76837e-007],0],
["I_HMG_01_high_F",[-0.375,-7.375,3.12652],270],
["I_HMG_01_high_F",[8.25,-2.875,3.12652],90],
["I_HMG_01_high_F",[-0.375,-0.125,3.12652],270],
["I_HMG_01_high_F",[-5,-8.12944,-0.00438261],0],
["Land_HBarrier_3_F",[6.25,11.375,1.35619],45],
["Land_HBarrier_3_F",[11.875,-11.25,1.30799],135],
["Land_HBarrier_3_F",[11.875,4.375,1.125],45],
["Land_HBarrier_3_F",[-7.875,11.25,1.34733],135],
["Land_HBarrier_3_F",[-7.75,-11.25,1.34859],45],
["Land_HBarrier_3_F",[-9.125,5.625,1.30799],135],
["Land_HBarrier_3_F",[-9,0.125,1.35619],45],
["Box_FIA_Support_F",[1.125,-1.625,0.601674],0,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}], // leave crate as-is, disallow damage, lock crate until mission complete.
["Box_IND_WpsSpecial_F",[8.125,1.875,0.722088],0,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}], // leave crate as-is, disallow damage, lock crate until mission complete.
["Box_IND_WpsLaunch_F",[5.75,1.875,0.722088],0,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}], // leave crate as-is, disallow damage, lock crate until mission complete.
["Box_IND_Grenades_F",[-0.875,-2.75,3.12652],0,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}], // leave crate as-is, disallow damage, lock crate until mission complete.
["Box_IND_Support_F",[-0.875,-5.25,3.12652],0,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}] // leave crate as-is, disallow damage, lock crate until mission complete.

]
