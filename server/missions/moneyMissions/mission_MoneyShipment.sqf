//	@file Version: 2
//	@file Name: mission_MoneyShipment.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Args: none

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

private ["_missionMarkerName","_missionType","_picture","_vehicleName","_hint","_waypoint","_routes","_MoneyShipment","_money","_convoys","_vehChoices","_moneyKilos","_moneyUnits","_strMoneyUnits","_moneyText","_vehClasses","_veh2","_rn","_waypoints","_starts","_startdirs","_group","_vehicles","_marker","_failed","_startTime","_numWaypoints","_cash1","_cash2","_createVehicle","_leader"];

_missionMarkerName = "Money_Shipment";
_missionType = "Money Shipment";
diag_log format["WASTELAND SERVER - Money Mission Started: %1", _missionType];
diag_log format["WASTELAND SERVER - Money Mission Waiting to run: %1", _missionType];
[moneyMissionDelayTime] call createWaitCondition;
diag_log format["WASTELAND SERVER - Money Mission Resumed: %1", _missionType];

// Money Shipments settings
// Difficulties : Min = 1, Max = infinite
// Convoys per difficulty : Min = 1, Max = infinite
// Vehicles per convoy : Min = 1, Max = infinite
// Choices per vehicle : Min = 1, Max = infinite
_MoneyShipment = 
[
	// Easy
	[
		12500, // Money
		[
			[ // NATO convoy
				["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"], // Veh 1
				["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"] // Veh 2
			],
			[ // CSAT convoy
				["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"], // Veh 1
				["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"] // Veh 2
			],
			[ // AAF convoy
				["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"], // Veh 1
				["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"] // Veh 2
			]
		]
	],
	// Medium
	[
		25000, // Money
		[
			[ // NATO convoy
				["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"], // Veh 1
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"], // Veh 2
				["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"] // Veh 3
			],
			[ // CSAT convoy
				["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"], // Veh 1
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], // Veh 2
				["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F"] // Veh 3
			],
			[ // AAF convoy
				["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"], // Veh 1
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"], // Veh 2
				["I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"] // Veh 3
			]
		]
	],
	// Hard
	[
		50000, // Money
		[
			[ // NATO convoy
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"], 	// Veh 1
				["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], 											// Veh 2
				["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], 											// Veh 3
				["B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], 											// Veh 4
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F"] 	// Veh 5
			],
			[ // CSAT convoy
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"], 	// Veh 1
				["O_MBT_02_cannon_F"], 																// Veh 2
				["O_MBT_02_cannon_F"], 																// Veh 3
				["O_MBT_02_cannon_F"], 																// Veh 4
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F"] 	// Veh 5
			],
			[ // AAF convoy
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"], 						// Veh 1
				["I_MBT_03_cannon_F"], 																// Veh 2
				["I_MBT_03_cannon_F"], 																// Veh 3
				["I_MBT_03_cannon_F"], 																// Veh 4
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F"] 							// Veh 5
			]
		]
	],
	// Extreme
	[
		100000, // Money
		[
			[ // NATO convoy
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 1
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 2
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 3
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 4
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 5
				["B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F"], // Veh 6
				["B_Heli_Attack_01_F","O_Heli_Attack_02_black_F"], //Air 1
				["B_Heli_Attack_01_F","O_Heli_Attack_02_black_F"] //Air 2
			],
			[ // CSAT convoy
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 1
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 2
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 3
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 4
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 5
				["O_APC_Wheeled_02_rcws_F", "O_APC_Tracked_02_cannon_F", "O_APC_Tracked_02_AA_F", "O_MBT_02_cannon_F"], // Veh 6
				["B_Heli_Attack_01_F","O_Heli_Attack_02_black_F"], //Air 1
				["B_Heli_Attack_01_F","O_Heli_Attack_02_black_F"] //Air 2
			],
			[ // AAF convoy
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 1
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 2
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 3
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 4
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 5
				["I_APC_Wheeled_03_cannon_F", "I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"], // Veh 6
				["B_Heli_Attack_01_F","O_Heli_Attack_02_black_F"], //Air 1
				["B_Heli_Attack_01_F","O_Heli_Attack_02_black_F"] //Air 2
			]
		]
	]
]
call BIS_fnc_selectRandom;

_money = _MoneyShipment select 0;
_convoys = _MoneyShipment select 1;
_vehChoices = _convoys call BIS_fnc_selectRandom;

_moneyText = format ["$%1", [_money] call fn_numbersText];

_vehClasses = [];
{ _vehClasses pushBack (_x call BIS_fnc_selectRandom) } forEach _vehChoices;

// available routes to add a route. If you add more routes append ,4 to the array and so on
_routes = [1,2,3,4];

// pick one of the routes
_rn = _routes call BIS_fnc_selectRandom;

// set starts and waypoints depending on above (random) choice
switch (_rn) do 
{ 
	case 0:
	{
		// Base route. Starts from Abandoned Outpost
		
		// starting positions for this route
		_starts = 
		[	
			[4351.39,4336.19],
			[4362,4340.34],
			[4367.57,4342.83],
			[4375.09,4346.21],
			[4385.51,4350.92],
			[4396.71,4354.47],
			[4407.56,4353.53],
			[4417.43,4346.86]
		];
		
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			64.1256,
			66.2054,
			65.8739,
			65.8739,
			69.6191,
			91.517,
			112.248,
			141.255
		];
		
		// the routes
		_waypoints =
		[			

		];
		// end of base route
	};
	
	case 1:
	{
		// Going North
		
		// starting positions for this route
		_starts = 
		[	
			[4351.39,4336.19],
			[4362,4340.34],
			[4367.57,4342.83],
			[4375.09,4346.21],
			[4385.51,4350.92],
			[4396.71,4354.47],
			[4407.56,4353.53],
			[4417.43,4346.86]
		];
		
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			64.1256,
			66.2054,
			65.8739,
			65.8739,
			69.6191,
			91.517,
			112.248,
			141.255
		];
		
		// the routes
		_waypoints =
		[			
			[4456.6,4283.31],
			[3826.11,4685.79],
			[3771.7,4788.68],
			[3818.36,4970.13],
			[3224.96,5680.34],
			[2834.95,5926.09]
		];
		// end of route
	};
	case 2:
	{
		// Going East
		
		// starting positions for this route
		_starts = 
		[	
			[4351.39,4336.19],
			[4362,4340.34],
			[4367.57,4342.83],
			[4375.09,4346.21],
			[4385.51,4350.92],
			[4396.71,4354.47],
			[4407.56,4353.53],
			[4417.43,4346.86]
		];
		
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			64.1256,
			66.2054,
			65.8739,
			65.8739,
			69.6191,
			91.517,
			112.248,
			141.255
		];
		
		// the routes
		_waypoints =
		[			
			[4452.27,4269.21],
			[4672.08,4386.24],
			[5018.03,4529.85],
			[5063.5,4772.42],
			[5333.76,4959.6],
			[5166.35,5302.42],
			[5363.43,5418.61],
			[5241.04,5816.09],
			[5702.43,5290.87],
			[6007.05,4962.39],
			[6273.67,5023.63],
			[6471.34,5364.12]
		];
		// end of route
	};
	case 3:
	{
		// Going South
		
		// starting positions for this route
		_starts = 
		[	
			[4351.39,4336.19],
			[4362,4340.34],
			[4367.57,4342.83],
			[4375.09,4346.21],
			[4385.51,4350.92],
			[4396.71,4354.47],
			[4407.56,4353.53],
			[4417.43,4346.86]
		];
		
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			64.1256,
			66.2054,
			65.8739,
			65.8739,
			69.6191,
			91.517,
			112.248,
			141.255
		];
		
		// the routes
		_waypoints =
		[			
			[4216.52,3979.91],
			[4272.57,3587.38],
			[3808.66,3350.8],
			[3542.53,2830.39],
			[3459.39,2640.67],
			[3061.68,2130.32],
			[2790.85,1808.4],
			[2844.77,1751.09],
			[3131.26,1593.58],
			[2851.04,1214.37],
			[2549.75,989.997],
			[2701.4,796.383],
			[2621.28,612.664]
		];
		// end of route
	};
	case 4:
	{
		// Going West
		
		// starting positions for this route
		_starts = 
		[	
			[4351.39,4336.19],
			[4362,4340.34],
			[4367.57,4342.83],
			[4375.09,4346.21],
			[4385.51,4350.92],
			[4396.71,4354.47],
			[4407.56,4353.53],
			[4417.43,4346.86]
		];
		
		// starting directions in which the vehicles are spawned on this route
		_startdirs = 
		[
			64.1256,
			66.2054,
			65.8739,
			65.8739,
			69.6191,
			91.517,
			112.248,
			141.255
		];
		
		// the routes
		_waypoints =
		[			
			[4452.69,4254.38],
			[4216.98,3978.97],
			[4225.32,3553.01],
			[3982.41,3581.73],
			[3609.85,3896.57],
			[3227.88,3799.78],
			[2730.3,3834.61],
			[2151.19,3627.59],
			[1927.92,3571.38]
		];
		// end of route
	};
}; 

_group = createGroup civilian;

_createVehicle = {
    private ["_type","_position","_direction","_group","_vehicle","_soldier"];
    
    _type = _this select 0;
    _position = _this select 1;
    _direction = _this select 2;
    _group = _this select 3;  
	_vehicle=false;
	
	if (_type isKindOf "Air") then {
	//Air units
		_vehicle = createVehicle [_type, _position, [], 0, "FLY"];
		_vehicle setPosATL (_vehicle modelToWorld[0,0,200]);
		_vehicle flyInHeight 200;
		
		_soldier = [_group, _position] call createRandomSoldier; 
		_soldier moveInDriver _vehicle;
		_soldier = [_group, _position] call createRandomSoldier; 
		_soldier assignAsGunner _vehicle;
		_soldier moveInTurret [_vehicle, [0]];
	}else{
	//Ground units
		_vehicle = _type createVehicle _position;
		_soldier = [_group, _position] call createRandomSoldier; 
		_soldier moveInDriver _vehicle;
		_soldier = [_group, _position] call createRandomSoldier; 
		_soldier moveInCargo [_vehicle, 0];
		_soldier = [_group, _position] call createRandomSoldier; 
		_soldier moveInTurret [_vehicle, [0,0]];
	};
	
	[_vehicle] call vehicleSetup;
    _vehicle setDir _direction;
    _group addVehicle _vehicle;
    
    _vehicle setVehicleLock "LOCKED";  // prevents players from getting into the vehicle while the AI are still owning it
	// _vehicle spawn cleanVehicleWreck;  // courtesy of AgentREV sets cleanup on the mission vehicles once wrecked :)
    _vehicle
};

_vehicles = [];
//Start spawning from last point. Last vehicle will be 1st in column and lead it.
_vehicleCounter = count _vehClasses - 1;
{
	_vehicles pushBack ([_x, _starts select _vehicleCounter, _startdirs select _vehicleCounter, _group] call _createVehicle);
	_vehicleCounter = _vehicleCounter-1;
} forEach _vehClasses;

_veh2 = _vehClasses select (1 min (count _vehClasses - 1));

_leader = driver (_vehicles select 0);
_group selectLeader _leader;
_leader setRank "LIEUTENANT";

_group setCombatMode "GREEN"; // units will defend themselves
_group setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
_group setFormation "STAG COLUMN";
_group setSpeedMode "LIMITED";

{
    _waypoint = _group addWaypoint [_x, 0];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointCompletionRadius 20;
    _waypoint setWaypointCombatMode "GREEN"; 
    _waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
    _waypoint setWaypointFormation "STAG COLUMN";
    _waypoint setWaypointSpeed "LIMITED";
} forEach _waypoints;

_marker = createMarker [_missionMarkerName, position leader _group];
_marker setMarkerType "mil_destroy";
_marker setMarkerSize [1.25, 1.25];
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Armed Money Shipment";

_picture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
_vehicleName = getText (configFile >> "cfgVehicles" >> _veh2 >> "displayName");

// Remove " (Covered)" from vehicle name when applicable
if ([_vehicleName, (count toArray _vehicleName) - 10] call BIS_fnc_trimString == " (Covered)") then
{
	_vehicleName = [_vehicleName, 0, (count toArray _vehicleName) - 11] call BIS_fnc_trimString;
};

_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Money Objective</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>A <t color='%4'>%3</t> carrying a unit of soldiers transporting " + _moneyText + " is on route with assistance. Stop them! Be aware that the money is divided among both units!</t>", _missionType, _picture, _vehicleName, moneyMissionColor, subTextColor];
[_hint] call hintBroadcast;

diag_log format["WASTELAND SERVER - Money Mission Waiting to be Finished: %1", _missionType];

_failed = false;
_startTime = floor(time);
_numWaypoints = count waypoints _group;
waitUntil
{
    private ["_unitsAlive"];
    
    sleep 10; 
    
    _marker setMarkerPos (position leader _group);
    
    if ((floor time) - _startTime >= moneyMissionTimeout) then { _failed = true };
    if (currentWaypoint _group >= _numWaypoints) then { _failed = true }; // Money Shipment got successfully to the target location
    _unitsAlive = { alive _x } count units _group;
    
    _unitsAlive == 0 || _failed
};

if(_failed) then
{
    // Mission failed
    {deleteVehicle _x} forEach _vehicles;
	{if (vehicle _x != _x) then { deleteVehicle vehicle _x; }; deleteVehicle _x;}forEach units _group;
	{deleteVehicle _x;}forEach units _group;
	deleteGroup _group; 
    _hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>Objective failed, better luck next time</t>", _missionType, _picture, _vehicleName, failMissionColor, subTextColor];
    [_hint] call hintBroadcast;
    diag_log format["WASTELAND SERVER - Money Mission Failed: %1",_missionType];
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
	for "_x" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", (markerPos _marker) vectorAdd ([[1 + random 2,0,0], random 360] call BIS_fnc_rotateVector2D), [], 0, "None"];
		_cash setDir random 360;
		_cash setVariable["cmoney", _money / 10, true];
		_cash setVariable["owner","world",true];
	};
	
	deleteGroup _group; 	
    _hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Complete</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>The Money Shipment has been stopped, the cash is now yours to take.</t>", _missionType, _picture, _vehicleName, successMissionColor, subTextColor];
    [_hint] call hintBroadcast;
    diag_log format["WASTELAND SERVER - Money Mission Success: %1",_missionType];
};

deleteMarker _marker;
