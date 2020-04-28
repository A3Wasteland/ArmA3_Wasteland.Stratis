/*
	Author: 7erra <https://forums.bohemia.net/profile/1139559-7erra/>

	Description:
	Function searches the cargo array of an object for the specified item class name and returns it's values as they are used in the shop.

	Parameter(s):
	0: OBJECT - Shop object
	1: STRING - Class name of the requested item
	2: (optional) NUMBER - Type of return: class (0), price (1), amount (2) or array of those (-1)
		Default: -1, returns all values
	3: (optional) ARRAY - Returned array when item is not part of the shop
		Default: [param1, 0, -1]

	Returns:
	ARRAY - ["class", price, amount]
	amount can be either a number (negative, 0 and positive) or a boolean: true - unlimited items

	NOTE: Theoretically the amount can also be false which means that the item will be removed next time the cargo us updated. This function shouldn't be able to return it though.
*/
params ["_object","_class",["_return",-1]];
_default = param [3,[_class,0,0]];
_default params [["_dClass",_class],["_dPrice",0],["_dAmount",0]];
private _cargo = _object getVariable ["TER_VASS_cargo",[]];
_class = toLower _class;

_cargo = [_dPrice, _dAmount] +_cargo;
_findInd = _cargo findIf {_x isEqualTo _class};
_rArray = [_dClass, _cargo#(_findInd+1), _cargo#(_findInd+2)];
if (_return < 0) then {
	_rArray
} else {
	_rArray#_return
};