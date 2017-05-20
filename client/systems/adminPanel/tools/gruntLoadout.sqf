_uid = getPlayerUID player;

if (_uid call isAdmin) then {

		fn_spawnLoadout_grunt = {
			
			_gruntLOADOUT = player;
 
			removeAllWeapons _gruntLOADOUT;
			removeAllItems _gruntLOADOUT;
			removebackpack _gruntLOADOUT;
			//removeUniform _gruntLOADOUT;
			removeAllAssignedItems _gruntLOADOUT;
			removeGoggles _gruntLOADOUT;
			removeHeadgear _gruntLOADOUT;
 
			_gruntLOADOUT addHeadgear "H_Bandanna_sand";
			//_gruntLOADOUT addUniform "U_B_T_Soldier_SL_F";
			_gruntLOADOUT addVest "V_PlateCarrierIAGL_dgtl";
			_gruntLOADOUT addBackpack "B_Carryall_oli";
			_gruntLOADOUT addWeapon "NVGoggles";
			 
			_gruntLOADOUT addweapon "arifle_MXM_Black_F";
			_gruntLOADOUT addPrimaryWeaponItem "muzzle_snds_H";
			_gruntLOADOUT addPrimaryWeaponItem "optic_Aco";
			_gruntLOADOUT addWeapon "launch_I_Titan_short_F";
 
			_gruntLOADOUT addWeaponGlobal "ItemCompass";
			_gruntLOADOUT addWeaponGlobal "ItemMap";
			_gruntLOADOUT addWeaponGlobal "Itemgps";
 
			(unitBackpack _gruntLOADOUT) additemCargo["FirstAidKit", 2];
			(unitBackpack _gruntLOADOUT) additemCargo["Titan_AT", 2];
			for "_i" from 1 to 5 do {_gruntLOADOUT addItemToVest "30Rnd_65x39_caseless_mag";};
        };
    [] spawn fn_spawnLoadout_grunt;
    hint format ["Grunt Loadout added to admin %1", name player];
}; 