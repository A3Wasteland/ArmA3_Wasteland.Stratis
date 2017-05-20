// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: vehicleMarkers.sqf v2.0
//	@file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {

		CCGVehicleMarkers =
		{
			while {Matt76vehiclemarkers == 1} do
			{
				{
					_typename = gettext (configFile >> 'CfgVehicles' >> typeOf _x >> 'displayName');
					_xPos = getPos _x;
					
					_cm = ('CCGVehicleMarkers' + (str _forEachIndex));
					_pos = getMarkerPos _cm;
					if((_pos select 0 != _xPos select 0) || (_pos select 1 != _xPos select 1))then
					{
						deleteMarkerLocal _cm;
						_vm = createMarkerLocal [_cm,_xPos];
						_vm setMarkerDirLocal (getDir _x);
						_vm setMarkerTypeLocal 'mil_start';
						_vm setMarkerColorLocal 'ColorBlue';
						_vm setMarkerTextLocal format['%1',_typename];
					};
					if(Matt76vehiclemarkers == 0)exitWith{};
				} forEach ([0,0,0] nearEntities[['LandVehicle','Ship','Air','Tank'],1000000]);
				if(Matt76vehiclemarkers == 0)exitWith{};
				uiSleep 1;
				if(Matt76vehiclemarkers == 0)exitWith{};
			};
			for '_i' from 0 to 99999 do {deleteMarkerLocal ('CCGVehicleMarkers' + (str _i));};
		};
		if(isNil 'Matt76vehiclemarkers')then{Matt76vehiclemarkers = 0;};
		if(Matt76vehiclemarkers == 0)then
		{
			_log = '2D Map Vehicle Markers Enabled';
			cutText [_log, 'PLAIN DOWN'];
			hint _log;
			CCGLogger = ["AdminLog", format["Admin turned Vehicle Markers on [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";			
			
			Matt76vehiclemarkers = 1;
			[] spawn CCGVehicleMarkers;
		}
		else
		{
			_log = '2D Map Vehicle Markers Disabled';
			cutText [_log, 'PLAIN DOWN'];
			hint _log;
			CCGLogger = ["AdminLog", format["Admin turned Vehicle Markers off [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";
			
			Matt76vehiclemarkers = 0;
			for '_i' from 0 to 99999 do {deleteMarkerLocal ('CCGVehicleMarkers' + (str _i));};
		};	
};	