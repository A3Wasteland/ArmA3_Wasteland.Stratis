//	@file Version: 2.0.3
//	@file Name: hvT.sqf
//	@file Author: Cael817, CRE4MPIE, LouD, AgentRev, soulkobk
//	@file Modified: soulkobk 7:16 PM 30/06/2016
//	@file Description:	v2.0.3 - soulkobk, added in proper HandleDisconnect event handler to delete the HVT marker upon player disconnecting.
//						if enabled, the players saved data will be reset/removed, so when they log back in they will be a fresh-spawn.
//						this may deter players from logging out as a high-value-target (toggable on/off via #define). Added in condition
//						to disable abort/respawn buttons if player is a HVT. once player drops money, HVT condition is reset and marker deleted.

#define HVT_AMOUNT 150000  // how much a player needs to be carrying to become a HVT
#define HINT_DELAY 60  // number of seconds between each HVT reminder hint
#define MARKER_REFRESH 30  // number of seconds between each HVT marker refresh
#define __PUNISH_HVT_LOGOUT__ // punish user if logged out as HVT?
#define __PREVENT_HVT_LOGOUT__ // disables the abort and respawn button if player is marked as a HVT

if (isServer) then
{
	HvT_deleteMarker = addMissionEventHandler ["HandleDisconnect", {
		params ["_unit", "_id", "_uid", "_name"];
		_markerName = format ["HvT_%1",_uid];
		if !((getMarkerPos _markerName) isEqualTo [0,0,0]) then
		{
			#ifdef __PUNISH_HVT_LOGOUT__
				_uid call fn_deletePlayerSave;
				diag_log format ["HIGH VALUE TARGET -> PLAYER '%1' (%2) DISCONNECTED AS A HIGH VALUE TARGET - PLAYER RESET TO A FRESH SPAWN!",_name,_uid];
			#else
				diag_log format ["HIGH VALUE TARGET -> PLAYER '%1' (%2) DISCONNECTED AS A HIGH VALUE TARGET - NO PUNISHMENT.",_name,_uid];
			#endif
		};
		deleteMarker _markerName;
	}];
};
	
if (!hasInterface) exitWith {};

waitUntil {sleep 0.1; alive player && !(player getVariable ["playerSpawning", true])};

_lastHintTime = -HINT_DELAY;
_lastMarkerTime = -MARKER_REFRESH;
_markerTarget = objNull;
_hasMarker = false;
_markerName = "";

while {true} do
{
	_isHvT = (player getVariable ["cmoney",0] >= HVT_AMOUNT && alive player && !(player getVariable ["playerSpawning", true]));
	if (_isHvT && diag_tickTime - _lastHintTime >= HINT_DELAY) then
	{
		hint parseText ([
			"<t color='#FF0000' size='1.5' align='center'>High Value Target</t>",
			//profileName,
			"<t color='#FFFFFF' shadow='1' shadowColor='#000000' align='center'>You have been spotted carrying a large sum of money and your location has been marked on the map!</t>"
		] joinString "<br/>");
		_lastHintTime = diag_tickTime;
	};
	if (diag_tickTime - _lastMarkerTime >= MARKER_REFRESH || (!alive _markerTarget && _hasMarker)) then
	{
		_markerName = "HvT_" + getPlayerUID player;
		if (_hasMarker) then
		{
			deleteMarker _markerName;
			_hasMarker = false;
		};
		if (_isHvT) then
		{
			createMarker [_markerName, getPosWorld player];
			_markerName setMarkerColor "ColorRed";
			_markerName setMarkerText format ["Sugar Daddy: %1 ($%2)", profileName, (player getVariable ["cmoney",0]) call fn_numToStr];
			_markerName setMarkerSize [0.75, 0.75];
			_markerName setMarkerShape "ICON";
			_markerName setMarkerType "mil_warning";
			_lastMarkerTime = diag_tickTime;
			_markerTarget = player;
			_hasMarker = true;
			playSound "Topic_Done";
		};
	};
	if (_isHvT && !((getMarkerPos _markerName) isEqualTo [0,0,0]) && !(isNull findDisplay 49)) then
	{
		#ifdef __PREVENT_HVT_LOGOUT__
			(findDisplay 49 displayCtrl 104) ctrlEnable false; // disables abort button
			(findDisplay 49 displayCtrl 1010) ctrlEnable false; // disables respawn button
		#endif
		#ifdef __PUNISH_HVT_LOGOUT__
			_text = "\n\n\n\n\n\n!!! WARNING !!!\nLogging out as a High-Value-Target will reset your player to a fresh spawn!";
			488 cutText [_text, "PLAIN DOWN"];
			uiSleep 0.5;
		#endif
	};
	if !(_isHvT && !((getMarkerPos _markerName) isEqualTo [0,0,0])) then
	{
		deleteMarker _markerName;
		_hasMarker = false;
	};
	uiSleep 0.5;
};