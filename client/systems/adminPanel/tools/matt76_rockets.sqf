// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: matt76_rockets.sqf v2.0
//	@file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {
	matts_rockets = 10;
	matts_position = {
		openMap[false, false];
		[_this] spawn {
			for '_l39'
			from 0 to matts_rockets do {
				_l87 = "M_AT";
				_l88 = [_this select 0 select 0, _this select 0 select 1, (_this select 0 select 2) + 200];
				_l89 = createVehicle[_l87, _l88, [], 0, "CAN_COLLIDE"];
				_l89 setvelocity[0, 0, 0];
				[_l89, -90, 0] call BIS_fnc_setPitchBank;
				hint format["%1 Missiles Launched", _l39];
				sleep(random 1.00);

			};
		};
		onMapSingleClick '';
	};
	cutText ["Click on map to drop bombs","PLAIN", 2];	

	onMapSingleClick "_pos call matts_position; true";
	openMap[true, false];	
	CCGLogger = ["AdminLog", format["Admin called in an artillery strike [%1 (%2)]", name player, getPlayerUID player]];
	publicVariableServer "CCGLogger";
};