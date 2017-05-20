player setDammage 0;
vehicle setDammage 0;
vehicle setFuel 1;
player removeEventHandler ["hit",_p_hit_EH];
player removeEventHandler ["dammaged",_p_dam_EH];
vehicle removeEventHandler ["hit",_veh_hit_EH];
vehicle removeEventHandler ["dammaged",_veh_dam_EH];