/*
	----------------------------------------------------------------------------------------------

	Copyright © 2018 soulkobk (soulkobk.blogspot.com)

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.

	----------------------------------------------------------------------------------------------

	Name: resupplyVehicles.sqf
	Version: 1.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 2:21 PM 20/03/2018
	Modification Date: 2:21 PM 20/03/2018

	Description:
	scripted for Fractured-Gaming.com A3Wasteland server.

	place this script at...
	\addons\resupplyVehicles\resupplyVehicles.sqf

	edit...
	\init.sqf

	paste in...
	[] execVM "addons\resupplyVehicles\resupplyVehicles.sqf";

	underneath...
	//init 3rd Party Scripts
	[] execVM "addons\parking\functions.sqf";

	in EDEN...
	place down object(s) "B_Slingload_01_Repair_F" then apply object variable name 'resupplyObject_0',
	copy/paste where you need resupply points for vehicles and save.

	edit...
	\client\functions\fn_resupplyTruck.sqf

	modify lines 91 to 97 (see below on what code to null/delete)...

	// Abort if no resupply vehicle in proximity
	// _checkCondition = {{alive _x && {_x getVariable ["A3W_resupplyTruck", false]}} count (_vehicle nearEntities ["AllVehicles", RESUPPLY_TRUCK_DISTANCE]) == 0};
	// if (call _checkCondition) exitWith
	// {
		// _pauseText = "Move closer to a resupply vehicle.";
		// _abortText = "Too far from resupply vehicle.";
	// };

	enjoy!

	Parameter(s): none

	Example: none

	Change Log:
	1.0 - original base script.

	----------------------------------------------------------------------------------------------
*/

_resupplyObjects = (allMissionObjects "ALL") select {["resupplyObject", str _x] call BIS_fnc_inString};
if !(_resupplyObjects isEqualTo []) then
{
	{
		_resupplyObject = _x;

		if (hasInterface) then
		{
			_resupplyObjectTrigger = createTrigger ["EmptyDetector", (getPosASL _resupplyObject), false];
			_resupplyObjectTrigger setTriggerArea [15,15,0,false,((getPosASL _resupplyObject select 2) + 15)];
			_resupplyObjectTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
			_resupplyObjectTrigger setTriggerStatements [
				"
					((vehicle player) in thisList) && {(_x isKindOf 'AllVehicles') && (alive _x) && (!isNull assignedDriver _x)} count thisList > 0;
				",
				"
					resupplyVehicle = player addAction ['<img image=''client\icons\repair.paa''/> Resupply Vehicle', 'client\functions\fn_resupplyTruck.sqf', [], 2, false, true, '', 'alive objectParent _this && attachedTo _target != vehicle _this && _target distance vehicle _this <= 10 && (isNil ''mutexScriptInProgress'' || {!mutexScriptInProgress})'];
				",
				"
					player removeAction resupplyVehicle;
				"
			];
		};

		if (isServer) then
		{
			_resupplyObject setDamage 0;
			_resupplyObject enableSimulationGlobal false;
			_resupplyObject allowDamage false;
			_resupplyObject setAmmoCargo 0;
			_resupplyObject setFuelCargo 0;
			_resupplyObject setRepairCargo 0;
			_resupplyObject enableRopeAttach false;

			clearBackpackCargoGlobal _resupplyObject;
			clearMagazineCargoGlobal _resupplyObject;
			clearWeaponCargoGlobal _resupplyObject;
			clearItemCargoGlobal _resupplyObject;

			_resupplyObjectPos = getPos _resupplyObject;
			_resupplyObjectDir = getDir _resupplyObject;

			_resupplyObject setVariable ["R3F_LOG_disabled", true];
			_resupplyObject setVariable ["A3W_lockpickDisabled", true];
			_resupplyObject setVariable ["A3W_resupplyTruck", true];
			_resupplyObject setVariable ["A3W_resupplyTruckSetup", true];

			_resupplyObjectMarker = createMarker [format ["resupplyObjectLayer0_%1",_resupplyObject],_resupplyObjectPos];
			_resupplyObjectMarker setMarkerShape "ELLIPSE";
			_resupplyObjectMarker setMarkerBrush "SOLIDBORDER";
			_resupplyObjectMarker setMarkerSize [20,20];
			_resupplyObjectMarker setMarkerDir _resupplyObjectDir;
			_resupplyObjectMarker setMarkerColor "colorBlack";
			_resupplyObjectMarker setMarkerAlpha 0.25;

			_resupplyObjectMarker = createMarker [format ["resupplyObjectLayer1_%1",_resupplyObject],_resupplyObjectPos];
			_resupplyObjectMarker setMarkerShape "ELLIPSE";
			_resupplyObjectMarker setMarkerBrush "SOLIDBORDER";
			_resupplyObjectMarker setMarkerSize [10,10];
			_resupplyObjectMarker setMarkerDir _resupplyObjectDir;
			_resupplyObjectMarker setMarkerColor "colorOrange";
			_resupplyObjectMarker setMarkerAlpha 0.75;

			_resupplyObjectMarker = createMarker [format ["resupplyObjectLayer2_%1",_resupplyObject],_resupplyObjectPos];
			_resupplyObjectMarker setMarkerShape "ICON";
			_resupplyObjectMarker setMarkerType "n_service";
			_resupplyObjectMarker setMarkerSize [0.5,0.5];
			_resupplyObjectMarker setMarkerColor "colorOrange";
			_resupplyObjectMarker setMarkerAlpha 1;
		};

	} forEach _resupplyObjects;
};
