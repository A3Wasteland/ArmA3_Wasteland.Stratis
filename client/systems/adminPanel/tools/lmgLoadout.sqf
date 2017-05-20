_uid = getPlayerUID player;

if (_uid call isAdmin) then {

		fn_spawnLoadout_lmg = {
			
			_lmgLOADOUT = player;
 
			removeAllWeapons _lmgLOADOUT;
			removeAllItems _lmgLOADOUT;
			removebackpack _lmgLOADOUT;
			//removeUniform _lmgLOADOUT;
			removeAllAssignedItems _lmgLOADOUT;
			removeGoggles _lmgLOADOUT;
			removeHeadgear _lmgLOADOUT;
 
			_lmgLOADOUT addHeadgear "H_Booniehat_dgtl";
			//_lmgLOADOUT addUniform "U_B_T_Soldier_SL_F";
			_lmgLOADOUT addVest "V_PlateCarrierIA2_dgtl";
			_lmgLOADOUT addBackpack "B_Carryall_cbr";
			_lmgLOADOUT addWeapon "NVGoggles";
			 
			_lmgLOADOUT addMagazine "150Rnd_556x45_Drum_Mag_F";
			_lmgLOADOUT addweapon "MMG_02_camo_F";
			_lmgLOADOUT addPrimaryWeaponItem "optic_LRPS";
			_lmgLOADOUT addPrimaryWeaponItem "bipod_01_F_blk";
 
			_lmgLOADOUT addWeaponGlobal "ItemCompass";
			_lmgLOADOUT addWeaponGlobal "ItemMap";
			_lmgLOADOUT addWeaponGlobal "Itemgps";
 
			(unitBackpack _lmgLOADOUT) additemCargo["FirstAidKit", 2];
			(unitBackpack _lmgLOADOUT) additemCargo["130Rnd_338_Mag", 3];
			(unitBackpack _lmgLOADOUT) additemCargo["130Rnd_338_Mag", 3];
        };
    [] spawn fn_spawnLoadout_lmg;
    hint format ["LMG Loadout added to admin %1", name player];
}; 