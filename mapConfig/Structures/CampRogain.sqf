_pos = [4991.153809,5917.874023,0.427933];
_object = createVehicle ["Land_Atm_01_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 150;
_object setPosATL _pos;
_object setVariable ["R3F_LOG_disabled", true, true];
_object enableSimulation false;
_object allowDamage false;