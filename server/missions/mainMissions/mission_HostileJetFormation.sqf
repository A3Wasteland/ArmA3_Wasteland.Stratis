// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileJetFormation.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf"

private ["_planeChoices", "_convoyVeh", "_veh1", "_veh2", "_veh3", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_vehicleName2", "_numWaypoints", "_box1", "_box2", "_box3", "_smoke"];

_setupVars =
{
	_missionType = "Hostile Jet Squadron";
	//_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos (((call cityList) call BIS_fnc_selectRandom) select 0);

	_planeChoices =
	[
		[["B_Plane_CAS_01_dynamicLoadout_F", "WipeoutMission"], ["Plane_Fighter_03_dynamicLoadout_base_F", "buzzardMission"]],
 		[["O_Plane_CAS_02_dynamicLoadout_F", "NeoMission"], ["Plane_Fighter_03_dynamicLoadout_base_F", "buzzardMission"]],
 		[["B_Plane_CAS_01_dynamicLoadout_F", "WipeoutMission"], ["O_Plane_CAS_02_dynamicLoadout_F", "NeoMission"]],
		["B_Plane_Fighter_01_F", ["Plane_Fighter_04_Base_F", "GryphonM"]],
		["O_Plane_Fighter_02_F", ["Plane_Fighter_04_Base_F", "GryphonM"]]
	];

	if (missionDifficultyHard) then
	{
		(_planeChoices select 0) set [0, ["Plane_Fighter_03_dynamicLoadout_base_F", "buzzardMission"]];
 		(_planeChoices select 1) set [0, ["Plane_Fighter_03_dynamicLoadout_base_F", "buzzardMission"]];
 		(_planeChoices select 2) set [0, ["O_Plane_CAS_02_dynamicLoadout_F", "NeoMission"]];
		(_planeChoices select 3) set [0, ["Plane_Fighter_04_Base_F", "GryphonM"]];
		(_planeChoices select 4) set [0, ["Plane_Fighter_04_Base_F", "GryphonM"]];
	};

	_convoyVeh = _planeChoices call BIS_fnc_selectRandom;

	_veh1 = _convoyVeh select 0;
	_veh2 = _convoyVeh select 1;
	_veh3 = _convoyVeh select 1;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_variant", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;
		_variant = _type param [1,"",[""]];
 
 		if (_type isEqualType []) then
 		{
 			_type = _type select 0;
 		};

		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];

 		if (_variant != "") then
 		{
 			_vehicle setVariable ["A3W_vehicleVariant", _variant, true];
 		};

		[_vehicle] call vehicleSetup;
		_vel = [velocity _vehicle, -(_direction)] call BIS_fnc_rotateVector2D; // Added to make it fly
		_vehicle setDir _direction;
		_vehicle setVelocity _vel; // Added to make it fly
		_vehicle setVariable [call vChecksum, true, false];
		_aiGroup addVehicle _vehicle;

		// add a driver/pilot/captain to the vehicle
		_soldier = [_aiGroup, _position] call createRandomSoldierC;
		_soldier moveInDriver _vehicle;

		switch (true) do
		{
			case (_type isKindOf "O_T_VTOL_02_infantry_dynamicLoadout_F"):
			{
				// these Aircraft need 1 gunner
				_soldier = [_aiGroup, _position] call createRandomSoldierC;
				_soldier moveInGunner _vehicle;
			};
		};

		// remove flares because it overpowers AI Jets
		/*if (_type isKindOf "Air") then
		{
			{
				if (["CMFlare", _x] call fn_findString != -1) then
				{
					_vehicle removeMagazinesTurret [_x, [-1]];
				};
			} forEach getArray (configFile >> "CfgVehicles" >> _type >> "magazines");
		};*/

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};
	// SKIP TOWN AND PLAYER PROXIMITY CHECK
 
	_skippedTowns = // get the list from -> \mapConfig\towns.sqf
	[
		"Town_4",
		"Town_11",
		"Town_13",
		"Town_15",
		"Town_16",
		"Town_17",
		"Town_19",
		"Town_20"
		
	];
	
	_town = ""; _missionPos = [0,0,0]; _radius = 0;
	_townOK = false;
	while {!_townOK} do
	{
		_town = selectRandom (call cityList); // initially select a random town for the mission.
		_missionPos = markerPos (_town select 0); // the town position.
		_radius = (_town select 1); // the town radius.
		_anyPlayersAround = (nearestObjects [_missionPos,["MAN"],_radius]) select {isPlayer _x}; // search the area for players only.
		if (((count _anyPlayersAround) isEqualTo 0) && !((_town select 0) in _skippedTowns)) exitWith // if there are no players around and the town marker is not in the skip list, set _townOK to true (exit loop).
		{
			_townOK = true;
		};
		sleep 0.1; // sleep between loops.
    };
	
	_aiGroup = createGroup CIVILIAN;
	
	//_town = selectRandom (call cityList);
 	//_missionPos = markerPos (_town select 0);
 	//_radius = (_town select 1);
 	// _vehiclePosArray = [_missionPos,(_radius / 2),_radius,5,0,0,0] call findSafePos;
 
 	// _vehicles = [];
 	// {
 		// _vehicles pushBack ([_x, _vehiclePosArray, 0, _aiGroup] call _createVehicle);

	_vehicles =
	[
		[_veh1, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle,
		[_veh2, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle,
		[_veh3, _missionPos vectorAdd ([[random 50, 0, 0], random 360] call BIS_fnc_rotateVector2D), 0] call _createVehicle
	];
	_vehiclePosArray = nil;
	{
		_vehiclePosArray = getPos ((_missionPos nearRoads _radius) select _forEachIndex);
		if (isNil "_vehiclePosArray") then
		{
			_vehiclePosArray = [_missionPos,(_radius / 2),_radius,5,0,0,0] call findSafePos;
		};
		_vehicles pushBack ([_x, _vehiclePosArray, 0, _aiGroup] call _createVehicle);
 		_vehiclePosArray = nil;
	};
	
	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;
	_leader setRank "LIEUTENANT";
	_aiGroup setCombatMode "WHITE"; // units will defend themselves
	_aiGroup setBehaviour "AWARE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "VEE";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	// behaviour on waypoints
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 100;
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointFormation "VEE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "picture");
 	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "displayName");
 	_vehicleName2 = getText (configFile >> "CfgVehicles" >> (_veh2 param [0,""]) >> "displayName");

	_missionHintText = format ["A formation of Experimental Jets containing a <t color='%3'>%1</t> and two <t color='%3'>%2</t> are patrolling the island. Destroy them and recover their cargo!", _vehicleName, _vehicleName2, mainMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	_box1 = createVehicle ["Box_NATO_Wps_F", _lastPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call randomCrateLoadOut;

	_box2 = createVehicle ["Box_East_Wps_F", _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	_box3 = createVehicle ["Box_IND_WpsSpecial_F", _lastPos, [], 5, "None"];
	_box3 setDir random 360;
	[_box3, "mission_Main_A3snipers"] call fn_refillbox;
	
	_smoke = createVehicle ["Smokeshellgreen", _lastPos, [], 5, "None"];
	_smoke = setDir random 360;

	_successHintMessage = "The sky is clear again, the enemy patrol was taken out! Ammo crates have fallen near the wreck.";
};

_this call mainMissionProcessor;
