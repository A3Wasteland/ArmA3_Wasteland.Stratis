// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: gearRestric.sqf
//	@file Author: [FRAC] Mokey , PIX515E, Strilles
//	@file Created: 4/18/2018 17:48

/*/-----------------Limits apply to each array in gearWhiteList.sqf-----------------/*/
/*/-----To remove an item completley, just comment it out in gearWhiteList.sqf-----/*/
/*/--------------------------Remember 1 Mag spawns in gun-------------------------/*/
_limitRockets = 1;
_limitRifleMagazines = 3;
_limitSniperMagazines = 3;
_limitLmgMagazines = 2;
_limitSmgMagazines = 4;
_limitHandGunMagazines = 2;
_limitHandGrenades = 2;
_limitGLRounds = 3;
_limit3GLRounds = 1;
_limitExplosives = 2;
/*/---END---/*/

/*/------------------------------------------------------------------------/*/
/*/----------DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING----------/*/
/*/------------------------------------------------------------------------/*/

#include "gearWhiteList.sqf"

_restrictedRocketsCount = (count _availableRockets) -1;
_count = 0;
while {_count < _restrictedRocketsCount} do
{
    for "_x" from 0 to _restrictedRocketsCount do
    {
        _selectRockets = _availableRockets select _x;
        _countRockets = {_selectRockets == _x} count (backpackItems player);
        if (_countRockets > _limitRockets) then
        {
            for "_i" from 1 to (_countRockets - _limitRockets) do
            {
              player removeItem _selectRockets;
            };
        };
    };
    _count = _count + 1;
};

_restrictedRifleMagazineCount = (count _availableRifleMagazines) -1;
_count = 0;
while {_count < _restrictedRifleMagazineCount} do
{
    for "_x" from 0 to _restrictedRifleMagazineCount do
    {
        _selectRifleMagazines = _availableRifleMagazines select _x;
        _countRifleMagazines = {_selectRifleMagazines == _x} count (ItemsWithMagazines player);
        if (_countRifleMagazines > _limitRifleMagazines) then
        {
            for "_i" from 1 to (_countRifleMagazines - _limitRifleMagazines) do
            {
              player removeItem _selectRifleMagazines;
            };
        };
    };
    _count = _count + 1;
};

_restrictedSniperMagazineCount = (count _availableSniperMagazines) -1;
_count = 0;
while {_count < _restrictedSniperMagazineCount} do
{
    for "_x" from 0 to _restrictedSniperMagazineCount do
    {
        _selectSniperMagazines = _availableSniperMagazines select _x;
        _countSniperMagazines = {_selectSniperMagazines == _x} count (ItemsWithMagazines player);
        if (_countSniperMagazines > _limitSniperMagazines) then
        {
            for "_i" from 1 to (_countSniperMagazines - _limitSniperMagazines) do
            {
              player removeItem _selectSniperMagazines;
            };
        };
    };
    _count = _count + 1;
};

_restrictedLmgMagazineCount = (count _availableLmgMagazines) -1;
_count = 0;
while {_count < _restrictedLmgMagazineCount} do
{
    for "_x" from 0 to _restrictedLmgMagazineCount do
    {
        _selectLmgMagazines = _availableLmgMagazines select _x;
        _countLmgMagazines = {_selectLmgMagazines == _x} count (ItemsWithMagazines player);
        if (_countLmgMagazines > _limitLmgMagazines) then
        {
            for "_i" from 1 to (_countLmgMagazines - _limitLmgMagazines) do
            {
              player removeItem _selectLmgMagazines;
            };
        };
    };
    _count = _count + 1;
};

_restrictedSmgMagazineCount = (count _availableSmgMagazines) -1;
_count = 0;
while {_count < _restrictedSmgMagazineCount} do
{
    for "_x" from 0 to _restrictedSmgMagazineCount do
    {
        _selectSmgMagazines = _availableSmgMagazines select _x;
        _countSmgMagazines = {_selectSmgMagazines == _x} count (ItemsWithMagazines player);
        if (_countSmgMagazines > _limitSmgMagazines) then
        {
            for "_i" from 1 to (_countSmgMagazines - _limitSmgMagazines) do
            {
              player removeItem _selectSmgMagazines;
            };
        };
    };
    _count = _count + 1;
};

_restrictedHandGunMagazineCount = (count _availableHandGunMagazines) -1;
_count = 0;
while {_count < _restrictedHandGunMagazineCount} do
{
    for "_x" from 0 to _restrictedHandGunMagazineCount do
    {
        _selectHandGunMagazines = _availableHandGunMagazines select _x;
        _countHandGunMagazines = {_selectHandGunMagazines == _x} count (ItemsWithMagazines player);
        if (_countHandGunMagazines > _limitHandGunMagazines) then
        {
            for "_i" from 1 to (_countHandGunMagazines - _limitHandGunMagazines) do
            {
              player removeItem _selectHandGunMagazines;
            };
        };
    };
    _count = _count + 1;
};

_restrictedHandGrenadesCount = (count _availableHandGrenades) -1;
_count = 0;
while {_count < _restrictedHandGrenadesCount} do
{
    for "_x" from 0 to _restrictedHandGrenadesCount do
    {
        _selectHandGrenades = _availableHandGrenades select _x;
        _countHandGrenades = {_selectHandGrenades == _x} count (ItemsWithMagazines player);
        if (_countHandGrenades > _limitHandGrenades) then
        {
            for "_i" from 1 to (_countHandGrenades - _limitHandGrenades) do
            {
              player removeItem _selectHandGrenades;
            };
        };
    };
    _count = _count + 1;
};

_restrictedGLRoundsCount = (count _availableGLRounds) -1;
_count = 0;
while {_count < _restrictedGLRoundsCount} do
{
    for "_x" from 0 to _restrictedGLRoundsCount do
    {
        _selectGLRounds = _availableGLRounds select _x;
        _countGLRounds = {_selectGLRounds == _x} count (ItemsWithMagazines player);
        if (_countGLRounds > _limitGLRounds) then
        {
            for "_i" from 1 to (_countGLRounds - _limitGLRounds) do
            {
              player removeItem _selectGLRounds;
            };
        };
    };
    _count = _count + 1;
};

_restricted3GLRoundsCount = (count _available3GLRounds) -1;
_count = 0;
while {_count < _restricted3GLRoundsCount} do
{
    for "_x" from 0 to _restricted3GLRoundsCount do
    {
        _select3GLRounds = _available3GLRounds select _x;
        _count3GLRounds = {_select3GLRounds == _x} count (ItemsWithMagazines player);
        if (_count3GLRounds > _limit3GLRounds) then
        {
            for "_i" from 1 to (_count3GLRounds - _limit3GLRounds) do
            {
              player removeItem _select3GLRounds;
            };
        };
    };
    _count = _count + 1;
};

_restrictedExplosivesCount = (count _availableExplosives) -1;
_count = 0;
while {_count < _restrictedExplosivesCount} do
{
    for "_x" from 0 to _restrictedExplosivesCount do
    {
        _selectExplosives = _availableExplosives select _x;
        _countExplosives = {_selectExplosives == _x} count (ItemsWithMagazines player);
        if (_countExplosives > _limitExplosives) then
        {
            for "_i" from 1 to (_countExplosives - _limitExplosives) do
            {
              player removeItem _selectExplosives;
            };
        };
    };
    _count = _count + 1;
};

_whiteListedItems =
_availableAttachments +
_availableRifles +
_availableRifleMagazines +
_availableSnipers +
_availableSniperMagazines +
_availableLmgs +
_availableLmgMagazines +
_availableSmgs +
_availableSmgMagazines +
_availableHandGuns +
_availableHandGunMagazines +
_availableLaunchers +
_availableRockets +
_availableHandGrenades +
_availableGLRounds +
_available3GLRounds +
_availableExplosives +
_availableHeadGear +
_availableHeadGearAccessories +
_availableUniforms +
_availableBackPacks +
_availableVests +
_availableAccessories;

private ["_allItems", "_assignedItems", "_whiteListedItems"];
_allItems = (items player) + (player weaponAccessories (currentWeapon player));
{
    if !(_x in _whiteListedItems) then
        {
                player removePrimaryWeaponItem _x;
                player removeHandGunItem _x;
                player removeItemFromUniform _x;
                player removeItemFromVest _x;
                player removeItemFromBackpack _x;
                player removeItem _x;
    };
} forEach _allItems;

_assignedItems = (assignedItems player);
{
    if !(_x in _whiteListedItems) then
    {
        player unassignItem _x;
        player removeItem _x;
    };
} forEach _assignedItems;

{
        if !(_x in _whiteListedItems) Then
        {
                player removeWeapon _x;
        };

} forEach weapons player;
