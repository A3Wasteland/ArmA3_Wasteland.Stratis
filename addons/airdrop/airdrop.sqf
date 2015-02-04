_empty = ["0"];
_pathtotools = "addons\airdrop\tools\";
_pathtoweapon = "addons\airdrop\weapons\";
_pathtovehicles = "addons\airdrop\veh\";
_pathtosoldier= "addons\airdrop\spawn\";
_EXECscript1 = 'player execVM "'+_pathtotools+'%1"';
_EXECscript3 = 'player execVM "'+_pathtoweapon+'%1"';
_EXECscript5 = 'player execVM "'+_pathtovehicles+'%1"';
_EXECscript6 = 'player execVM "'+_pathtosoldier+'%1"';

 	if (!((getPlayerUID player) in _empty)) then { //all admins
 	if (!((getPlayerUID player) in _empty)) then { //Admins Go Here aswell
	
		adminmenu =
		[
			["Fusions Menu",true],
				["Tools", [4], "#USER:ToolsMenu", -5, [["expression", ""]], "1", "1"],
				["Cars", [4], "#USER:VehicleMenu", -5, [["expression", ""]], "1", "1"],
				["Weapons", [5], "#USER:WeaponMenu", -5, [["expression", ""]], "1", "1"],
				["Spawn Groups", [5], "#USER:Soldier", -5, [["expression", ""]], "1", "1"],
				["", [-1], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]		
		];};
} else {
adminmenu =
[
	["",true],
		//["Toggle Debug", [2], "", -5, [["expression", format[_execdebug,"playerstats.sqf"]]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];};
ToolsMenu =
[
	["Tools",true],
        ["Teleport", [2],  "", -5, [["expression", format[_EXECscript1,"teleport.sqf"]]], "1", "1"],
		["Teleport Player To Me", [3],  "", -5, [["expression", format[_EXECscript1,"tptome.sqf"]]], "1", "1"],		
        ["God Mode", [4],  "", -5, [["expression", format[_EXECscript1,"god.sqf"]]], "1", "1"],
		["Car God Mode", [5],  "", -5, [["expression", format[_EXECscript1,"cargod.sqf"]]], "1", "1"],
		["Heal Self", [6],  "", -5, [["expression", format[_EXECscript1,"heal.sqf"]]], "1", "1"],
		["Heal Player(s)", [7],  "", -5, [["expression", format[_EXECscript1,"healp.sqf"]]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

WeaponMenu =
[
	["Weapons",true],
	//Add Weapons Here Gave some examples :D
		["MX", [2],  "", -5, [["expression", format[_EXECscript3,"mx.sqf"]]], "1", "1"],
		["MK 200", [3],  "", -5, [["expression", format[_EXECscript3,"mk200.sqf"]]], "1", "1"],
		["LRR", [4],  "", -5, [["expression", format[_EXECscript3,"lrr.sqf"]]], "1", "1"],
		["EBR", [5],  "", -5, [["expression", format[_EXECscript3,"ebr.sqf"]]], "1", "1"],
		["GM6", [6],  "", -5, [["expression", format[_EXECscript3,"gm6.sqf"]]], "1", "1"],
		["P07", [7],  "", -5, [["expression", format[_EXECscript3,"phgun.sqf"]]], "1", "1"],
		
			["Next page", [12], "#USER:WeaponMenu2", -5, [["expression", ""]], "1", "1"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];
WeaponMenu2 = 
[
	["Weapons 2",true],
	//Add Weapons Here Gave another page because it could get a little confusing :P
		["MX", [2],  "", -5, [["expression", format[_EXECscript3,"mx.sqf"]]], "1", "1"],
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
		
];
VehicleMenu = 
[
	["Vehicles",true],
		["ATV ($1,500)", [2],  "", -5, [["expression", format[_EXECscript5,"ATV.sqf"]]], "1", "1"],
		["Offroad HMG .50 ($5,000)", [3],  "", -5, [["expression", format[_EXECscript5,"offroad.sqf"]]], "1", "1"],
		["Boxer Refuel Truck ($15,000)", [4],  "", -5, [["expression", format[_EXECscript5,"boxerfuel.sqf"]]], "1", "1"],
		["Offroad Repair Vehicle ($15,000)", [5],  "", -5, [["expression", format[_EXECscript5,"repairoffroad.sqf"]]], "1", "1"],
		["Hunter HMG .50 ($30,000)", [6],  "", -5, [["expression", format[_EXECscript5,"hunter.sqf"]]], "1", "1"],
		["HEMTT Ammo Truck ($50,000)", [6],  "", -5, [["expression", format[_EXECscript5,"hemttammo.sqf"]]], "1", "1"],
		["AFV-4 Gorgon ($60,000)", [7],  "", -5, [["expression", format[_EXECscript5,"gorgon.sqf"]]], "1", "1"],
		["IFV-6a Cheetah AA ($80,000)", [8],  "", -5, [["expression", format[_EXECscript5,"cheetah.sqf"]]], "1", "1"],
		["M2A1 Slammer ($80,000)", [9],  "", -5, [["expression", format[_EXECscript5,"m2a1slammer.sqf"]]], "1", "1"],
			["Next page", [10], "#USER:Supports", -5, [["expression", ""]], "1", "1"],
			["Cancel Airdrop", [11], "", -3, [["expression", ""]], "1", "1"]
];
Supports = 
[
	["Supports",true],
		["Food Support Drop ($10,000)", [2],  "", -5, [["expression", format[_EXECscript5,"food.sqf"]]], "1", "1"],
		["Water Support Drop ($10,000)", [3],  "", -5, [["expression", format[_EXECscript5,"water.sqf"]]], "1", "1"],
		["Random Weapon Crate ($25,000)", [3],  "", -5, [["expression", format[_EXECscript5,"crate.sqf"]]], "1", "1"],
		["Cancel Airdrop", [11], "", -3, [["expression", ""]], "1", "1"]
];
Soldier = 
[
	["Spawner", true],
		["Select Spawn Position (OpFor)", [2],  "", -5, [["expression", format[_EXECscript6,"east.sqf"]]], "1", "1"],
		["Delete Previous Spawn Area (OpFor)", [3],  "", -5, [["expression", format[_EXECscript6,"deleteop.sqf"]]], "1", "1"],
		["Spawn(OpFor)", [4],  "", -5, [["expression", format[_EXECscript6,"eastsp.sqf"]]], "1", "1"],
		["Select Spawn Position (BluFor)", [5],  "", -5, [["expression", format[_EXECscript6,"west.sqf"]]], "1", "1"],
		["Delete Previous Spawn Area (BluFor)", [6],  "", -5, [["expression", format[_EXECscript6,"deletebl.sqf"]]], "1", "1"],
		["Spawn(BluFor)", [7],  "", -5, [["expression", format[_EXECscript6,"westsp.sqf"]]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];
		
showCommandingMenu "#USER:VehicleMenu";