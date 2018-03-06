// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedHeli.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass = selectRandom
	[
		["B_Heli_Light_01_dynamicLoadout_F", "PawneeMission"],
		["B_Heli_Attack_01_dynamicLoadout_F", "BlackfootMission"],
		["O_Heli_Light_02_dynamicLoadout_F", "orcaMission"],
		["O_Heli_Attack_02_dynamicLoadout_F", "KajmanMissionCAS"],
		["O_Heli_Attack_02_dynamicLoadout_F", "KajmanMissionAG"],
		["I_Heli_light_03_dynamicLoadout_F", "HellMission"],
		"B_Heli_Transport_03_black_F",
		"B_Heli_Transport_01_camo_F"
	];

	_missionType = "Experimental Attack Chopper";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;