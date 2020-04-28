/*
	Author: 7erra <https://forums.bohemia.net/profile/1139559-7erra/>

	Description:
	Change the inventory of a shop.

	Parameter(s):
	0: OBJECT - The shop object whose inventory will be changed.
	1: ARRAY - List of items, prices and amounts to add
		Format: ["class0", price, amount, "class1", price, amount,..., "classN", price, amount]
			Class: STRING - Class name of the item
			Price: NUMBER - The cost of the item
			Amount: NUMBER or BOOL - How many items the trader has. True means unlimited, false removes it from the inventory.
	(optional) 2: NUMBER - Overwrite mode:
		0 - Don't overwrite, only add new things
		1 - (default) Overwrite soft, only adjust prices and add new things
		2 - Hard overwrite, the passed array becomes the new inventory
		3 - Overwrite old, don't add new entries, only modify old ones
		4 - Amount diff, add/substract amounts
	(optional) 3: BOOL - Change inventory for all players. If not specified, the _object's "TER_VASS_shared" variable is used. If this isn't set either it defaults to true.

	Returns:
	ARRAY - New inventory
*/

params ["_object","_cargo", ["_overwrite", 1]];
_global = param [3, _object getVariable ["TER_VASS_shared",true]];

_cargoClasses = _cargo select {_x isEqualType ""};
_cargoClasses = _cargoClasses apply {toLower _x};
//--- Shop settings
_newCargo = [];
if (_overwrite != 2) then {
	_newCargo = _object getVariable ["TER_VASS_cargo",[]];
};

for "_i" from 0 to (count _cargo -3) step 3 do {
	//--- Iterate through the classes
	_class = tolower (_cargo#_i);
	_price = _cargo#(_i+1);
	_amount = _cargo#(_i+2);

	_findInd = _newCargo findIf {_class isEqualTo _x};
	if (_findInd != -1 && (_overwrite == 1 || _overwrite == 4)) then {
		//--- Overwrite current setting
		if (_overwrite == 4) then {
			_amount = _amount + (_newCargo#(_findInd+2));
		};
		_newCargo set [_findInd+1, _price];
		_newCargo set [_findInd+2, _amount];
	};
	if (_findInd == -1 && _overwrite != 3) then {
		//--- New entry
		_findInd = count _newCargo;
		_newCargo set [_findInd+0, _class];
		_newCargo set [_findInd+1, _price];
		_newCargo set [_findInd+2, _amount];
	};
};

_returnCargo = [];
for "_i" from 2 to (count _newCargo -1) step 3 do {
	// only items whith quantity not false
	if !((_newCargo#_i) isEqualTo false) then {
		_returnCargo append [_newCargo#(_i-2), _newCargo#(_i-1), _newCargo#_i];
	};
};

if (isNil {_object getVariable "TER_VASS_cargo_default"}) then {
	_object setVariable ["TER_VASS_cargo_default",_returnCargo, _global];
};
_object setVariable ["TER_VASS_cargo",_returnCargo, _global];
_returnCargo
