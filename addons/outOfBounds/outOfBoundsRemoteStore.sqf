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
	
	Name: outOfBoundsRemoteStore.sqf
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
	(in meters) as set per the _maxHeightRemote variable. The maximum time duration any _uav is allowed
	to be outside the playable area (in seconds) is set by the _maxTime variable.
	
	Place this file at...
	\addons\outOfBounds\outOfBoundsRemoteStore.sqf
	
	Edit the file...
	\server\functions\fn_createCrewUAV.sqf
	
	And paste in at the bottom...
	[_uav] execVM "addons\outOfBounds\outOfBoundsRemoteStore.sqf";
	
	Above the line... (right at the bottom of the script).
	_grp
	
	Parameter(s): none

	Example: none
	
	Change Log:
	1.0.0 -	original base script.
	
	----------------------------------------------------------------------------------------------
*/

_maxTime = 30; // max out of bounds timer
_maxHeightRemote = 1500; // max remote-vehicle height - this MUST match the outOfBoundsRemote.sqf entry!

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

params ["_uav"];
	
if (!isNil "_uav") then
{
	_uavText = format ["\n! %1 PLEASE NOTE THAT THE REMOTE VEHICLE '%2' HAS A MAX ALTITUDE OF %3M !",toUpper (name player),toUpper (getText (configfile >> "CfgVehicles" >> typeOf _uav >> "displayName")),_maxHeightRemote];
	[_uavText, 5] call mf_notify_client;
	
	[_uav,_maxTime,_maxHeightRemote] spawn
	{
		params ["_uav","_maxTime","_maxHeightRemote"];
		respawnDialogActive = false;
		_inLoop = false;
		while {alive _uav} do
		{
			waitUntil {uiSleep 1; alive _uav};
			if (alive _uav) then
			{
				_outOfBounds = !(_uav inArea "playableAreaRemote");
				_outOfBoundsAltitude = (getPos _uav select 2 > _maxHeightRemote);
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
						_outOfBounds = !(_uav inArea "playableAreaRemote");
						_outOfBoundsAltitude = (getPos _uav select 2 > _maxHeightRemote);
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
