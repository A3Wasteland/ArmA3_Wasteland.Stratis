// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: matt76_ammo.sqf v2.0
//  @file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {	
 
	if (isnil("CCGAMMO")) then {
            CCGAMMO = 0;
        };
        if (CCGAMMO == 0) then {
            CCGAMMO = 1;
			hintSilent parseText format["<t size='1.1' color='#01DF01'>Unlimited Ammo Enabled</t>"];
			CCGLogger = ["AdminLog", format["Admin Turned Unlimited Ammo On [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";	
        } else {
            CCGAMMO = 0;
			hintSilent parseText format["<t size='1.1' color='#01DF01'>Unlimited Ammo Disabled</t>"];
			CCGLogger = ["AdminLog", format["Admin Turned Unlimited Ammo On [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";			
        };
        while {
            CCGAMMO == 1
        }
        do {
            _l25 = primaryWeapon player;
            _l31 = secondaryWeapon player;
            player setAmmo[_l25, 999];
            player setAmmo[_l31, 999];
            (vehicle player) setVehicleAmmo 1;
            (vehicle player) setVehicleAmmo 1;
            sleep 0.01;
        };
};