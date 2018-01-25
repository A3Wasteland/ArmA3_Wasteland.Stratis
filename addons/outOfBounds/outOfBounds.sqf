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

_maxTime = 30; // 20 seconds max default
_maxHeight = 2200; // 1500m height max default

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
		_playerObject = objNull;
		_outOfBounds = false;
		_outOfBoundsAltitude = false;
		_outOfBoundsText = "";
		_outOfBoundsTextDeath = "";
		while {_loopForever} do
		{
			waitUntil {uiSleep 0.1; alive player && !(player getVariable ["playerSpawning",true]) && !respawnDialogActive};
			if (alive player) then
			{
				_connectedUAV = getConnectedUAV player;
				if (!isNull _connectedUAV) then
				{
					_outOfBounds = !(_connectedUAV inArea "playableArea") || !(player inArea "playableArea");
					_outOfBoundsAltitude = (getPos _connectedUAV select 2 > _maxHeight) || (getPos player select 2 > _maxHeight);
					_outOfBoundsText = "YOU OR YOUR REMOTE VEHICLE ARE";
					_outOfBoundsTextDeath = "YOU AND YOUR REMOTE VEHICLE WILL BE KILLED!";
				}
				else
				{
					_outOfBounds = !(player inArea "playableArea");
					_outOfBoundsAltitude = (getPos player select 2 > _maxHeight);
					_outOfBoundsText = "YOU ARE";
					_outOfBoundsTextDeath = "YOU WILL BE KILLED!";
				};
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
						_oobText = format ["%1 OUTSIDE OF THE PLAYABLE AREA!\n\nYOU HAVE %2 %3 TO GET INSIDE THE PLAYABLE AREA AND BE UNDER %4M ALTITUDE\nOR\n%5",_outOfBoundsText,_inLoopTimer,_secondsText,_maxHeight,_outOfBoundsTextDeath];
						[_oobText, 1] call mf_notify_client;
						// playSound "Alarm";
						uiSleep 1;
						_inLoopTimer = _inLoopTimer - 1;
						if (_inLoopTimer isEqualTo 0) exitWith
						{
							if (!isNull _connectedUAV) then
							{
								vehicle _connectedUAV setDamage 1; // kill the remote vehicle if connected and oob.
								_connectedUAV setDamage 1; // kill the remote vehicle if connected and oob.
							};
							vehicle player setDamage 1; // kill the player vehicle if oob.
							player setDamage 1;// kill the player if oob.
						};
						_connectedUAV = getConnectedUAV player;
						if (!isNull _connectedUAV) then
						{
							_outOfBounds = !(_connectedUAV inArea "playableArea") || !(player inArea "playableArea");
							_outOfBoundsAltitude = (getPos _connectedUAV select 2 > _maxHeight) || (getPos player select 2 > _maxHeight);
							_outOfBoundsText = "YOU OR YOUR REMOTE VEHICLE ARE";
						}
						else
						{
							_outOfBounds = !(player inArea "playableArea");
							_outOfBoundsAltitude = (getPos player select 2 > _maxHeight);
							_outOfBoundsText = "YOU ARE";
						};
					};
					_connectedUAV = getConnectedUAV player;
					if (!isNull _connectedUAV) then
					{
						if (alive _connectedUAV) then
						{
							_oobText = "YOU AND YOUR REMOTE VEHICLE ARE BACK INSIDE THE PLAYABLE AREA!";
							[_oobText, 10] call mf_notify_client;
						}
						else
						{
							_oobText = "YOU AND YOUR REMOTE VEHICLE WERE OUTSIDE OF THE PLAYABLE AREA FOR TOO LONG AND HAVE BEEN KILLED!";
							[_oobText, 10] call mf_notify_client;
						};
					}
					else
					{
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
