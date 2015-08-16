// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: storeOwners.sqf
//	@file Author: AgentRev, JoSchaap, His_Shadow

// Notes: Gun and general stores have position of spawned crate, vehicle stores have an extra air spawn direction
//
// Array contents are as follows:
// Name, Building Position, Desk Direction (or [Desk Direction, Front Offset]), Excluded Buttons
storeOwnerConfig = compileFinal str
[
	["GenStore1", 2, 260, []], // Agia Marina
	["GenStore2", 4, 310, []], // Kamino Firing Range
	["GenStore4", 1, 80, []], // Wal-Mart
	["GenStore5", 1, 115, []], // Jay Cove
	["GenStore6", 1, 340, []], // Rogain
	["GenStore7", 2, 15, []], // Airfield
	["GenStore8", 0, 359, []], // Valley

	["GunStore1", 0, 195, []], // Airfield
	["GunStore2", 0, 130, []], // KillFarm
	["GunStore3", 5, 85, []], // Dixie
	["GunStore4", 2, 315, []], // Kamino Firing Range
	["GunStore5", 1, 330, []], // Maxwell
	["GunStore6", 1, 210, []], // Agia Marina
	["GunStore9", 5, 85, ["Armament"]], // Wal-Mart

	// Buttons you can disable: "Land", "Armored", "Tanks", "Helicopters", "Boats", "Planes"
	["VehStore1", 0, 195, ["Planes"]], // Kamino
	["VehStore2", 2, 285, ["Boats"]], // Airfield
	["VehStore3", 4, 340, ["Planes"]], // Girna
	["VehStore4", 3, 240, ["Planes","Boats"]], // Wal-Mart
	["VehStore5", 2, 130, ["Planes","Boats"]], // Agia Marina
	["VehStore6", 1, 42, ["Planes","Boats"]] // Agios Loannis
	
];

// Outfits for store owners
storeOwnerConfigAppearance = compileFinal str
[
	["GenStore1", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore2", [["weapon", ""], ["uniform", "U_IG_Guerilla2_3"]]],
	["GenStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore6", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore7", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore8", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],

	["GunStore1", [["weapon", ""], ["uniform", "U_B_SpecopsUniform_sgg"]]],
	["GunStore2", [["weapon", ""], ["uniform", "U_O_SpecopsUniform_blk"]]],
	["GunStore3", [["weapon", ""], ["uniform", "U_I_CombatUniform_tshirt"]]],
	["GunStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore6", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore9", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],

	["VehStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore3", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore4", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore5", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore6", [["weapon", ""], ["uniform", "U_Competitor"]]]
];