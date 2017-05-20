// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: optionSelect.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19

#define debugMenu_option 50003
#define adminMenu_option 50001
disableSerialization;

private ["_panelType","_displayAdmin","_displayDebug","_adminSelect","_debugSelect","_money"];
_uid = getPlayerUID player;
if (_uid call isAdmin) then
{
	_panelType = _this select 0;

	_displayAdmin = uiNamespace getVariable ["AdminMenu", displayNull];
	_displayDebug = uiNamespace getVariable ["DebugMenu", displayNull];

	switch (true) do
	{
		case (!isNull _displayAdmin): //Admin panel
		{
			_adminSelect = _displayAdmin displayCtrl adminMenu_option;

			switch (lbCurSel _adminSelect) do
			{
				case 0: //Player Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\playerMenu.sqf";
					if (!isNil "notifyAdminMenu") then { ["PlayerManagement", "Opened"] call notifyAdminMenu };
				};
				case 1: //Full Vehicle Management
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\vehicleManagement.sqf";
					if (!isNil "notifyAdminMenu") then { ["VehicleManagement", "Opened"] call notifyAdminMenu };
				};
				case 2: //Heal Self
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tools\healSelf.sqf";
				};
				case 3: // No Recoil
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\recoil.sqf";
				};
				case 4: //Toggle Vehicle Markers
				{
					execVM "client\systems\adminPanel\tools\vehicleMarkers.sqf";
				};
				case 5: //Teleport
				{
					closeDialog 0;
					["A3W_teleport", "onMapSingleClick",
					{
						vehicle player setPos _pos;
						if (!isNil "notifyAdminMenu") then { ["teleport", _pos] spawn notifyAdminMenu };
						["A3W_teleport", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
						true
					}] call BIS_fnc_addStackedEventHandler;
					hint "Click on map to teleport";
				};
				case 6: //esp map markers
				{
					execVM "client\systems\adminPanel\tools\mapEsp.sqf";
				};
				case 7: //esp
				{
					execVM "client\systems\adminPanel\tools\igEsp.sqf";
				};
				case 8: //Money
				{
					_money = 100000000;
					player setVariable ["cmoney", (player getVariable ["cmoney",0]) + _money, true];
					if (!isNil "notifyAdminMenu") then { ["money", _money] call notifyAdminMenu };
				};
				case 9: //Debug Menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadDebugMenu.sqf";
					if (!isNil "notifyAdminMenu") then { ["LoadDebugMenu", "Opened"] call notifyAdminMenu };
				};
				case 10: //Object search menu
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\loadObjectSearch.sqf";
					if (!isNil "notifyAdminMenu") then { ["ObjectSearch", "Opened"] call notifyAdminMenu };
				};
				case 11: // toggle God mode
				{
					execVM "client\systems\adminPanel\toggleGodMode.sqf";
					//Is logged from inside target script
				};
				case 12: // toggle invis mode
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\toggleInvisMode.sqf";
					//Is logged from inside target script
				};
				case 13: // toggle veh God mode
				{
					execVM "client\systems\adminPanel\tools\vehicleGod.sqf";
				};
				case 14: //matt76_rockets
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tools\matt76_rockets.sqf";
				};
				case 15: //matt76_rockets
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tools\matt76_bullets.sqf";
				};
				case 16: //gun store
				{
					closeDialog 0;
					[] call loadGunStore;
				};
				case 17: //Gen store
				{
					closeDialog 0;
					[] call loadGeneralStore;
				};
				case 18: //ATM
				{
					closeDialog 0;
					call mf_items_atm_access;
				};
				case 19: //ai esp
				{
					closeDialog 0;
					execVM "client\systems\adminPanel\tools\aiEsp.sqf";
				};
				case 20: //freecam
				{
					closeDialog 0;
					if(!isNil'camerathread')then{terminate camerathread;camerathread=nil;};
					camerathread = [] spawn (uinamespace getvariable 'bis_fnc_camera');
				};
				case 21: //Spawn Beacon markers
				{
					execVM "client\systems\adminPanel\tools\spawnBeacons.sqf";
				};
				case 22: //unlimited ammo
 				{
                    closeDialog 0;
 					execVM "client\systems\adminPanel\tools\matt76_ammo.sqf";
 				};
			};
		};
		case (!isNull _displayDebug): //Debug panel
		{
			_debugSelect = _displayDebug displayCtrl debugMenu_option;

			switch (lbCurSel _debugSelect) do
			{
				case 0: //Access Proving Grounds
				{
					closeDialog 0;
					createDialog "balca_debug_main";
					if (!isNil "notifyAdminMenu") then { ["ProvingGrounds", "Opened"] call notifyAdminMenu };
				};
				case 1: //Show server FPS function
				{
					hint format["Server FPS: %1",serverFPS];
					if (!isNil "notifyAdminMenu") then { ["ServerFPS", "Used"] call notifyAdminMenu };
				};
				case 2: //Unlock Base Objects within 15m
				{
					execVM "client\systems\adminPanel\unLock.sqf";
					if (!isNil "notifyAdminMenu") then { ["UnlockObjects", "Opened"] call notifyAdminMenu };
				};
				case 3: //Delete Unlocked Base Objects within 15m
				{
					execVM "client\systems\adminPanel\deleteUnlocked.sqf";
					if (!isNil "notifyAdminMenu") then { ["DeleteUnlockedObjects", "Opened"] call notifyAdminMenu };
				};
				case 4: //Relock objects within 30m
				{
					execVM "client\systems\adminPanel\reLock.sqf";
					if (!isNil "notifyAdminMenu") then { ["RelockObjects", "Opened"] call notifyAdminMenu };
				};
				case 5: //Access TOParma News
				{
					[] call loadTOParmaInfo;
					if (!isNil "notifyAdminMenu") then { ["News", "Opened"] call notifyAdminMenu };
				};
			};
		};
	};
};
