// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: gearRestrict.sqf
//	@file Author: [FRAC] Mokey
//	@file Created: 4/18/2018 17:48

_restrictedAmmoArray = [
"RPG7_F",
"RPG32_F",
"RPG32_HE_F",
"MRAWS_HEAT_F",
"MRAWS_HE_F",
"Vorona_HEAT",
"Vorona_HE",
"NLAW_F",
"Titan_AT",
"Titan_AP",
"Titan_AA"];

//restrict rocketAmmoArray count from BackPack
_restrictedAmmoArrayCount = (count _restrictedAmmoArray) -1;
_count = 0;
_limit = 1;
while {_count < _restrictedAmmoArrayCount} do
{
    for "_x" from 0 to _restrictedAmmoArrayCount do
    {
        _currentElement = _restrictedAmmoArray select _x;
        _numberOfKits = {_currentElement == _x} count (backpackItems player);
        if (_numberOfKits > _limit) then
        {
            for "_i" from 1 to (_numberOfKits - _limit) do
            {
          player removeItem _currentElement;
          };
        };
    };
    _count = _count + 1;
};
