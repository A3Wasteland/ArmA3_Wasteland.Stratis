// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: fn_refillbox.sqf  "fn_refillbox"
//	@file Author: [404] Pulse , [404] Costlyy , [404] Deadbeat, AgentRev
//	@file Created: 22/1/2012 00:00
//	@file Args: [OBJECT (Weapons box that needs filling), STRING (Name of the fill to give to object)]

// if (!isServer) exitWith {};

#define RANDOM_BETWEEN(START,END) (START + floor random ((END - START) + 1))

private ["_box", "_boxType", "_boxItems", "_item", "_qty", "_mag"];
_box = _this select 0;
_boxType = _this select 1;

_box allowDamage false; // No more fucking busted crates
_box setVariable ["A3W_inventoryLockR3F", true, true];

// Clear pre-existing cargo first
//clearBackpackCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

if (_boxType == "mission_USSpecial2") then { _boxType = "mission_USSpecial" };

switch (_boxType) do
{

	case "mission_Mixed":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(1,4)],
			["itm", "Medikit", RANDOM_BETWEEN(1,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(0,1)],
			["itm", ["optic_MRCO", "optic_Arco", "optic_Hamr", "optic_SOS"], RANDOM_BETWEEN(2,4)],
			["itm", ["muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "muzzle_snds_acp"], RANDOM_BETWEEN(0,3)],
			["wep", ["arifle_mas_asval", "arifle_mas_aks74", "arifle_mas_m4_m203_d", "arifle_mas_fal"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],
			["wep", ["srifle_EBR_F", "arifle_mas_m14", "arifle_mas_g36c"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["LMG_mas_M60_F", "LMG_mas_pkm_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)]
		];
	};

	case "mission_General":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["bpk", ["B_Carryall_mcamo","B_Carryall_khk","B_Carryall_oucamo"], RANDOM_BETWEEN(2,3)],
			["itm", "Medikit", RANDOM_BETWEEN(1,2)],
			["itm", "Toolkit", RANDOM_BETWEEN(0,1)],
			["itm", "MineDetector", RANDOM_BETWEEN(1,2)],
			["itm", "Laserdesignator", RANDOM_BETWEEN(1,2)],
			["itm", ["V_PlateCarrierIAGL_dgtl","V_TacVestIR_blk","V_TacVest_camo"], RANDOM_BETWEEN(2,3)],
			["itm", ["V_RebreatherB","V_RebreatherIR","V_RebreatherIA"], RANDOM_BETWEEN(1,2)],
			["itm", "U_B_GhillieSuit", RANDOM_BETWEEN(1,1)],
			["itm", "U_O_GhillieSuit", RANDOM_BETWEEN(1,1)],
			["itm", "U_I_GhillieSuit", RANDOM_BETWEEN(1,1)],
			["itm", ["G_mas_wpn_wrap_gog_t","G_mas_wpn_wrap_gog_f","G_mas_wpn_wrap_gog_c"], RANDOM_BETWEEN(2,3)],
			["itm", ["U_BG_leader","U_I_CombatUniform_tshirt","U_B_SpecopsUniform_sgg","U_I_OfficerUniform","U_O_OfficerUniform_ocamo","U_B_CombatUniform_mcam_tshirt"], RANDOM_BETWEEN(2,3)],
			["itm", ["H_HelmetB_camo","H_Bandanna_camo","H_Watchcap_camo","H_Cap_brn_SPECOPS","H_RacingHelmet_1_black_F"], RANDOM_BETWEEN(3,3)],
			["mag", ["ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(3,5)]
		];
	};
	
	
	case "mission_UAV":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["bpk", ["B_UAV_01_backpack_F"], RANDOM_BETWEEN(1,1)],
			["bpk", ["O_UAV_01_backpack_F"], RANDOM_BETWEEN(1,1)],
			["bpk", ["I_UAV_01_backpack_F"], RANDOM_BETWEEN(1,1)],
			["itm", ["B_UavTerminal"], RANDOM_BETWEEN(1,1)],
			["itm", ["O_UavTerminal"], RANDOM_BETWEEN(1,1)],
			["itm", ["I_UavTerminal"], RANDOM_BETWEEN(1,1)],
			["itm", ["optic_mas_term","optic_Nightstalker","optic_tws"], RANDOM_BETWEEN(0,2)],
			["wep", "launch_Titan_short_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)]
		];
	};
	
	case "mission_USLaunchers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["mas_launch_RPG7_F", "mas_launch_maaws_F", "mas_launch_Stinger_F"], RANDOM_BETWEEN(3,5), RANDOM_BETWEEN(1,2)],
			["wep", "mas_launch_M136_F", RANDOM_BETWEEN(1,2), RANDOM_BETWEEN(1,2)],
			["mag", ["ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag", "ATMine_Range_Mag", "DemoCharge_Remote_Mag", "SatchelCharge_Remote_Mag"], RANDOM_BETWEEN(3,8)]
		];
	};
	case "mission_USSpecial":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			//["itm", "NVGoggles", 5],
			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(1,5)],
			["itm", "Medikit", RANDOM_BETWEEN(1,3)],
			["itm", "Toolkit", RANDOM_BETWEEN(0,1)],
			["itm", ["optic_MRCO", "optic_Arco", "optic_Hamr", "optic_SOS"], RANDOM_BETWEEN(0,2)],
			["itm", ["muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "muzzle_snds_acp"], RANDOM_BETWEEN(0,3)],
			["wep", ["arifle_mas_saiga", "arifle_mas_mp5SD_e", "hgun_Pistol_heavy_02_F", "hgun_Pistol_heavy_02_Yorris_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(3,5)],
			["wep", ["srifle_mas_m91", "srifle_mas_svd_h", "srifle_mas_sr25_h"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["LMG_mas_Mk48_F_v_t", "LMG_mas_rpk_F"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(2,4)]
		];
	};
	case "mission_Main_A3snipers":
	{
		_boxItems =
		[
			// Item type, Item class(es), # of items, # of magazines per weapon
			["wep", ["srifle_mas_m24_v_h", "srifle_mas_m91", "srifle_mas_sr25_h", "srifle_mas_m107_v"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["srifle_mas_mk17s_h", "srifle_mas_m110_h"], RANDOM_BETWEEN(1,3), RANDOM_BETWEEN(4,6)],
			["wep", ["Binocular", "Rangefinder"], RANDOM_BETWEEN(1,3)],
			["itm", "optic_DMS", RANDOM_BETWEEN(1,2)]
		];
	};
};

[_box, _boxItems] call processItems;

