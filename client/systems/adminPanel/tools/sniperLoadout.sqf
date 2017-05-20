_uid = getPlayerUID player;

if (_uid call isAdmin) then {

		fn_spawnLoadout_snipar = {
			
			_SniperLOADOUT = player;
 
			removeAllWeapons _SniperLOADOUT;
			removeAllItems _SniperLOADOUT;
			removebackpack _SniperLOADOUT;
			removeAllAssignedItems _SniperLOADOUT;
			removeGoggles _SniperLOADOUT;
			removeHeadgear _SniperLOADOUT;
 
			_SniperLOADOUT addHeadgear "H_Bandanna_camo";
			_SniperLOADOUT addGoggles "G_Sport_Blackred";
			_SniperLOADOUT addVest "V_BandollierB_cbr";
			_SniperLOADOUT addBackpack "B_Carryall_ocamo";
			_SniperLOADOUT addWeapon "NVGoggles";
			_SniperLOADOUT addWeapon "Rangefinder";
 
			_SniperLOADOUT addMagazine "20Rnd_762x51_Mag";
			_SniperLOADOUT addMagazine "20Rnd_762x51_Mag";
			_SniperLOADOUT addMagazine "20Rnd_762x51_Mag";
			_SniperLOADOUT addMagazine "20Rnd_762x51_Mag";
			_SniperLOADOUT addMagazine "20Rnd_762x51_Mag";
			_SniperLOADOUT addweapon "srifle_EBR_DMS_pointer_snds_F";
 
			_SniperLOADOUT addWeaponGlobal "ItemCompass";
			_SniperLOADOUT addWeaponGlobal "ItemMap";
			_SniperLOADOUT addWeaponGlobal "Itemgps";
 
			(unitBackpack _SniperLOADOUT) additemCargo["FirstAidKit", 2];
			(unitBackpack _SniperLOADOUT) additemCargo["20Rnd_762x51_Mag", 9];
        };
    [] spawn fn_spawnLoadout_snipar;
    hint format ["Sniper Loadout added to admin %1", name player];
};        


   