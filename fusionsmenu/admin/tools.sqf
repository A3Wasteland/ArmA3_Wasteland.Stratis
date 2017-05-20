_pathtotools = "fusionsmenu\admin\tools\";
_pathtoweapon = "fusionsmenu\admin\weapons\";
_pathtovehicles = "fusionsmenu\admin\veh\";
_pathtosoldier= "fusionsmenu\admin\spawn\";
_EXECscript1 = 'player execVM "'+_pathtotools+'%1"';
_EXECscript3 = 'player execVM "'+_pathtoweapon+'%1"';
_EXECscript5 = 'player execVM "'+_pathtovehicles+'%1"';
_EXECscript6 = 'player execVM "'+_pathtosoldier+'%1"';


if ((getPlayerUID player) in ["76561198049621925","76561198049329273","76561198021648470"]) then { //all admins
	if ((getPlayerUID player) in ["76561198049621925","76561198049329273","76561198021648470"]) then { //Admins Go Here aswell
		adminmenu =
		[
			["Fusions Menu",true],
				["Tools", [2], "#USER:ToolsMenu", -5, [["expression", ""]], "1", "1"],
				["Cars", [3], "#USER:VehicleMenu", -5, [["expression", ""]], "1", "1"],
				["Weapons", [4], "#USER:WeaponMenu", -5, [["expression", ""]], "1", "1"],
				["Spawn Groups", [5], "#USER:Soldier", -5, [["expression", ""]], "1", "1"],
				//["", [-1], "", -5, [["expression", ""]], "1", "0"],
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
	    ["Boom!", [2],  "", -5, [["expression", format[_EXECscript1,"explode_target.sqf"]]], "1", "1"],
		["Repair", [3],  "", -5, [["expression", format[_EXECscript1,"repair_target.sqf"]]], "1", "1"],
		["Delete Vehicle", [4],  "", -5, [["expression", format[_EXECscript1,"delete.sqf"]]], "1", "1"],		
        ["Autoheal", [5],  "", -5, [["expression", format[_EXECscript1,"autoheal.sqf"]]], "1", "1"],
		["Heal Other Player", [6],  "", -5, [["expression", format[_EXECscript1,"healp.sqf"]]], "1", "1"],
		["Car God Mode", [7],  "", -5, [["expression", format[_EXECscript1,"cargod.sqf"]]], "1", "1"],
		//["Look And Repair", [8],  "", -5, [["expression", format[_EXECscript1,"looknrepair.sqf"]]], "1", "1"],
		["Repair Buildings", [9],  "", -5, [["expression", format[_EXECscript1,"fixbuildings.sqf"]]], "1", "1"],
		["Check Player Inv", [10],  "", -5, [["expression", format[_EXECscript1,"dayzesp.sqf"]]], "1", "1"],
		//["", [-1], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

WeaponMenu =
[
	["Weapons",true],
	//Add Weapons Here Gave some examples :D
		["AT Rockets", [2],  "", -5, [["expression", format[_EXECscript3,"titanr.sqf"]]], "1", "1"],
		["AA Rockets", [3],  "", -5, [["expression", format[_EXECscript3,"titanaar.sqf"]]], "1", "1"],
		["IED", [4],  "", -5, [["expression", format[_EXECscript3,"IED.sqf"]]], "1", "1"],
		["Titan AA", [5],  "", -5, [["expression", format[_EXECscript3,"titanaa.sqf"]]], "1", "1"],
		["GM6", [6],  "", -5, [["expression", format[_EXECscript3,"gm6.sqf"]]], "1", "1"],
		["Titan AT", [7],  "", -5, [["expression", format[_EXECscript3,"titanat.sqf"]]], "1", "1"],
		
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
		["ATV", [2],  "", -5, [["expression", format[_EXECscript5,"ATV.sqf"]]], "1", "1"],
		["Strider HMG", [3],  "", -5, [["expression", format[_EXECscript5,"strider.sqf"]]], "1", "1"],
		["Pawnee", [4],  "", -5, [["expression", format[_EXECscript5,"pawnee.sqf"]]], "1", "1"],
		["Qilin Minigun", [5], "", -5, [["expression", format[_EXECscript5,"hatchback.sqf"]]], "1", "1"],
		["Marshall", [6], "", -5, [["expression", format[_EXECscript5,"marshall.sqf"]]], "1", "1"],
		["Blackfoot", [7], "", -5, [["expression", format[_EXECscript5,"blackfoot.sqf"]]], "1", "1"],
			["Next page", [12], "#USER:VehicleMenu2", -5, [["expression", ""]], "1", "1"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];
VehicleMenu2 = 
[
	["Vehicles 2",true],
		["Example", [2],  "", -5, [["expression", format[_EXECscript5,"Example.sqf"]]], "1", "1"],
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
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
		
showCommandingMenu "#USER:adminmenu";