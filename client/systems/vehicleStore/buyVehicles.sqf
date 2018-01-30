// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: buyVehicles.sqf
//	@file Author: His_Shadow, AgentRev
//	@file Created: 06/14/2013 05:13

scriptName "buyVehicles";

if (!isNil "storePurchaseHandle" && {typeName storePurchaseHandle == "SCRIPT"} && {!scriptDone storePurchaseHandle}) exitWith {hint "Please wait, your previous purchase is being processed"};

#include "dialog\vehiclestoreDefines.hpp";

storePurchaseHandle = _this spawn
{
	disableSerialization;

	private ["_switch", "_playerMoney", "_price", "_dialog", "_playerMoneyText", "_itemlist", "_itemIndex", "_itemText", "_itemData", "_colorlist", "_colorIndex", "_colorText", "_colorData", "_applyVehProperties", "_class", "_price", "_requestKey", "_vehicle"];

	//Initialize Values
	_switch = _this select 0;
	_textureDir = "client\images\vehicleTextures";
	_playerMoney = player getVariable ["cmoney", 0];

	// Grab access to the controls
	_dialog = findDisplay vehshop_DIALOG;
	_playerMoneyText = _dialog displayCtrl vehshop_money;

	_itemlist = _dialog displayCtrl vehshop_veh_list;
	_itemIndex = lbCurSel vehshop_veh_list;
	_itemText = _itemlist lbText _itemIndex;
	_itemData = _itemlist lbData _itemIndex;

	_itemData = call compile _itemData; // [name, class, price, type, variant, ...]

	_colorlist = _dialog displayCtrl vehshop_color_list;
	_colorIndex = lbCurSel vehshop_color_list;
	_colorText = _colorlist lbText _colorIndex;
	_colorData = call compile (_colorlist lbData _colorIndex);

	_showInsufficientFundsError =
	{
		_itemText = _this select 0;
		hint parseText format ["Not enough money for<br/>""%1""", _itemText];
		playSound "FD_CP_Not_Clear_F";
		_price = -1;
	};

	_showItemSpawnTimeoutError =
	{
		_itemText = _this select 0;
		hint parseText format ["<t color='#ffff00'>An unknown error occurred.</t><br/>The purchase of ""%1"" has been cancelled.", _itemText];
		playSound "FD_CP_Not_Clear_F";
		_price = -1;
	};

	_showItemSpawnedOutsideMessage =
	{
		_itemText = _this select 0;
		hint format ["""%1"" has been spawned outside, in front of the store.", _itemText];
		playSound "FD_Finish_F";
	};
	
	_checkLastPurchase =
	{
		_canPurchase = true;
		if (!isNil "vehicleStore_lastPurchaseTime") then
		{
			_timeLeft = (["A3W_vehiclePurchaseCooldown", 60] call getPublicVar) - (diag_tickTime - vehicleStore_lastPurchaseTime);
			if (_timeLeft > 0) then
			{
				_canPurchase = false;
			};
		};
		_canPurchase
	};
		
	_checkLastRemotePurchase =
	{
		_canRemotePurchase = true;
		if (!isNil "vehicleStore_lastRemotePurchaseTime") then
		{
			_timeLeft = (["A3W_vehicleRemotePurchaseCooldown", 60] call getPublicVar) - (diag_tickTime - vehicleStore_lastRemotePurchaseTime);
			if (_timeLeft > 0) then
			{
				_canRemotePurchase = false;
			};
		};
		_canRemotePurchase
	};

	_applyVehProperties =
	{
		private ["_vehicle", "_colorText", "_playerItems", "_playerAssignedItems", "_uavTerminal", "_allUAV"];
		_vehicle = _this select 0;
		_colorText = _this select 1;
		_colorData = _this select 2;
		_texArray  = [];

		if (count _colorData > 0) then
		{
			[_vehicle, _colorData] call applyVehicleTexture;
		};
		
		// If UAV or UGV, fill vehicle with UAV AI, give UAV terminal to our player, and connect it to the vehicle
		if (round getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "isUav") > 0) then
		{
			vehicleStore_lastRemotePurchaseTime = diag_tickTime;
			
			switch (playerSide) do
			{
				case BLUFOR: { _uavTerminal = "B_UavTerminal" };
				case OPFOR:	 { _uavTerminal = "O_UavTerminal" };
				default	     { _uavTerminal = "I_UavTerminal" };
			};

			if !(_uavTerminal in assignedItems player) then
			{
				{ player unassignItem _x } forEach ["ItemGPS", "B_UavTerminal", "O_UavTerminal", "I_UavTerminal"]; // Unassign any GPS slot item

				if (_uavTerminal in items player) then
				{
					player assignItem _uavTerminal;
				}
				else
				{
					player linkItem _uavTerminal;
				};
			};

			_vehicle spawn
			{
				params ["_uav"];
				private "_crewActive";
				_time = time;

				waitUntil {time - _time > 30 || {_crewActive = alive _uav && !(crew _uav isEqualTo []); _crewActive}};

				if (_crewActive) then
				{
					player connectTerminalToUav _uav;
				};
			};
		};
		_vehicle
	};

	
	if (_itemData isEqualType []) then
	{
		_class = _itemData param [1];
		_price = _itemData param [2];

		// Ensure the player has enough money
		if (_price > _playerMoney) exitWith
		{
			[_itemText] call _showInsufficientFundsError;
		};
		
		///////////////////////////////////////////////////////////////////////////////////////////
		_purchaseAllowed = true; // set the default to true
		_isRemote = false; // set the default to false
		if (round getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") > 0) then // check if is UAV/UGV/REMOTE vehicle BEFORE vehicle creation!
		{
			_purchaseAllowed = call _checkLastRemotePurchase; // returns true or false
			_isRemote = true;
		}
		else
		{
			_purchaseAllowed = call _checkLastPurchase; // returns true or false
			_isRemote = false;
		};
		if (_purchaseAllowed) then
		{
			_requestKey = call A3W_fnc_generateKey;
			_itemData call requestStoreObject;
			_vehicle = objectFromNetId (missionNamespace getVariable _requestKey);
			if (!isNil "_vehicle" && {!isNull _vehicle}) then
			{
				[_vehicle, _colorText, if (!isNil "_colorData") then { _colorData } else { "" }] call _applyVehProperties;
			};
		}
		else
		{
			if (_isRemote) then
			{
				_timeLeft = (["A3W_vehicleRemotePurchaseCooldown", 60] call getPublicVar) - (diag_tickTime - vehicleStore_lastRemotePurchaseTime);
				hint format ["You need to wait %1s before buying another remote vehicle", ceil _timeLeft];
				playSound "FD_CP_Not_Clear_F";
				_price = -1;
			}
			else
			{
				_timeLeft = (["A3W_vehiclePurchaseCooldown", 60] call getPublicVar) - (diag_tickTime - vehicleStore_lastPurchaseTime);
				hint format ["You need to wait %1s before buying another vehicle", ceil _timeLeft];
				playSound "FD_CP_Not_Clear_F";
				_price = -1;
			};
		};
		///////////////////////////////////////////////////////////////////////////////////////////	
	};
	if (!isNil "_price" && {_price > -1}) then
	{
		_playerMoney = player getVariable ["cmoney", 0];

		// Re-check for money after purchase
		if (_price > _playerMoney) then
		{
			if (!isNil "_requestKey" && {!isNil _requestKey}) then
			{
				deleteVehicle objectFromNetId (missionNamespace getVariable _requestKey);
			};

			[_itemText] call _showInsufficientFundsError;
		}
		else
		{
			vehicleStore_lastPurchaseTime = diag_tickTime;

			player setVariable ["cmoney", _playerMoney - _price, true];
			_playerMoneyText ctrlSetText format ["Cash: $%1", [player getVariable ["cmoney", 0]] call fn_numbersText];

			if (["A3W_playerSaving"] call isConfigOn) then
			{
				[] spawn fn_savePlayerData;
			};
		};
	};

	if (!isNil "_requestKey" && {!isNil _requestKey}) then
	{
		missionNamespace setVariable [_requestKey, nil];
	};

	sleep 0.5; // double-click protection
};

if (typeName storePurchaseHandle == "SCRIPT") then
{
	private "_storePurchaseHandle";
	_storePurchaseHandle = storePurchaseHandle;
	waitUntil {scriptDone _storePurchaseHandle};
};

storePurchaseHandle = nil;
