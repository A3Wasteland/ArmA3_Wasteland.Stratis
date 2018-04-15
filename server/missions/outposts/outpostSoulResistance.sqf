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
	
	Name: outpostSoulResistance.sqf
	Version: 1.0.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 10:55 PM 27/05/2016
	Modification Date: 10:55 PM 27/05/2016
	
	Description:
	For use with A3Wasteland 1.2b mission (A3Wasteland.com).
	
	Parameter(s): none

	Example: none
	
	Change Log:
	1.0.0 -	original base script.

	----------------------------------------------------------------------------------------------
*/

[

["CamoNet_BLUFOR_open_F",[0,-0.625,0.875],90],
["Land_BagBunker_Tower_F",[7.125,6.375,0],180],
["Land_BagBunker_Tower_F",[-7.413,-6.841,0],0],
["Land_HBarrier_Big_F",[-0.113232,7.06883,0],180],
["Land_HBarrier_Big_F",[-3.36323,3.81883,0],270],
["Land_HBarrier_Big_F",[-0.125,-7.375,0],0],
["Land_HBarrier_Big_F",[3.125,-4.125,0],90],
["Land_HBarrier_5_F",[-0.113232,7.06883,2],180],
["Land_HBarrier_5_F",[-0.125,-7.375,2],0],
["Land_HBarrier_5_F",[-7,0.625,0],90],
["Land_HBarrier_5_F",[6.75,-1,0],270],
["Land_LampShabby_F",[-3.625,-7.25,0],0],
["Land_LampShabby_F",[-2.98823,0.568832,0],90],
["Land_LampShabby_F",[3.38677,6.94383,0],180],
["Land_LampShabby_F",[2.75,-0.875,0],270],
["I_HMG_01_high_F",[-7.5,-8.25,2.75],224.259], // keep static hmg.
["I_HMG_01_high_F",[9.63365,-5.67368,0],134.326], // keep static hmg.
["I_HMG_01_high_F",[7.212,7.784,2.75],44.2588], // keep static hmg.
["I_HMG_01_high_F",[-9.87188,5.36751,0],314.326], // keep static hmg.
["Land_HBarrier_3_F",[3.125,-4.125,2],90],
["Land_HBarrier_3_F",[-3.36323,3.81883,2],270],
["B_CargoNet_01_ammo_F",[0,0,0],0,{_this allowDamage false; _this setVariable ["A3W_inventoryLockR3F", true, true];}], // leave crate as-is, disallow damage, lock crate until mission complete.
["Land_BagFence_Round_F",[-9.73823,7.94383,0],180],
["Land_BagFence_Round_F",[6.375,-10.625,0],315],
["Land_BagFence_Round_F",[13.125,-4.75,0],270],
["Land_BagFence_Round_F",[9.5,-8.25,0],0],
["Land_BagFence_Round_F",[-6.61323,10.3188,0],135],
["Land_BagFence_Round_F",[-13.3632,4.44383,0],90],
["Land_BagFence_Long_F",[-7.23823,7.69383,0],90],
["Land_BagFence_Long_F",[9.67477,-0.465172,0],225],
["Land_BagFence_Long_F",[7,-8,0],270],
["Land_BagFence_Long_F",[-3.73823,12.4438,0],270],
["Land_BagFence_Long_F",[7.212,3.534,2.75],180],
["Land_BagFence_Long_F",[11.625,-7.125,0],135],
["Land_BagFence_Long_F",[3.5,-12.75,0],90],
["Land_BagFence_Long_F",[-11.9882,2.19383,0],45],
["Land_BagFence_Long_F",[-3,-11.25,0],0],
["Land_BagFence_Long_F",[-11.8632,6.81883,0],315],
["Land_BagFence_Long_F",[0,-11.25,0],0],
["Land_BagFence_Long_F",[2.76177,10.9438,0],180],
["Land_BagFence_Long_F",[11.75,-2.5,0],225],
["Land_BagFence_Long_F",[1.375,-12.75,0],90],
["Land_BagFence_Long_F",[-9.913,0.159004,0],45],
["Land_BagFence_Long_F",[-1.61323,12.4438,0],270],
["Land_BagFence_Long_F",[-7.5,-4,2.75],0],
["Land_BagFence_Long_F",[-0.238232,10.9438,0],180],
["Box_East_WpsSpecial_F",[7.07523,4.21517,0],0,{_this call randomCrateLoadOut;}],
["Box_East_WpsSpecial_F",[-7.375,-4.75,0],0,{_this call randomCrateLoadOut;}],
["Land_BagFence_Short_F",[-8.288,-1.466,0],225],
["Land_BagFence_Short_F",[7.625,-7.25,0],45],
["Land_BagFence_Short_F",[-7.86323,6.94383,0],225],
["Land_BagFence_Short_F",[5.33723,5.15917,2.75],270],
["Land_BagFence_Short_F",[8.04977,1.15983,0],45],
["Land_BagFence_Short_F",[4.25,-11.25,0],0],
["Land_BagFence_Short_F",[-4.48823,10.9438,0],180],
["Land_BagFence_Short_F",[-5.625,-5.625,2.75],90],
["Land_BagFence_Corner_F",[-6,-4.25,2.75],0],
["Land_BagFence_Corner_F",[5.712,3.784,2.75],179.326],
["Land_BagFence_Corner_F",[-9.125,-4.375,2.75],270],
["Land_BagFence_Corner_F",[8.837,3.909,2.75],90]

]
