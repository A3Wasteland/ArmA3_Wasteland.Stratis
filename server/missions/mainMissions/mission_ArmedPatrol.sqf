// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_ArmedPatrol.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "MainMissionDefines.sqf";

private ["_Patrol", "_convoys", "_vehChoices", "_vehClasses", "_createVehicle", "_vehicles", "_veh2", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_box3", "_Mortar"];

_setupVars =
{
	// _locationsArray = nil;

	// Patrol settings
	// Difficulties : Min = 1, Max = infinite
	// Convoys per difficulty : Min = 1, Max = infinite
	// Vehicles per convoy : Min = 1, Max = infinite
	// Choices per vehicle : Min = 1, Max = infinite
	_Patrol =
	[
		// Medium
		[
			"APC Patrol", // Marker text
			[
				[ // Tracked convoy 1
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_APC_Tracked_01_rcws_F", "B_T_APC_Tracked_01_rcws_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				],
				[ // Wheeled convoy
					["B_APC_Wheeled_01_cannon_F", "B_T_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"], // Veh 1
					["O_T_APC_Wheeled_02_rcws_ghex_F", "O_APC_Wheeled_02_rcws_F"], // Veh 2
					["O_T_APC_Wheeled_02_rcws_ghex_F", "O_APC_Wheeled_02_rcws_F"], // Veh 3
					["B_APC_Wheeled_01_cannon_F", "B_T_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"] // Veh 4
				],
				[ // Tracked Convoy 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_T_APC_Tracked_01_CRV_F", "B_APC_Tracked_01_CRV_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				]
			]
		],
		// Hard
		[
			"Armored Patrol", // Marker text
			[
				[ // Tracked convoy 1
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["I_MBT_03_cannon_F", "O_MBT_02_cannon_F", "O_T_MBT_02_cannon_ghex_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				],
				[ // Wheeled convoy
					["B_APC_Wheeled_01_cannon_F", "B_T_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"], // Veh 1
					["O_T_APC_Wheeled_02_rcws_ghex_F", "O_APC_Wheeled_02_rcws_F"], // Veh 2
					["O_T_APC_Wheeled_02_rcws_ghex_F", "O_APC_Wheeled_02_rcws_F"], // Veh 3
					["B_APC_Wheeled_01_cannon_F", "B_T_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"] // Veh 4
				],
				[ // Tracked Convoy 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_T_MBT_01_cannon_F", "B_T_MBT_01_TUSK_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F" ], // Veh 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				]
			]
		],
		// Extreme
		[
			"Anti Air Patrol", // Marker text
			[
				[ // Tracked convoy 1
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["B_T_APC_Tracked_01_AA_F", "B_APC_Tracked_01_AA_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				],
				[ // Wheeled convoy
					["B_APC_Wheeled_01_cannon_F", "B_T_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"], // Veh 1
					["B_T_APC_Tracked_01_AA_F", "B_APC_Tracked_01_AA_F"], // Veh 2
					["O_T_APC_Tracked_02_AA_ghex_F", "O_APC_Tracked_02_AA_F"], // Veh 3
					["B_APC_Wheeled_01_cannon_F", "B_T_APC_Wheeled_01_cannon_F", "I_APC_Wheeled_03_cannon_F"] // Veh 4
				],
				[ // Tracked Convoy 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"], // Veh 1
					["O_T_APC_Tracked_02_AA_ghex_F", "O_APC_Tracked_02_AA_F"], // Veh 2
					["O_APC_Tracked_02_cannon_F", "O_T_APC_Tracked_02_cannon_ghex_F", "I_APC_tracked_03_cannon_F"] // Veh 3
				]
			]
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _Patrol select 0;
	_convoys = _Patrol select 1;
	_vehChoices = _convoys call BIS_fnc_selectRandom;


	_vehClasses = [];
	{ _vehClasses pushBack (_x call BIS_fnc_selectRandom) } forEach _vehChoices;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	// call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];

		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;

			_soldier = [_aiGroup, _position] call createRandomSoldier;

			if (_vehicle emptyPositions "commander" > 0) then
			{
				_soldier moveInCommander _vehicle;
			}
			else
			{
				_soldier moveInCargo [_vehicle, 1];
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;
		_vehicle
	};


    // SKIP TOWN AND PLAYER PROXIMITY CHECK

    _skippedTowns = // get the list from -> \mapConfig\towns.sqf
    [
        "Town_14" // Pythos Island Marker Name
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
	_vehicles = [];
	_vehiclePosArray = nil;
	{
		_vehiclePosArray = getPos ((_missionPos nearRoads _radius) select _forEachIndex);
		if (isNil "_vehiclePosArray") then
		{
			_vehiclePosArray = [_missionPos,(_radius / 2),_radius,5,0,0,0] call findSafePos;
		};
		_vehicles pushBack ([_x, _vehiclePosArray, 0, _aiGroup] call _createVehicle);
		_vehiclePosArray = nil;
	} forEach _vehClasses;

	_veh2 = _vehClasses select (1 min (count _vehClasses - 1));

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 100;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach ((call cityList) call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "picture");
 	_vehicleName = getText (configFile >> "CfgVehicles" >> (_veh1 param [0,""]) >> "displayName");

	_missionHintText = format ["A Military Patrol containing a <t color='%3'>%1</t> is patrolling the island. Destroy them and recover their cargo!", _vehicleName, mainMissionColor];

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
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _lastPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	_box3 = createVehicle ["Box_IND_WpsSpecial_F", _lastPos, [], 5, "None"];
	_box3 setDir random 360;
	[_box3, "mission_Main_A3snipers"] call fn_refillbox;
	
	_mortar = createVehicle ["I_Mortar_01_F", _lastPos, [], 5, "None"];
	_mortar setVariable ["R3F_LOG_Disabled", false, true];
	_mortar setDir random 360;

	_successHintMessage = "The Patrol has been stopped! Ammo crates and a Mortar have fallen nearby.";
};

_this call MainMissionProcessor;
