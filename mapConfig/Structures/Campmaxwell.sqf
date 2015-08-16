_pos = [3276.0441895,2947.411377,0.439255];
_object = createVehicle ["Land_Atm_01_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 140;
_object setPosATL _pos;
_object setVariable ["R3F_LOG_disabled", true, true];
_object enableSimulation false;
_object allowDamage false;