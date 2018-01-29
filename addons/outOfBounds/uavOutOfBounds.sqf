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
	
	Name: outOfBounds.sqf
	Version: 1.0.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 9:33 PM 04/07/2016
	Modification Date: 3:01 PM 06/07/2016
	
	Description:
	For use with A3Wasteland 1.xx mission (A3Wasteland.com). This script will create a playable area
	boundary on the map (server side) which is automatically calculated from the current maps
	configuration. It will also execute a constant _uav check to make sure they are within the
	playable area at all times. If the _uav is outside of the play area, a timer will show on
	screen with a count down and an audible warning. If the countdown reaches 0 seconds, then the
	_uav (and any vehicle the _uav is in) will be killed and forced to respawn.
	
	The playable area is within a visible blue circle border on the map as well as an altitude limit
	(in meters) as set per the _maxHeight variable. The maximum time duration any _uav is allowed
	to be outside the playable area (in seconds) is set by the _maxTime variable.
	
	Place this file at...
	\addons\outOfBounds\uavOutOfBounds.sqf
	
	Edit the file...
	\server\functions\fn_createCrewUAV.sqf
	
	And paste in at the bottom...
	[_uav] execVM "addons\outOfBounds\uavOutOfBounds.sqf";
	
	Above the line... (right at the bottom of the script).
	_grp
	
	Parameter(s): none

	Example: none
	
	Change Log:
	1.0.0 -	original base script.
	
	----------------------------------------------------------------------------------------------
*/

_maxTime = 30; // 30 seconds max default
_maxHeight = 2200; // 2500m height max default

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

params ["_uav"];
	
if (!isNil "_uav") then
{
	[_uav,_maxTime,_maxHeight] spawn
	{
		params ["_uav","_maxTime","_maxHeight"];
		respawnDialogActive = false;
		_inLoop = false;
		while {alive _uav} do
		{
			waitUntil {uiSleep 0.1; alive _uav};
			if (alive _uav) then
			{
				_outOfBounds = !(_uav inArea "playableArea");
				_outOfBoundsAltitude = (getPos _uav select 2 > _maxHeight);
				if (((_outOfBounds) || (_outOfBoundsAltitude)) && (!_inLoop)) then
				{
					_inLoop = true;
					_inLoopTimer = _maxTime;
					_secondsText = "";
					while {(_outOfBounds) || (_outOfBoundsAltitude)} do
					{
						uiSleep 1;
						_inLoopTimer = _inLoopTimer - 1;
						if (_inLoopTimer isEqualTo 0) exitWith
						{
							vehicle _uav setDamage 1;
							_uav setDamage 1;
						};
						_outOfBounds = !(_uav inArea "playableArea");
						_outOfBoundsAltitude = (getPos _uav select 2 > _maxHeight);
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
