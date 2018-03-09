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
	
	Name: outOfBoundsPlayer.sqf
	Version: 1.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 2:14 PM 20/02/2018
	Modification Date: 2:14 PM 20/02/2018
	
	Description:
	out of bounds checks for player on-foot or in a parachute.

	Parameter(s): none

	Example: none

	Change Log:
	1.0 - original base script.
	
	----------------------------------------------------------------------------------------------
*/

_maxTime = 30; // max out of bounds timer
_maxHeight = 2500; // max player height

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

if (isServer) then
{
	_mapSizeSquare = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	_mapSizeEllipse = sqrt ((_mapSizeSquare * _mapSizeSquare) + (_mapSizeSquare * _mapSizeSquare));
	_mapCenterPos = [(_mapSizeSquare / 2),(_mapSizeSquare / 2)];
	_mkrInBounds = createMarker ["playableAreaPlayer",_mapCenterPos];
	_mkrInBounds setMarkerColor "ColorGreen";
	_mkrInBounds setMarkerShape "ELLIPSE";
	_mkrInBounds setMarkerBrush "BORDER";
	_mkrInBounds setMarkerAlpha 1;
	_mkrInBounds setMarkerSize [(_mapSizeEllipse / 1.96),(_mapSizeEllipse / 1.96)];
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
		"Parachute",
		"
		<br/>Marker: GREEN Ellipse.
		<br/>Altitude Limit: " + str _maxHeight + " meters.
		<br/>Timer: " + str _maxTime + " seconds.

		"
		]];
		player createDiaryRecord ["outofbounds",
		[
		"Player",
		"
		<br/>Marker: GREEN Ellipse.
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
			waitUntil {uiSleep 1; (((objectParent player) isEqualTo objNull) || ((objectParent player) isKindOf "ParachuteBase")) && (!(player inArea "playableAreaPlayer") || ((getPos player select 2) > _maxHeight))};
			///////////////////////////////////////////////////////////////////////////////////////
			_secondsTimer = _maxTime;
			_secondsText = "";
			while {!(player inArea "playableAreaPlayer") || ((getPos player select 2) > _maxHeight)} do
			{
				if (_secondsTimer > 1) then
				{
					_secondsText = "SECONDS";
				}
				else
				{
					_secondsText = "SECOND";
				};
				_text = format ["YOU ARE OUTSIDE OF THE PLAYABLE AREA!\n\nYOU HAVE %1 %2 TO BE INSIDE THE PLAYABLE AREA AND UNDER %3M ALTITUDE!",_secondsTimer,_secondsText,_maxHeight];
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
			if ((objectParent player) isEqualTo objNull) then
			{
				if (alive player) then
				{
					_text = "YOU ARE BACK INSIDE THE PLAYABLE AREA";
					[_text, 10] call mf_notify_client;
				}
				else
				{
					_text = "YOU WERE KILLED DUE TO BEING OUTSIDE OF THE PLAYABLE AREA FOR TOO LONG";
					[_text, 10] call mf_notify_client;
				};
			};
			///////////////////////////////////////////////////////////////////////////////////////
		};
	};
};	
