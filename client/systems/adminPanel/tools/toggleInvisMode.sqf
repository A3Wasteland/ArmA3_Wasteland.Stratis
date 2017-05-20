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
	private ["_curPlayerInvisState","_player","_isAdminInvisible"];
	
	_player = player;

	// If variable is not set ,set default value.
	_isAdminInvisible = missionNamespace getVariable ["pvar_isAdminInvisible",[_player, false]];
	missionNamespace setVariable ["pvar_isAdminInvisible", _isAdminInvisible];
	_curPlayerInvisState = pvar_isAdminInvisible select 1;

	// Go hiding
	if (!_curPlayerInvisState) then
	{
		_curPlayerInvisState = true;
		pvar_isAdminInvisible = [_player, _curPlayerInvisState];
		publicVariable "pvar_isAdminInvisible";
		hint "You are now invisible";
		CCGLogger = ["AdminLog", format["Turned invisibility on [%1 (%2)]", name player, getPlayerUID player]];
	    publicVariableServer "CCGLogger";	
	}
	else
	{
		_curPlayerInvisState = false;
		pvar_isAdminInvisible = [_player, _curPlayerInvisState];
		publicVariable "pvar_isAdminInvisible";
		hint "You are no longer invisible";
	    CCGLogger = ["AdminLog", format["Turned invisibility Off [%1 (%2)]", name player, getPlayerUID player]];
	    publicVariableServer "CCGLogger";		
	};
};