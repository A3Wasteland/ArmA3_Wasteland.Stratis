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
	
	Name: outpostSoulRampart.sqf
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

["Land_Cargo_Patrol_V2_F",[-0.25,6.125,0.000378132],180],
["Land_Cargo_Patrol_V2_F",[-0.25,-6.125,0.000378132],0],
["Land_HBarrier_5_F",[-0.25,-7.75,0.000378609],0],
["Land_HBarrier_5_F",[-5.875,-7.75,0.000378609],0],
["Land_HBarrier_5_F",[7.5,5.625,0.000378609],270],
["Land_HBarrier_5_F",[-5.75,7.625,0.000378132],0],
["Land_HBarrier_5_F",[5.5,7.625,0.000377655],0],
["Land_HBarrier_5_F",[11,0,0.000377655],270],
["Land_HBarrier_5_F",[7.5,-5.625,0.000379086],270],
["Land_HBarrier_5_F",[-0.125,7.625,0.000378609],0],
["Land_HBarrier_5_F",[-11.375,-0.125,0.000377655],270],
["Land_HBarrier_5_F",[-7.875,-5.75,0.000377655],270],
["Land_HBarrier_5_F",[-7.875,5.5,0.000377655],270],
["Land_HBarrier_5_F",[5.375,-7.75,0.000378609],0],
["Land_HBarrier_5_F",[-5.875,2,0.000377655],180],
["Land_HBarrier_5_F",[-0.25,2,0.000379562],180],
["Land_HBarrier_5_F",[5.5,-2,0.000377178],0],
["Land_HBarrier_5_F",[-0.125,-2,0.000377655],0],
["Land_LampShabby_F",[-3.375,2,0.000377655],90],
["Land_LampShabby_F",[3,-2,0.000377655],270],
["Land_HBarrier_3_F",[6.5,-6.75,1.25038],135],
["Land_HBarrier_3_F",[-7,-2.5,0.000378609],135],
["Land_HBarrier_3_F",[-6.875,6.625,1.25038],135],
["Land_HBarrier_3_F",[-6.875,-6.75,1.25038],45],
["Land_HBarrier_3_F",[6.375,6.625,1.25038],45],
["Land_HBarrier_3_F",[6.625,2.25,0.000377655],135],
["Land_HBarrier_3_F",[8.625,-1.125,0.000377655],135],
["Land_HBarrier_3_F",[-8.875,0.875,0.000342369],135],
["Box_FIA_Wps_F",[4.75,-5,0],270,{_this call randomCrateLoadOut;}],
["Box_FIA_Wps_F",[-5,4.801,0],90,{_this call randomCrateLoadOut;}]

]
