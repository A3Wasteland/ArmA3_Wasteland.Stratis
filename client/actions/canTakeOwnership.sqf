// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: canTakeOwnership.sqf
//	@file Author: MercyfulFate, AgentRev

#define CONCAT(STR1,STR2) format ["%1 %2", STR1, STR2]
#define ERR_FAILED "Acquiring failed!"
#define ERR_IN_VEHICLE "You can't do that in a vehicle."
#define ERR_DISTANCE "You are too far away from the vehicle."
#define ERR_MOVED "Somebody moved the vehicle."
#define ERR_TOWED "Somebody towed or lifted the vehicle."
#define ERR_OWNED "The vehicle is already yours."
#define ERR_LOCKED "The vehicle is locked."
#define ERR_CREW "Somebody is inside the vehicle."
#define ERR_CONNECTED "Somebody is connected to the UAV."
#define ERR_DESTROYED "The vehicle is destroyed."
#define ERR_CANCELLED "Lockpicking cancelled!"

params ["_vehicle"];

if (isNil "_vehicle") then
{
	_vehicle = ["LandVehicle", "Air", "Ship"] call mf_nearest_vehicle;
};

private _text = "";

switch (true) do
{
	case (!alive player): { _text = "dead" };
	case (vehicle player != player): { _text = CONCAT(ERR_FAILED, ERR_IN_VEHICLE) };
	case (!alive _vehicle): { _text = CONCAT(ERR_FAILED, ERR_DESTROYED) };
	case (_vehicle getVariable ["ownerUID","0"] isEqualTo getPlayerUID player && {!unitIsUAV _vehicle || side _vehicle == side group player}): { _text = CONCAT(ERR_FAILED, ERR_OWNED) };
	case (locked _vehicle > 1): { _text = CONCAT(ERR_FAILED, ERR_LOCKED) };
	case ({alive _x && getText (configFile >> "CfgVehicles" >> typeOf _x >> "simulation") != "UAVPilot"} count crew _vehicle > 0): { _text = CONCAT(ERR_FAILED, ERR_CREW) };
	case (!isNull ((uavControl _vehicle) select 0)): { _text = CONCAT(ERR_FAILED, ERR_CONNECTED) };
	//case (!isNull (_vehicle getVariable ["R3F_LOG_est_deplace_par", objNull])): { _text = CONCAT(ERR_FAILED, ERR_MOVED) };
	//case (!isNull (_vehicle getVariable ["R3F_LOG_est_transporte_par", objNull])): { _text = CONCAT(ERR_FAILED, ERR_TOWED) };
	case (player distance _vehicle > (sizeOf typeOf _vehicle / 3) max 3): { _text = CONCAT(ERR_FAILED, ERR_DISTANCE) };
};

_text