//@file Version: 1.2
//@file Name: gearLevel3.sqf
private ["_player"];
_player = _this;


_player setVariable ["cmoney", (_player getVariable "cmoney") + 1000, true];

{_player removeWeapon _x} forEach weapons _player;
{_player removeMagazine _x} forEach magazines _player;
removeallitems _player;
removeVest _player;
removeBackpack _player;
removeGoggles _player;
removeHeadgear _player;

_player addBackpack "G_Bergen";
_player addItem "FirstAidKit";

_player addMagazines ["11Rnd_45ACP_Mag", 2];
_player addWeapon "hgun_Pistol_heavy_01_F";

_player addMagazines ["HandGrenade", 1];

_player selectWeapon "hgun_ACPC2_F";

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
