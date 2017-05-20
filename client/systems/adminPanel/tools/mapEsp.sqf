// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mapEsp.sqf v2.0
//	@file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {

	matt76_mape5p = {
		matt76_map_vehicles = [];
		matt76_map_foot = [];
		if (isnil "matt76_map_Map_Markers") then {
			matt76_map_Map_Markers = 0;
		};
		if (matt76_map_Map_Markers == 0) then {
			matt76_map_Map_Markers = 1;
			hint "Player Map ESP Markers ON";
			CCGLogger = ["AdminLog", format["Turned Map ESP Markers On [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";			
		} else {
			matt76_map_Map_Markers = 0;
			hint "Player Map ESP Markers OFF";
			CCGLogger = ["AdminLog", format["Turned Map ESP Markers Off [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";			
		};
		while {
			matt76_map_Map_Markers == 1
		}
		do {
			{
				if ((vehicle _x isKindOf "LandVehicle") || (vehicle _x isKindOf "Air") || (vehicle _x isKindOf "Ship")) then {
					if (count(crew vehicle _x) > 0) then {
						{
							if (!(_x in matt76_map_vehicles) and(alive _x) and(getPlayerUID _x != "")) then {
								private["_pos", "_l44", "_l45"];
								_l45 = vehicle _x;
								_pos = visiblePosition _x;
								_l44 = createMarkerLocal[format["CRW%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]];
								_l8 = (gettext(configFile >> 'CfgVehicles' >> (typeof vehicle _x) >> 'displayName'));
								_l44 setMarkerTextLocal format['%1---%2---%3m', name _x, _l8, round(_x distance player)];
								_l44 setMarkerTypeLocal "mil_dot";
								
								switch ((side _x)) do {

								case west:       { _l44 setMarkerColorLocal "ColorBlue"; };
								case east:       { _l44 setMarkerColorLocal "ColorRed"; };
								case resistance: { _l44 setMarkerColorLocal "ColorGreen"; };
								case civilian:   { _l44 setMarkerColorLocal "ColorWhite"; };
								};	
																

								_l44 setMarkerSizeLocal[1, 1];
								matt76_map_vehicles set[count matt76_map_vehicles, _x];
								[_x, _l44, _l45] spawn {
									private["_l46", "_l47", "_l48"];
									_l46 = _this select 0;
									_l47 = _this select 1;
									while {
										(matt76_map_Map_Markers == 1) and(alive _l46) and(vehicle _l46 != _l46) and(getPlayerUID _l46 != "")
									}
									do {
										_l48 = ((crew vehicle _l46) find _l46);
										_l47 setMarkerPosLocal([(visiblePosition _l46 select 0) + 20, (visiblePosition _l46 select 1) - (25 + _l48 * 20), 0]);
										sleep 0.01;
									};
									deleteMarkerLocal _l47;
									if (_l46 in matt76_map_vehicles) then {
										matt76_map_vehicles set[(matt76_map_vehicles find _l46), -1];
										matt76_map_vehicles = matt76_map_vehicles - [-1];
									};
									true;
								};
							};
						}
						forEach crew vehicle _x;
					};
				} else {
					if (!(_x in matt76_map_foot) and(vehicle _x == _x) and(getPlayerUID _x != "")) then {
						private["_pos", "_l44"];
						_pos = visiblePosition _x;
						_l44 = createMarkerLocal[format["PLR%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]];
						_l44 setMarkerTypeLocal "mil_dot";
						_l44 setMarkerSizeLocal[1, 1];

						switch ((side _x)) do {

						case west:       { _l44 setMarkerColorLocal "ColorBlue"; };
						case east:       { _l44 setMarkerColorLocal "ColorRed"; };
						case resistance: { _l44 setMarkerColorLocal "ColorGreen"; };
						case civilian:   { _l44 setMarkerColorLocal "ColorWhite"; };
						};							

						_l44 setMarkerTextLocal format["%1---%2", name _x, round(_x distance player)];
						matt76_map_foot set[count matt76_map_foot, _x];
						[_x, _l44] spawn {
							private["_l46", "_l47"];
							_l46 = _this select 0;
							_l47 = _this select 1;
							while {
								(matt76_map_Map_Markers == 1) and(alive _l46) and(vehicle _l46 == _l46) and(getPlayerUID _l46 != "")
							}
							do {
								_l47 setMarkerPosLocal([visiblePosition _l46 select 0, visiblePosition _l46 select 1, 0]);
								sleep 0.01;
							};
							deleteMarkerLocal _l47;
							if (_l46 in matt76_map_foot) then {
								matt76_map_foot set[(matt76_map_foot find _l46), -1];
								matt76_map_foot = matt76_map_foot - [-1];
							};
							true;
						};
					};
				};
			}
			forEach playableUnits;
			sleep 0.3;
		}; {
			_l44 = str _x;
			deleteMarkerLocal _l44;
		}
		forEach playableUnits;
	};	

	[] spawn matt76_mape5p

};