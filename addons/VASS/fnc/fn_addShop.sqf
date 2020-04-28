/*
	Author: 7erra <https://forums.bohemia.net/profile/1139559-7erra/>

	Description:
	Add shop action to an object. Any previous actions of this type are removed. VASS is only activated when the arsenal is opened via this function.

	Parameter(s):
	0: OBJECT - Object to which the action is added.
	(optional) 1: STRING - Title of the action
		default: "Shop"
	(optional) 2: NUMBER - Priority of the action, see BIKI: addAction
		default: 1.5
	(optional) 3: STRING - Condition which has to be fullfilled for shop to be accessible, see BIKI: addAction
		default: "alive _this && alive _object"
	(optional) 4: NUMBER - Distance from which the action is activatable
		default: 5

	Returns:
	NUMBER - ID of the action, alos saved as "TER_VASS_actionID" on the object.
*/

params [ "_object", ["_title","Shop"], ["_priority",1.5], ["_condition","alive _this && alive _target"], ["_radius",5] ];
_actionID = _object getVariable ["TER_VASS_actionID",-1];
if (_actionID > -1) then {_object removeAction _actionID};
_actionID = _object addAction [_title,{
	params ["_object", "_caller", "_actionId", "_arguments"];
	TER_VASS_shopObject = _object;
	uiNamespace setVariable ["TER_VASS_shopObject",_object];
	//--- Arsenal cargo
	_cargo = _object getVariable ["TER_VASS_cargo",[]];
	_cargo = _cargo select {_x isEqualType ""};
	_cargo = _cargo select {
		_iValues = [_object, _x] call TER_fnc_getItemValues;
		_amount = _iValues#2;
		if (_amount isEqualType 0) then {_amount > 0} else {_amount}
	};
	_vItems = [[/*Weapons*/],[/*Items*/],[/*Mags*/],[/*backpacks*/]];
	{
		_category = (_x call BIS_fnc_itemType) select 0;
		_type = (_x call BIS_fnc_itemType) select 1;
		_ind = switch _category do {
			case "Weapon":{0};
			case "Equipment";
			case "Item":{1};
			case "Mine";
			case "Magazine":{2};
			default {3};
		};
		_ind = switch _type do {
			case "Backpack":{3};
			default{_ind};
		};
		_vItems#_ind pushback _x;
	} forEach _cargo;
	if (isNil {_object getvariable "bis_fnc_arsenal_action"}) then {
		_object setvariable ["bis_fnc_arsenal_action",-1];// Prevent default arsenal action. for some reason it's still getting added otherwise
	};
	{
		[_object, true, false] call call compile format ["BIS_fnc_removeVirtual%1Cargo",_x];
		[_object, _vItems select _forEachIndex, false, false] call call compile format ["BIS_fnc_addVirtual%1Cargo",_x];
	} forEach ["Weapon","Item","Magazine","Backpack"];
	//--- Open Arsenal
	["Open",[nil,_object,_caller]] call bis_fnc_arsenal;
}, [], _priority, true, true, "", _condition, _radius];
_object setVariable ["TER_VASS_actionID",_actionId];
//--- Update shops array but only if the shop hasnt been added yet
if (isNil "TER_VASS_allShops") then {
	TER_VASS_allShops = [];
};
_newInd = TER_VASS_allShops pushBackUnique _object;
if (_newInd >= 0) then {publicVariable "TER_VASS_allShops";};
_actionID

