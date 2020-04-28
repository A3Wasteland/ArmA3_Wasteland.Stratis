#include "\A3\Ui_f\hpp\defineResinclDesign.inc"
#include "idcs.inc"
#define SELF (compile preprocessFileLineNumbers "addons\VASS\gui\scripts\RscDisplayCheckout.sqf")
#define MONEYGREEN [0.13,0.42,0.16,1]
/*DEBUG
#define TER_fnc_getItemValues (compile preprocessFileLineNumbers "addons\VASS\fnc\fn_getItemValues.sqf")
#define TER_fnc_resetTimer (compile preprocessFileLineNumbers "addons\VASS\fnc\fn_resetTimer.sqf")
*/
params ["_mode","_this"];
switch _mode do {
	case "onLoad":{
		//--- Init GUI
		params ["_grpCheckout"];
		_displayArsenal = ctrlParent _grpCheckout;
		private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		//--- Tabs Added/Removed
		_tabsChange = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_TABSCHANGE;
		_tabsChange ctrlAddEventHandler ["ToolBoxSelChanged",{
			with uiNamespace do {["tabChange",_this] call SELF};
		}];
		//--- LNB header line
		_header = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_LNBHEADERITEMS;
		_header lnbAddRow ["","#","Item","Price","Total"];
		_header ctrlEnable false;
		//--- LNB items
		_lnbItemsAdded = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_LNBITEMSADDED;
		_lnbItemsRemoved = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_LNBITEMSREMOVED;
		_lnbItemsRemoved ctrlEnable false;
		//--- Button buy
		_btnBuy = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_BTNBUY;
		_btnBuy ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["btnBuy",_this] call SELF};
		}];
		//--- Button return
		_btnReturn = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_BTNRETURN;
		_btnReturn ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["btnReturn",_this] call SELF};
		}];
	};
	case "refresh":{
		params ["_grpCheckout"];
		_displayArsenal = ctrlParent _grpCheckout;
		_grpCheckout ctrlsetfade 0;
		_grpCheckout ctrlcommit 0.15;
		_grpCheckout ctrlenable true;
		private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		//--- LNB items
		_lnbItemsAdded = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_LNBITEMSADDED;
		_lnbItemsRemoved = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_LNBITEMSREMOVED;
		{lnbClear _x} forEach [_lnbItemsAdded, _lnbItemsRemoved];
		_columns = count lnbGetColumnsPosition _lnbItemsAdded;
		{
			_x params ["_item","_amount"];
			_ctrl = [_lnbItemsRemoved, _lnbItemsAdded] select (_amount > 0);
			_config = format ["configFile >> ""%1"" >> ""%2""","%1",_item];
			_itemCfg = {
				_itemCfg = call compile format [_config,_x];
				if (isClass _itemCfg) exitWith {_itemCfg};
				configNull
			} forEach ["CfgWeapons","CfgMagazines","CfgVehicles"];
			_itemName = _itemCfg call BIS_fnc_displayName;
			_itemPicture = getText (_itemCfg >> "picture");
			_itemPrice = [TER_VASS_shopObject, _item, 1] call TER_fnc_getItemValues;
			_ind = _ctrl lnbAddRow [
				"",
				format ["%1x", abs _amount],
				_itemName,
				format ["%1$",[_itemPrice] call BIS_fnc_numberText],
				format ["%1$",[_itemPrice * abs _amount] call BIS_fnc_numberText]
			];
			_ctrl lbsettooltip [_ind * _columns, _itemName];
			_ctrl lnbSetPicture [[_ind,0],_itemPicture];
		} forEach TER_VASS_changedItems;

		_ctrlMouseBlock = _displayArsenal displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		//_ctrlMouseBlock ctrlenable true;
		//ctrlsetfocus _ctrlMouseBlock;

		//--- Money info
		_stxtMoney = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_STXTMONEY;
		_fncTparams = {
			params ["_money", "_align"];
			_tMoney = [abs _money] call BIS_fnc_numberText;
			_tRed = "#FF0000";
			_tGreen = "#00FF00";
			_tWhite = "#FFFFFF"; // respect
			_tCond = _money < 0;
			_tColor = [_tGreen, _tRed] select _tCond;
			//_tSign = ["+","-"] select _tCond;// for some fucking reason the minus sign doesnt get displayed EVERY OTHER WORKS!!!
			_tSign = "";
			if (_money == 0) then {_tColor = _tWhite; _tSign = "";};
			//if (_money > 0) then {_tSign = "+"};
			format ["<t align='%1' color='%2'>%3%4$</t>", _align, _tColor, _tSign, _tMoney]
		};
		//--- Funds
		_funds = with missionnamespace do {["getMoney",[_center]] call TER_fnc_VASShandler};
		_fundsText = [_funds, "left"] call _fncTparams;
		//--- Costs
		_cost = _displayArsenal getVariable ["shop_cost",0];
		_costText = [-_cost, "center"] call _fncTparams;
		//--- Difference
		_diff = _funds -_cost;
		_diffText = [_diff, "right"] call _fncTparams;

		_topLine = "<t align='left'>Current</t><t align='center'>Cost</t><t align='right'>Difference</t>";
		_stxtMoney ctrlSetStructuredText composeText [parsetext _topLine,lineBreak,parsetext _fundsText,parsetext _costText,parsetext _diffText];
		//--- Button buy
		_btnBuy = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_BTNBUY;
		if (_funds >= _cost) then {
			_btnBuy ctrlSetText "CONFIRM";
			_btnBuy ctrlEnable true;
		} else {
			_btnBuy ctrlSetText "Not enough money";
			_btnBuy ctrlEnable false;
		};

		_tabsChange = _grpCheckout controlsGroupCtrl IDC_RSCDISPLAYCHECKOUT_TABSCHANGE;
		ctrlsetfocus _tabsChange;
	};
	case "tabChange":{
		params ["_tabsChange","_ind"];
		_grpCheckout = ctrlParentControlsGroup _tabsChange;
		{
			_ctrl = _grpCheckout controlsGroupCtrl _x;
			if (_forEachIndex == _ind) then {
				_ctrl ctrlEnable true;
				_ctrl ctrlShow true;
			} else {
				_ctrl ctrlEnable false;
				_ctrl ctrlShow false;
			};
		} forEach [IDC_RSCDISPLAYCHECKOUT_LNBITEMSADDED, IDC_RSCDISPLAYCHECKOUT_LNBITEMSREMOVED];
	};
	case "btnBuy":{
		params ["_btnBuy"];
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_grpCheckout = ctrlParentControlsGroup _btnBuy;
		_displayArsenal = ctrlParent _grpCheckout;
		_cost = _displayArsenal getVariable "shop_cost";
		//--- Update player's money
		with missionnamespace do {["setMoney",[_center, -_cost]] call TER_fnc_VASShandler};
		//--- Update shop inventory
		_cargo = TER_VASS_shopObject getVariable ["TER_VASS_cargo",[]];
		_cargo = [0,-1] + _cargo;// if an item is not in the cargo these values will be used
		private _resetArray = [];
		{
			_x params ["_item", "_amount"];
			_findInd = _cargo findIf {_x isEqualTo _item};
			_indAmount = _findInd +2;// Amount of the item comes 2 places behind class
			if !((_cargo select _indAmount) isEqualTo true) then {// Only modify finite items (true indicates inifite ones)
				_newAmount = (_cargo select _indAmount) -_amount;
				_itemPrice = [TER_VASS_shopObject, _item, 1] call TER_fnc_getItemValues;
				_resetArray append [_item, _itemPrice, _amount];
				if (_newAmount <= 0) then {// Delete empty items
					for "_i" from 0 to 2 do {_cargo deleteAt _findInd};
				} else {// Add/remove sold item count
					_cargo set [_indAmount, _newAmount];
				};
			};
		} forEach TER_VASS_changedItems;// Format: ["class", change]
		if (TER_VASS_shopObject getVariable ["TER_VASS_refresh",-1] > 0) then {
			// Reset inventory after certain time
			[TER_VASS_shopObject, _resetArray] spawn TER_fnc_resetTimer;
		};
		for "_i" from 0 to 1 do {_cargo deleteAt 0};//remove this script's default values
		[TER_VASS_shopObject, _cargo, 2] call TER_fnc_addShopCargo;
		TER_VASS_shopObject setVariable ["TER_VASS_cargo", _cargo, TER_VASS_shopObject getVariable ["TER_VASS_shared", true]];
		//--- Exit arsenal
		_displayArsenal closeDisplay 1;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call bis_fnc_textTiles;
		["Exit"] call BIS_fnc_arsenal;
	};
	case "btnReturn":{
		params ["_btnReturn"];
		_grpCheckout = ctrlParentControlsGroup _btnReturn;
		_displayArsenal = ctrlParent _grpCheckout;
		_ctrlMouseBlock = _displayArsenal displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlenable false;
		_grpCheckout ctrlEnable false;
		_grpCheckout ctrlSetFade 1;
		_grpCheckout ctrlCommit 0.15;
	};
};