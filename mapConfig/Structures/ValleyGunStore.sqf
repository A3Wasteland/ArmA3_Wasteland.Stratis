_pos = [2260.026123,3815.310303,-4.26462];
_object = createVehicle ["Land_Castle_01_wall_08_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 110;
_object setPosATL _pos;
_object setVariable ["R3F_LOG_disabled", true, true];
_object enableSimulation false;
_object allowDamage false;
