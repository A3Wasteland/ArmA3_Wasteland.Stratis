// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_RoadBlock.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, soulkobk
//	@file Created: 08/12/2012 15:19
//	@file Modified: 4:31 PM 06/07/2016 (soulkobk)

if (!isServer) exitwith {};

#include "sideMissionDefines.sqf";

private ["_nbUnits", "_roadBlock", "_objects", "_loadout"];

_setupVars =
{
	_missionType = "Road Block";
	_locationsArray = RoadBlockMissionMarkers;
};
_setupObjects =
{
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	_missionPos = markerPos _missionLocation;
	_missionDir = markerDir _missionLocation;
	_roadBlock = selectRandom (call compile preprocessFileLineNumbers "server\missions\roadBlocks\roadBlockList.sqf");
	_objects = [_roadBlock, _missionPos, _missionDir] call createRoadBlock;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach _objects;
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 15] call createCustomGroup;
	_missionHintText = format ["Enemies have set up a road block and are stopping all traffic! Go and take it over!", sideMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	{ deleteVehicle _x } forEach _objects;
};
_successExec =
{
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;
	
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;
	
	_successHintMessage = "The road block has been taken over, good work!";

	// changed by soulkobk for random number of boxes and random crate loot
	_crateBoxes = 
	[
		"Box_IND_Ammo_F",
		"Box_IND_AmmoOrd_F",
		"Box_IND_Grenades_F",
		"Box_IND_Support_F",
		"Box_IND_Wps_F",
		"Box_IND_WpsLaunch_F",
		"Box_IND_WpsSpecial_F"
	];
	_numBoxes = round(random 2) + 1; // minimum 1, maximum 4.
	switch (_numBoxes) do // because apparently a for _i loop doesnt work with missions... bad coding? pfft.
	{
		case 1: {
			_crateBox1 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox1 setDir random 360;
			_crateBox1 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
		};
		case 2: {
			_crateBox1 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox1 setDir random 360;
			_crateBox1 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
			_crateBox2 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox2 setDir random 360;
			_crateBox2 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
		};
		case 3: {
			_crateBox1 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox1 setDir random 360;
			_crateBox1 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
			_crateBox2 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox2 setDir random 360;
			_crateBox2 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
			_crateBox3 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox3 setDir random 360;
			_crateBox3 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
		};
		case 4: {
			_crateBox1 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox1 setDir random 360;
			_crateBox1 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
			_crateBox2 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox2 setDir random 360;
			_crateBox2 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
			_crateBox3 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox3 setDir random 360;
			_crateBox3 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
			_crateBox4 = createVehicle [(selectRandom _crateBoxes), _missionPos, [], 15, "None"];
			_crateBox4 setDir random 360;
			_crateBox4 call randomCrateLoadOut; // must use soulkobk' randomCrateLoadOut script (github.com/soulkobk).
		};
	};
};

_this call sideMissionProcessor;
