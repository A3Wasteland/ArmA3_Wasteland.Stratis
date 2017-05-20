// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
/*
	Original Script Author: Joris-Jan van 't Land
	Edited by armatec, JoSchaap, AgentRev, soulkobk

	Description:
	Takes an array of data about a dynamic object template and creates the objects.

	Parameter(s):
	_this select 0: compositions name - "roadBlockLarge"
	_this select 1: Location to start
	_this select 2: Direction in degrees - Number

	Example:
	["roadBlockLarge", getMarkerPos "roadBlock_1", markerDir "roadBlock_1" ] execVM "createRoadBlock.sqf";

*/

private ["_fileName", "_dir", "_pos", "_objList", "_objs", "_class", "_relPos", "_relDir", "_fuel", "_damage", "_init"];

_fileName = _this select 0;
_basePos = _this select 1;
_baseDir = _this select 2;

_objList = call compile preprocessFileLineNumbers format ["server\missions\roadBlocks\%1.sqf", _fileName];
_objs = [];

{
	private ["_obj"];
	_objName = _x select 0;
	_objPos = _x select 1;
	_objDir = _x select 2;
	_objInit = _x param [3, nil];
	_objPos = _basePos vectorAdd ([_objPos, -(_baseDir)] call BIS_fnc_rotateVector2D);
	_obj = createVehicle [_objName, _objPos, [], 0, "CAN_COLLIDE"];
	_obj setDir (_baseDir + _objDir);
	_obj setPos _objPos;
	_obj setPosATL _objPos;
	_objDirCurr = getDir _obj;
	_objs pushBack _obj;
	if (!isNil "_objInit") then { _obj call _objInit };
	uiSleep 0.1;
} forEach _objList;

_objs
