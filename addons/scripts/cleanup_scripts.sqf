/*

	AUTHOR: aeroson
	NAME: repetitive_cleanup.sqf
	VERSION: 2.0

	DESCRIPTION:
	Can delete everything that is not really needed:
	dead bodies, dropped items, smokes, chemlights, explosives, times and classes can be specified
	Beware: if weapons on ground is intentional e.g. fancy weapons stack, it will delete them too.
	Beware: if dead bodies are intentional it will delete them too.
	Beware: if destroyed vehicles intentional it will delete them too.
	Uses allMissionObjects "" to iterate over all objects.
	Adds objects for deletion only if players are specified distance away from them.
	If you want something to withstand the clean up, paste this into it's init:
	this setVariable["persistent",true];

	USAGE:
	paste into init
	[] execVM 'repetitive_cleanup.sqf';
	then open the script and adjust values in CNFIGURATION section

*/

if (!isServer) exitWith {}; // isn't server

#define COMPONENT repetitiveCleanup
#define DOUBLES(A,B) ##A##_##B
#define TRIPLES(A,B,C) ##A##_##B##_##C
#define QUOTE(A) #A
#define GVAR(A) DOUBLES(COMPONENT,A)
#define QGVAR(A) QUOTE(GVAR(A))


if (!isNil{GVAR(isRunning)} && {GVAR(isRunning)}) then { // reset if already running
	GVAR(isRunning)=false;
	waitUntil{isNil{GVAR(isRunning)}};
};
GVAR(isRunning)=true;

//==================================================================================//
//=============================== CNFIGURATION start ===============================//
//==================================================================================//


_ttdBodies = 30; // seconds to delete dead bodies (0 means don't delete)
_ttdVehiclesDead = 10; // seconds to delete dead vehicles (0 means don't delete)
_ttdVehiclesImmobile = 0; // seconds to delete immobile vehicles (0 means don't delete)

GVAR(deleteClassesConfig) = [
	[8*60, ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"]],
	[30*60, ["TimeBombCore"]],
	[3*60, ["SmokeShell"]],
	[30, ["CraterLong_small","CraterLong"]],
	[30, ["AGM_SpareWheel","AGM_JerryCan","AGM_SpareTrack","AGM_FastRoping_Helper","Land_BakedBeans_F","Land_BottlePlastic_V1_F","Land_Suitcase_F","water","cannedfood","repairkit00"]],
	[30, ["#dynamicsound","#destructioneffects","#track","#particlesource"]]
];

GVAR(resetTimeIfPlayerIsWithin) = 1 // how far away from object player needs to be so it can delete

//==================================================================================//
//=============================== CNFIGURATION end =================================//
//==================================================================================//




GVAR(objectsToCleanup)
GVAR(timesWhenToCleanup)
GVAR(originalCleanupDelays)
GVAR(resetTimeIfPlayerNearby) // might want to do it on my own in more effective way

GVAR(deleteThoseIndexes)=[];


private ["_markArraysForCleanupAt", "_cleanupArrays"];

#define IS_SANE(OBJECT) !isNil{OBJECT} && {!isNull(OBJECT)}

_markArraysForCleanupAt = {
	params [
		"_index"
	];
	GVAR(deleteThoseIndexes) pushBack _index;
};

_cleanupArrays = {
	GVAR(deleteThoseIndexes) sort false;
	{
		GVAR(objectsToCleanup) deleteAt _x;
		GVAR(timesWhenToCleanup) deleteAt _x;
		GVAR(originalCleanupDelays) deleteAt _x;
		GVAR(resetTimeIfPlayerNearby) deleteAt _x;
	} forEach GVAR(deleteThoseIndexes);
	GVAR(deleteThoseIndexes) = [];
};



GVAR(addToCleanup) = {
	params [
		"_object",
		["_delay", 60, [0]],
		["_resetTimerIfPlayerNearby", true, [true,false]],
		["_resetValuesIfObjectAlreadyPresent", false, [true,false]]
	];
	private ["_newTime", "_index", "_currentTime"];
	if(IS_SANE(_object) && {!(_object getVariable["persistent",false])}) then {
		_newTime = _delay + time;
		_index = GVAR(objectsToCleanup) find _object;
		if(_index == -1) then {
			GVAR(objectsToCleanup) pushBack _object;
			GVAR(timesWhenToCleanup) pushBack _newTime;
			GVAR(originalCleanupDelays) pushBack _delay;
			GVAR(resetTimeIfPlayerNearby) pushBack _resetTimerIfPlayerNearby;
		} else {
			if(_resetValuesIfObjectAlreadyPresent) then {
				GVAR(timesWhenToCleanup) set[_index, _newTime];
				GVAR(originalCleanupDelays) set[_index, _delay];
				GVAR(resetTimeIfPlayerNearby) set[_index, _resetTimerIfPlayerNearby];
			};
		};
	};
};

GVAR(removeFromCleanup) = {
	params [
		"_object"
	];
	if(!isNil{_object} && {!isNull(_object)}) then {
		_index = GVAR(objectsToCleanup) find _object;
		if(_index!=-1) then {
			[_index] call _markArraysForCleanupAt;
		};
	};
};


private ["_playerPositions", "_unit", "_myPos", "_delay", "_newTime", "_object", "_objectIndex"];

while{GVAR(isRunning)} do {

    sleep 2;

    {
    	_object = _x;
		{
	    	_timeToDelete = _x select 0;
	    	_clasesToDelete = _x select 1;
	    	if(_timeToDelete>0) then {
		    	{
					if( (typeof _object == _x) || {(_object isKindOf _x)} ) then {
						[_object, _timeToDelete, true, false] call GVAR(addToCleanup);
					};
				} forEach _clasesToDelete;
			};
	    } forEach GVAR(deleteClassesConfig);
	} forEach allMissionObjects "";


	/*{ // might be causing some bugs in other scripts
		if ((count units _x)==0) then {
			deleteGroup _x;
		};
	} forEach allGroups;*/


	if (_ttdBodies>0) then {
		{
			[_x, _ttdBodies, true, false] call GVAR(addToCleanup);
		} forEach allDeadMen;
	};

	if (_ttdVehiclesDead>0) then {
		{
			if(_x == vehicle _x) then { // make sure its vehicle
				[_x, _ttdVehiclesDead, true, false] call GVAR(addToCleanup);
			};
		} forEach (allDead - allDeadMen); // all dead without dead men == mostly dead vehicles
	};

	if (_ttdVehiclesImmobile>0) then {
		{
			if(!canMove _x && {alive _x}count crew _x==0) then {
				[_x, _ttdVehiclesImmobile, true, false] call GVAR(addToCleanup);
			} else {
				[_x] call GVAR(removeFromCleanup);
			};
		} forEach vehicles;
	};

	_playerPositions = [];
	{
		_playerPositions pushBack (getPosATL _x);
	} forEach allPlayers;


	GVAR(resetTimeIfPlayerIsWithin)Sqr = GVAR(resetTimeIfPlayerIsWithin) * GVAR(resetTimeIfPlayerIsWithin);

	call _cleanupArrays;
	{
		_object = _x;
		_objectIndex = _forEachIndex;
		if(IS_SANE(_object)) then {
			[_objectIndex] call _markArraysForCleanupAt;
		} else {
			if((GVAR(timesWhenToCleanup) select _objectIndex) < time) then {
				[_objectIndex] call _markArraysForCleanupAt;
				deleteVehicle _object; // hideBody _object; sometimes doesn't work while deleteVehicle works always
			} else {
				if(GVAR(resetTimeIfPlayerNearby) select _objectIndex) then {
					_myPos = getPosATL _object;
					{
						if( (_myPos distanceSqr _x) < GVAR(resetTimeIfPlayerIsWithin)Sqr) exitWith {
							_delay = GVAR(originalCleanupDelays) select _objectIndex;
							_newTime = _delay + time;
							GVAR(timesWhenToCleanup) set[_objectIndex, _newTime];
						};
					} forEach _playerPositions;
				};
			};
		};
	} forEach GVAR(objectsToCleanup);
	call _cleanupArrays;

};

GVAR(isRunning) = nil;