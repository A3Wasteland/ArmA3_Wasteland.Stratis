	// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: aiEsp.sqf v2.0
//	@file Author: Matt76 @CCG

_uid = getPlayerUID player;

if (_uid call isAdmin) then {

	matt76_aie5p = {
		if (isnil("stopcopyandpastingmyshit2")) then {
			stopcopyandpastingmyshit2 = 0;
		};
		if (stopcopyandpastingmyshit2 == 0) then {
			stopcopyandpastingmyshit2 = 1;
			hint "In game E5P ON";
			CCGLogger = ["AdminLog", format["Turned Ai ESP On [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";			
		} else {
			stopcopyandpastingmyshit2 = 0;
			hint "In game E5P OFF";
			CCGLogger = ["AdminLog", format["Turned Ai ESP Off [%1 (%2)]", name player, getPlayerUID player]];
			publicVariableServer "CCGLogger";				
		};
		if (stopcopyandpastingmyshit2 == 1) then {
			onEachFrame {
				_l49 = nearestobjects[player, ["CAManBase"], 2000]; {

					if (!(isPlayer _x) && ((player distance _x) < 2000)) then {
						drawIcon3D["", [255, 204, 0, 1], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2) + 1], 0.1, 0.1, 45, (format["%2 : %1m", round(player distance _x), name _x]), 1, 0.04, "TahomaB"]
					};
				}
				foreach allUnits;
			};
		} else {
			onEachFrame {
				nil
			};
		};
	};

	[] spawn matt76_aie5p
};	