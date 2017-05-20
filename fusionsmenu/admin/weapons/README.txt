===================================================================================================================================================
Instructions on how to add more guns to the list.
===================================================================================================================================================

Okay so first lets get what kind of gun you want, Go here to get them

http://forums.bistudio.com/showthread.php?169226-Arma-3-Assets-Objects-Weapons-Magazines-and-much-more
===================================================================================================================================================
Okay so now what you do is make a addAction so that it actually comes up in the menu.

gun1 = player addAction ["Name Of GUN",{execVM "fusionsmenu\admin\weapons\WEAPONNAME.sqf";}];  // Change the car2 to what ever car it is

Make sure that the actual removeAction in the vehicles sqf file is declared!!!!!!!

NOW TO MAKE THE ACTUAL VEHICLE

GearAdd = (vehicle player);
GearAdd addWeapon 'REPLACE WITH GUN CLASSNAME';
GearAdd addMagazine '30Rnd_65x39_caseless_mag'; // CHANGE FOR MAG NAME
GearAdd addMagazine '30Rnd_65x39_caseless_mag'; // CHANGE FOR MAG NAME
GearAdd addMagazine '30Rnd_65x39_caseless_mag'; // CHANGE FOR MAG NAME ALSO ADD MORE OF THESE TO GET MORE WEAPONS
player removeAction gun;
player removeAction gun1;
player removeAction line1;
player removeAction line2;
player removeAction godmode;
player removeAction tele;
player removeAction guns;
player removeAction mainveh;
player removeAction cgod;
player removeAction hplay;  // Keep adding these for how many you have in ALL of the vehicle sqfs :D 

I will be continually updating this to make a better menu <3

===================================================================================================================================================
===================================================================================================================================================