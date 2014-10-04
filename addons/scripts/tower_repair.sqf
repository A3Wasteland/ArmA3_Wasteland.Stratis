//@file Version: 1.2
//@file Name: vehiclesave.sqf
//@file Author: MercyfulFate edited by Gigatek
//@file Created: 06/09/2014
//@file Description: Save the nearest Vehicle

#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_IN_object "Reparing Failed! You can't do that in a vehicle."
#define ERR_DESTROYED "The object is too damaged to repair."
#define ERR_TOO_FAR_AWAY "Reparing Failed! You are too far away from the object."
#define ERR_CANCELLED "Reparing Cancelled!"

private ["_object", "_checks", "_success", "_nearvehicle","_playerMoney","_DURATION","_COST","_TOWERTYPE"];
_nearvehicle = nearestObjects [player, ["Land_Cargo_Tower_V1_ruins_F", "Land_Cargo_Patrol_V1_ruins_F"], 7];
_object = _nearvehicle select 0;
_playerMoney = player getVariable ["cmoney", 0];
_DURATION = 0;
_COST = 0;
_TOWERTYPE = "";

switch (typeOf _object) do {
	case ("Land_Cargo_Tower_V1_ruins_F"):{
		_DURATION = 10*60;
		_COST = 2500*1.5;
		_TOWERTYPE = "Land_Cargo_Tower_V1_F";
	};
	case ("Land_Cargo_Patrol_V1_ruins_F"):{
		_DURATION = 5*60;
		_COST = 400*1.5;
		_TOWERTYPE = "Land_Cargo_Patrol_V1_F";
	};
};

_ERR_LOWMONEY = format["You do not have %1$ to repair it!",_COST];

_checks = {
    private ["_progress","_failed", "_text"];
    _progress = _this select 0;
    _object = _this select 1;
    _text = "";
    _failed = true;
    switch (true) do {
        case (!alive player): {}; // player is dead, no need for a notification
        case (vehicle player != player): {_text = ERR_IN_object};
        case (player distance _object > (sizeOf typeOf _object / 3) max 3): {_text = ERR_TOO_FAR_AWAY};
        case (!alive _object): {_error = ERR_DESTROYED};
        case (doCancelAction): {_text = ERR_CANCELLED; doCancelAction = false;};
        case (_playerMoney < _COST): {_error = _ERR_LOWMONEY};
        default {
            _text = format["Tower Reparing %1%2 Complete", round(100 * _progress), "%"];
            _failed = false;
        };
    };
    [_failed, _text];
};

_success = [_DURATION, ANIMATION, _checks, [_object]] call a3w_actions_start;

if (_success) then {
	_dir = getDir _object;
	_pos = getPos _object;
	_objectLocked = _obj getVariable ['objectLocked', false];
	deleteVehicle _object;
	
	_tower = _TOWERTYPE createVehicle _pos;
	_tower setDir _dir;
	_tower setVariable ['objectLocked', _objectLocked, true];
	player setVariable ["cmoney", _playerMoney - _COST, true];
	
	["Tower Reparing complete!", 5] call mf_notify_client;
};
_success;