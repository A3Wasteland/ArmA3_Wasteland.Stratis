waitUntil { sleep 0.5; !(isNull player) };
waitUntil { sleep 1.271; time > 0 };

MDET_var_active = false;

/// COMMON VARIABLES
if (isNil "MDET_var_radius") then { MDET_var_radius = 5 }; // Maximum distance from player to mine
if (isNil "MDET_var_angle") then { MDET_var_angle = 60 }; // Player to mine direction angle threshold

/// RANDOMIZE DISTANCE VALUE
if (isNil "MDET_var_rnd_radius") then { MDET_var_rnd_radius = true }; // Enable/Disable randomizer
if (isNil "MDET_var_rnd_radius_value") then { MDET_var_rnd_radius_value = 7 }; // +/- %

/// LOAD FUNCTIONS
call compile preprocessFileLineNumbers "addons\Mine_detector\functions.sqf";

_mdet_action_1 = player addAction [localize "STR_MDET_TOGGLE_ON", { call MDET_fnc_switchState }, [], -100, false, true, "", "call MDET_fnc_canDetect && !MDET_var_active"];
_mdet_action_2 = player addAction [localize "STR_MDET_TOGGLE_OFF", { call MDET_fnc_switchState }, [], -100, false, true, "", "call MDET_fnc_canDetect && MDET_var_active"];

while { alive player } do {
	if (call MDET_fnc_canDetect) then {
		if (MDET_var_active) then {
			_nearestMine = call MDET_fnc_getNearestMine;
			if (count _nearestMine > 0) then {
				_nearestMine call MDET_fnc_mineInRange;
			};
		} else {
			// sleep 2.381;
		};
	} else {
		if (MDET_var_active) then {
			[] call MDET_fnc_switchState
		};
	};
	sleep .503;
};

player removeAction _mdet_action_1;
player removeAction _mdet_action_2;
/*
MineDetectorMakeSound = true;
MineDetector_fnc_init = 
{
	player addAction ["Switch MineDetector On/Off",
	"MineDetectorMakeSound=not MineDetectorMakeSound;hint ('Enable MineDetector Beep: '+str(MineDetectorMakeSound))",
	[],
	-100,
	false,
	true,
	"",
	"'MineDetector' in items player"];
};
player addEventHandler ["respawn","call MineDetector_fnc_init"];
call MineDetector_fnc_init;
while {true} do
{
	if(alive player && {"MineDetector" in items player} && {MineDetectorMakeSound}) then
	{
		[player] call Mine_detector_fnc_playSound;
	}
	else
	{
//		systemChat ("Has Mine Detector: "+str("MineDetector" in items player));
	};
	sleep .5;
};
*/