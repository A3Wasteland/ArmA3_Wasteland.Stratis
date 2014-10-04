//	@file Version: 1.2
//	@file Name: playerActions.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19

{ [player, _x] call fn_addManagedAction } forEach
[
	[format ["<img image='client\icons\playerMenu.paa' color='%1'/> <t color='%1'>[</t>Player Menu<t color='%1'>]</t>", "#FF8000"], "client\systems\playerMenu\init.sqf", [], -10, false], //, false, "", ""],

	["<img image='client\icons\money.paa'/> Pickup Money", "client\actions\pickupMoney.sqf", [], 1, false, false, "", "{_x getVariable ['owner', ''] != 'mission'} count (player nearEntities ['Land_Money_F', 5]) > 0"],

	["<img image='client\icons\save.paa'/> Save Vehicle", "addons\scripts\vehicle_save.sqf", [cursorTarget], 1,false,false,"","!isNull cursorTarget && (alive cursorTarget) && {{ cursorTarget isKindOf _x } count ['Air','Tank','Motorcycle','Car','Ship'] > 0 ;} && !(cursorTarget getVariable ['objectLocked', false]) && !(cursorTarget getVariable ['R3F_LOG_disabled', false]) && (player distance cursortarget) < 7"],
	["<img image='client\icons\save.paa'/> Unsave Vehicle", "addons\scripts\vehicle_unsave.sqf", [cursorTarget], 1,false,false,"","!isNull cursorTarget && (alive cursorTarget) && {{ cursorTarget isKindOf _x } count ['Air','Tank','Motorcycle','Car','Ship'] > 0 ;} && (cursorTarget getVariable ['objectLocked', false]) && !(cursorTarget getVariable ['R3F_LOG_disabled', false]) && (player distance cursortarget) < 7 "],
	["<img image='client\icons\r3f_lock.paa'/> Lock Vehicle", "addons\scripts\vehicle_lock.sqf", [cursorTarget], 1,false,false,"","!isNull cursorTarget && (alive cursorTarget) && {{ cursorTarget isKindOf _x } count ['Air','Tank','Motorcycle','Car','Ship'] > 0 ;} && !((locked cursorTarget)==2) && (count crew cursorTarget == 0) && !(cursorTarget getVariable ['R3F_LOG_disabled', false]) && (player distance cursortarget) < 7"],
	["<img image='client\icons\r3f_unlock.paa'/> Unlock Vehicle", "addons\scripts\vehicle_unlock.sqf", [cursorTarget], 1,false,false,"","!isNull cursorTarget && (alive cursorTarget) && {{ cursorTarget isKindOf _x } count ['Air','Tank','Motorcycle','Car','Ship'] > 0 ;} && ((locked cursorTarget)==2) && !(cursorTarget getVariable ['R3F_LOG_disabled', false]) && ((player distance cursortarget) < 7) && (((str(cursorTarget getVariable ['side', false])==str(side player)) && (str(cursorTarget getVariable ['side', false])!='GUER')) || (str(cursorTarget getVariable ['ownerUID', false])==str(getPlayerUID player)))"],
	["<img image='client\icons\repair.paa'/> Salvage", "client\actions\salvage.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && !alive cursorTarget && {cursorTarget isKindOf 'AllVehicles' && !(cursorTarget isKindOf 'Man') && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 2}"],
	["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> <t color='#FFFFFF'>Cancel Action</t>", "noscript.sqf", "doCancelAction = true", 1, false, false, "", "mutexScriptInProgress"],
	["<img image='client\icons\repair.paa'/> Repair", "addons\scripts\tower_repair.sqf", [], 1.1, false, false, "", "!isNull cursorTarget && alive cursorTarget && (((typeOf cursorTarget == 'Land_Cargo_Tower_V1_ruins_F') || (typeOf cursorTarget == 'Land_Cargo_Patrol_V1_ruins_F')) && player distance cursorTarget <= (sizeOf typeOf cursorTarget / 3) max 2)"],

	["[0]"] call getPushPlaneAction,
	["Push vehicle", "server\functions\pushVehicle.sqf", [2.5, true], 1, false, false, "", "[2.5] call canPushVehicleOnFoot"],
	["Push vehicle forward", "server\functions\pushVehicle.sqf", [2.5], 1, false, false, "", "[2.5] call canPushWatercraft"],
	["Push vehicle backward", "server\functions\pushVehicle.sqf", [-2.5], 1, false, false, "", "[-2.5] call canPushWatercraft"],

	["<t color='#FF0000'>Emergency eject</t>", "client\actions\forceEject.sqf", [], -9, false, true, "", "(vehicle player) isKindOf 'Air'"],
	["<t color='#FF00FF'>Open magic parachute</t>", "client\actions\openParachute.sqf", [], 20, true, true, "", "vehicle player == player && (getPos player) select 2 > 2.5"]
];


// Hehehe...
if !(288520 in getDLCs 1) then
{
	[player, ["<t color='#00FFFF'>Get in as Driver</t>", "client\actions\moveInDriver.sqf", [], 6, true, true, "", "cursorTarget isKindOf 'Kart_01_Base_F' && player distance cursorTarget < 3.4 && isNull driver cursorTarget"]] call fn_addManagedAction;
};