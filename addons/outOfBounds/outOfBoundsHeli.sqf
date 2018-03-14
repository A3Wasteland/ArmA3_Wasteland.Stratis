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
	
	Name: outOfBoundsHeli.sqf
	Version: 1.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 2:14 PM 20/02/2018
	Modification Date: 2:14 PM 20/02/2018
	
	Description:
	out of bounds checks for player in a helicopter.

	Parameter(s): none

	Example: none

	Change Log:
	1.0 - original base script.
	
	----------------------------------------------------------------------------------------------
*/

_maxTime = 30; // max out of bounds timer
_maxHeight = 1700; // max helicopter height

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

if (isServer) then
{
	_mapSizeSquare = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	_mapSizeEllipse = sqrt ((_mapSizeSquare * _mapSizeSquare) + (_mapSizeSquare * _mapSizeSquare));
	_mapCenterPos = [(_mapSizeSquare / 2),(_mapSizeSquare / 2)];
	_mkrInBounds = createMarker ["playableAreaHeli",_mapCenterPos];
	_mkrInBounds setMarkerColor "ColorOrange";
	_mkrInBounds setMarkerShape "ELLIPSE";
	_mkrInBounds setMarkerBrush "BORDER";
	_mkrInBounds setMarkerAlpha 1;
	_mkrInBounds setMarkerSize [(_mapSizeEllipse / 1.99),(_mapSizeEllipse / 1.99)];
};

if (hasInterface) then
{
	waitUntil {!isNull player};
	if !(player diarySubjectExists "outofbounds") then
	{
		player createDiarySubject ["outofbounds", "Out Of Bounds"];
	};
	if (player diarySubjectExists "outofbounds") then
	{
		player createDiaryRecord ["outofbounds",
		[
		"Helicopter",
		"
		<br/>Marker: ORANGE Ellipse.
		<br/>Altitude Limit: " + str _maxHeight + " meters.
		<br/>Timer: " + str _maxTime + " seconds.

		"
		]];
	};
	
	[_maxTime,_maxHeight] spawn
	{
		params ["_maxTime","_maxHeight"];
		_loopForever = true;
		while {_loopForever} do
		{
			waitUntil {uiSleep 1; alive player && !(player getVariable ["playerSpawning",true])};
			waitUntil {uiSleep 1; (((objectParent player) isKindOf "Helicopter") && !((objectParent player) isKindOf "ParachuteBase")) && (!((objectParent player) inArea "playableAreaHeli") || ((getPos (objectParent player) select 2) > _maxHeight))};
			///////////////////////////////////////////////////////////////////////////////////////
			_secondsTimer = _maxTime;
			_secondsText = "";
			while {!((objectParent player) inArea "playableAreaHeli") || ((getPos (objectParent player) select 2) > _maxHeight)} do
			{
				if (_secondsTimer > 1) then
				{
					_secondsText = "SECONDS";
				}
				else
				{
					_secondsText = "SECOND";
				};
				_text = format ["YOU AND YOUR HELICOPTER ARE OUTSIDE OF THE PLAYABLE AREA!\n\nYOU HAVE %1 %2 TO BE INSIDE THE PLAYABLE AREA AND UNDER %3M ALTITUDE!",_secondsTimer,_secondsText,_maxHeight];
				[_text, 1] call mf_notify_client;
				uiSleep 1;
				_secondsTimer = _secondsTimer - 1;
				if (_secondsTimer isEqualTo 0) exitWith
				{
					(objectParent player) setDamage 1;
					player setDamage 1;
				};
			};
			///////////////////////////////////////////////////////////////////////////////////////
			if !((objectParent player) isEqualTo objNull) then
			{
				if ((alive player) && (alive (objectParent player))) then
				{
					_text = "YOU AND YOUR HELICOPTER ARE BACK INSIDE THE PLAYABLE AREA";
					[_text, 10] call mf_notify_client;
				}
				else
				{
					_text = "YOU WERE KILLED AND YOUR HELICOPTER WAS DESTROYED DUE TO BEING OUTSIDE OF THE PLAYABLE AREA FOR TOO LONG";
					[_text, 10] call mf_notify_client;
				};
			};
			///////////////////////////////////////////////////////////////////////////////////////
		};
	};
};	
