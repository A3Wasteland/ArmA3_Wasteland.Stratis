// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: spawnBeacons.sqf v2.0
//	@file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {

	CCGsbMarkers =
	{
		while {Matt76spawnbeacons == 1} do
		{
			{					
				_owner = _x getVariable ["ownerName", ""];
				_xPos = getPos _x;
				_cm = ('CCGsbMarkers' + (str _forEachIndex));
				_pos = getMarkerPos _cm;
				if((_pos select 0 != _xPos select 0) || (_pos select 1 != _xPos select 1))then
				{
					deleteMarkerLocal _cm;
					_vm = createMarkerLocal [_cm,_xPos];
					_vm setMarkerDirLocal (getDir _x);
					_vm setMarkerTypeLocal 'mil_start';
					_vm setMarkerColorLocal 'ColorBlack';
					_vm setMarkerTextLocal format['Spawn Beacon Owner %1',_owner];

				};
				if(Matt76spawnbeacons == 0)exitWith{};
			} forEach nearestObjects [position player, ['Land_Tentdome_F'], 100000];
			//} forEach ([0,0,0] nearEntities[['Land_Tentdome_F'],1000000]);

			if(Matt76spawnbeacons == 0)exitWith{};
			uiSleep 20;

			if(Matt76spawnbeacons == 0)exitWith{};
		};
		for '_i' from 0 to 99999 do {deleteMarkerLocal ('CCGsbMarkers' + (str _i));};
	};
	if (isNil 'Matt76spawnbeacons') then {Matt76spawnbeacons = 0;};
	if (Matt76spawnbeacons == 0) then
	{
		_log = '2D Map Spawn Beacon Markers Enabled';
		cutText [_log, 'PLAIN DOWN'];
		hint _log;
		CCGLogger = ["AdminLog", format["Admin turned Spawn Beacon Map Markers on [%1 (%2)]", name player, getPlayerUID player]];
		publicVariableServer "CCGLogger";			
		
		Matt76spawnbeacons = 1;
		[] spawn CCGsbMarkers;
	}
	else
	{
		_log = '2D Map Spawn Beacon Markers Disabled';
		cutText [_log, 'PLAIN DOWN'];
		hint _log;
		CCGLogger = ["AdminLog", format["Admin turned Spawn Beacon Markers off [%1 (%2)]", name player, getPlayerUID player]];
		publicVariableServer "CCGLogger";
		
		Matt76spawnbeacons = 0;
		for '_i' from 0 to 99999 do {deleteMarkerLocal ('CCGsbMarkers' + (str _i));};
	};	
};	