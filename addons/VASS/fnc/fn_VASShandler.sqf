/*
	Author: 7erra <https://forums.bohemia.net/profile/1139559-7erra/>

	Description:
	 VASS calls this function when certain events happen. Add your own code to change behaviour.
	 (Similar to BIS_fnc_callScriptedEventHandler)

	Parameter(s):
	 0: STRING - Mode in which the functions is called
	 1: ARRAY - Passed arguments

	Returns:
	 See sub functions
*/

params ["_mode",["_this",[]]];

switch _mode do {
	case "getMoney":{
		/*
			Description:
			 VASS wants to know how much money the unit has

			Parameter(s):
			 0: OBJECT - Unit whose money is requested

			Has to return:
			 NUMBER - Unit's money
		*/
		params ["_unit"];
		/* EXAMPLE */
		rating _unit
	};
	case "setMoney":{
		/*
			Description:
			 VASS changes the amount of money the player has

			Parameter(s):
			 1: OBJECT - Unit whose money will be changed
			 0: NUMBER - Amount of money changed (can be positive or negative)

			Has to return:
			 Nothing
		*/
		params ["_unit", "_change"];
		/* EXAMPLE */
		_unit addRating _change;
	};
};