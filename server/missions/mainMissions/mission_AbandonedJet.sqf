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
		["I_Plane_Fighter_03_dynamicLoadout_F", "buzzardMission"],
		["B_Plane_CAS_01_dynamicLoadout_F", "WipeoutMission"],
		["O_Plane_CAS_02_dynamicLoadout_F", "NeoMission"],
		["Plane_Fighter_04_Base_F", "GryphonM"],
		["Plane_Fighter_04_Base_F", "GryphonG"],
		["Plane_Fighter_04_Base_F", "GryphonA"],
		["O_T_VTOL_02_infantry_dynamicLoadout_F", "Xi'anAir"],
		"B_Plane_Fighter_01_Stealth_F"

	];

	_missionType = "Abandoned Jet";
	_locationsArray = MissionSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
};

_this call mission_VehicleCapture;
