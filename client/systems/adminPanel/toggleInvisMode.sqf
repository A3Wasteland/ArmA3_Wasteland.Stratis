// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2015 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: toggleInvisMode.sqf
//	@file Author: macchky
//	@file Created: 2015/4/7 9:35

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{

	_curPlayerInvisState = player getVariable ["isAdminInvisible", false];

	if (!_curPlayerInvisState) then
	{
		[[player, true], "A3W_fnc_invisible", false, true] call A3W_fnc_MP;
		player setVariable ["isAdminInvisible", true, true];
		hint "You are now invisible";
	}
	else
	{
		[[player, false], "A3W_fnc_invisible", false, true] call A3W_fnc_MP;
		player setVariable ["isAdminInvisible", false, true];
		hint "You are no longer invisible";
	};
}