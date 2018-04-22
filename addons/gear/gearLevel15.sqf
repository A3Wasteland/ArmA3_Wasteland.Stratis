//@file Version: 1.2
//@file Name: gearLevel10.sqf
//@file Author: Cael817, based of something i found - fixed by soulkobk 11:16 PM 20/04/2018
private ["_player"];
_player = _this;

_player setVariable ["gmoney",1000];

#include "gearWhiteList.sqf"

["Open",false] call BIS_fnc_arsenal;

[missionNameSpace,(_availableBackPacks),false,false] call BIS_fnc_addVirtualBackpackCargo;
[missionNameSpace,(_availableHeadGear + _availableHeadGearAccessories + _availableUniforms + _availableVests + _availableAttachments + _availableAccessories + _availableAttachments),false,false] call BIS_fnc_addVirtualItemCargo;
[missionNameSpace,(_availableRifleMagazines + _availableSniperMagazines + _availableLmgMagazines + _availableSmgMagazines + _availableHandGunMagazines + _availableRockets + _availableHandGrenades + _availableGLRounds + _available3GLRounds + _availableExplosives),false,false] call BIS_fnc_addVirtualMagazineCargo;
[missionNameSpace,(_availableRifles + _availableSnipers + _availableLmgs + _availableSmgs + _availableHandGuns + _availableLaunchers),false,false] call BIS_fnc_addVirtualWeaponCargo;

systemChat format["Welcome %1, Enjoy your Virtual Arsenal!", name player];
