#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

#define DEFAULT_MATERIAL "\a3\data_f\default.rvmat"
#define DEFAULT_TEXTURE "#(rgb,8,8,3)color(0,0,0,0)"
#define FADE_DELAY	0.15

disableserialization;

private _fullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal", false]; // INCLUDE IDENTITY
private _broadcastUpdates = isMultiplayer && _fullVersion;
private _mode = param [0, "Open", [displaynull, ""]];
private _confirmAction = param [2, false];
_this = param [1, []];

private _fnc_getFaceConfig =
{
	private _faces = missionnamespace getvariable ["BIS_fnc_arsenal_faces", [[],[]]];
	private _faceIndex = _faces select 0 findIf { _this == _x };
	if (_faceIndex > -1) exitWith { _faces select 1 select _faceIndex };
	configNull
};

private _fnc_setUnitInsignia =
{
	params ["_unit", "_insignia", ["_global", false]];

	private _index = getArray (configFile >> "CfgVehicles" >> getText (configFile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections") findIf { _x == "insignia" };
	private _materialArray = [_index, getText (configfile >> "CfgUnitInsignia" >> _insignia >> "material") call {[_this, DEFAULT_MATERIAL] select (_this isEqualTo "")}];
	private _textureArray = [_index, getText (configfile >> "CfgUnitInsignia" >> _insignia >> "texture") call {[_this, DEFAULT_TEXTURE] select (_this isEqualTo "")}];

	_unit setVariable ["BIS_fnc_setUnitInsignia_class", [_insignia, nil] select (_insignia isEqualTo ""), true];

	if (_global) exitWith
	{
		_unit setObjectMaterialGlobal _materialArray;
		_unit setObjectTextureGlobal _textureArray;
	};

	_unit setObjectMaterial _materialArray;
	_unit setObjectTexture _textureArray;
};

private _fnc_getUnitInsignia  = { _this getVariable ["BIS_fnc_setUnitInsignia_class", ""] };

#define IDCS_LEFT\
	IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,\
	IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,\
	IDC_RSCDISPLAYARSENAL_TAB_VEST,\
	IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,\
	IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,\
	IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,\
	IDC_RSCDISPLAYARSENAL_TAB_NVGS,\
	IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,\
	IDC_RSCDISPLAYARSENAL_TAB_MAP,\
	IDC_RSCDISPLAYARSENAL_TAB_GPS,\
	IDC_RSCDISPLAYARSENAL_TAB_RADIO,\
	IDC_RSCDISPLAYARSENAL_TAB_COMPASS,\
	IDC_RSCDISPLAYARSENAL_TAB_WATCH,\
	IDC_RSCDISPLAYARSENAL_TAB_FACE,\
	IDC_RSCDISPLAYARSENAL_TAB_VOICE,\
	IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA

#define IDCS_RIGHT\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC\

#define IDCS	[IDCS_LEFT,IDCS_RIGHT]

#define INITTYPES\
		private _types = [];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,["Uniform"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_VEST,["Vest"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,["Backpack"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,["Headgear"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,["Glasses"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_NVGS,["NVGoggles"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,["Binocular","LaserDesignator"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","SubmachineGun"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,["Launcher","MissileLauncher","RocketLauncher"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,["Handgun"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_MAP,["Map"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_GPS,["GPS","UAVTerminal"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_RADIO,["Radio"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_COMPASS,["Compass"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_WATCH,["Watch"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_FACE,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_VOICE,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,[/*"Grenade","SmokeShell"*/]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,[/*"Mine","MineBounding","MineDirectional"*/]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC,["FirstAidKit","Medikit","MineDetector","Toolkit"]];

#define GETVIRTUALCARGO\
	private _virtualItemCargo =\
		(missionnamespace call bis_fnc_getVirtualItemCargo) +\
		(_cargo call bis_fnc_getVirtualItemCargo) +\
		items _center +\
		assigneditems _center +\
		primaryweaponitems _center +\
		secondaryweaponitems _center +\
		handgunitems _center +\
		[uniform _center,vest _center,headgear _center,goggles _center];\
	private _virtualWeaponCargo = [];\
	{\
		_weapon = _x call bis_fnc_baseWeapon;\
		_virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];\
		{\
			private ["_item"];\
			_item = gettext (_x >> "item");\
			if !(_item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_item];};\
		} foreach ((configfile >> "cfgweapons" >> _x >> "linkeditems") call bis_fnc_returnchildren);\
	} foreach ((missionnamespace call bis_fnc_getVirtualWeaponCargo) + (_cargo call bis_fnc_getVirtualWeaponCargo) + weapons _center + [binocular _center]);\
	private _virtualMagazineCargo = (missionnamespace call bis_fnc_getVirtualMagazineCargo) + (_cargo call bis_fnc_getVirtualMagazineCargo) + magazines _center;\
	private _virtualBackpackCargo = (missionnamespace call bis_fnc_getVirtualBackpackCargo) + (_cargo call bis_fnc_getVirtualBackpackCargo) + [backpack _center];

#define STATS_WEAPONS\
	["reloadtime","dispersion","maxzeroing","hit","mass","initSpeed"],\
	[true,true,false,true,false,false]

#define STATS_EQUIPMENT\
	["passthrough","armor","maximumLoad","mass"],\
	[false,false,false,false]

#define ADDBINOCULARSMAG\
	_magazines = getarray (configfile >> "cfgweapons" >> _item >> "magazines");\
	if (count _magazines > 0) then {_center addmagazine (_magazines select 0);};

#define CONDITION(ITEMLIST)	(_fullVersion || {"%ALL" in ITEMLIST} || { ITEMLIST findIf {_item == _x} > -1 })
#define ERROR if !(_item in _disabledItems) then {_disabledItems set [count _disabledItems,_item];};

//--- Function to get item DLC. Don't use item itself, but the first addon in which it's defined. SOme items are re-defined in mods.
//#define GETDLC	{configsourcemod _this}
#define GETDLC\
	{\
		private _dlc = "";\
		private _addons = configsourceaddonlist _this;\
		if (count _addons > 0) then {\
			private _mods = configsourcemodlist (configfile >> "CfgPatches" >> _addons select 0);\
			if (count _mods > 0) then {\
				_dlc = _mods select 0;\
			};\
		};\
		_dlc\
	}


#define ADDMODICON\
	{\
		private _dlcName = _this call GETDLC;\
		if (_dlcName != "") then {\
			_ctrlList lbsetpictureright [_lbAdd,(modParams [_dlcName,["logo"]]) param [0,""]];\
		};\
	};

//--- Defautl mod list for sorting
#define MODLIST ["","curator","kart","heli","mark","expansion","expansionpremium"]

#define CAM_DIS_MAX	7

//--- 7erra defines
#include "..\gui\scripts\idcs.inc"
#define SELF TER_fnc_shop
#define STRSELF #SELF
#define MONEYGREEN [0.13,0.42,0.16,1]
#define INF "∞"
#define COL_PIC 0
#define COL_NAME 1
#define COL_COUNT 2
#define COL_PRICE 3
#define COL_STARTCOUNT 4

#define COL_DATA_CLASS 0
#define COL_DATA_COUNT 0
#define COL_DATA_STARTCOUNT 1

_fncCurAdd = {
	params ["_item"];
	private _addCur = [TER_VASS_changedItems, tolower _item] call BIS_fnc_findInPairs;
	_addCur = if (_addCur == -1) then {0} else {TER_VASS_changedItems#_addCur#1};
	_addCur
};
//DEBUG
//#define TER_fnc_getItemValues (compile preprocessFileLineNumbers "addons\VASS\fnc\fn_getItemValues.sqf")


switch _mode do {
	case "preInit":{
		//--- Init the system
		//--- Make all functions available in uiNamespace
		{
			_fnc = format ["TER_fnc_%1", configName _x];
			_file = format["addons\VASS\fnc\fn_%1.sqf", configName _x];
			uiNamespace setVariable [_fnc, compile preprocessFileLineNumbers _file];
		} forEach ("true" configClasses (missionConfigFile >> "CfgFunctions" >> "TER" >> "VASS"));
		["Preload"] call BIS_fnc_arsenal;
		[ missionNamespace, "arsenalOpened", {
			["arsenalOpened",_this] call SELF;
		}] call BIS_fnc_addScriptedEventHandler;
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "arsenalOpened":{
		if (isNil "TER_VASS_shopObject") exitWith {};
		_display = _this select 0;
		uiNamespace setVariable ["TER_VASS_changedItems",[]];
		//--- Arsenal was opened
		_display setVariable ["shop_loadoutStart",getUnitLoadout _center];
		_display setVariable ["shop_cost",0];
		_display displayAddEventHandler ["unLoad",{
			with uiNamespace do {["shopUnLoad",_this] call SELF};
		}];
		//--- Handle display
		_display displaySetEventHandler ["keydown",format ["with (uinamespace) do {['KeyDown',_this] call %1;};", STRSELF]];
		{
			_btnDisable = _display displayCtrl _x;
			_btnDisable ctrlEnable false;
			_btnDisable ctrlShow false;
			_btnDisable ctrlSetFade 1;
			_btnDisable ctrlCommit 0;
		} forEach [IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE, IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD, IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT, IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT, IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM];
		//--- New "BUY" button
		_ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		_ctrlButtonInterface ctrlSetTooltip "Check purchases and leave shop";
		_ctrlButtonInterface ctrlSetEventHandler ["buttonclick",format ["with uinamespace do {['buttonBuy',[ctrlparent (_this select 0),'init']] call %1;};",STRSELF]];
		["costChange",[_display,[""]]] call SELF;
		_ctrlButtonInterface ctrlAddEventHandler ["MouseEnter",{
			with uiNamespace do {["buyMouse",[_this#0, +1]] call SELF};
		}];
		_ctrlButtonInterface ctrlAddEventHandler ["MouseExit",{
			with uiNamespace do {["buyMouse",[_this#0, -1]] call SELF};
		}];
		_wBtn =  6 * ((safezoneW - 1 * (((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * (((safezoneW / safezoneH) min 1.2) / 40);
		_ctrlButtonInterface ctrlSetPositionW _wBtn;
		_ctrlButtonInterface ctrlCommit 0;
		//--- New checkout controlsgroup
		_ctrlCheckout = _display ctrlCreate ["TER_VASS_RscCheckout", IDC_RSCDISPLAYCHECKOUT_CHECKOUT];
		_ctrlCheckout ctrlEnable false;
		/*
		//--- Credit button
		_ctrlCredit = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlCredit ctrlSetStructuredText parseText "<t align='right'>VASS</t>";
		_ctrlCredit ctrlEnable true;
		_ctrlCredit ctrlRemoveAllEventHandlers "buttonclick";
		*/

		//--- Control EHs
		_ctrlArrowLeft = _display displayctrl IDC_RSCDISPLAYARSENAL_ARROWLEFT;
		_ctrlArrowLeft ctrlSetEventHandler ["buttonclick","with uinamespace do {['buttonCargo',[ctrlparent (_this select 0),-1]] call TER_fnc_shop;};"];

		_ctrlArrowRight = _display displayctrl IDC_RSCDISPLAYARSENAL_ARROWRIGHT;
		_ctrlArrowRight ctrlSetEventHandler ["buttonclick","with uinamespace do {['buttonCargo',[ctrlparent (_this select 0),+1]] call TER_fnc_shop;};"];

		_sortValues = uinamespace getvariable ["ter_fnc_shop_sort",[]];
		{
			_idc = _x;
			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_mode = if (_idc in [IDCS_LEFT]) then {"TabSelectLeft"} else {"TabSelectRight"};
			{
				_x ctrlSetEventHandler ["buttonclick",format ["with uinamespace do {['%2',[ctrlparent (_this select 0),%1]] call %3;};",_idc,_mode,STRSELF]];
			} foreach [_ctrlIcon,_ctrlTab];

			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
			_ctrlList ctrlSetEventHandler ["lbselchanged",format ["with uinamespace do {['SelectItem',[ctrlparent (_this select 0),(_this select 0),%1]] call %2;};",_idc,STRSELF]];

			//--- Add prices to the listboxes
			if (ctrltype _ctrlList == 102) then {
				// LNB
				_newColumn = _ctrlList lnbAddColumn 0.7;
				_newnewColumn = _ctrlList lnbAddColumn -1;
				_ctrlList lnbSetColumnsPos [0.07, 0.15, 0.6, 0.71];
				for "_row" from 0 to (lnbSize _ctrlList select 0) do {
					_item = _ctrlList lnbData [_row,0];
					_itemValues = [TER_VASS_shopObject, _item] call TER_fnc_getItemValues;
					_itemValues params ["", "_itemCost","_itemAmount"];
					_symbol = [str _itemAmount, INF] select (_itemAmount isEqualTo true);/*
					_startAmount = {_x == _ctrlList lnbData [_row, COL_NAME]} count (switch true do {
						case ctrlEnabled (_display displayCtrl IDC_RSCDISPLAYARSENAL_TAB_UNIFORM): {uniformItems player};
						case ctrlEnabled (_display displayCtrl IDC_RSCDISPLAYARSENAL_TAB_UNIFORM): {vestItems player};
						case ctrlEnabled (_display displayCtrl IDC_RSCDISPLAYARSENAL_TAB_UNIFORM): {backpackitems player};
						default {[]};
					});
					_ctrlList lnbSetValue [[_row, COL_COUNT], 0];
					_ctrlList lnbSetValue [[_row, COL_STARTCOUNT], _startAmount];*/
					//_ctrlList lnbSetText [[_row, COL_COUNT], format ["%1/%2", _startAmount, _startAmount + _itemMax]];
					_ctrlList lnbSetText [[_row, _newColumn], format ["%1$", [_itemCost] call BIS_fnc_numberText]];
					_ctrlList lnbSetColor [[_row,_newColumn], MONEYGREEN];
				};
			} else {
				// LB
				for "_row" from 0 to (lbSize _ctrlList) do {
					if (_ctrlList lbPictureRight _row == "") then {
						_ctrlList lbSetPictureRight [_row,"\a3\ui_f\data\igui\cfg\targeting\empty_ca.paa"];
					};
					_item = _ctrlList lbData _row;
					if (_item != "") then {
						_itemValues = [TER_VASS_shopObject, _item] call TER_fnc_getItemValues;
						_itemValues params ["", "_itemCost","_itemAmount"];
						_curText = _ctrlList lbText _row;
						_text = [format ["%2", _itemAmount, _curText], _curText] select (_itemAmount isEqualTo true);// TODO: Find way to display item amount
						_ctrlList lbSettext [_row, _text];
						_ctrlList lbSetTextRight [_row,format ["%1$", [_itemCost] call BIS_fnc_numberText]];
						_ctrlList lbSetColorRight [_row, MONEYGREEN];
						_ctrlList lbsetvalue [_row, _itemCost];
					} else {
						_ctrlList lbsetvalue [_row, -1e+6];
					};
				};
			};

			//--- Sort EH
			_sort = _sortValues param [_idc,0];
			_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _idc);
			_ctrlSort ctrlSetEventHandler ["lbselchanged",format ["with uinamespace do {['lbSort',[_this,%1]] call %2;};",_idc, STRSELF]];
			lbClear _ctrlSort;
			{_ctrlSort lbAdd _x} forEach ["Name", "$ -> $$$", "$$$ -> $"];
			_ctrlSort lbsetcursel _sort;
			_sortValues set [_idc,_sort];

		} foreach IDCS;
		uinamespace setvariable ["ter_fnc_shop_sort",_sortValues];

	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "shopUnLoad":{
		params ["_display","_exitCode"];
		{_x setVariable ["TER_VASS_shopObject",nil]} forEach [missionnamespace, uiNamespace];
		TER_VASS_changedItems = nil;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		if (_exitCode != 1) then {
			_center setUnitLoadout (_display getVariable "shop_loadoutStart");
		};
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonCargo": {
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_display = _this select 0;
		_add = _this select 1;

		_selected = -1;
		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			if (ctrlenabled _ctrlList) exitwith {_selected = _x;};
		} foreach [IDCS_LEFT];

		_ctrlList = ctrlnull;
		_lbcursel = -1;
		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			if (ctrlenabled _ctrlList) exitwith {_lbcursel = lbcursel _ctrlList;};
		} foreach [IDCS_RIGHT];
		_item = _ctrlList lnbdata [_lbcursel,0];
		if !(tolower _item in (TER_VASS_shopObject getVariable ["TER_VASS_cargo",[]])) exitWith {
			playSound "addItemFailed";
			["showMessage", [_display, "The shop does not have this item."]] call bis_fnc_arsenal;
		};
		_load = 0;
		_items = [uniformItems _center, vestItems _center, backpackitems _center] select (_selected - IDC_RSCDISPLAYARSENAL_TAB_UNIFORM);
		_mpCost = 0;//m
		_value = {_x == _item} count _items;
		_lnbData = _display displayCtrl IDC_RSCDISPLAYARSENAL_DATA;
		_addCur = [_item] call _fncCurAdd;
		_addMax = [TER_VASS_shopObject, _item, 2] call TER_fnc_getItemValues;
		_addAllowed = if (_addMax isEqualType true) then {_addMax} else {_addCur < _addMax};
		//_addAllowed = [_addCur < _addMax, true] select (_addMax isEqualTo true);

		switch _selected do {
			case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM: {
				if (_add > 0) then {
					if (_center canAddItemToUniform _item && _addAllowed) then {
						_mpCost = 1;
						_center additemtouniform _item;
					};//m
				} else {
					if (uniformItems _center findIf {tolower _x == _item} > -1) then {
						_mpCost = -1;
						_center removeItemFromUniform _item;
					};//m
				};
				_load = loaduniform _center;
				_items = uniformitems _center;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_VEST: {
				if (_add > 0) then {
					if (_center canAddItemToVest _item && _addAllowed) then {
						_mpCost = 1;
						_center additemtovest _item;
					};//m
				} else {
					if (vestitems _center findIf {tolower _x == _item} > -1) then {
						_mpCost = -1;
						_center removeItemFromVest _item;
					};//m
				};
				_load = loadvest _center;
				_items = vestitems _center;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
				if (_add > 0) then {
					if (_center canAddItemToBackpack _item && _addAllowed) then {
						_mpCost = 1;
						_center addItemToBackpack _item;
					};//m
				} else {
					if (backpackitems _center findIf {tolower _x == _item} > -1) then {
						_mpCost = -1;
						_center removeitemfrombackpack _item;
					};//m
				};
				_load = loadbackpack _center;
				_items = backpackitems _center;
			};
		};
		["costChange",[_display, [_item], _mpCost]] call SELF;//m
		_ctrlList lnbsetvalue [[_lbcursel,COL_COUNT], _addCur +_mpCost];

		_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
		_ctrlLoadCargo progresssetposition _load;

		_value = {_x == _item} count _items;
		_text = if (_addMax isEqualType true) then {str _value} else {format ["%1|%2", _value, _addMax - _addCur - _mpCost]};
		_ctrlList lnbsettext [[_lbcursel,2], _text];

		["SelectItemRight",[_display,_ctrlList,_index]] call bis_fnc_arsenal;
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabSelectLeft": {
		_display = _this select 0;
		_index = _this select 1;

		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			_ctrlList lbsetcursel -1;
			lbclear _ctrlList;
		} foreach [
			IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			//IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG
		];

		{
			_idc = _x;
			_active = _idc == _index;

			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _active;
				_ctrlList ctrlsetfade ([1,0] select _active);
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];

			_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrlTab ctrlenable !_active;

			if (_active) then {
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
				_ctrlLineTabLeft = _display displayctrl IDC_RSCDISPLAYARSENAL_LINETABLEFT;
				_ctrlLineTabLeft ctrlsetfade 0;
				_ctrlTabPos = ctrlposition _ctrlTab;
				_ctrlLineTabPosX = (_ctrlTabPos select 0) + (_ctrlTabPos select 2) - 0.01;
				_ctrlLineTabPosY = (_ctrlTabPos select 1);
				_ctrlLineTabLeft ctrlsetposition [
					safezoneX,//_ctrlLineTabPosX,
					_ctrlLineTabPosY,
					(ctrlposition _ctrlList select 0) - safezoneX,//_ctrlLineTabPosX,
					ctrlposition _ctrlTab select 3
				];
				_ctrlLineTabLeft ctrlcommit 0;
				ctrlsetfocus _ctrlList;
				['SelectItem',[_display,_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc),_idc]] call SELF;
			};

			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			//_ctrlIcon ctrlsetfade ([1,0] select _active);
			_ctrlIcon ctrlshow _active;
			_ctrlIcon ctrlenable !_active;

			_ctrlIconBackground = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICONBACKGROUND + _idc);
			_ctrlIconBackground ctrlshow _active;
		} foreach [IDCS_LEFT];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade 0;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [
			IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT
		];

		//--- Weapon attachments
		_showItems = _index in [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_HANDGUN];
		_fadeItems = [1,0] select _showItems;
		{
			_idc = _x;
			_ctrl = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrl ctrlenable _showItems;
			_ctrl ctrlsetfade _fadeItems;
			_ctrl ctrlcommit 0;//FADE_DELAY;
			{
				_ctrl = _display displayctrl (_x + _idc);
				_ctrl ctrlenable _showItems;
				_ctrl ctrlsetfade _fadeItems;
				_ctrl ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];
		} foreach [
			IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
		];
		if (_showItems) then {['TabSelectRight',[_display,IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC]] call SELF;};

		//--- Containers
		_showCargo = _index in [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,IDC_RSCDISPLAYARSENAL_TAB_VEST,IDC_RSCDISPLAYARSENAL_TAB_BACKPACK];
		_fadeCargo = [1,0] select _showCargo;
		{
			_idc = _x;
			_ctrl = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrl ctrlenable _showCargo;
			_ctrl ctrlsetfade _fadeCargo;
			_ctrl ctrlcommit 0;//FADE_DELAY;
			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _showCargo;
				_ctrlList ctrlsetfade _fadeCargo;
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED];
		} foreach [
			IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
		];
		_ctrl = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
		_ctrl ctrlsetfade _fadeCargo;
		_ctrl ctrlcommit FADE_DELAY;
		if (_showCargo) then {['TabSelectRight',[_display,IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG]] call SELF;};

		//--- Right sidebar
		_showRight = _showItems || _showCargo;
		_fadeRight = [1,0] select _showRight;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade _fadeRight;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [
			IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
			IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT
		];

		//--- Refresh weapon accessory lists
		//['SelectItem',[_display,_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _index),_index]] call bis_fnc_arsenal;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabSelectRight": {
		_display = _this select 0;
		_index = _this select 1;
		_ctrFrameRight = _display displayctrl IDC_RSCDISPLAYARSENAL_FRAMERIGHT;
		_ctrBackgroundRight = _display displayctrl IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT;
		{
			_idc = _x;
			_active = _idc == _index;

			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _active;
				_ctrlList ctrlsetfade ([1,0] select _active);
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];

			_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrlTab ctrlenable (!_active && ctrlfade _ctrlTab == 0);

			if (_active) then {
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
				_ctrlLineTabRight = _display displayctrl IDC_RSCDISPLAYARSENAL_LINETABRIGHT;
				_ctrlLineTabRight ctrlsetfade 0;
				_ctrlTabPos = ctrlposition _ctrlTab;
				_ctrlLineTabPosX = (ctrlposition _ctrlList select 0) + (ctrlposition _ctrlList select 2);
				_ctrlLineTabPosY = (_ctrlTabPos select 1);
				_ctrlLineTabRight ctrlsetposition [
					_ctrlLineTabPosX,
					_ctrlLineTabPosY,
					safezoneX + safezoneW - _ctrlLineTabPosX,//(_ctrlTabPos select 0) - _ctrlLineTabPosX + 0.01,
					ctrlposition _ctrlTab select 3
				];
				_ctrlLineTabRight ctrlcommit 0;
				ctrlsetfocus _ctrlList;

				_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
				_ctrlListPos = ctrlposition _ctrlList;
				_ctrlListPos set [3,(_ctrlListPos select 3) + (ctrlposition _ctrlLoadCargo select 3)];
				{
					_x ctrlsetposition _ctrlListPos;
					_x ctrlcommit 0;
				} foreach [_ctrFrameRight,_ctrBackgroundRight];

				if (
					_idc in [
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
					]
				) then {
					//--- Update counts for all items in the list
					_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
					_selected = IDC_RSCDISPLAYARSENAL_TAB_UNIFORM;
					_itemsCurrent = switch true do {
						case (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_UNIFORM))): {
							uniformitems _center
						};
						case (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_VEST))): {
							_selected = IDC_RSCDISPLAYARSENAL_TAB_VEST;
							vestitems _center
						};
						case (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_BACKPACK))): {
							_selected = IDC_RSCDISPLAYARSENAL_TAB_BACKPACK;
							backpackitems _center
						};
						default {[]};
					};
					for "_l" from 0 to (lbsize _ctrlList - 1) do {
						_class = _ctrlList lnbdata [_l,0];
						_itemMax = [TER_VASS_shopObject, _class, 2] call TER_fnc_getItemValues;

						_value =  {_x == _class} count _itemsCurrent;
						_addCur = [_class] call _fncCurAdd;
						_text = if (_itemMax isEqualType true) then {str _value} else {format ["%1|%2", _value, _itemMax - _addCur]};
						_ctrlList lnbsettext [[_l, COL_COUNT], _text];
						//str ()];
					};
					["SelectItemRight",[_display,_ctrlList,_index]] call bis_fnc_arsenal;
				};
			};

			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			//_ctrlIcon ctrlenable false;
			_ctrlIcon ctrlshow _active;
			_ctrlIcon ctrlenable (!_active && ctrlfade _ctrlTab == 0);

			_ctrlIconBackground = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICONBACKGROUND + _idc);
			_ctrlIconBackground ctrlshow _active;
		} foreach [IDCS_RIGHT];
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "SelectItem": {
		private ["_ctrlList","_index","_cursel"];
		_display = _this select 0;
		_ctrlList = _this select 1;
		_index = _this select 2;
		_cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};
		_item = if (ctrltype _ctrlList == 102) then {_ctrlList lnbdata [_cursel,0]} else {_ctrlList lbdata _cursel};
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center",player];

		_ctrlListPrimaryWeapon = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON);
		_ctrlListSecondaryWeapon = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON);
		_ctrlListHandgun = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_HANDGUN);

		private _addedItems = [];
		private _removedItems = [];

		_loadout = getUnitLoadout _center;
		switch _index do
		{
			case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM:
			{
				_removedItems pushBack uniform _center;
				if (_item == "") then {
					_removedItems append uniformItems _center;//m
					removeuniform _center;
				} else {
					_items = uniformitems _center;//m
					_removedItems append _items;
					_center forceadduniform _item;
					_addedItems = [_item];
					while {count uniformitems _center > 0} do {_center removeitemfromuniform (uniformitems _center select 0);}; //--- Remove default config contents
					{
						if (_center canAddItemToUniform _x) then {
							_center additemtouniform _x;
							_removedItems deleteAt (_removedItems find _x)};
					} foreach _items;
				};

				//--- Refresh insignia (gets removed when uniform changes)
				//["SelectItem",[_display, _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA),IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA]] spawn bis_fnc_arsenal;
				[_center, _center call _fnc_getUnitInsignia, false] call _fnc_setUnitInsignia;

			};
			case IDC_RSCDISPLAYARSENAL_TAB_VEST:
			{
				_removedItems pushBack vest _center;
				if (_item == "") then {
					_removedItems append vestItems _center;//m
					removevest _center;
				} else {
					_items = vestitems _center;
					_removedItems append _items;
					_center addvest _item;
					_addedItems = [_item];
					while {count vestitems _center > 0} do {_center removeitemfromvest (vestitems _center select 0);}; //--- Remove default config contents
					{
						if (_center canAddItemToVest _x) then {
							_center addItemToVest _x;
							_removedItems deleteAt (_removedItems find _x)};
					} foreach _items;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
				_items = backpackitems _center;
				_removedItems pushBack backpack _center;
				_removedItems append _items;
				removebackpack _center;
				if !(_item == "") then {
					_center addbackpack _item;
					_addedItems = [_item];
					while {count backpackitems _center > 0} do {_center removeitemfrombackpack (backpackitems _center select 0);}; //--- Remove default config contents
					{
						if (_center canAddItemToBackpack _x) then {
							_center addItemToBackpack _x;
							_removedItems deleteAt (_removedItems find _x)};
					} foreach _items;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR: {
				_removedItems = [headgear _center];
				if (_item == "") then {
					removeheadgear _center;
				} else {
					_center addheadgear _item;
					_addedItems = [_item];
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES: {
				_removedItems = [goggles _center];
				if (_item == "") then {
					removegoggles _center;
				} else {
					_center addgoggles _item;
					_addedItems = [_item];
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_NVGS:{
				if (_item == "") then {
					_weapons = [];
					for "_l" from 0 to (lbsize _ctrlList) do {_weapons set [count _weapons,tolower (_ctrlList lbdata _l)];};
					{
						if (tolower _x in _weapons) then {_center removeweapon _x; _removedItems pushBack _x};
					} foreach (assigneditems _center);
				} else {
					_removedItems pushBack hmd _center;
					_center addweapon _item;
					_addedItems pushBack _item;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS: {
				if (_item == "") then {
					_weapons = [];
					for "_l" from 0 to (lbsize _ctrlList) do {_weapons set [count _weapons,tolower (_ctrlList lbdata _l)];};
					{
						if (tolower _x in _weapons) then {_center removeweapon _x; _removedItems pushBack _x};
					} foreach (assigneditems _center);
				} else {
					_removedItems pushBack binocular _center;
					_center addweapon _item;
					_addedItems pushBack _item;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON: {
				_isDifferentWeapon = (primaryweapon _center call bis_fnc_baseWeapon) != _item;
				if (_isDifferentWeapon) then {
					_removedItems pushBack primaryWeapon _center;
					_removedItems append (primaryweaponitems _center -[""]);
					_loadedMags = [_loadout#0 param [4,[]], _loadout#0 param [5,[]]];
					_loadedMags = _loadedMags select {_x param [1,0] > 0};
					if ({count _x > 0} count _loadedMags > 0) then {
						{
							_x params ["_class", "_count"];
							if (_center canAdd _class) then {
								_center addMagazine [_class, _count];
							} else {
								_removedItems pushBack _class;
							};
						} forEach _loadedMags;
					};
					//{_center removemagazines _x} foreach getarray (configfile >> "cfgweapons" >> primaryweapon _center >> "magazines");
					if (_item == "") then {
						_center removeweapon primaryweapon _center;
					} else {
						_compatibleItems = _item call bis_fnc_compatibleItems;
						_weaponAccessories = primaryweaponitems _center - [""];
						[_center,_item,0] call bis_fnc_addweapon;
						_addedItems pushBack _item;
						{
							_acc = _x;
							if ({_x == _acc} count _compatibleItems > 0) then {
								_center addprimaryweaponitem _acc;
								_removedItems deleteAt (_removedItems find _acc);
							};
						} foreach _weaponAccessories;
					};
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON: {
				_isDifferentWeapon = (secondaryweapon _center call bis_fnc_baseWeapon) != _item;
				if (_isDifferentWeapon) then {
					_removedItems pushBack secondaryweapon _center;
					_removedItems append (secondaryWeaponItems _center -[""]);
					_loadedMags = [_loadout#1 param [4,[]], _loadout#1 param [5,[]]];
					_loadedMags = _loadedMags select {_x param [1,0] > 0};
					if ({count _x > 0} count _loadedMags > 0) then {
						{
							_x params ["_class", "_count"];
							if (_center canAdd _class) then {
								_center addMagazine [_x, _count];
							} else {
								_removedItems pushBack _class;
							};
						} forEach _loadedMags;
					};
					//{_center removemagazines _x} foreach getarray (configfile >> "cfgweapons" >> secondaryweapon _center >> "magazines");
					if (_item == "") then {
						_center removeweapon secondaryweapon _center;
					} else {
						_compatibleItems = _item call bis_fnc_compatibleItems;
						_weaponAccessories = secondaryWeaponItems _center - [""];
						[_center,_item,0] call bis_fnc_addweapon;
						_addedItems pushBack _item;
						{
							_acc = _x;
							if ({_x == _acc} count _compatibleItems > 0) then {
								_center addSecondaryWeaponItem _acc;
								_removedItems deleteAt (_removedItems find _acc);
							};
						} foreach _weaponAccessories;
					};
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN: {
				_isDifferentWeapon = (handgunweapon _center call bis_fnc_baseWeapon) != _item;
				if (_isDifferentWeapon) then {
					_loadedMags = [_loadout#2 param [4,[]], _loadout#2 param [5,[]]];
					_loadedMags = _loadedMags select {_x param [1,0] > 0};
					if ({count _x > 0} count _loadedMags > 0) then {
						{
							_x params ["_class", "_count"];
							if (_center canAdd _class) then {
								_center addMagazine [_x, _count];
							} else {
								_removedItems pushBack _class;
							};
						} forEach _loadedMags;
					};
					//{_center removemagazines _x} foreach getarray (configfile >> "cfgweapons" >> handgunweapon _center >> "magazines");
					if (_item == "") then {
						_removedItems pushBack handgunweapon _center;
						_removedItems append handgunItems _center;
						_center removeweapon handgunweapon _center;
					} else {
						_compatibleItems = _item call bis_fnc_compatibleItems;
						_weaponAccessories = handgunItems _center - [""];
						_removedItems append _weaponAccessories;
						[_center,_item,0] call bis_fnc_addweapon;
						_addedItems pushBack _item;
						{
							_acc = _x;
							if ({_x == _acc} count _compatibleItems > 0) then {
								_center addHandgunItem _acc;
								_removedItems deleteAt (_removedItems find _acc);
							};
						} foreach _weaponAccessories;
					};
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_MAP;
			case IDC_RSCDISPLAYARSENAL_TAB_GPS;
			case IDC_RSCDISPLAYARSENAL_TAB_RADIO;
			case IDC_RSCDISPLAYARSENAL_TAB_COMPASS;
			case IDC_RSCDISPLAYARSENAL_TAB_WATCH: {
				if (_item == "") then {
					_items = [];
					for "_l" from 0 to (lbsize _ctrlList) do {_items set [count _items,tolower (_ctrlList lbdata _l)];};
					{
						if (tolower _x in _items) then {_center unassignitem _x; _center removeitem _x; _removedItems pushBack _x;};
					} foreach (assigneditems _center);
				} else {
					if (!(tolower _item in (assigneditems _center apply {toLower _x}))) then {
						_removedItems = assigneditems _center;
						_center linkitem _item;
						_removedItems = _removedItems -assigneditems _center;
						_removedItems deleteAt (_removedItems find _item);
						_addedItems pushBack _item;
					};
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_FACE:
			{
				if !(_item isEqualTo "") then { _center setFace _item };
			};
			case IDC_RSCDISPLAYARSENAL_TAB_VOICE:
			{
				if !(_item isEqualTo "") then { _center setSpeaker _item };
				if (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_VOICE))) then {
					if !(isnil "BIS_fnc_arsenal_voicePreview") then {terminate BIS_fnc_arsenal_voicePreview;};
					BIS_fnc_arsenal_voicePreview = [] spawn {
						scriptname "BIS_fnc_arsenal_voicePreview";
						sleep 0.6;
						_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
						_center directsay "CuratorObjectPlaced";
					};
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA:
			{
				[_center, _item, false] call _fnc_setUnitInsignia;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMACC;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD: {
				_accIndex = [
					IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
					IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
					IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
					IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
				] find _index;
				switch true do {
					case (ctrlenabled _ctrlListPrimaryWeapon): {
						_removedItems pushBack ((_center weaponAccessories primaryWeapon _center) select _accIndex);
						if (_item != "") then {
							_center addprimaryweaponitem _item;
							_addedItems pushBack _item;
						} else {
							_weaponAccessories = _center weaponaccessories primaryweapon _center;
							if (count _weaponAccessories > 0) then {
								_center removeprimaryweaponitem (_weaponAccessories select _accIndex);
							};
						};
						clearRadio;
					};
					case (ctrlenabled _ctrlListSecondaryWeapon): {
						_removedItems pushBack ((_center weaponAccessories secondaryweapon _center) select _accIndex);
						if (_item != "") then {
							_center addsecondaryweaponitem _item;
							_addedItems pushBack _item;
						} else {
							_weaponAccessories = _center weaponaccessories secondaryweapon _center;
							if (count _weaponAccessories > 0) then {_center removesecondaryweaponitem (_weaponAccessories select _accIndex);};
						};
					};
					case (ctrlenabled _ctrlListHandgun): {
						_removedItems pushBack ((_center weaponAccessories handgunweapon _center) select _accIndex);
						if (_item != "") then {
							_center addhandgunitem _item;
							_addedItems pushBack _item;
						} else {
							_weaponAccessories = _center weaponaccessories handgunweapon _center;
							if (count _weaponAccessories > 0) then {_center removehandgunitem (_weaponAccessories select _accIndex);};
						};
					};
				};
			};
		};
		["costChange",[_display,_addedItems,+1]] call SELF;
		["costChange",[_display,_removedItems,-1]] call SELF;

		//--- Container Cargo
		if (
			_index in [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,IDC_RSCDISPLAYARSENAL_TAB_VEST,IDC_RSCDISPLAYARSENAL_TAB_BACKPACK]
			&&
			ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _index))
		) then {
			_cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull]);
			GETVIRTUALCARGO

			_itemsCurrent = [];
			_load = 0;
			switch _index do {
				case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM: {
					_itemsCurrent = uniformitems _center;
					_load = if (uniform _center == "") then {1} else {loaduniform _center};
				};
				case IDC_RSCDISPLAYARSENAL_TAB_VEST: {
					_itemsCurrent = vestitems _center;
					_load = if (vest _center == "") then {1} else {loadvest _center};
				};
				case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
					_itemsCurrent = backpackitems _center;
					_load = if (backpack _center == "") then {1} else {loadbackpack _center};
				};
				default {[]};
			};

			_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
			_ctrlLoadCargo progresssetposition _load;

			//--- Weapon magazines (based on current weapons)
			private ["_ctrlList"];
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG);
			_columns = count lnbGetColumnsPosition _ctrlList;
			lbclear _ctrlList;
			_magazines = [];
			{
				_cfgWeapon = configfile >> "cfgweapons" >> _x;
				{
					_cfgMuzzle = if (_x == "this") then {_cfgWeapon} else {_cfgWeapon >> _x};
					{
						private _item = _x;
						if (CONDITION(_virtualMagazineCargo)) then {
							_mag = tolower _item;
							_cfgMag = configfile >> "cfgmagazines" >> _mag;
							if (!(_mag in _magazines) && {getnumber (_cfgMag >> "scope") == 2 || getnumber (_cfgMag >> "scopeArsenal") == 2}) then {
								_magazines set [count _magazines,_mag];
								_value = {_x == _mag} count _itemsCurrent;
								_displayName = gettext (_cfgMag >> "displayName");
								([TER_VASS_shopObject, _mag] call TER_fnc_getItemValues) params ["","_itemCost","_itemMax"];
								_text = if (_itemMax isEqualType true) then {str _value} else { format ["%1|%2", _value, _itemMax - ([_mag] call _fncCurAdd)] };
								_lbAdd = _ctrlList lnbaddrow ["", _displayName, _text, format ["%1$", [_itemCost] call BIS_fnc_numberText]];
								_ctrlList lnbSetColor [[_lbAdd,3],MONEYGREEN];
								_ctrlList lnbsetdata [[_lbAdd,0],_mag];
								_ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_cfgMag >> "mass")];
								_ctrlList lnbsetpicture [[_lbAdd,0],gettext (_cfgMag >> "picture")];
								_ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",_displayName,_item]];
							};
						};
					} foreach getarray (_cfgMuzzle >> "magazines");
					// Magazine wells
					{
						// Find all entries inside magazine well
						{
							// Add all magazines from magazineWell sub class
							{
								private _item = _x;
								if (CONDITION(_virtualMagazineCargo)) then {
									_mag = tolower _item;
									_cfgMag = configfile >> "cfgmagazines" >> _mag;
									if (!(_mag in _magazines) && {getnumber (_cfgMag >> "scope") == 2 || getnumber (_cfgMag >> "scopeArsenal") == 2}) then {
										_magazines set [count _magazines,_mag];
										_value = {_x == _mag} count _itemsCurrent;
										_displayName = gettext (_cfgMag >> "displayName");
										([TER_VASS_shopObject, _mag] call TER_fnc_getItemValues) params ["","_itemCost","_itemMax"];
										_text = if (_itemMax isEqualType true) then {str _value} else { format ["%1|%2", _value, _itemMax - ([_mag] call _fncCurAdd)] };
										_lbAdd = _ctrlList lnbaddrow ["", _displayName, _text, format ["%1$", [_itemCost] call BIS_fnc_numberText]];
										_ctrlList lnbSetColor [[_lbAdd,3],MONEYGREEN];
										_ctrlList lnbsetdata [[_lbAdd,0],_mag];
										_ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_cfgMag >> "mass")];
										_ctrlList lnbsetpicture [[_lbAdd,0],gettext (_cfgMag >> "picture")];
										_ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",_displayName,_item]];
									};
								};
							}foreach (getArray _x);
						}foreach (configProperties [configFile >> "CfgMagazineWells" >> _x,"isarray _x"]);
					} foreach getarray (_cfgMuzzle >> "magazineWell");

				} foreach getarray (_cfgWeapon >> "muzzles");
			} foreach (weapons _center - ["Throw","Put"]);
			_ctrlList lbsetcursel (lbcursel _ctrlList max 0);

			//--- Update counts for all items in the list
			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				if (ctrlenabled _ctrlList) then {
					for "_l" from 0 to (lbsize _ctrlList - 1) do {
						_class = _ctrlList lnbdata [_l,0];
						([TER_VASS_shopObject, _class] call TER_fnc_getItemValues) params ["","_itemCost","_itemMax"];
						_value =  {_x == _class} count _itemsCurrent;
						_text = if (_itemMax isEqualType true) then {str _value} else { format ["%1|%2", _value, _itemMax - ([_class] call _fncCurAdd)] };
						_ctrlList lnbsettext [[_l, COL_COUNT], _text];
						//_ctrlList lnbsettext [[_l,2],str ({_x == _class} count _itemsCurrent)];
					};
					["SelectItemRight",[_display,_ctrlList,_index]] call bis_fnc_arsenal;
				};
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
			];
		};

		//--- Weapon attachments
		_modList = MODLIST;
		if (
			_index in [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_HANDGUN]
			&&
			ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _index))
		) then {
			private ["_ctrlList"];

			_cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull]);
			GETVIRTUALCARGO

			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				lbclear _ctrlList;
				_ctrlList lbsetcursel -1;
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			];

			//--- Attachments
			_compatibleItems = _item call bis_fnc_compatibleItems;
			{
				private ["_item"];
				_item = _x;
				([TER_VASS_shopObject, _item] call TER_fnc_getItemValues) params ["","_itemCost","_itemMax"];
				_itemCfg = configfile >> "cfgweapons" >> _item;
				_scope = if (isnumber (_itemCfg >> "scopeArsenal")) then {getnumber (_itemCfg >> "scopeArsenal")} else {getnumber (_itemCfg >> "scope")};
				if (_scope == 2 && CONDITION(_virtualItemCargo)) then {
					_type = _item call bis_fnc_itemType;
					_idcList = switch (_type select 1) do {
						case "AccessoryMuzzle": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE};
						case "AccessoryPointer": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMACC};
						case "AccessorySights": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC};
						case "AccessoryBipod": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD};
						default {-1};
					};
					_ctrlList = _display displayctrl _idcList;
					_lbAdd = _ctrlList lbadd gettext (_itemCfg >> "displayName");
					_ctrlList lbsetdata [_lbAdd,_item];
					_ctrlList lbsetvalue [_lbAdd, _itemCost];
					_ctrlList lbsetpicture [_lbAdd,gettext (_itemCfg >> "picture")];
					_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",gettext (_itemCfg >> "displayName"),_item]];
					_itemCfg call ADDMODICON;
					// /*MODDED
					if (_ctrlList lbPictureRight _lbAdd == "") then {
						_ctrlList lbSetPictureRight [_lbAdd,"\a3\ui_f\data\igui\cfg\targeting\empty_ca.paa"];
					};
					_ctrlList lbSetTextRight [_lbAdd,format ["%1$", [_itemCost] call BIS_fnc_numberText]];
					_ctrlList lbSetColorRight [_lbAdd, MONEYGREEN];
					// MODDED*/
				};
			} foreach _compatibleItems;

			//--- Magazines
			_weapon = switch true do {
				case (ctrlenabled _ctrlListPrimaryWeapon): {primaryweapon _center};
				case (ctrlenabled _ctrlListSecondaryWeapon): {secondaryweapon _center};
				case (ctrlenabled _ctrlListHandgun): {handgunweapon _center};
				default {""};
			};

			//--- Select current
			_weaponAccessories = _center weaponaccessories _weapon;
			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				_lbAdd = _ctrlList lbadd format ["<%1>",localize "str_empty"];
				_ctrlList lbsetvalue [_lbAdd,-1e+6];
				lbsort _ctrlList;
				for "_l" from 0 to (lbsize _ctrlList - 1) do {
					_data = _ctrlList lbdata _l;
					if (_data != "" && {{_data == _x} count _weaponAccessories > 0}) exitwith {_ctrlList lbsetcursel _l;};
				};
				if (lbcursel _ctrlList < 0) then {_ctrlList lbsetcursel 0;};

				_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _x);
				["lbSort",[[_ctrlSort,lbcursel _ctrlSort],_x]] call SELF;
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			];
		};

		//--- Calculate load
		_ctrlLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_LOAD;
		_ctrlLoad progresssetposition load _center;


		if (ctrlenabled _ctrlList) then
		{
			_itemCfg = switch _index do
			{
				case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK:	{configfile >> "cfgvehicles" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES:		{configfile >> "cfgglasses" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_FACE:		{ _item call _fnc_getFaceConfig };
				case IDC_RSCDISPLAYARSENAL_TAB_VOICE:		{configfile >> "cfgvoice" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA:	{configfile >> "cfgunitinsignia" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC:	{configfile >> "cfgmagazines" >> _item};
				default						{configfile >> "cfgweapons" >> _item};
			};

			if (BIS_fnc_arsenal_type == 0 || (BIS_fnc_arsenal_type == 1 && !is3DEN)) then
			{
				["ShowItemInfo",[_itemCfg]] call bis_fnc_arsenal;
				["ShowItemStats",[_itemCfg]] call bis_fnc_arsenal;

			};
		};
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyDown":
	{
		_display = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_return = false;
		/*
		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_inTemplate = ctrlfade _ctrlTemplate == 0;
		*/
		_inTemplate = false;
		_ctrlCheckout = _display displayCtrl IDC_RSCDISPLAYCHECKOUT_CHECKOUT;
		_inCheckout = ctrlFade _ctrlCheckout == 0;

		switch true do {
			case (_key == DIK_ESCAPE): {
				if (_inCheckout) then {
					_ctrlCheckout ctrlsetfade 1;
					_ctrlCheckout ctrlcommit FADE_DELAY;
					_ctrlCheckout ctrlenable false;

					_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
					_ctrlMouseBlock ctrlenable false;
				} else {
					if (_fullVersion) then {["buttonClose",[_display]] spawn bis_fnc_arsenal;} else {_display closedisplay 2;};
				};
				_return = true;
			};

			//--- Enter
			case (_key in [DIK_RETURN,DIK_NUMPADENTER]): {
				_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
				if (ctrlfade _ctrlTemplate == 0) then {
					if (BIS_fnc_arsenal_type == 0) then {
						["buttonTemplateOK",[_display]] spawn bis_fnc_arsenal;
					} else {
						["buttonTemplateOK",[_display]] spawn bis_fnc_garage;
					};
					_return = true;
				};
			};

			//--- Prevent opening the commanding menu
			case (_key == DIK_1);
			case (_key == DIK_2);
			case (_key == DIK_3);
			case (_key == DIK_4);
			case (_key == DIK_5);
			case (_key == DIK_1);
			case (_key == DIK_7);
			case (_key == DIK_8);
			case (_key == DIK_9);
			case (_key == DIK_0): {
				_return = true;
			};

			//--- Tab to browse tabs
			case (_key == DIK_TAB): {
				_idc = -1;
				{
					_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x);
					if !(ctrlenabled _ctrlTab) exitwith {_idc = _x;};
				} foreach [IDCS_LEFT];
				_idcCount = {!isnull (_display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x))} count [IDCS_LEFT];
				_idc = if (_ctrl) then {(_idc - 1 + _idcCount) % _idcCount} else {(_idc + 1) % _idcCount};
				if (BIS_fnc_arsenal_type == 0) then {
					["TabSelectLeft",[_display,_idc]] call SELF;
				} else {
					["TabSelectLeft",[_display,_idc]] call bis_fnc_garage;
				};
				_return = true;
			};
			/* DISABLED BY VASS
			//--- Export to script (Ctrl+C), export to config (Ctrl+Shift+C)
			case (_key == DIK_C): { if (_ctrl) then { ['buttonExport', [_display, ["init", "config"] select _shift]] call ([bis_fnc_garage, bis_fnc_arsenal] select (BIS_fnc_arsenal_type == 0)) } };

			//--- Import from script (Ctrl+V)
			case (_key == DIK_V): { if (_ctrl) then { ['buttonImport' ,[_display]] call ([bis_fnc_garage, bis_fnc_arsenal] select (BIS_fnc_arsenal_type == 0)) } };

			//--- Save (Ctrl+S)
			case (_key == DIK_S): { if (_ctrl) then { ['buttonSave', [_display]] call bis_fnc_arsenal } };

			//--- Open (Ctrl+O)
			case (_key == DIK_O): { if (_ctrl) then {['buttonLoad',[_display]] call bis_fnc_arsenal } };

			//--- Randomize (Ctrl+R)
			case (_key == DIK_R):
			{
				if (_ctrl) then {
					if (BIS_fnc_arsenal_type == 0) then {
						if (_shift) then {
							_soldiers = [];
							{
								_soldiers set [count _soldiers,configname _x];
							} foreach ("getnumber (_x >> 'scope') > 1 && gettext (_x >> 'simulation') == 'soldier'" configclasses (configfile >> "cfgvehicles"));
							[_center, selectRandom _soldiers] call bis_fnc_loadinventory;
							_center switchmove "";
							["ListSelectCurrent",[_display]] call bis_fnc_arsenal;
						} else {
							['buttonRandom',[_display]] call bis_fnc_arsenal;
						};
					} else {
						['buttonRandom',[_display]] call bis_fnc_garage;
					};
				};
			};
			*/
			//--- Toggle interface
			case (_key == DIK_BACKSPACE && !_inTemplate): {
				['buttonInterface',[_display]] call bis_fnc_arsenal;
				_return = true;
			};

			//--- Acctime
			case (_key in (actionkeys "timeInc")): {
				if (acctime == 0) then {setacctime 1;};
				_return = true;
			};
			case (_key in (actionkeys "timeDec")): {
				if (acctime != 0) then {setacctime 0;};
				_return = true;

			};

			//--- Vision mode
			case (_key in (actionkeys "nightvision") && !_inTemplate): {
				_mode = missionnamespace getvariable ["BIS_fnc_arsenal_visionMode",0];
				_mode = (_mode + 1) % 2;
				missionnamespace setvariable ["BIS_fnc_arsenal_visionMode",_mode];
				switch _mode do {
					//--- Normal
					case 0: {
						camusenvg false;
						false setCamUseTi 0;
					};
					//--- NVG
					case 1: {
						camusenvg true;
						false setCamUseTi 0;
					};
					//--- TI
					default {
						camusenvg false;
						true setCamUseTi 0;
					};
				};
				playsound ["RscDisplayCurator_visionMode",true];
				_return = true;

			};
/*
			//--- Delete template
			case (_key == DIK_DELETE): {
				_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
				if !(ctrlenabled _ctrlMouseBlock) then {
					['buttonTemplateDelete',[_display]] call bis_fnc_arsenal;
					_return = true;
				};
			};
*/
		};
		_return
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "lbSort": {
		private _input = _this select 0;
		private _idc = (_this select 1);

		private _display = ctrlparent (_input select 0);
		private _sort = _input select 1;
		private _ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
		private _cursel = lbcursel _ctrlList;
		private _selected = _ctrlList lbdata _cursel;
		switch _sort do {
			case 1: {lbSortByValue _ctrlList};
			case 2: {
				//--- First reverse and then sort the lb values
				for "_i" from 1 to (lbSize _ctrlList -1) do {
					_ctrlList lbSetValue [_i,(-1 * (_ctrlList lbValue _i))];
				};
				lbSortByValue _ctrlList;
				for "_i" from 1 to (lbSize _ctrlList -1) do {
					_ctrlList lbSetValue [_i,(-1 * (_ctrlList lbValue _i))];
				};
			};
			default {lbsort _ctrlList};
		};

		//--- Selected previously selected item (if there was one)
		if (_cursel >= 0) then {
			for '_i' from 0 to (lbsize _ctrlList - 1) do {
				if ((_ctrlList lbdata _i) == _selected) exitwith {_ctrlList lbsetcursel _i;};
			};
		};

		//--- Store sort type for persistent use
		_sortValues = uinamespace getvariable ["ter_fnc_shop_sort",[]];
		_sortValues set [_idc,_sort];
		uinamespace setvariable ["ter_fnc_shop_sort",_sortValues];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonBuy":{
		_display = _this select 0;
		_ctrlCheckout = _display displayCtrl IDC_RSCDISPLAYCHECKOUT_CHECKOUT;
		["refresh",[_ctrlCheckout]] execVM "addons\VASS\gui\scripts\RscDisplayCheckout.sqf";
	};
	case "buyMouse":{
		_ctrlButtonInterface = _this select 0;
		_display = ctrlParent _ctrlButtonInterface;
		_enter = _this#1 == 1;
		if (_enter) then {
			_ctrlButtonInterface ctrlSetText "CHECKOUT";
		} else {
			["costChange", [_display, [""]]] call SELF;
		};
	};
	///////////////////////////////////////////////////////////////////////////////////////////
	case "costChange":{
		params ["_display",["_changedItems",[]],["_mp",1]];
		if (count _changedItems == 0) exitWith {};
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_changedItems = _changedItems -[""];
		private _addCost = 0;
		if (count _changedItems != 0) then {
			_changedItems apply {_addCost = _addCost + _mp * ([TER_VASS_shopObject, _x, 1] call TER_fnc_getItemValues)};
		};
		_fncTparams = {
			// Okay story time. I was trying to figure out why the minus sign wasnt getting displayed even though every other symbol did. This was especially weird since the same code would work on another display and also worked just yesterday. I tried different approaches for nearly half an hour. End of the story: The resolution in windowed mode was so low that the "-" symbol didn't take up one single pixel in height... FML
			params ["_money", "_align"];
			_tMoney = [abs _money] call BIS_fnc_numberText;
			_tRed = "#FF0000";
			_tGreen = "#00FF00";
			_tWhite = "#FFFFFF"; // respect
			_tCond = _money < 0;
			_tColor = [_tGreen, _tRed] select _tCond;
			_tSign = ["+","-"] select _tCond;
			if (_money == 0) then {_tColor = _tWhite; _tSign = "";};
			_tReturn = format ["<t align='%1' color='%2'>%3%4$</t>", _align, _tColor, _tSign, _tMoney];
			_tReturn
		};
		//--- Funds
		_funds = with missionnamespace do {["getMoney",[_center]] call TER_fnc_VASShandler};
		_fundsText = [_funds, "left"] call _fncTparams;
		//--- Costs
		_cost = _display getVariable ["shop_cost",0];
		_cost = _cost +_addCost;
		_display setVariable ["shop_cost",_cost];
		_costText = [-_cost, "center"] call _fncTparams;
		//--- Difference
		_diff = _funds -_cost;
		_diffText = [_diff, "right"] call _fncTparams;

		_ctrlButtonInterface = _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		_ctrlButtonInterface ctrlSetStructuredText parseText ([_fundsText,_costText,_diffText] joinString "");

		//--- Keep changed item array up to date
		{
			private _item = toLower _x;
			[TER_VASS_changedItems, _item, _mp] call BIS_fnc_addToPairs;
		} forEach _changedItems;
		TER_VASS_changedItems = TER_VASS_changedItems select {_x#1 != 0};
	};
};