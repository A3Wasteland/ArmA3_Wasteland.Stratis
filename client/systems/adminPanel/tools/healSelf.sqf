// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: checkAdmin.sqf
//	@file Author: Matt76

_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	hint format ["Healing..."];
	sleep 2;
	player setDamage 0;
	hint format ["Your all fixed up"];

	CCGLogger = ["AdminLog", format["Healed Self [%1 (%2)]", name player, getPlayerUID player]];
	publicVariableServer "CCGLogger";	

};