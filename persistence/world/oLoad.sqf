//	@file Version: 1.2
//	@file Name: oLoad.sqf
//	@file Author: JoSchaap, AgentRev, Austerror
//	@file Description: Basesaving load script

if (!isServer) exitWith {};

#include "functions.sqf"

_strToSide =
{
	switch (toUpper _this) do
	{
		case "WEST":  { BLUFOR };
		case "EAST":  { OPFOR };
		case "GUER":  { INDEPENDENT };
		case "CIV":   { CIVILIAN };
		case "LOGIC": { sideLogic };
		default       { sideUnknown };
	};
};

_isWarchestEntry = { [_variables, "a3w_warchest", false] call fn_getFromPairs };
_isBeaconEntry = { [_variables, "a3w_spawnBeacon", false] call fn_getFromPairs };

_maxLifetime = ["A3W_objectLifetime", 0] call getPublicVar;

_exists = _fileName call PDB_exists; // iniDB_exists
_objectsCount = 0;

_savingMethod = ["A3W_savingMethod", 1] call getPublicVar;

if (!isNil "_exists" && {_exists}) then
{
	_objectsCount = [_fileName, "Info", "ObjCount", "NUMBER"] call PDB_read; // iniDB_read

	if (!isNil "_objectsCount") then
	{
		for "_i" from 1 to _objectsCount do
		{
			_objName = format ["Obj%1", _i];

			_class = [_fileName, _objName, "Class", "STRING"] call PDB_read; // iniDB_read
			_pos = [_fileName, _objName, "Position", "ARRAY"] call PDB_read; // iniDB_read
			_hoursAlive = [_fileName, _objName, "HoursAlive", "NUMBER"] call PDB_read; // iniDB_read

			if (!isNil "_class" && {!isNil "_pos"} && {_maxLifetime <= 0 || {_hoursAlive < _maxLifetime}}) then
			{
				_variables = [_fileName, _objName, "Variables", "ARRAY"] call PDB_read; // iniDB_read

				_allowed = switch (true) do
				{
					case (call _isWarchestEntry):       { _warchestSavingOn };
					case (call _isBeaconEntry):         { _beaconSavingOn };
					case (_class call _isBox):          { _boxSavingOn };
					case (_class call _isStaticWeapon): { _staticWeaponSavingOn };
					default                             { _baseSavingOn };
				};

				if (_allowed) then
				{
					_dir = [_fileName, _objName, "Direction", "ARRAY"] call PDB_read; // iniDB_read
					_damage = [_fileName, _objName, "Damage", "NUMBER"] call PDB_read; // iniDB_read
					_allowDamage = [_fileName, _objName, "AllowDamage", "NUMBER"] call PDB_read; // iniDB_read

					_obj = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
					//_obj setPosWorld _pos;
					_obj setPosATL _pos;

					if (!isNil "_dir") then
					{
						_obj setVectorDirAndUp _dir;
					};

					_obj setVariable ["baseSaving_hoursAlive", _hoursAlive];
					_obj setVariable ["baseSaving_spawningTime", diag_tickTime];
					_obj disableTIEquipment true; // disables thermal equipment on loaded vehicles, comment out if you want thermals	
					
					//Lock obj again if it's not vehicle
					if ({ _obj isKindOf _x } count ['Air','Tank','Motorcycle','Car','Ship'] > 0)then{
						_obj setVariable ["objectLocked", false, true]; // loads the saved vehicle unlocked
					}else{
						_obj setVariable ["objectLocked", true, true]; // loads the saved vehicle locked
					};
					
					if (_obj isKindOf "SUV_01_base_F") then
					{
					_centerOfMass = getCenterOfMass _vehicle;
					_centerOfMass set [2, -0.657];
					_obj setCenterOfMass _centerOfMass;
					};	
					
					//Attempt to set the vehicle texture on the vehicle
					private ["_veh", "_texture", "_selections"];
					_veh = _obj;
					_texture = [_fileName, _objName, "Texture", "STRING"] call PDB_read;

					if (!isNull _obj && _texture != "") then
					{
						_veh setVariable ["BIS_enableRandomization", false, true];

						// Apply texture to all appropriate parts
						_selections = switch (true) do
						{
							case (_veh isKindOf "Van_01_base_F"):             { [0,1] };
					
							case (_veh isKindOf "MRAP_01_base_F"):            { [0,2] };
							case (_veh isKindOf "MRAP_02_base_F"):            { [0,2] };
							case (_veh isKindOf "MRAP_03_base_F"):            { [0,1] };

							case (_veh isKindOf "Truck_01_base_F"):           { [0,1,2] };
							case (_veh isKindOf "Truck_02_base_F"):           { [0,1] };
							case (_veh isKindOf "Truck_03_base_F"):           { [0,1] };

							case (_veh isKindOf "APC_Wheeled_01_base_F"):     { [0,2] };
							case (_veh isKindOf "APC_Wheeled_02_base_F"):     { [0,2] };
							case (_veh isKindOf "APC_Wheeled_03_base_F"):     { [0,2,3] };

							case (_veh isKindOf "APC_Tracked_01_base_F"):     { [0,1,2,3] };
							case (_veh isKindOf "APC_Tracked_02_base_F"):     { [0,1,2] };
							case (_veh isKindOf "APC_Tracked_03_base_F"):     { [0,1] };

							case (_veh isKindOf "MBT_01_base_F"):             { [0,1,2] };
							case (_veh isKindOf "MBT_02_base_F"):             { [0,1,2,3] };
							case (_veh isKindOf "MBT_03_base_F"):             { [0,1,2] };

							case (_veh isKindOf "Heli_Transport_01_base_F"):  { [0,1] };
							case (_veh isKindOf "Heli_Transport_02_base_F"):  { [0,1,2] };
							case (_veh isKindOf "Heli_Attack_02_base_F"):     { [0,1] };

							case (_veh isKindOf "Plane_Base_F"):              { [0,1] };

							default                                           { [0] };
						};
				
						  { _veh setObjectTextureGlobal [_x, _texture] } forEach _selections;
							_veh setVariable ["A3W_objectTexture", _texture, true];				
					};			
					
					
					if (_allowDamage > 0) then
					{
						_obj setDamage _damage;
						_obj setVariable ["allowDamage", true];
					}
					else
					{
						_obj allowDamage false;
					};

					{
						_var = _x select 0;
						_value = _x select 1;

						switch (_var) do
						{
							case "side": { _value = _value call _strToSide };
							case "R3F_Side": { _value = _value call _strToSide };
							case "ownerName":
							{
								switch (typeName _value) do
								{
									case "ARRAY": { _value = toString _value };
									case "STRING":
									{
										if (_savingMethod == 2) then
										{
											_value = _value call iniDB_Base64Decode;
										};
									};
									default { _value = "[Beacon]" };
								};
							};
							//Запираем/отпираем технику
							case "vehicleLocked":{
								_obj lock _value;
							}
						};

						_obj setVariable [_var, _value, true];
						//AddAi to vehicle
						if (getNumber(configFile >> "CfgVehicles" >> typeOf _obj >> "isUav") > 0) then{
							createVehicleCrew _obj;
						};
					} forEach _variables;

					clearWeaponCargoGlobal _obj;
					clearMagazineCargoGlobal _obj;
					clearItemCargoGlobal _obj;
					clearBackpackCargoGlobal _obj;

					_unlock = switch (true) do
					{
						case (_obj call _isWarchest): { true };
						case (_obj call _isBeacon):
						{
							pvar_spawn_beacons pushBack _obj;
							publicVariable "pvar_spawn_beacons";
							true
						};
						default { false };
					};

					if (_unlock) exitWith
					{
						_obj setVariable ["objectLocked", false, true];
					};

					if (_boxSavingOn && {_class call _isBox}) then
					{
						_weapons = [_fileName, _objName, "Weapons", "ARRAY"] call PDB_read; // iniDB_read
						_magazines = [_fileName, _objName, "Magazines", "ARRAY"] call PDB_read; // iniDB_read
						_items = [_fileName, _objName, "Items", "ARRAY"] call PDB_read; // iniDB_read
						_backpacks = [_fileName, _objName, "Backpacks", "ARRAY"] call PDB_read; // iniDB_read

						if (!isNil "_weapons") then
						{
							{ _obj addWeaponCargoGlobal _x } forEach _weapons;
						};
						if (!isNil "_magazines") then
						{
							{ _obj addMagazineCargoGlobal _x } forEach _magazines;
						};
						if (!isNil "_items") then
						{
							{ _obj addItemCargoGlobal _x } forEach _items;
						};
						if (!isNil "_backpacks") then
						{
							{
								if !((_x select 0) isKindOf "Weapon_Bag_Base") then
								{
									_obj addBackpackCargoGlobal _x;
								};
							} forEach _backpacks;
						};
					};

					if (_staticWeaponSavingOn && {_class call _isStaticWeapon}) then
					{
						_turretMags = [_fileName, _objName, "TurretMagazines", "ARRAY"] call PDB_read; // iniDB_read

						if (!isNil "_turretMags") then
						{
							_obj setVehicleAmmo 0;
							{ _obj addMagazine _x } forEach _turretMags;
						};
					};
					

					if (_class call _isVehicle) then
					{					
						diag_log format["%1 is loading as vehicle. It it really vehicle?",_class];
						//Load vehicle ammo
						_vehicleMags = [_fileName, _objName, "VehicleMags", "ARRAY"] call PDB_read;
						if (!isNil "_vehicleMags") then
						{
							_obj setVehicleAmmo 0;
							{ _obj addMagazine _x } forEach _vehicleMags;
						};
						
						//Load vehicle flares
						_turretMags = [_fileName, _objName, "TurretMagazines", "ARRAY"] call PDB_read;
						if (!isNil "_turretMags") then
						{	
							{ _obj addMagazineTurret [_x,[-1]]} forEach _turretMags;
						};
											
						//Recreate checksumm for vehicle if valid
						_validChecksum = [_fileName, _objName, "validChecksum", "BOOL"] call PDB_read;
						if (_validChecksum=="true") then {
							_obj setVariable [call vChecksum, true];	
						}else{
							diag_log("Hacked saved vehicle found!");
							deleteVehicle _obj;	
						};
						
						//Restore cargo
						_ammoCargo = [_fileName, _objName, "AmmoCargo", "NUMBER"] call PDB_read; // iniDB_read
						_fuelCargo = [_fileName, _objName, "FuelCargo", "NUMBER"] call PDB_read; // iniDB_read
						_repairCargo = [_fileName, _objName, "RepairCargo", "NUMBER"] call PDB_read; // iniDB_read
						
						if (!isNil "_ammoCargo") then { _obj setAmmoCargo _ammoCargo };
						if (!isNil "_fuelCargo") then { _obj setFuelCargo _fuelCargo };
						if (!isNil "_repairCargo") then { _obj setRepairCargo _repairCargo };
						
					};
				};
			};
		};
	};

	if (_warchestMoneySavingOn) then
	{
		pvar_warchest_funds_west = ([_fileName, "Info", "WarchestMoneyBLUFOR", "NUMBER"] call PDB_read) max 0; // iniDB_read
		publicVariable "pvar_warchest_funds_west";
		pvar_warchest_funds_east = ([_fileName, "Info", "WarchestMoneyOPFOR", "NUMBER"] call PDB_read) max 0; // iniDB_read
		publicVariable "pvar_warchest_funds_east";
	};
};

diag_log format ["A3Wasteland - world persistence loaded %1 objects from %2", _objectsCount, ["A3W_savingMethodName", "a rip in the fabric of space-time"] call getPublicVar];
