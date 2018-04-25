-// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedHeli.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev, Mokey
//	@file Created: 4/12/2018 11:13AM

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass = selectRandom
	[
		"B_MBT_01_arty_F",         //NEED LOADOUT
		"O_MBT_02_arty_F",      //NEED LOADOUT
		"B_APC_Tracked_01_AA_F",     //NEED LOADOUT
		"B_MBT_01_mlrs_F",
	];

	_missionType = "Abandoned Vehicle";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;
