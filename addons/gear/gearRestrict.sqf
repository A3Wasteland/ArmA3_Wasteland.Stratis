// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: gearRestrict.sqf
//	@file Author: [FRAC] Mokey
//	@file Created: 4/18/2018 17:48

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
