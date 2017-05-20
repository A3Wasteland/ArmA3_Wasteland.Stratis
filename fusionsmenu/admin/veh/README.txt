===================================================================================================================================================
Instructions on how to add more vehicles to the list.
===================================================================================================================================================

Okay so first lets get what kind of vehicle you want, Go here to get them

http://forums.bistudio.com/showthread.php?169226-Arma-3-Assets-Objects-Weapons-Magazines-and-much-more
===================================================================================================================================================
Okay so now what you do is make a addAction so that it actually comes up in the menu.

car2 = player addAction ["Name Of Vehicle",{execVM "fusionsmenu\admin\veh\CARNAME.sqf";}];  // Change the car2 to what ever car it is

Make sure that the actual removeAction in the vehicles sqf file is declared!!!!!!!

NOW TO MAKE THE ACTUAL VEHICLE

_spawn = "REPLACE ME WITH CAR CLASS NAME";
_posplr = [((getPos player) select 0) + 2, ((getPos player) select 1) + 2, 0];
_dirplr = getDir player;
_spwnveh = _spawn createVehicle (_posplr);
_spwnveh setVariable ["Sarge",1,true];
player removeAction car;
player removeAction car1;
player removeAction car2;
player removeAction line1;
player removeAction line2;
player removeAction godmode;
player removeAction tele;
player removeAction guns;
player removeAction mainveh;
player removeAction cgod;
player removeAction hplay;   // Keep adding these for how many you have in ALL of the vehicle sqfs :D 

I will be continually updating this to make a better menu <3

===================================================================================================================================================
===================================================================================================================================================