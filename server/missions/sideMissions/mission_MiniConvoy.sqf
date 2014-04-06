//	@file Version: 2
//	@file Name: mission_MiniConvoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo)
//	@file Created: 1/09/2013 14:19
//	@file Args: none

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_missionMarkerName","_missionType","_picture","_vehicleName","_hint","_waypoint","_routes","_convoyVeh","_veh1","_veh2","_veh3","_rn","_waypoints","_starts","_startdirs","_groupsm","_vehicles","_marker","_failed","_startTime","_numWaypoints","_ammobox","_createVehicle","_leader"];

_missionMarkerName = "MiniConvoy_Marker";
_missionType = "Truck Convoy";
diag_log format["WASTELAND SERVER - Side Mission Started: %1", _missionType];
diag_log format["WASTELAND SERVER - Side Mission Waiting to run: %1", _missionType];
[sideMissionDelayTime] call createWaitCondition;
diag_log format["WASTELAND SERVER - Side Mission Resumed: %1", _missionType];

//pick the vehicles for the convoy (veh2 is the 'convoyed' vehicle
_convoyVeh = 
[
	["B_Quadbike_01_F", "C_Van_01_box_F", "B_Quadbike_01_F"],
	["I_G_Offroad_01_F", "I_Truck_02_transport_F", "I_G_Offroad_01_F"],
	["I_G_Offroad_01_armed_F", "O_Truck_02_transport_F", "I_G_Offroad_01_F"]
]
call BIS_fnc_selectRandom;

_veh1 = _convoyVeh select 0;
_veh2 = _convoyVeh select 1;
_veh3 = _convoyVeh select 2;

// available routes to add a route. If you add more routes append ,4 to the array and so on
_routes = [1,2,3];

// pick one of the routes
_rn = _routes select (floor(random(count _routes)));

// set starts and waypoints depending on above (random) choice
switch (_rn) do 
{ 
	case 1: {
		// route 1
		// starting positions for this route
		_starts = 
		[
			[2614.0962, 623.4976],
			[2619.0709, 613.5274],
			[2607.2347, 627.8529]
		];
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			110,
			110,
			110
		];
		// the routes
		_waypoints = 
		[			
			[2620.1548,612.56152],
    		[3121.2034,1679.9956],
    		[2796.7263,1814.6265],
    		[3782.2229,2991.4355],
    		[3811.5823,3352.3765],
    		[4278.4458,3617.1807],
    		[4256.2026,3987.7041],
    		[4453.8467,4265.6416],
    		[5034.1582,4551.7168],
    		[5332.6191,4984.7158],
    		[5179.1089,5317.814],
    		[5355.2534,5447.2158],
    		[5209.6572,5804.0298],
    		[4650.4116,5920.8677],
    		[4989.0015,6177.1587],
    		[4795.2671,6547.9424],
    		[4093.5972,6355.2212],
    		[4376.2495,6777.9741]
		];
		// end of route one
	}; 
	case 2: {
		// route 1
		// starting positions for this route
		_starts = 
		[
			[2614.0962, 623.4976],
			[2619.0709, 613.5274],
			[2607.2347, 627.8529]
		];
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			110,
			110,
			110
		];
		// the routes
		_waypoints = 
		[			
			[2620.1548,612.56152],
    		[3121.2034,1679.9956],
    		[2796.7263,1814.6265],
    		[3782.2229,2991.4355],
    		[3811.5823,3352.3765],
    		[4278.4458,3617.1807],
    		[4256.2026,3987.7041],
    		[4453.8467,4265.6416],
    		[5034.1582,4551.7168],
    		[5332.6191,4984.7158],
    		[5179.1089,5317.814],
    		[5355.2534,5447.2158],
    		[5209.6572,5804.0298],
    		[4650.4116,5920.8677],
    		[4989.0015,6177.1587],
    		[4795.2671,6547.9424],
    		[4093.5972,6355.2212],
    		[4376.2495,6777.9741]
		];
		// end of route one
	}; 
	case 3: {
		// route 1
		// starting positions for this route
		_starts = 
		[
			[2614.0962, 623.4976],
			[2619.0709, 613.5274],
			[2607.2347, 627.8529]
		];
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			110,
			110,
			110
		];
		// the routes
		_waypoints = 
		[			
			[2620.1548,612.56152],
    		[3121.2034,1679.9956],
    		[2796.7263,1814.6265],
    		[3782.2229,2991.4355],
    		[3811.5823,3352.3765],
    		[4278.4458,3617.1807],
    		[4256.2026,3987.7041],
    		[4453.8467,4265.6416],
    		[5034.1582,4551.7168],
    		[5332.6191,4984.7158],
    		[5179.1089,5317.814],
    		[5355.2534,5447.2158],
    		[5209.6572,5804.0298],
    		[4650.4116,5920.8677],
    		[4989.0015,6177.1587],
    		[4795.2671,6547.9424],
    		[4093.5972,6355.2212],
    		[4376.2495,6777.9741]
		];
		// end of route one
	}; 
	default {
		// this shouldnt happen but just to be sure..
		diag_log format["WASTELAND SERVER - WARNING! %1 encountered an error selecting routes - defaulting to route 1", _missionType];
		// route 1
		// starting positions for this route
		_starts = 
		[
			[2614.0962, 623.4976],
			[2619.0709, 613.5274],
			[2607.2347, 627.8529]
		];
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			110,
			110,
			110
		];
		// the routes
		_waypoints = 
		[			
			[2620.1548,612.56152],
    		[3121.2034,1679.9956],
    		[2796.7263,1814.6265],
    		[3782.2229,2991.4355],
    		[3811.5823,3352.3765],
    		[4278.4458,3617.1807],
    		[4256.2026,3987.7041],
    		[4453.8467,4265.6416],
    		[5034.1582,4551.7168],
    		[5332.6191,4984.7158],
    		[5179.1089,5317.814],
    		[5355.2534,5447.2158],
    		[5209.6572,5804.0298],
    		[4650.4116,5920.8677],
    		[4989.0015,6177.1587],
    		[4795.2671,6547.9424],
    		[4093.5972,6355.2212],
    		[4376.2495,6777.9741]
		];
		// end of route one
	}; 
}; 

_groupsm = createGroup civilian;

_createVehicle = {
    private ["_type","_position","_direction","_vehicle","_soldier"];
    
    _type = _this select 0;
    _position = _this select 1;
    _direction = _this select 2;
    _groupsm = _this select 3;
    
    _vehicle = _type createVehicle _position;
	[_vehicle] call vehicleSetup;
    _vehicle setDir _direction;
    _groupsm addVehicle _vehicle;
    
    _soldier = [_groupsm, _position] call createRandomSoldier; 
    _soldier moveInDriver _vehicle;
    _soldier = [_groupsm, _position] call createRandomSoldier; 
    _soldier moveInCargo [_vehicle, 0];
    _vehicle setVehicleLock "LOCKED";  // prevents players from getting into the vehicle while the AI are still owning it
	// _vehicle spawn cleanVehicleWreck;  // courtesy of AgentREV sets cleanup on the mission vehicles once wrecked :)
    _vehicle
};

_vehicles = [];
_vehicles set [0, [_veh1, (_starts select 0), (_startdirs select 0), _groupsm] call _createVehicle];
_vehicles set [1, [_veh2, (_starts select 1), (_startdirs select 1), _groupsm] call _createVehicle];
_vehicles set [2, [_veh3, (_starts select 2), (_startdirs select 2), _groupsm] call _createVehicle];

_leader = driver (_vehicles select 0);
_groupsm selectLeader _leader;
_leader setRank "LIEUTENANT";

_groupsm setCombatMode "GREEN"; // units will defend themselves
_groupsm setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
_groupsm setFormation "STAG COLUMN";
_groupsm setSpeedMode "LIMITED";

{
    _waypoint = _groupsm addWaypoint [_x, 0];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointCompletionRadius 50;
    _waypoint setWaypointCombatMode "GREEN"; 
    _waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
    _waypoint setWaypointFormation "STAG COLUMN";
    _waypoint setWaypointSpeed "LIMITED";
} forEach _waypoints;

_marker = createMarker [_missionMarkerName, position leader _groupsm];
_marker setMarkerType "mil_destroy";
_marker setMarkerSize [1.25, 1.25];
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Truck Convoy";

_picture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
_vehicleName = getText (configFile >> "cfgVehicles" >> _veh2 >> "displayName");
_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Side Objective</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>A <t color='%4'>%3</t> transporting weapon cargo is on route! Stop the convoy and capture the goods!</t>", _missionType, _picture, _vehicleName, sideMissionColor, subTextColor];
[_hint] call hintBroadcast;

diag_log format["WASTELAND SERVER - Side Mission Waiting to be Finished: %1", _missionType];

_failed = false;
_startTime = floor(time);
_numWaypoints = count waypoints _groupsm;
waitUntil
{
    private ["_unitsAlive"];
    
    sleep 10; 
    
    _marker setMarkerPos (position leader _groupsm);
    
    if ((floor time) - _startTime >= sideMissionTimeout) then { _failed = true };
    if (currentWaypoint _groupsm >= _numWaypoints) then { _failed = true }; // Convoy got successfully to the target location
    _unitsAlive = { alive _x } count units _groupsm;
    
    _unitsAlive == 0 || _failed
};

if(_failed) then
{
    // Mission failed
    if not(isNil "_vehicle") then {deleteVehicle _vehicle;};
	{if (vehicle _x != _x) then { deleteVehicle vehicle _x; }; deleteVehicle _x;}forEach units _groupsm;
	{deleteVehicle _x;}forEach units _groupsm;
	deleteGroup _groupsm; 
    _hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>Objective failed, better luck next time.</t>", _missionType, _picture, _vehicleName, failMissionColor, subTextColor];
    [_hint] call hintBroadcast;
    diag_log format["WASTELAND SERVER - Side Mission Failed: %1",_missionType];
} else {
	// Mission completed
	// unlock the vehicles incase the player cleared the mission without destroying them
	if (!isNil "_vehicles") then { 
		{
			_x setVehicleLock "UNLOCKED"; 
			_x setVariable ["R3F_LOG_disabled", false, true];
		}forEach _vehicles;
	};
	// give the rewards
	_ammobox = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
    [_ammobox,"mission_USSpecial2"] call fn_refillbox;
	_ammobox allowDamage false;
	
	deleteGroup _groupsm; 
    _hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Complete</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>The convoy has been stopped, the ammo creates and vehicles are yours to take.</t>", _missionType, _picture, _vehicleName, successMissionColor, subTextColor];
    [_hint] call hintBroadcast;
    diag_log format["WASTELAND SERVER - Side Mission Success: %1",_missionType];
};

deleteMarker _marker;
