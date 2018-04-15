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
	
	Name: outpostSoulRapid.sqf
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

["Land_BagBunker_Tower_F",[3.75,4,0],225],
["Land_Mil_WallBig_4m_F",[-3.375,3.75,0],90,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-10.375,0.625,0],90,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-10.375,-3.375,0],90,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[7.625,-3.25,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-3.375,-0.25,0],90,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[3.625,-3.25,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-3.375,-10.375,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[10.625,7.75,0],270,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-0.375,10.75,0],180,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[10.625,-0.25,0],270,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-10.375,-7.375,0],90,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[0.625,-10.375,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-3.375,7.75,0],90,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-0.375001,-3.25,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[-7.375,-10.375,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_4m_F",[7.625,10.75,0],180,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_Corner_F",[-3.125,-3,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_Corner_F",[10.375,10.5,0],180,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_Corner_F",[-10.125,-10.125,0],0,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_Corner_F",[10.375,-3,0],270,{_this setVectorUP [0,0,1];}],
["Land_Mil_WallBig_Corner_F",[-3.125,10.5,0],90,{_this setVectorUP [0,0,1];}],
["Land_HBarrier_5_F",[-6.75,-0.875,0],90],
["Land_HBarrier_5_F",[5.375,-10.125,0],90],
["Land_HBarrier_5_F",[-3,14,0],0],
["Land_HBarrier_5_F",[2.625,14,0],180],
["Land_HBarrier_5_F",[-13.75,-2.375,0],90],
["Land_HBarrier_5_F",[5.5,-8.625,1.25],90],
["Land_HBarrier_5_F",[14,2.75,0],270],
["Land_HBarrier_5_F",[4.625,-6.5,0],0],
["Land_HBarrier_5_F",[14,-2.875,0],90],
["Land_HBarrier_5_F",[14,3.875,1.125],270],
["Land_HBarrier_5_F",[-13.75,3.25,0],90],
["Land_HBarrier_5_F",[-6.75,4.75,0],90],
["Land_HBarrier_5_F",[3.25,-13.625,0],0],
["Land_HBarrier_5_F",[-10.25,5.375,0],0],
["Land_HBarrier_5_F",[-8,-13.625,0],0],
["Land_HBarrier_5_F",[-8.75,5.375,1.125],0],
["Land_HBarrier_5_F",[-1,-6.5,0],0],
["Land_HBarrier_5_F",[-6.75001,10.375,0],90],
["Land_HBarrier_5_F",[-2.375,-13.625,0],0],
["Land_HBarrier_5_F",[14,8.375,0],270],
["Land_HBarrier_5_F",[-13.75,-8,0],90],
["Land_HBarrier_5_F",[10.25,-6.5,0],0],
["Land_HBarrier_5_F",[8.25,14,0],180],
["Land_HBarrier_5_F",[3.75,14,1.25],0],
["I_HMG_01_high_F",[-1.25,5.25,0],45], // keep static hmg.
["I_HMG_01_high_F",[5.375,-1.375,0],45], // keep static hmg.
["I_HMG_01_high_F",[-7,-8.75,0],90], // keep static hmg.
["I_HMG_01_high_F",[-8.5,-6.875,0],0], // keep static hmg.
["Land_HBarrier_3_F",[13.25,-5.75,1.25],135],
["Land_HBarrier_3_F",[-13.875,-13.875,0],45],
["Land_HBarrier_3_F",[-6,13.25,1.25],135],
["Land_HBarrier_3_F",[12.5,12.625,1.25],225],
["Land_HBarrier_3_F",[12.5,12.625,0],225],
["Land_BagFence_Long_F",[4.30963,2.18105,3.5],135],
["Land_BagFence_Long_F",[1.25,2,2.78],45],
["Land_BagFence_Long_F",[1.875,4.625,2.78],135],
["Land_BagFence_Long_F",[1.25,2,3.375],45],
["Land_BagFence_Long_F",[4,11,0],0],
["Land_BagFence_Long_F",[10.875,4.125,0],270],
["Land_BagFence_Long_F",[1.875,4.625,3.375],135],
["Land_BagFence_Long_F",[4.30963,2.18105,2.78],135],
["Land_HBarrier_1_F",[13.75,-6.375,0],45],
["Land_HBarrier_1_F",[-6.5,13.75,0],45],
["Land_BagFence_End_F",[2.125,11,0],180],
["Land_BagFence_End_F",[2.5,0.75,2.78],45],
["Land_BagFence_End_F",[3,0.875,3.5],135],
["Land_BagFence_End_F",[0.625,3.375,2.78],135],
["Land_BagFence_End_F",[2.5,0.75,3.375],45],
["Land_BagFence_End_F",[3,0.875,2.78],135],
["Land_BagFence_End_F",[10.875,2.25,0],90],
["Land_BagFence_End_F",[0.625,3.375,3.375],135],
["Box_FIA_Ammo_F",[2.625,2.875,0],45,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}], // leave crate as-is, disallow damage, lock crate until mission complete.
["O_CargoNet_01_ammo_F",[2.5,2.75,2.78],135,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}] // leave crate as-is, disallow damage, lock crate until mission complete.

]
