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
	
	Name: outpostSoulRecon.sqf
	Version: 1.0.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 8:16 PM 26/05/2016
	Modification Date: 8:16 PM 26/05/2016
	
	Description:
	For use with A3Wasteland 1.2b mission (A3Wasteland.com).
	
	Parameter(s): none

	Example: none
	
	Change Log:
	1.0.0 -	original base script.

	----------------------------------------------------------------------------------------------
*/

[

["Land_Cargo_Tower_V1_F",[0,0,0],270],
["Land_Cargo_Patrol_V1_F",[8.45585,9.25773,4.76837e-007],225],
["Land_Cargo_Patrol_V1_F",[-9.04415,-8.49227,4.76837e-007],45],
["Land_BagBunker_Tower_F",[-7.54415,15.2577,0],90],
["Land_BagBunker_Tower_F",[6.70585,-14.4923,0],270],
["Land_BarGate_F",[20.7058,-8.24227,0],270],
["Land_BarGate_F",[-21.2942,8.50773,0],90],
["Land_LampHalogen_F",[12.7058,-3.99227,4.76837e-007],180],
["Land_LampHalogen_F",[-13.0442,4.75773,0.17999],0],
["Land_HBarrier_Big_F",[15.7058,-12.4923,0],180],
["Land_HBarrier_Big_F",[-16.2942,13.2577,0],0],
["Land_HBarrier_Big_F",[-13.2942,-9.24227,0],270],
["Land_HBarrier_Big_F",[3.45585,-7.49227,0],270],
["Land_HBarrier_Big_F",[-9.79415,-12.4923,0],180],
["Land_HBarrier_Big_F",[15.9558,-3.74227,0],0],
["Land_HBarrier_Big_F",[-4.29415,8.25773,0],270],
["Land_HBarrier_Big_F",[-1.29415,-12.4923,0],180],
["Land_HBarrier_Big_F",[-16.2942,4.50773,0],180],
["Land_HBarrier_Big_F",[12.7058,10.0077,0],90],
["Land_HBarrier_Big_F",[12.7058,1.50773,0],90],
["Land_HBarrier_Big_F",[0.705849,13.2577,0],0],
["Land_HBarrier_Big_F",[9.20585,13.2577,0],0],
["Land_HBarrier_Big_F",[-13.2942,-0.742268,0],270],
["Land_HBarrier_3_F",[6.20585,5.25773,0],0],
["Land_HBarrier_3_F",[-6.79415,-4.49227,0],0],
["Land_BagFence_Round_F",[-9.75,8,0],45],
["Land_BagFence_Round_F",[9,-7.25,0],225],
["Land_BagFence_Long_F",[6.25,-6.5,0],0],
["Land_BagFence_Long_F",[-10.5,10.75,0],270],
["Land_BagFence_Long_F",[9.75,-10,0],90],
["Land_BagFence_Long_F",[-7,7.25,0],180],
["Land_BagFence_Long_F",[10,3.75,0],0],
["Land_BagFence_Long_F",[-10.5,-3,0],180],
["Land_BagFence_Corner_F",[7.75,4,0],180],
["Land_BagFence_Corner_F",[-8.25,-3.25,0],0],
["I_supplyCrate_F",[0.955849,-2.99227,17.8895],90,{_this call randomCrateLoadOut;}],
["Box_IND_WpsSpecial_F",[5.70585,-3.99227,15.5007],90, {_this call randomCrateLoadOut;}],
["Box_NATO_WpsSpecial_F",[5.70585,-1.49227,15.5007],90,{_this call randomCrateLoadOut;}],
["I_HMG_01_high_F",[8.70585,-14.2423,2.78],270,{if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup}],
["I_HMG_01_high_F",[-9.54415,15.0077,2.78],90,{if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup}],
["I_HMG_01_high_F",[7,-9,0],90,{if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup}],
["I_HMG_01_high_F",[-8,10,0],270,{if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup}]

]
