// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
	["mission_Convoy", 0.75],
	["mission_APC", 1],
	["mission_MBT", 0.50],
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 0.50],
	["mission_ArmedJet", 0.50],
	["mission_CivHeli", 1],
	["mission_ArmedDiversquad", 0.50]

];

SideMissions =
[
	["mission_HostileHelicopter", 0.40],
	["mission_HostileJet", 0.40],
	["mission_MiniConvoy", 0.75],
	["mission_Outpost", 1],
	["mission_Truck", 1],
	["mission_HostileInfantry", 0.50],
	["mission_Sniper", 0.50] ,
	["mission_Roadblock", 1]

];

MoneyMissions =
[
	["mission_MoneyShipment", 0.50],
	["mission_SunkenTreasure", 0.50],
	["mission_HackLaptop", 0.75]

];
MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;

MissionSpawnMarkers = [];
SunkenMissionMarkers = [];
{
	switch (true) do
	{
		case (["Mission_", _x] call fn_startsWith):
		{
			MissionSpawnMarkers pushBack [_x, false];
		};
		case (["SunkenMission_", _x] call fn_startsWith):
		{
			SunkenMissionMarkers pushBack [_x, false];
		};
	};
} forEach allMapMarkers;

LandConvoyPaths = [];
{
	LandConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf");

CoastalConvoyPaths = [];
{
	CoastalConvoyPaths pushBack [_x, false];
} forEach (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf");
