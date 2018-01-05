/*
	----------------------------------------------------------------------------------------------
	
	Copyright © 2016 soulkobk (soulkobk.blogspot.com)

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
*/

_maxTime = 20; // 20 seconds max default
_maxHeight = 2500; // 1500m height max default

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

if (isServer) then
{
	_mapSizeSquare = getNumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");
	_mapSizeEllipse = sqrt ((_mapSizeSquare * _mapSizeSquare) + (_mapSizeSquare * _mapSizeSquare));
	_mapCenterPos = [(_mapSizeSquare / 2),(_mapSizeSquare / 2)];

	_mkrInBounds = createMarker ["playableArea",_mapCenterPos];
	_mkrInBounds setMarkerColor "ColorBlue";
	_mkrInBounds setMarkerShape "ELLIPSE";
	_mkrInBounds setMarkerBrush "BORDER";
	_mkrInBounds setMarkerAlpha 1;
	_mkrInBounds setMarkerSize [(_mapSizeEllipse / 2),(_mapSizeEllipse / 2)];
};

if (hasInterface) then
{
	[_maxTime,_maxHeight] spawn
	{
		params ["_maxTime","_maxHeight"];
		respawnDialogActive = false;
		_inLoop = false;
		_loopForever = true;
		while {_loopForever} do
		{
			waitUntil {uiSleep 0.1; alive player && !playerSpawning && !respawnDialogActive};
			if (alive player) then
			{
				_outOfBounds = !(player inArea "playableArea");
				_outOfBoundsAltitude = (getPos player select 2 > _maxHeight);
				if (((_outOfBounds) || (_outOfBoundsAltitude)) && (!_inLoop)) then
				{
					_inLoop = true;
					_inLoopTimer = _maxTime;
					_secondsText = "";
					while {(_outOfBounds) || (_outOfBoundsAltitude)} do
					{
						if (_inLoopTimer > 1) then
						{
							_secondsText = "SECONDS";
						}
						else
						{
							_secondsText = "SECOND";
						};
						_oobText = format ["YOU ARE OUTSIDE OF THE PLAYABLE AREA!\n\nYOU HAVE %1 %2 TO BE INSIDE THE PLAYABLE AREA AND UNDER %3M ALTITUDE!",_inLoopTimer,_secondsText,_maxHeight];
						[_oobText, 1] call mf_notify_client;
						// playSound "Alarm";
						uiSleep 1;
						_inLoopTimer = _inLoopTimer - 1;
						if (_inLoopTimer isEqualTo 0) exitWith
						{
							vehicle player setDamage 1;
							player setDamage 1;
						};
						_outOfBounds = !(player inArea "playableArea");
						_outOfBoundsAltitude = (getPos player select 2 > _maxHeight);
					};
					if (alive player) then
					{
						_oobText = "YOU ARE BACK INSIDE THE PLAYABLE AREA!";
						[_oobText, 10] call mf_notify_client;
					}
					else
					{
						_oobText = "YOU WERE OUTSIDE OF THE PLAYABLE AREA FOR TOO LONG AND HAVE BEEN KILLED!";
						[_oobText, 10] call mf_notify_client;
					};
					_inLoop = false;
					_outOfBounds = false;
					_outOfBoundsAltitude = false;
				};
			};
			uiSleep 1;
		};
	};
};
