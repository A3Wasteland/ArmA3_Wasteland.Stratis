/*
	Author: 7erra <https://forums.bohemia.net/profile/1139559-7erra/>

	Description:
	Function to change the items of a shop after a certain amount of time.

	Parameter(s):
	0: OBJECT - Shop object.
	1: ARRAY or TRUE - List of items to readd/remove OR true to reset the inventory to default.
	(optional) 2: NUMBER - Time until reset. Negative values will use the "TER_VASS_refresh" variable from the object.
		default: -1
	(optional) 3: BOOL - Passed items will become the only ones after reset. If items is true then it is automatically set to reset.
		default: false

	Returns:
	Bool - True when done
*/

params ["_object", "_items", ["_sleep", -1], ["_reset",false]];

if (_sleep < 0) then {
	_sleep = _object getVariable "TER_VASS_refresh"
};
if (_items isEqualTo true) then {
	_items = _object getVariable "TER_VASS_cargo_default";
	_reset = true;
};
sleep _sleep;
[_object, _items, [4,2]select(_reset)] call TER_fnc_addShopCargo;
true