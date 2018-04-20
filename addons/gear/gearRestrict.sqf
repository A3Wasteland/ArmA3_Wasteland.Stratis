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
	"Titan_AA"
	];

//The following is functional TO A Point. It will check for all items in the array and delete them down to 1each.
//I.E; if you have 5 MAAWS HEAT and 4 MAAWS HE you will wind up with 1 MAAWS HEAT and 1  MAAWS HE.

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


/*/--------------------OLD RESTRICT--------------------/*/
/*
private _var = player;
fn_gearCompatibleMagazines =
{
	private _class = configFile >> "CfgWeapons" >> _this;
	private _result = [];
	{
		_result pushBack (if (_x == "this")
		then
		{
			getArray(_class >> "magazines")
		}
		else
		{
			getArray(_class >> _x >> "magazines")
		});
	} forEach getArray(_class >> "muzzles");

	_result
};

{
	if (count _x > 0) then
	{
		while {count _x > 0} do {
			{
			    if (count _x > 0) then
			    	{
					_var removeMagazine (_x select 0)
				}
			} foreach (_x call fn_gearCompatibleMagazines)
		}
	}

} forEach [primaryWeapon _var, secondaryWeapon _var, handgunWeapon _var];

{
	if (count _x > 0) then
	{
		{
			if (count _x > 0) then
			{
				_var addMagazines [(_x select 0), 4]
			}
		} foreach (_x call fn_gearCompatibleMagazines)
	}
} forEach [primaryWeapon _var, handgunWeapon _var];
