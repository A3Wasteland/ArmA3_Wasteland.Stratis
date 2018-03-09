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
	
	Name: outOfBoundsRemote.sqf
	Version: 1.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 2:14 PM 20/02/2018
	Modification Date: 2:14 PM 20/02/2018
	
	Description:
	out of bounds checks for player connected to a remote vehicle (uav/ugv).

	Parameter(s): none

	Example: none

	Change Log:
	1.0 - original base script.
	
	----------------------------------------------------------------------------------------------
*/

_maxTime = 30; // max out of bounds timer
_maxHeight = 1500; // max remote height

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

if (isServer) then
{
	_mapSizeSquare = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	_mapSizeEllipse = sqrt ((_mapSizeSquare * _mapSizeSquare) + (_mapSizeSquare * _mapSizeSquare));
	_mapCenterPos = [(_mapSizeSquare / 2),(_mapSizeSquare / 2)];
	_mkrInBounds = createMarker ["playableAreaRemote",_mapCenterPos];
	_mkrInBounds setMarkerColor "ColorYellow";
	_mkrInBounds setMarkerShape "ELLIPSE";
	_mkrInBounds setMarkerBrush "BORDER";
	_mkrInBounds setMarkerAlpha 1;
	_mkrInBounds setMarkerSize [(_mapSizeEllipse / 1.98),(_mapSizeEllipse / 1.98)];
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
		"Remote Vehicle (UAV/UGV)",
		"
		<br/>Marker: YELLOW Ellipse.
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
			waitUntil {uiSleep 1; !((UAVcontrol (getConnectedUAV player) select 0) isEqualTo objNull) && (!((getConnectedUAV player) inArea "playableAreaRemote") || ((getPos (getConnectedUAV player) select 2) > _maxHeight))};
			///////////////////////////////////////////////////////////////////////////////////////
			_secondsTimer = _maxTime;
			_secondsText = "";
			while {!((getConnectedUAV player) inArea "playableAreaRemote") || ((getPos (getConnectedUAV player) select 2) > _maxHeight)} do
			{
				if (_secondsTimer > 1) then
				{
					_secondsText = "SECONDS";
				}
				else
				{
					_secondsText = "SECOND";
				};
				_text = format ["YOUR REMOTE VEHICLE IS OUTSIDE OF THE PLAYABLE AREA!\n\nYOU HAVE %1 %2 TO GET IT INSIDE THE PLAYABLE AREA AND UNDER %3M ALTITUDE!",_secondsTimer,_secondsText,_maxHeight];
				[_text, 1] call mf_notify_client;
				uiSleep 1;
				_secondsTimer = _secondsTimer - 1;
				if (_secondsTimer isEqualTo 0) exitWith
				{
					(getConnectedUAV player) setDamage 1;
					player setDamage 1;
				};
			};
			///////////////////////////////////////////////////////////////////////////////////////
			if !((getConnectedUAV player) isEqualTo objNull) then
			{
				if ((alive player) && (alive (getConnectedUAV player))) then
				{
					_text = "YOUR REMOTE VEHICLE ARE BACK INSIDE THE PLAYABLE AREA";
					[_text, 10] call mf_notify_client;
				}
				else
				{
					_text = "YOU WERE KILLED AND YOUR REMOTE VEHICLE WAS DESTROYED DUE TO BEING OUTSIDE OF THE PLAYABLE AREA FOR TOO LONG";
					[_text, 10] call mf_notify_client;
				};
			};
			///////////////////////////////////////////////////////////////////////////////////////
		};
	};
};	
