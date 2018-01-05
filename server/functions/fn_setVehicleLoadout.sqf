// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_setVehicleLoadout.sqf
//	@file Author: AgentRev

params [["_veh",objNull,[objNull,""]], ["_brandNew",false,[false]], ["_resupply",false,[false]], ["_redoWeapons",false,[false]]];

if (_veh isEqualType "") then {	_veh = objectFromNetId _veh };

if (!alive _veh) exitWith {};
if (!local _veh) exitWith
{
	if !(_this isEqualType []) then { _this = [_this] };

	_this remoteExec ["A3W_fnc_setVehicleLoadout", _veh];
};

private _class = typeOf _veh;
private _variant = _veh getVariable ["A3W_vehicleVariant", ""];
private ["_mags", "_weapons", "_pylons", "_customCode"];

// Loadouts now in modConfig\vehicleLoadouts.sqf
call fn_vehicleLoadouts;

if (isNil "_mags" && isNil "_weapons" && isNil "_pylons" && isNil "_customCode") exitWith {};

// record default non-pylon weapons, so that default pylon weapons are erased
if (!isNil "_pylons" && isNil "_weapons") then
{
	_weapons = [];
	private _turretConfigs = [_veh, configNull] call BIS_fnc_getTurrets;
	private "_path";

	{
		_path = _x;
		_weapons append ((getArray (_turretConfigs select _forEachIndex >> "weapons")) apply {[_x, _path]});
	} forEach ([[-1]] + allTurrets _veh);
};

private "_oldWeapons";

if (isServer && (_redoWeapons || !isNil "_weapons")) then
{
	_oldWeapons = _veh call fn_removeTurretWeapons;
};

if (_brandNew && !isNil "_mags") then
{
	{ _veh removeMagazineTurret (_x select [0,2]) } forEach magazinesAllTurrets _veh;
	{ _veh addMagazineTurret _x } forEach _mags;
};

if (isServer && !isNil "_oldWeapons") then
{
	[_veh, if (_redoWeapons || isNil "_weapons") then {_oldWeapons} else {_weapons}] call fn_addTurretWeapons;
};

if (_brandNew || _resupply) then
{
	if (!isNil "_pylons") then
	{
		private _paths = (configProperties [configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
		private _pathCount = count _paths;

		if (count _pylons > _pathCount) then
		{
			_pylons resize _pathCount;
		};

		{ _veh setPylonLoadOut [_forEachIndex + 1, _x, true, _paths select _forEachIndex] } forEach _pylons;
	};

	if (!isNil "_customCode") then
	{
		call _customCode;
	};
};