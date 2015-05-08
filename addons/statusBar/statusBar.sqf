waitUntil {!(isNull (findDisplay 46))};
disableSerialization;
/*
	File: fn_statusBar.sqf
	Author: Osef (Ported to EpochMod by piX)
	Edited by: [piX]
	Description: Puts a small bar in the bottom centre of screen to display in-game information

	PLEASE KEEP CREDITS - THEY ARE DUE TO THOSE WHO PUT IN THE EFFORT!
*/
_rscLayer = "osefStatusBar" call BIS_fnc_rscLayer;
_rscLayer cutRsc["osefStatusBar","PLAIN"];
 // systemChat format["This is your player type %1", typeOf player];

[] spawn {
	sleep 5;
	_counter = 180;
	_timeSinceLastUpdate = 0;

	while {true} do
	{
		sleep 1;
		_counter = _counter - 1;
		_time    = (round(180-(serverTime)/60)); //edit the '240' (60*4=240) to change the countdown timer if your server restarts are shorter or longer than 4 hour intervals
		_hours   = (floor(_time/60));
		_minutes = (_time - (_hours * 60));

		((uiNamespace getVariable "osefStatusBar")displayCtrl 1000)ctrlSetText format["RaidCall: 9875436 | JUGADORES VIVOS: %1 | MEDIA DE FPS: %2", count playableUnits, round diag_fps];
	};
};
