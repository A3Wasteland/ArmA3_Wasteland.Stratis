//	@file Version: 1.0
//	@file Name: config.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:13
//	@file Description: Main config.

// For SERVER CONFIG, values are in server\init.sqf

// Towns and cities array
// Marker Name, Diameter, City Name
cityList = compileFinal str
[
	["Town_1", 200, "Air Station Mike-28"],
	["Town_2", 100, "Agios Loannis"],
	["Town_3", 100, "Agios Cephas"],
	["Town_4", 200, "Girna"],
	["Town_5", 200, "Camp Tempest"],
	["Town_6", 300, "Stratis Airbase Town"],
	["Town_7", 250, "Stratis Airbase Runway"],
	["Town_8", 350, "Agia Marina"],
	["Town_9", 250, "Kill Farm"],
	["Town_10", 200, "Camp Rogain"],
	["Town_11", 230, "Kamino Firing Range"],
	["Town_12", 240, "Camp Maxwell"],
	["Town_13", 150, "ol-Kamino"],
	//["Town_14", 15, "Isla Pythos"],  // do not increase radius, else vehicles and objects will spawn on the island! // who the heck thought a town on an island was a good idea!?
	["Town_15", 100, "Baldy Barracks"],
	["Town_16", 175, "ol-Keiros"],
	["Town_17", 175, "Tsoukalia"],
	["Town_18", 100, "LZ Connor"],
	["Town_19", 180, "Playa-del-Stragos"],
	["Town_20", 250, "ol-Jay"]
];

/*
militarylist = compileFinal str
[
	["milSpawn_1"],
	["milSpawn_2"],
	["milSpawn_3"]
];
*/

config_items_jerrycans_max = compileFinal "1";
config_items_syphon_hose_max = compileFinal "1";

config_refuel_amount_default = compileFinal "0.25";
config_refuel_amounts = compileFinal str
[
	["Quadbike_01_base_F", 0.50],
	["Tank", 0.10],
	["Air", 0.10]
];

// NOTE: Player saving and money settings moved to external config (A3Wasteland_settings\main_config.sqf), default values are set in server\default_config.sqf

// Is player saving enabled?
// config_player_saving_enabled = compileFinal "0";

// How much do players spawn with?
// config_initial_spawn_money = compileFinal "100";

// Territory system definitions. See territory/README.md for more details.
//
// Format is:
// 1 - Territory marker name. Must begin with 'TERRITORY_'
// 2 - Descriptive name
// 3 - Monetary value
// 4 - Territory category, currently unused. See territory/README.md for details.
config_territory_markers = compileFinal str
[
	["TERRITORY_AGIA_NORTH", "North Agia Marina", 200, "TOWN"],
	["TERRITORY_AGIA_SOUTH", "South Agia Marina", 200, "TOWN"],
	["TERRITORY_AGIOS_CEPHAS", "Agios Cephas", 200, "TOWN"],
	["TERRITORY_AGIOS_IOANNIS", "Agios Ioannis", 200, "TOWN"],
	["TERRITORY_AIRBASE_NORTH", "North Stratis Airbase", 500, "AIRBASE"],
	["TERRITORY_AIRBASE_SOUTH", "South Stratis Airbase", 500, "AIRBASE"],
	["TERRITORY_AIRSTATION_MIKE", "Air Station Mike", 200, "MILITARY"],
	["TERRITORY_CAMP_MAXWELL", "Camp Maxwell", 200, "MILITARY"],
	["TERRITORY_CAMP_ROGAIN", "Camp Rogain", 200, "MILITARY"],
	["TERRITORY_CAMP_TEMPEST", "Camp Tempest", 200, "MILITARY"],
	["TERRITORY_GIRNA", "Girna", 200, "TOWN"],
	["TERRITORY_JAY_COVE", "Jay Cove", 200, "TOWN"],
	["TERRITORY_KAMINO_FIRING_RANGE", "Kamino Firing Range", 200, "MILITARY"],
	["TERRITORY_KAMINO_SETTLEMENT", "Kamino Settlement", 200, "TOWN"],
	["TERRITORY_KILL_FARM", "Kill Farm", 200, "TOWN"],
	["TERRITORY_LIMERI_BAY", "Limeri Bay", 200, "TOWN"],
	["TERRITORY_LZ_BALDY", "LZ Baldy", 200, "MILITARY"],
	["TERRITORY_LZ_CONNOR", "LZ Connor", 200, "MILITARY"],
	["TERRITORY_PYTHOS", "Pythos Island", 200, "ISLAND"],
	["TERRITORY_RADIO_TOWERS", "Radio Towers", 200, "MILITARY"]
];

