// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_takeOwnership.sqf
//	@file Author: AgentRev

params [["_veh",objNull,[objNull,""]], ["_player",objNull,[objNull]], ["_createCrewUAV",true,[false]]];

if (!isPlayer _player) exitWith {};

if (_veh isEqualType "") then { _veh = objectFromNetId _veh };

if (isNull _veh) exitWith {};

if (!isServer) exitWith
{
	_this remoteExecCall ["A3W_fnc_takeOwnership", 2];
};

_veh setVariable ["ownerUID", getPlayerUID _player, true];
_veh setVariable ["ownerName", name _player, true];
[_veh, 1] call A3W_fnc_setLockState; // Unlock

if (_veh getVariable ["A3W_skipAutoSave", false]) then
{
	_veh setVariable ["A3W_skipAutoSave", nil, true];
};

if (unitIsUAV _veh && _createCrewUAV) then
{
	[_veh, side _player, true] remoteExecCall ["fn_createCrewUAV", _veh];
}
else
{
	if (_veh isKindOf "AllVehicles" && !(_veh isKindOf "StaticWeapon")) then
	{
		if (!isNil "fn_manualVehicleSave") then { _veh call fn_manualVehicleSave };
	}
	else
	{
		if (!isNil "fn_manualObjectSave") then { _veh call fn_manualObjectSave };
	};
};