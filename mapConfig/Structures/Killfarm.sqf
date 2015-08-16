_pos = [4483.861328,6702.974609,0.169891];
_object = createVehicle ["Land_HBarrierWall_corner_F", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 90;
_object setPosATL _pos;_object setVariable ["R3F_LOG_disabled", true, true];
_object enableSimulation false;
_object allowDamage false;


_pos = [4486.123047,6705.779297,0.489746];
_object = createVehicle ["Land_Slums01_8m", _pos, [], 0, "CAN_COLLIDE"];
_object setDir 300;
_object setPosATL _pos;
_object setVariable ["R3F_LOG_disabled", true, true];
_object enableSimulation false;
_object allowDamage false;