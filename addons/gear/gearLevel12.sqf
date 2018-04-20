//@file Version: 1.2
//@file Name: gearLevel12.sqf
private ["_player"];
_player = _this;

// _player setVariable ["cmoney", (_player getVariable "cmoney") + 1000, true];
_player setVariable ["gmoney",1000];

{_player removeWeapon _x} forEach weapons _player;
{_player removeMagazine _x} forEach magazines _player;

removeallitems _player;
removeVest _player;
removeBackpack _player;
removeGoggles _player;
removeHeadgear _player;

_player addBackpack "G_Bergen";
_player addMagazines ["9Rnd_45ACP_Mag", 1];
_player addWeapon "hgun_ACPC2_F";

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
