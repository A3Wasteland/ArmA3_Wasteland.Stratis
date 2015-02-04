// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HackLaptop.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

private ["_positions", "_bunker", "_laptop", "_obj", "_randomGroup", "_vehicleName"];

_setupVars =
{
	_missionType = "Hackers";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 
	

	_bunker = createVehicle ["CamoNet_INDP_big_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_bunker allowdamage false;

	_missionPos = getPosASL _bunker;

	_laptop = createVehicle ["Land_Laptop_unfolded_F", _missionPos, [], 0, "CAN COLLIDE"];
	_laptop setPosASL [_missionPos select 0, (_missionPos select 1) - 0.25, _missionPos select 2];

	_obj = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj setPosASL [_missionPos select 0, (_missionPos select 1) + 2, _missionPos select 2];

	AddLaptopHandler = _laptop;
	publicVariable "AddLaptopHandler";

	_laptop setVariable [ "Done", false, true ];

	// NPC Randomizer 
	_randomGroup = [createGroup1,createGroup2,createGroup3,createGroup4,createGroup5,createGroup6,createGroup7,createGroup8,createGroup9,createGroup10] call BIS_fnc_selectRandom;
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos] spawn _randomGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_vehicleName = "Laptop";
	_missionHintText = format ["<t color='%2'>Hackers</t> are using a laptop to hack bank accounts. Stop them before it's too late and take the money for yourself !", _vehicleName, moneyMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec =
{
	AddLaptopHandler = _laptop;
	publicVariable "AddLaptopHandler";
};
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { _laptop getVariable ["Done", false] };
_ignoreAiDeaths = true;

_failedExec =
{
	// Mission failed
	RemoveLaptopHandler = _laptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_bunker, _obj, _laptop];
};

_successExec =
{
	// Mission completed
	RemoveLaptopHandler = _laptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_bunker, _laptop, _obj];

	_successHintMessage = format ["The laptop is hacked and the smugglers are dead. Well done!"];
};

_this call moneyMissionProcessor;