//@file Version: 1.2
//@file Name: gearLevel9.sqf
private ["_player"];
_player = _this;


_player setVariable ["cmoney", (_player getVariable "cmoney") + 1000, true];

{_player removeWeapon _x} forEach weapons _player;
{_player removeMagazine _x} forEach magazines _player;

removeVest _player;
removeBackpack _player;
removeGoggles _player;
removeHeadgear _player;

_player addBackpack "B_Carryall_oli"; //BackPack
_player addVest "V_PlateCarrierGL_rgr";
_player linkItem "NVGoggles";
_player linkItem "ItemGPS";
_player addWeapon "Binocular";
_player addMagazines ["HandGrenade", 2];
_player addGoggles "G_Sport_Red";
_player addHeadgear "H_HelmetB_light";

_player addMagazines ["11Rnd_45ACP_Mag", 2];
_player addWeapon "hgun_Pistol_heavy_01_F";
_player addhandGunItem "optic_MRD";
_player addhandGunItem "muzzle_snds_acp";

_player addMagazines ["30Rnd_65x39_caseless_mag", 4];
_player addWeapon "arifle_MXM_F";
_player addPrimaryWeaponItem "optic_Hamr";
_player addPrimaryWeaponItem "muzzle_snds_H";


_player addMagazines ["RPG32_F", 1];
_player addWeapon "launch_RPG32_F";

_player selectWeapon "arifle_MXM_F"; //Select Active Weapon

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
