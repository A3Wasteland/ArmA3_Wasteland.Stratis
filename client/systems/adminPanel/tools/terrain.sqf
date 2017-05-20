// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
// @file Name: terrain.sqf
// @file Author: Matt76 @CCG

if ((getPlayerUID player) call isAdmin) then
{
	_adminloweredterrain = player getVariable ["adminloweredterrain", false];

	if (!_adminloweredterrain) then
	{
		setTerrainGrid 50;
		hint "Terrain Low";
		player setVariable ["adminloweredterrain", true, true];
		CCGLogger = ["AdminLog", format["Admin lowered Terrain [%1 (%2)]", name player, getPlayerUID player]];
		publicVariableServer "CCGLogger";
	}
	else
	{
		setTerrainGrid 25;
		hint "Terrain Normal";
		player setVariable ["adminloweredterrain", false, true];
		CCGLogger = ["AdminLog", format["Admin set terrain back to normal [%1 (%2)]", name player, getPlayerUID player]];
		publicVariableServer "CCGLogger";
	};
};
