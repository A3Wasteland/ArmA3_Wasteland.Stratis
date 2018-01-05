//@file Version: 1.2
//@file Name: gearLevel8.sqf
//@file Author: Cael817, based of something i found
private ["_player"];
_player = _this;


_player setVariable ["cmoney", (_player getVariable "cmoney") + 800, true];

{_player removeWeapon _x} forEach weapons _player;
{_player removeMagazine _x} forEach magazines _player;
//removeUniform _player;
//removeallitems _player;
removeVest _player;
removeBackpack _player;
removeGoggles _player;
removeHeadgear _player;

_player addBackpack "B_Carryall_oli"; //BackPack
//_player addUniform ""; //Uniform (must be supported by side)
_player addVest "V_TacVest_oli"; //Vest
_player linkItem "NVGoggles"; //Nightvision, "NVGoggles"
_player linkItem "ItemGPS"; //GPS, "ItemGPS"
_player addWeapon "Binocular"; //Binoculars
_player addMagazines ["HandGrenade", 2]; //Grenades
_player addItem "FirstAidKit"; //Any other stuff that goes in inventory if there is space
//_player addItem "Medikit"; //Any other stuff that goes in inventory if there is space
//_player addItem "ToolKit"; //Any other stuff that goes in inventory if there is space
//_player addItem ""; //Any other stuff that goes in inventory if there is space
//_player addItem ""; //Any other stuff that goes in inventory if there is space
_player addGoggles "G_Sport_Red"; //Glasses or masks. Overwrites, add as item if you want it a an extra item
_player addHeadgear "H_HelmetB_light"; //Hat or helmet. Overwrites, add as item if you want it a an extra item

_player addMagazines ["11Rnd_45ACP_Mag", 4]; //Add handgun magazines first so one gets loaded
_player addWeapon "hgun_Pistol_heavy_01_F"; //Handgun
_player addhandGunItem "optic_MRD"; //Handgun Attachments
//_player addhandGunItem ""; //Handgun Attachments

_player addMagazines ["30Rnd_65x39_caseless_mag", 2]; //Add primary weapon magazines first so one gets loaded
_player addWeapon "arifle_MXC_F"; //Primary Weapon
_player addPrimaryWeaponItem "optic_Holosight_smg"; //Primary Weapon Attachments
//_player addPrimaryWeaponItem ""; //Primary Weapon Attachments
//_player addPrimaryWeaponItem ""; //Primary Weapon Attachments

_player addMagazines ["RPG32_F", 1]; //Add secondary Weapon magazines first so one gets loaded
_player addWeapon "launch_RPG32_F"; //Secondary Weapon (Launcher slot)

_player selectWeapon "arifle_MXC_F"; //Select Active Weapon

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		_player addItem "MediKit";
		_player removeItem "";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		_player addItem "ToolKit";
		_Player addItem "MineDetector";
		_player removeItem "";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		_player addWeapon "Rangefinder";
		_player removeItem "";
	};
		case (["_diver_", typeOf _player] call fn_findString != -1):
	{
		_player addVest "V_RebreatherIA";
		_player addGoggles "G_Diving";
		_player removeItem "";

	};
};
