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
	["Town_1",200,"Air Station Mike-28"],
	["Town_2",100,"Agios Loannis"],
	["Town_3",100,"Agios Cephas"],
	["Town_4",200,"Girna"],			
	["Town_5",200,"Camp Tempest"],
	["Town_6",300,"Stratis Airbase Town"],
	["Town_7",250,"Stratis Airbase Runway"],
	["Town_8",350,"Agia Marina"],
	["Town_9",250,"Kill Farm"],
	["Town_10",200,"Camp Rogain"],
	["Town_11",230,"Kamino Firing Range"],
	["Town_12",240,"Camp Maxwell"],
	["Town_13",150,"ol-Kamino"],
	["Town_14",15,"Isla Pythos"],  // do not increase radius, else vehicles and objects will spawn on the island!
	["Town_15",100,"Baldy Barracks"],
	["Town_16",175,"ol-Keiros"],			
	["Town_17",175,"Tsoukalia"],
	["Town_18",100,"LZ Connor"],
	["Town_19",180,"Playa-del-Stragos"],
	["Town_20",250,"ol-Jay"]
];

militarylist = compileFinal str
[
	["milSpawn_1"],
	["milSpawn_2"],
	["milSpawn_3"]
];

cityLocations = [];

config_items_jerrycans_max = compileFinal "1";
config_items_syphon_hose_max = compileFinal "1";

config_refuel_amount_default = compileFinal "0.25";
config_refuel_amounts = compileFinal str
[
	["Quadbike_01_base_F", 0.50],
	["Tank", 0.10],
	["Air", 0.10]
];

// Is player saving enabled?
config_player_saving_enabled = compileFinal "0";

// Can players get extra in-game cash at spawn by donating?
config_player_donations_enabled = compileFinal "0";

// How much do players spawn with?
config_initial_spawn_money = compileFinal "100";

// Territory system definitions. See territory/README.md for more details.
//
// Format is:
// 1 - Territory marker name. Must begin with 'TERRITORY_'
// 2 - Descriptive name
// 3 - Monetary value
// 4 - Territory category, currently unused. See territory/README.md for details.
config_territory_markers = compileFinal str
[
	//["TERRITORY_AIRPORT_TEST", "Main Airport", 500, "AIRFIELD"] // Also add to the map to test
];

