//@file Version: 1.2
//@file Name: vehiclesave.sqf
//@file Author: MercyfulFate edited by Gigatek
//@file Created: 06/09/2014
//@file Description: Save the nearest Vehicle

#define DURATION 10
#define ANIMATION "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_IN_object "Saving Failed! You can't do that in a vehicle."
#define ERR_DESTROYED "The vehicle is too damaged to save."
#define ERR_TOO_FAR_AWAY "Saving Failed! You are too far away from the vehicle."
#define ERR_CANCELLED "Saving Cancelled!"

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
            _text = format["Vehicle Save %1%2 Complete", round(100 * _progress), "%"];
            _failed = false;
        };
    };
    [_failed, _text];
};

_success = [DURATION, ANIMATION, _checks, [_object]] call a3w_actions_start;

if (_success) then {
	//_object setVariable ["ownerSide", side player, true];
	if (_object getVariable ["ownerUID",""] == "") then {
		_object setVariable ["ownerUID", getPlayerUID player, true];
	};
	_object setVariable ["objectLocked", true, true];
	_object allowDamage true;

	["Vehicle Save Complete!", 5] call mf_notify_client;
};
_success;