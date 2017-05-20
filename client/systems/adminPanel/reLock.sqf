// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright � 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: reLock.sqf
//	@file Author: LouD, NRZ7
//	@file Created: 15-08-2015

#define RADIUS 60
_objects = nearestObjects [position player, ["thingX", "Building", "ReammoBox_F"], RADIUS];
_ownedObjects = {typeName _x == "OBJECT" && {_x getVariable ["objectLocked",true]}} count _objects;

_confirmMsg = format ["This will lock %1 base objects within %2m<br/>", _ownedObjects, RADIUS];
_confirmMsg = _confirmMsg + format ["<br/>Lock Objects?"];

if ([parseText _confirmMsg, "Confirm", "CONFIRM", true] call BIS_fnc_guiMessage) then
{
	{
		if (_x getVariable ["objectLocked",true]) then
		{
			_x setVariable ["objectLocked", true, false];
		};
	} forEach _objects;
	hint format["You have locked all base objects within %1m of the area", RADIUS];
};