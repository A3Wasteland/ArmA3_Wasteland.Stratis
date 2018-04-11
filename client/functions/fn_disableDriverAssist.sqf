// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2017 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: fn_enableDriverAssist.sqf
//	@file Author: AgentRev

private _veh = if (isNil "_veh") then { objectParent player } else { _veh };
private _driver = driver _veh;

if (!isAgent teamMember _driver || _driver getVariable ["A3W_driverAssistOwner", objNull] != player) exitWith {};

deleteVehicle _driver;
["unlockDriver", _veh] call A3W_fnc_towingHelper;