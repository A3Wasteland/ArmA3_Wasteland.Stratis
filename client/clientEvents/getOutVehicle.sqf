// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: getOutVehicle.sqf
//	@file Author: AgentRev

params ["_veh"];

if (!unitIsUAV _veh) then
{
	player setAnimSpeedCoef 1; // Reset fast anim speed set in fn_inGameUIActionEvent.sqf

	_veh removeEventHandler ["Engine", _veh getVariable ["A3W_engineEH", -1]];
	_veh setVariable ["A3W_engineEH", nil];

	if ({alive _x} count crew _veh == 0) then
	{
		[_veh, 1] call A3W_fnc_setLockState; // Unlock
	};

	call fn_disableDriverAssist;
};

{ _veh removeAction _x } forEach (_veh getVariable ["A3W_serviceBeaconActions", []]);
_veh setVariable ["A3W_serviceBeaconActions", nil];

[_veh, _veh getVariable ["A3W_flipDroneAction", -1]] call fn_removeManagedAction;
_veh setVariable ["A3W_flipDroneAction", nil];

{ [_veh, _x] call fn_removeManagedAction } forEach (_veh getVariable ["A3W_saveDroneActions", []]);
_veh setVariable ["A3W_saveDroneActions", nil];
