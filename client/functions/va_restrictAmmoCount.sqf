// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: va_restrictAmmoCount.sqf
//	@file Author: [FRAC] Mokey
//	@file Created: 4/18/2018 17:48

private _var = player;

Fn_Gear_CompatibleMagazines =
{
	private _cls = configFile >> "CfgWeapons" >> _this;
	private _res = [];
	{
		_res pushBack (if (_x == "this")
		then {getArray(_cls >> "magazines")}
		else {getArray(_cls >> _x >> "magazines")});
	} forEach getArray(_cls >> "muzzles");

	_res
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
			} foreach (_x call Fn_Gear_CompatibleMagazines)
		}
	}

} forEach [primaryWeapon _var, secondaryWeapon _var, handgunWeapon _var];

{
	if (count _x > 0) then
	{
		{
			if (count _x > 0) then
			{
				_var addMagazines [(_x select 0), 2]
			}
		} foreach (_x call Fn_Gear_CompatibleMagazines)
	}
} forEach [primaryWeapon _var, secondaryWeapon _var, handgunWeapon _var];
