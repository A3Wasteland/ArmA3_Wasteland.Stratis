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
	["GenStore1", -1, [], []],		//Agia Marina 
	["GenStore2", -1, [], []],		//Kamino 
	["GenStore3", -1, [], []],		//Rogain
	["GenStore4", -1, [], []],		//Airbase
	["GenStore5", -1, [], []],		//JayCove
	["GenStore6", -1, [], []],		//Walmart
	["GenStore7", -1, [], []],		//Abandoned Settlement

	["GunStore1", -1, [], []],		//Kamino
	["GunStore2", -1, [], []],		//KillFarm
	["GunStore3", -1, [], []],		//Agia Cephas
	["GunStore4", -1, [], []],		//Airbase
	["GunStore5", -1, [], []],		//Agia Marina
	["GunStore6", -1, [], []],		//Camp Maxwell
	["GunStore7", -1, [], []],		//Walmart
	

	// Buttons you can disable: "Land", "Armored", "Tanks", "Helicopters", "Boats", "Planes"
	["VehStore1", -1, [], ["Planes", "Helicopters"]],		//Kamino
	["VehStore2", -1, [], ["Boats"]],		//Airbase
	["VehStore3", -1, [], ["Boats", "Planes"]],		//Agios Ioannis
	["VehStore4", -1, [], ["Boats", "Planes"]],		//Agia Marina
	["VehStore5", -1, [], ["Boats", "Planes"]],		//Walmart
	["VehStore6", -1, [], ["Planes"]],				//Girna
    ["VehStore7", -1, [], ["Boats", "Planes", "Tanks"]],	//Rogain
	["VehStore8", -1, [], ["Land", "Armored", "Tanks"]]	//Kamino Aircraft Carrier
	
];

// Outfits for store owners
storeOwnerConfigAppearance = compileFinal str
[
	["GenStore1", [["weapon", ""], ["uniform", "U_IG_Guerilla2_2"]]],
	["GenStore2", [["weapon", ""], ["uniform", "U_IG_Guerilla2_3"]]],
	["GenStore3", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore6", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],
	["GenStore7", [["weapon", ""], ["uniform", "U_IG_Guerilla3_1"]]],

	["GunStore1", [["weapon", ""], ["uniform", "U_B_SpecopsUniform_sgg"]]],
	["GunStore2", [["weapon", ""], ["uniform", "U_O_SpecopsUniform_blk"]]],
	["GunStore3", [["weapon", ""], ["uniform", "U_I_CombatUniform_tshirt"]]],
	["GunStore4", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore5", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore6", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],
	["GunStore7", [["weapon", ""], ["uniform", "U_IG_Guerilla1_1"]]],

	["VehStore1", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore2", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore3", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore4", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore5", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore6", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore7", [["weapon", ""], ["uniform", "U_Competitor"]]],
	["VehStore8", [["weapon", ""], ["uniform", "U_Competitor"]]]
];
