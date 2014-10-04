//@file Version: 1.2
//@file Name: vehiclesave.sqf
//@file Author: MercyfulFate edited by Gigatek
//@file Created: 06/09/2014
//@file Description: Save the nearest Vehicle

#define DURATION 5
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_IN_object "Unlocking Failed! You can't do that in a vehicle."
#define ERR_DESTROYED "The vehicle is too damaged to unlock."
#define ERR_TOO_FAR_AWAY "Unlocking Failed! You are too far away from the vehicle."
#define ERR_CANCELLED "Unlocking Cancelled!"

private ["_object", "_checks", "_success", "_nearvehicle"];
_nearvehicle = nearestObjects [player, ['Air','Tank','Motorcycle','Car','Ship'], 7];
_object = _nearvehicle select 0;

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
        default {
            _text = format["Vehicle Unlocking %1%2 Complete", round(100 * _progress), "%"];
            _failed = false;
        };
    };
    [_failed, _text];
};

_success = [DURATION, ANIMATION, _checks, [_object]] call a3w_actions_start;

if (_success) then {
	[[[netId _object], {(objectFromNetId (_this select 0)) lock 0}], "BIS_fnc_spawn", _object] call TPG_fnc_MP;
	
	_object setVariable ["vehicleLocked", 0, true];
	_object setVariable ["ownerUID", nil, true];
	_object setVariable ["ownerSide", nil, true];
	
	Public_VehicleLock=_object;
	publicVariable "Public_VehicleLock";
	
	player action ["lightOn", _object];
	sleep 1;
	player action ["lightOff", _object];

	["Vehicle Unlock Complete!", 5] call mf_notify_client;
};
_success;