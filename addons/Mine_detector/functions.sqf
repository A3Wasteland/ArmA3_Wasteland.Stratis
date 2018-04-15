MDET_fnc_canDetect = {
	("MineDetector" in (items player)) && (player == vehicle player)
};

MDET_fnc_switchState = {
	if (MDET_var_active) then {
		MDET_var_active = false;
		hint parseText (localize "STR_MDET_DEACTIVATED")
	} else {
		MDET_var_active = true;
		hint parseText (localize "STR_MDET_ACTIVATED")
	};
};

MDET_fnc_randomize = {
	private "_percented";
	_percented = random (_this / 100 * MDET_var_rnd_radius_value);
	if (round (random 1) == 0) then {
		_this + _percented
	} else {
		_this - _percented
	}
};

MDET_fnc_getNearestMine = {
	private ["_found", "_nearestMine", "_allMines", "_mine", "_distance"];
	_found = false;
	_nearestMine = [];
	_allMines = allMines;
	for "_i" from 0 to ((count _allMines) - 1) do {
		_mine = _allMines select _i;
		_distance = player distance _mine;
		if (_distance <= MDET_var_radius) then {
			if ([getPos player, getDir player, MDET_var_angle, getPos _mine] call BIS_fnc_inAngleSector) then {
				if (_found) then {
					if ((_nearestMine select 1) > _distance) then {
						_nearestMine = [_mine, _distance];
					};
				} else {
					_found = true;
					_nearestMine = [_mine, _distance];
				};
			};
		};
	};
	_nearestMine
};

MDET_fnc_playSound = {
	private "_percentage";
	_percentage = _this / MDET_var_radius * 100;
	switch (true) do {
		case (_percentage > 80 && _percentage < 100): { playSound "Mine_Detector_Sound_1" };
		case (_percentage > 60 && _percentage < 80): { playSound "Mine_Detector_Sound_2" };
		case (_percentage > 40 && _percentage < 60): { playSound "Mine_Detector_Sound_3" };
		case (_percentage > 20 && _percentage < 40): { playSound "Mine_Detector_Sound_4" };
		case (_percentage > 0  && _percentage < 20): { playSound "Mine_Detector_Sound_5" };
	};
};

MDET_fnc_mineInRange = {
	private "_distance";
	_distance = _this select 1;
	if (MDET_var_rnd_radius) then {
		_distance = _distance call MDET_fnc_randomize;
	};
	_distance call MDET_fnc_playSound;
	////// MINE IS IN RANGE AND IN CORRECT ANGLE //////
	//systemChat format["Explosive detected in radius: %1m", round _distance];
};