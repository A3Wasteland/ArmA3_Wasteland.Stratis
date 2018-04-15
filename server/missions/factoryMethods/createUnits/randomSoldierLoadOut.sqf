/*
	----------------------------------------------------------------------------------------------
	
	Copyright © 2016 soulkobk (soulkobk.blogspot.com)
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Affero General Public License for more details.
	You should have received a copy of the GNU Affero General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.
	
	----------------------------------------------------------------------------------------------
	
	Name: randomSoldierLoadOut.sqf
	Version: 1.0.1
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 2:20 PM 10/10/2016
	Modification Date: 2:20 PM 10/10/2016
	
	Description:
	For use with A3Wasteland 1.Xx mission (A3Wasteland.com). This script is for custom AI loadouts,
	for usage within missions.
	
	Place this script into folder...
	\server\missions\factoryMethods\createUnits\randomSoldierLoadOut.sqf
	
	Then add...
	randomSoldierLoadOut = [_path, "createUnits\randomSoldierLoadOut.sqf"] call mf_compile;
	
	To...
	\server\functions\serverCompile.sqf
	
	Underneath the line...
	_path = "server\missions\factoryMethods";

	Then in each of your createUnits files, for example...
	\server\missions\factoryMethods\createUnits\customGroup.sqf
	\server\missions\factoryMethods\createUnits\customGroup2.sqf
	\server\missions\factoryMethods\createUnits\createRandomSoldier.sqf
	\server\missions\factoryMethods\createUnits\createRandomSoldierC.sqf
	
	You need to remove the old load out for AI and add in...
	[_soldier] call randomSoldierLoadOut;
	
	*Or leave the original code as-is and add the above line to the end of each of those scripts
	(before the last "_soldier" line) to override the _soldier's load out with 100% random gear.
	
	This script will load out each AI unit randomly with...
	
	+ Uniform (default/guarenteed addition)
	+ Head Gear (percentage chance addition)
	+ Vest (percentage chance addition)
	+ Back Pack (percentage chance addition)
	+ Primary Weapon (default/guarenteed addition)
	+ Primary Weapon Muzzle (percentage chance addition)
	+ Primary Weapon Pointer (percentage chance addition)
	+ Primary Weapon Optic (percentage chance addition)
	+ Health Kit(s) (percentage chance addition) - unit will also have 'Medic' trait
	+ Grenade(s) (percentage chance addition)
	+ Rocket Launcher (percentage chance addition) - unit will also have a back pack added
	
	*See the percentage chance per AI unit below (changable configuration).
	*See _opticsDisallow option to REMOVE optics from the random optic list.
	
	Changeable configuration below.
	
	Parameter(s): [<unit>] call randomSoldierLoadOut;
	Example: [_soldier] call randomSoldierLoadOut;
	
	Change Log:
	1.0.0 -	original base script.
	1.0.1 -	corrected _opticsDisallow default entries.
	1.0.2 -	corrected typo at setUnitTrait.
	
	----------------------------------------------------------------------------------------------
*/

if !(isServer) exitWith {}; // DO NOT DELETE THIS LINE!

_headGearProbability = 65; // 65% chance
_vestProbability = 100; // 100% chance
_backpackProbability = 25; // 25% chance
_muzzleProbability = 35; // 35% chance
_pointerProbability = 25; // 25% chance
_opticProbability = 45; // 45% chance
_healthProbability = 25; // 25% chance
_grenadeProbability = 35; // 35% chance
_launcherProbability = 15; // 15% chance

_healthAmount = (round (random 4) + 1); // minimum 1, maximum 5
_grenadeAmount = (round (random 4) + 1); // minimum 1, maximum 5

_weaponMagazineAmount = (round(random 4) + 2); // minimum 2, maximum 6
_launcherMagazineAmount = (round(random 3) + 3); // minimum 3, maximum 6

_primaryWeapons = // .45, 9mm, 5.45mm, 5.56mm, 5.8mm and 6.5mm ONLY! NO OP WEAPONS!
[
	"arifle_AKS_F", // AKS-74U 5.45 mm
	"arifle_CTARS_blk_F", // CAR-95-1 5.8mm (Black)
	"arifle_CTAR_blk_F", // CAR-95 5.8 mm (Black)
	"arifle_Katiba_C_F", // Katiba Carbine 6.5 mm
	"arifle_Katiba_F", // Katiba 6.5 mm
	"arifle_Mk20C_plain_F", // Mk20C 5.56 mm
	"arifle_Mk20_plain_F", // Mk20 5.56 mm
	"arifle_MXC_Black_F", // MXC 6.5 mm (Black)
	"arifle_MXC_F", // MXC 6.5 mm
	"arifle_MXM_Black_F", // MXM 6.5 mm (Black)
	"arifle_MXM_F", // MXM 6.5 mm
	"arifle_MX_Black_F", // MX 6.5 mm (Black)
	"arifle_MX_F", // MX 6.5 mm
	"arifle_MX_SW_Black_F", // MX SW 6.5 mm (Black)
	"arifle_MX_SW_F", // MX SW 6.5 mm
	"arifle_SDAR_F", // SDAR 5.56 mm
	"arifle_SPAR_01_blk_F", // SPAR-16 5.56 mm (Black)
	"arifle_SPAR_02_blk_F", // SPAR-16S 5.56 mm (Black)
	"arifle_TRG20_F", // TRG-20 5.56 mm
	"arifle_TRG21_F", // TRG-21 5.56 mm
	"hgun_PDW2000_F", // PDW2000 9 mm
	"LMG_03_F", // LIM-85 5.56 mm
	"LMG_Mk200_BI_F", // Mk200 6.5 mm
	"LMG_Mk200_F", // Mk200 6.5 mm
	"SMG_01_F", // Vermin SMG .45 ACP
	"SMG_02_F", // Sting 9 mm
	"SMG_05_F", // Protector 9 mm
	"srifle_DMR_07_blk_F" // CMR-76 6.5 mm (Black)
];

_launcherWeapons =
[
	"launch_B_Titan_F", // Titan MPRL (Sand)
	"launch_I_Titan_short_F", // Titan MPRL Compact (Olive)
	"launch_NLAW_F", // PCML
	"launch_RPG32_F", // RPG-42 Alamut
	"launch_RPG7_F" // RPG-7
];

_uniforms =
[
	// "U_BG_Guerilla1_1", // Guerilla Garment
	// "U_BG_Guerilla2_1", // Guerilla Outfit (Plain, Dark)
	// "U_BG_Guerilla2_2", // Guerilla Outfit (Pattern)
	// "U_BG_Guerilla2_3", // Guerilla Outfit (Plain, Light)
	// "U_BG_Guerilla3_1", // Guerilla Smocks
	// "U_BG_Guerrilla_6_1", // Guerilla Apparel
	// "U_BG_leader", // Guerilla Uniform
	"U_B_CombatUniform_mcam", // Combat Fatigues (MTP)
	"U_B_CombatUniform_mcam_tshirt", // Combat Fatigues (MTP) (Tee)
	// "U_B_CombatUniform_mcam_vest", // Recon Fatigues (MTP)
	// "U_B_CombatUniform_mcam_worn", // Worn Combat Fatigues (MTP)
	"U_B_CTRG_1", // CTRG Combat Uniform
	"U_B_CTRG_2", // CTRG Combat Uniform (Tee)
	"U_B_CTRG_3", // CTRG Combat Uniform (Rolled-up)
	"U_B_CTRG_Soldier_2_F", // CTRG Stealth Uniform (Tee)
	"U_B_CTRG_Soldier_3_F", // CTRG Stealth Uniform (Rolled-up)
	"U_B_CTRG_Soldier_F", // CTRG Stealth Uniform
	"U_B_CTRG_Soldier_urb_1_F", // CTRG Urban Uniform
	"U_B_CTRG_Soldier_urb_2_F", // CTRG Urban Uniform (Tee)
	"U_B_CTRG_Soldier_urb_3_F", // CTRG Urban Uniform (Rolled-up)
	"U_B_FullGhillie_ard", // Full Ghillie (Arid) [NATO]
	"U_B_FullGhillie_lsh", // Full Ghillie (Lush) [NATO]
	"U_B_FullGhillie_sard", // Full Ghillie (Semi-Arid) [NATO]
	"U_B_GEN_Commander_F", // Gendarmerie Commander Uniform
	"U_B_GEN_Soldier_F", // Gendarmerie Uniform
	"U_B_GhillieSuit", // Ghillie Suit [NATO]
	"U_B_HeliPilotCoveralls", // Heli Pilot Coveralls [NATO]
	"U_B_PilotCoveralls", // Pilot Coveralls [NATO]
	"U_B_Protagonist_VR", // VR Suit [NATO]
	"U_B_survival_uniform", // Survival Fatigues
	"U_B_T_FullGhillie_tna_F", // Full Ghillie (Jungle) [NATO]
	"U_B_T_Sniper_F", // Ghillie Suit (Tropic) [NATO]
	"U_B_T_Soldier_AR_F", // Combat Fatigues (Tropic, Tee)
	"U_B_T_Soldier_F", // Combat Fatigues (Tropic)
	"U_B_T_Soldier_SL_F", // Recon Fatigues (Tropic)
	// "U_B_Wetsuit", // Wetsuit [NATO]
	"U_Competitor", // Competitor Suit
	"U_I_CombatUniform", // Combat Fatigues [AAF]
	"U_I_CombatUniform_shortsleeve", // Combat Fatigues [AAF] (Rolled-up)
	"U_I_C_Soldier_Para_1_F", // Paramilitary Garb (Tee)
	"U_I_C_Soldier_Para_2_F", // Paramilitary Garb (Jacket)
	"U_I_C_Soldier_Para_3_F", // Paramilitary Garb (Shirt)
	"U_I_C_Soldier_Para_4_F", // Paramilitary Garb (Tank Top)
	"U_I_C_Soldier_Para_5_F", // Paramilitary Garb (Shorts)
	// "U_I_FullGhillie_ard", // Full Ghillie (Arid) [AAF]
	// "U_I_FullGhillie_lsh", // Full Ghillie (Lush) [AAF]
	// "U_I_FullGhillie_sard", // Full Ghillie (Semi-Arid) [AAF]
	"U_I_GhillieSuit", // Ghillie Suit [AAF]
	"U_I_HeliPilotCoveralls", // Heli Pilot Coveralls [AAF]
	"U_I_OfficerUniform", // Combat Fatigues [AAF] (Officer)
	"U_I_pilotCoveralls", // Pilot Coveralls [AAF]
	// "U_I_Wetsuit", // Wetsuit [AAF]
	"U_O_CombatUniform_ocamo", // Fatigues (Hex) [CSAT]
	"U_O_CombatUniform_oucamo", // Fatigues (Urban) [CSAT]
	// "U_O_FullGhillie_ard", // Full Ghillie (Arid) [CSAT]
	// "U_O_FullGhillie_lsh", // Full Ghillie (Lush) [CSAT]
	// "U_O_FullGhillie_sard", // Full Ghillie (Semi-Arid) [CSAT]
	"U_O_GhillieSuit", // Ghillie Suit [CSAT]
	"U_O_OfficerUniform_ocamo", // Officer Fatigues (Hex)
	"U_O_PilotCoveralls", // Pilot Coveralls [CSAT]
	"U_O_SpecopsUniform_ocamo", // Recon Fatigues (Hex)
	// "U_O_T_FullGhillie_tna_F", // Full Ghillie (Jungle) [CSAT]
	"U_O_T_Officer_F", // Officer Fatigues (Green Hex) [CSAT]
	"U_O_T_Sniper_F", // Ghillie Suit (Green Hex) [CSAT]
	"U_O_T_Soldier_F" // Fatigues (Green Hex) [CSAT]
	// "U_O_V_Soldier_Viper_F", // Special Purpose Suit (Green Hex)
	// "U_O_V_Soldier_Viper_hex_F", // Special Purpose Suit (Hex)
	// "U_O_Wetsuit", // Wetsuit [CSAT]
];

_vests =
[
	"V_BandollierB_blk", // Slash Bandolier (Black)
	"V_BandollierB_cbr", // Slash Bandolier (Coyote)
	"V_BandollierB_ghex_F", // Slash Bandolier (Green Hex)
	"V_BandollierB_khk", // Slash Bandolier (Khaki)
	"V_BandollierB_oli", // Slash Bandolier (Olive)
	"V_BandollierB_rgr", // Slash Bandolier (Green)
	"V_Chestrig_blk", // Chest Rig (Black)
	"V_Chestrig_khk", // Chest Rig (Khaki)
	"V_Chestrig_oli", // Chest Rig (Olive)
	"V_Chestrig_rgr", // Chest Rig (Green)
	"V_HarnessOGL_brn", // LBV Grenadier Harness
	"V_HarnessOGL_ghex_F", // LBV Grenadier Harness (Green Hex)
	"V_HarnessOGL_gry", // LBV Grenadier Harness (Grey)
	"V_HarnessO_brn", // LBV Harness
	"V_HarnessO_ghex_F", // LBV Harness (Green Hex)
	"V_HarnessO_gry", // LBV Harness (Grey)
	"V_I_G_resistanceLeader_F", // Tactical Vest (Stavrou)
	"V_PlateCarrier1_blk", // Carrier Lite (Black)
	"V_PlateCarrier1_rgr", // Carrier Lite (Green)
	"V_PlateCarrier1_rgr_noflag_F", // Carrier Lite (Green, No Flag)
	"V_PlateCarrier1_tna_F", // Carrier Lite (Tropic)
	"V_PlateCarrier2_blk", // Carrier Rig (Black)
	"V_PlateCarrier2_rgr", // Carrier Rig (Green)
	"V_PlateCarrier2_rgr_noflag_F", // Carrier Rig (Green, No Flag)
	"V_PlateCarrier2_tna_F", // Carrier Rig (Tropic)
	"V_PlateCarrierGL_blk", // Carrier GL Rig (Black)
	"V_PlateCarrierGL_mtp", // Carrier GL Rig (MTP)
	"V_PlateCarrierGL_rgr", // Carrier GL Rig (Green)
	"V_PlateCarrierGL_tna_F", // Carrier GL Rig (Tropic)
	"V_PlateCarrierH_CTRG", // CTRG Plate Carrier Rig Mk.2 (Heavy)
	"V_PlateCarrierIA1_dgtl", // GA Carrier Lite (Digi)
	"V_PlateCarrierIA2_dgtl", // GA Carrier Rig (Digi)
	"V_PlateCarrierIAGL_dgtl", // GA Carrier GL Rig (Digi)
	"V_PlateCarrierIAGL_oli", // GA Carrier GL Rig (Olive)
	"V_PlateCarrierL_CTRG", // CTRG Plate Carrier Rig Mk.1 (Light)
	"V_PlateCarrierSpec_blk", // Carrier Special Rig (Black)
	"V_PlateCarrierSpec_mtp", // Carrier Special Rig (MTP)
	"V_PlateCarrierSpec_rgr", // Carrier Special Rig (Green)
	"V_PlateCarrierSpec_tna_F", // Carrier Special Rig (Tropic)
	"V_PlateCarrier_Kerry", // US Plate Carrier Rig (Kerry)
	"V_Rangemaster_belt", // Rangemaster Belt
	"V_TacChestrig_cbr_F", // Tactical Chest Rig (Coyote)
	"V_TacChestrig_grn_F", // Tactical Chest Rig (Green)
	"V_TacChestrig_oli_F", // Tactical Chest Rig (Olive)
	"V_TacVestIR_blk", // Raven Vest
	"V_TacVest_blk", // Tactical Vest (Black)
	"V_TacVest_brn", // Tactical Vest (Brown)
	"V_TacVest_camo", // Tactical Vest (Camo)
	"V_TacVest_gen_F", // Gendarmerie Vest
	"V_TacVest_khk", // Tactical Vest (Khaki)
	"V_TacVest_oli" // Tactical Vest (Olive)
];

_headGear =
[
	"H_HelmetB", // Combat Helmet
	"H_HelmetB_black", // Combat Helmet (Black)
	"H_HelmetB_camo", // Combat Helmet (Camo)
	"H_HelmetB_desert", // Combat Helmet (Desert)
	"H_HelmetB_Enh_tna_F", // Enhanced Combat Helmet (Tropic)
	"H_HelmetB_grass", // Combat Helmet (Grass)
	"H_HelmetB_light", // Light Combat Helmet
	"H_HelmetB_light_black", // Light Combat Helmet (Black)
	"H_HelmetB_light_desert", // Light Combat Helmet (Desert)
	"H_HelmetB_light_grass", // Light Combat Helmet (Grass)
	"H_HelmetB_light_sand", // Light Combat Helmet (Sand)
	"H_HelmetB_light_snakeskin", // Light Combat Helmet (Snakeskin)
	"H_HelmetB_Light_tna_F", // Light Combat Helmet (Tropic)
	"H_HelmetB_sand", // Combat Helmet (Sand)
	"H_HelmetB_snakeskin", // Combat Helmet (Snakeskin)
	"H_HelmetB_tna_F", // Combat Helmet (Tropic)
	"H_HelmetCrew_B", // Crew Helmet [NATO]
	"H_HelmetCrew_I", // Crew Helmet [AAF]
	"H_HelmetCrew_O", // Crew Helmet [CSAT]
	"H_HelmetCrew_O_ghex_F", // Crew Helmet (Green Hex) [CSAT]
	"H_HelmetIA", // Modular Helmet
	"H_HelmetLeaderO_ghex_F", // Defender Helmet (Green Hex)
	"H_HelmetLeaderO_ocamo", // Defender Helmet (Hex)
	"H_HelmetLeaderO_oucamo", // Defender Helmet (Urban)
	"H_HelmetO_ghex_F", // Protector Helmet (Green Hex)
	"H_HelmetO_ocamo", // Protector Helmet (Hex)
	"H_HelmetO_oucamo", // Protector Helmet (Urban)
	"H_HelmetSpecB", // Enhanced Combat Helmet
	"H_HelmetSpecB_blk", // Enhanced Combat Helmet (Black)
	"H_HelmetSpecB_paint1", // Enhanced Combat Helmet (Grass)
	"H_HelmetSpecB_paint2", // Enhanced Combat Helmet (Desert)
	"H_HelmetSpecB_sand", // Enhanced Combat Helmet (Sand)
	"H_HelmetSpecB_snakeskin", // Enhanced Combat Helmet (Snakeskin)
	"H_HelmetSpecO_blk", // Assassin Helmet (Black)
	"H_HelmetSpecO_ghex_F", // Assassin Helmet (Green Hex)
	"H_HelmetSpecO_ocamo" // Assassin Helmet (Hex)
];

_backPacks =
[
	"B_AssaultPack_blk", // Assault Pack (Black)
	"B_AssaultPack_cbr", // Assault Pack (Coyote)
	"B_AssaultPack_dgtl", // Assault Pack (Digi)
	"B_AssaultPack_khk", // Assault Pack (Khaki)
	"B_AssaultPack_mcamo", // Assault Pack (MTP)
	"B_AssaultPack_ocamo", // Assault Pack (Hex)
	"B_AssaultPack_rgr", // Assault Pack (Green)
	"B_AssaultPack_sgg", // Assault Pack (Sage)
	"B_AssaultPack_tna_F", // Assault Pack (Tropic)
	"B_Carryall_cbr", // Carryall Backpack (Coyote)
	"B_Carryall_ghex_F", // Carryall Backpack (Green Hex)
	"B_Carryall_khk", // Carryall Backpack (Khaki)
	"B_Carryall_mcamo", // Carryall Backpack (MTP)
	"B_Carryall_ocamo", // Carryall Backpack (Hex)
	"B_Carryall_oli", // Carryall Backpack (Olive)
	"B_Carryall_oucamo", // Carryall Backpack (Urban)
	"B_FieldPack_blk", // Field Pack (Black)
	"B_FieldPack_cbr", // Field Pack (Coyote)
	"B_FieldPack_ghex_F", // Field Pack (Green Hex)
	"B_FieldPack_khk", // Field Pack (Khaki)
	"B_FieldPack_ocamo", // Field Pack (Hex)
	"B_FieldPack_oli", // Field Pack (Olive)
	"B_FieldPack_oucamo", // Field Pack (Urban)
	"B_Kitbag_cbr", // Kitbag (Coyote)
	"B_Kitbag_mcamo", // Kitbag (MTP)
	"B_Kitbag_rgr", // Kitbag (Green)
	"B_Kitbag_sgg", // Kitbag (Sage)
	"B_TacticalPack_blk", // Tactical Backpack (Black)
	"B_TacticalPack_mcamo", // Tactical Backpack (MTP)
	"B_TacticalPack_ocamo", // Tactical Backpack (Hex)
	"B_TacticalPack_oli", // Tactical Backpack (Olive)
	"B_TacticalPack_rgr", // Tactical Backpack (Green)
	"B_ViperHarness_blk_F", // Viper Harness (Black)
	"B_ViperHarness_ghex_F", // Viper Harness (Green Hex)
	"B_ViperHarness_hex_F", // Viper Harness (Hex)
	"B_ViperHarness_khk_F", // Viper Harness (Khaki)
	"B_ViperHarness_oli_F", // Viper Harness (Olive)
	"B_ViperLightHarness_blk_F", // Viper Light Harness (Black)
	"B_ViperLightHarness_ghex_F", // Viper Light Harness (Green Hex)
	"B_ViperLightHarness_hex_F", // Viper Light Harness (Hex)
	"B_ViperLightHarness_khk_F", // Viper Light Harness (Khaki)
	"B_ViperLightHarness_oli_F" // Viper Light Harness (Olive)
];

_opticsDisallow =
[
	// "optic_Aco", // ACO (Red)
	// "optic_ACO_grn", // ACO (Green)
	// "optic_ACO_grn_smg", // ACO SMG (Green)
	// "optic_Aco_smg", // ACO SMG (Red)
	"optic_AMS", // AMS (Black)
	"optic_AMS_khk", // AMS (Khaki)
	"optic_AMS_snd", // AMS (Sand)
	// "optic_Arco", // ARCO
	// "optic_Arco_blk_F", // ARCO (Black)
	// "optic_Arco_ghex_F", // ARCO (Green Hex)
	"optic_DMS", // DMS
	"optic_DMS_ghex_F", // DMS (Green Hex)
	// "optic_ERCO_blk_F", // ERCO (Black)
	// "optic_ERCO_khk_F", // ERCO (Khaki)
	// "optic_ERCO_snd_F", // ERCO (Sand)
	// "optic_Hamr", // RCO
	// "optic_Hamr_khk_F", // RCO (Khaki)
	// "optic_Holosight", // Mk17 Holosight
	// "optic_Holosight_blk_F", // Mk17 Holosight (Black)
	// "optic_Holosight_khk_F", // Mk17 Holosight (Khaki)
	// "optic_Holosight_smg", // Mk17 Holosight SMG
	// "optic_Holosight_smg_blk_F", // Mk17 Holosight SMG (Black)
	"optic_KHS_blk", // Kahlia (Black)
	"optic_KHS_hex", // Kahlia (Hex)
	"optic_KHS_old", // Kahlia (Old)
	"optic_KHS_tan", // Kahlia (Tan)
	"optic_LRPS", // LRPS
	"optic_LRPS_ghex_F", // LRPS (Green Hex)
	"optic_LRPS_tna_F", // LRPS (Tropic)
	// "optic_MRCO", // MRCO
	// "optic_MRD", // MRD
	"optic_Nightstalker", // Nightstalker
	"optic_NVS", // NVS
	"optic_SOS", // MOS
	"optic_SOS_khk_F", // MOS (Khaki)
	"optic_tws", // TWS
	"optic_tws_mg" // TWS MG
	// "optic_Yorris" // Yorris J2
];

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

_soldier = _this select 0;

removeUniform _soldier;
removeHeadgear _soldier:
removeGoggles _soldier;
removeVest _soldier;
removeBackpack _soldier;
removeAllWeapons _soldier;
removeAllAssignedItems _soldier;
removeAllItems _soldier;

_soldierUniform = selectRandom _uniforms;
_soldier addUniform _soldierUniform;

if ((_headGearProbability > random 99) || (_headGearProbability == 100)) then
{
	_soldierHeadgear = selectRandom _headGear;
	_soldier addHeadgear _soldierHeadgear;
};

if ((_vestProbability > random 99) || (_vestProbability == 100)) then
{
	_soldierVest = selectRandom _vests;
	_soldier addVest _soldierVest;
};

if ((_backpackProbability > random 99) || (_backpackProbability == 100)) then
{
	_soldierBackpack = selectRandom _backPacks;
	_soldier addBackPack _soldierBackpack;
};

if ((_launcherProbability > random 99) || (_launcherProbability == 100)) then
{
	if (isNull (unitBackpack _soldier)) then
	{
		_soldierBackpack = selectRandom _backPacks;
		_soldier addBackPack _soldierBackpack;
	};
	_soldierLauncherWeapon = selectRandom _launcherWeapons;
	_soldierLauncherWeaponAdd = [_soldier, _soldierLauncherWeapon, _launcherMagazineAmount] call BIS_fnc_addWeapon;
};

_soldierPrimaryWeapon = selectRandom _primaryWeapons;
_soldierPrimaryWeaponAdd = [_soldier, _soldierPrimaryWeapon, _weaponMagazineAmount] call BIS_fnc_addWeapon;

if ((_muzzleProbability > random 99) || (_muzzleProbability == 100)) then
{
	_soldierPrimaryMuzzles = []; _soldierPrimaryMuzzles = getArray (configFile >> "CfgWeapons" >> _soldierPrimaryWeapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
	if ((count _soldierPrimaryMuzzles) >= 1) then
	{
		_soldierPrimaryMuzzle = selectRandom _soldierPrimaryMuzzles;
		_soldier addPrimaryWeaponItem _soldierPrimaryMuzzle;
	};
};

if ((_pointerProbability > random 99) || (_pointerProbability == 100)) then
{
	_soldierPrimaryPointers = []; _soldierPrimaryPointers = getArray (configFile >> "CfgWeapons" >> _soldierPrimaryWeapon >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
	if ((count _soldierPrimaryPointers) >= 1) then
	{
		_soldierPrimaryPointer = selectRandom _soldierPrimaryPointers;
		_soldier addPrimaryWeaponItem _soldierPrimaryPointer;
	};
};

if ((_opticProbability > random 99) || (_opticProbability == 100)) then
{
	_soldierPrimaryOptics = []; _soldierPrimaryOptics = getArray (configFile >> "CfgWeapons" >> _soldierPrimaryWeapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
	_soldierPrimaryOptics = _soldierPrimaryOptics - _opticsDisallow;
	if ((count _soldierPrimaryOptics) >= 1) then
	{
		_soldierPrimaryOptic = selectRandom _soldierPrimaryOptics;
		_soldier addPrimaryWeaponItem _soldierPrimaryOptic;
	};
};

if ((_healthProbability > random 99) || (_healthProbability == 100)) then
{
	for "_i" from 1 to _healthAmount do
	{
		_soldier addItem "FirstAidKit";
		_soldier setUnitTrait ["Medic",true];
	};
};

if ((_grenadeProbability > random 99) || (_grenadeProbability == 100)) then
{
	_soldier addMagazines ["HandGrenade", _grenadeAmount];
};
