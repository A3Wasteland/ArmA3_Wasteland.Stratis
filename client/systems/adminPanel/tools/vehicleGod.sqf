// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1
//	@file Name: VehicleGod.sqf
//	@file Author: Matt76 @ CCG
//	@file Created: 31/07/2017 15:19
//	@file Args:

if (isDedicated) exitWith {};

if ((getPlayerUID player) call isAdmin) then
{
	if (isnil "Matt76" ) then {Matt76=0};
	if (Matt76==0) then
	{	
		hint format ["Vehicle Godmode ON"];
		Matt76 = 1;
		Matt77 = true;

		CCGLogger = ["AdminLog", format["Turned ON Vehicle God Mode [%1 (%2)]", name player, getPlayerUID player]];
		publicVariableServer "CCGLogger";	

		while {matt77 && alive vehicle player} do
		{

		vehicle player setfuel 1;
		vehicle player setvehicleammo 1;
		vehicle player setdammage 0;
		sleep 0.001;
		
		};
	}
	else
	{
		hint format ["Vehicle Godmode OFF"];
		Matt77 = false;
		Matt76 = 0;

		CCGLogger = ["AdminLog", format["Turned OFF Vehicle God Mode [%1 (%2)]", name player, getPlayerUID player]];
		publicVariableServer "CCGLogger";			
	};
};

