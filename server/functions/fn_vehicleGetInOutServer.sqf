// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_vehicleGetInOutServer.sqf
//	@file Author: AgentRev

params ["_vehicle", "_seat", "_unit"];
private ["_pos"];

_unit setVariable ["lastVehicleRidden", netId _vehicle, true];

if (_vehicle isKindOf "StaticWeapon" && owner _vehicle != owner _unit) then
{
	_vehicle setOwner owner _unit;
};

if (isPlayer _unit && owner _vehicle == owner _unit) then
{
	_vehicle setVariable ["lastVehicleOwnerUID", getPlayerUID _unit, true];
};

_vehicle setVariable ["vehSaving_hoursUnused", 0];
_vehicle setVariable ["vehSaving_lastUse", diag_tickTime];

//Don't allow players to glitch into objects when exiting vehicles
if (isNull objectParent _unit) then 
{
	//Check the current position of the player
	_pos = [_unit, 0, 0.25, 0.5, 0, 1, 0] call BIS_fnc_findSafePos;

	//Function returns current position [x,y] if it is safe, otherwise map center
	// is returned [x,y,z]. In the second case, the player current position is
	// invalid and we find another within 5m of the vehicle
	if(count _pos > 2) then {
		//Find position relative to vehicle, 5m max
		_pos = [_vehicle, 0, 5, 1, 0, 45, 0] call BIS_fnc_findSafePos;

		//If a position is found, then move the unit to a non-glitched pos
		if(count _pos == 2) then {
			_unit setPos _pos;
		};
	};
};


{
	if (isAgent teamMember _x) then
	{
		_assistOwner = _x getVariable ["A3W_driverAssistOwner", objNull];

		if (!alive _assistOwner || _assistOwner == _unit) then
		{
			if (driver _vehicle == _x && lockedDriver _vehicle) then
			{
				[_vehicle, false] remoteExecCall ["lockDriver", 0];
			};

			deleteVehicle _x;
		};
	};
} forEach crew _vehicle;
