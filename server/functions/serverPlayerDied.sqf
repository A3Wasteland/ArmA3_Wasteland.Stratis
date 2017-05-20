// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: serverPlayerDied.sqf
//	@file Author: [404] Pulse, AgentRev
//	@file Created: 20/11/2012 05:19

if (!isServer) exitWith {};

params [["_unit",objNull,[objNull]], "", "", ["_deathCause",[],[[]]]]; // _unit, _killer, _presumedKiller, _deathCause

_unit call A3W_fnc_setItemCleanup;
_unit setVariable ["A3W_deathCause_local", _deathCause];

private _killer = (_this select [0,3]) call A3W_fnc_registerKillScore;

// Remove player save on death
if (isPlayer _unit && {["A3W_playerSaving"] call isConfigOn}) then
{
	(getPlayerUID _unit) call fn_deletePlayerSave;
};

private _backpack = unitBackpack _unit;

if (!isNull _backpack) then
{
	_backpack call A3W_fnc_setItemCleanup;
};

// Eject corpse from vehicle once stopped
if (vehicle _unit != _unit) then
{
	if (local _unit) then
	{
		_unit spawn fn_ejectCorpse;
	}
	else
	{
		_unit remoteExec ["fn_ejectCorpse", _unit];
	};
};

// Make NPCs drop Cash
if (!isPlayer _unit) then
{
			_itemtype = ["Item","Land_Money_F"];
			_item = createVehicle [_itemtype select 1, getpos _unit, [], 5, "None"];
			_item setPos ([getPos _unit, 1, 3, 0, 0, 2000, 0] call BIS_fnc_findSafePos);
			_item setDir random 360;
			_cash = round(random 5000);
			_item setVariable ["cmoney", _cash , true];
			_item setVariable ["owner", "world", true];

};

//if !(["G_Diving", goggles _unit] call fn_startsWith) then { removeGoggles _unit };


