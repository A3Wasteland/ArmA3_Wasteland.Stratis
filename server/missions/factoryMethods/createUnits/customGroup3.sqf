//	@file Version: 1.0
//	@file Name: midGroup.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 21:58
//	@file Args:

if (!isServer) exitWith {};

private ["_group", "_pos", "_leader", "_man2", "_man3", "_man4", "_man_5", "_man6"];

_group = _this select 0;
_pos = _this select 1;

// Leader
_leader = _group createUnit ["C_man_polo_1_F", [(_pos select 0) + 10, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _leader;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_leader addUniform "U_I_GhillieSuit";
_leader addVest "V_TacVest_camo";
_leader addItemToVest "FirstAidKit";
_leader addBackpack "B_Carryall_oli";
_leader addWeapon "srifle_GM6_SOS_F";
_leader addMagazine "5Rnd_127x108_APDS_Mag";
_leader addMagazine "5Rnd_127x108_APDS_Mag";
_leader call setMissionSkill;
_leader addRating 1e11;
_leader addEventHandler ["Killed", server_playerDied];


// Soldier2
_man2 = _group createUnit ["C_man_polo_2_F", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man2;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man2 addUniform "U_I_GhillieSuit";
_man2 addVest "V_TacVest_camo";
_man2 addItemToVest "FirstAidKit";
_man2 addBackpack "B_Carryall_oli";
_man2 addMagazine "5Rnd_127x108_APDS_Mag";
_man2 addWeapon "srifle_GM6_SOS_F";
_man2 addMagazine "5Rnd_127x108_APDS_Mag";
_man2 call setMissionSkill;
_man2 addRating 1e11;
_man2 addEventHandler ["Killed", server_playerDied];


// Soldier3
_man3 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man3;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man3 addUniform "U_I_GhillieSuit";
_man3 addVest "V_TacVest_camo";
_man3 addBackpack "B_Carryall_oli";
_man3 addItemToVest "FirstAidKit";
_man3 addWeapon "srifle_EBR_SOS_F";
_man3 addMagazine "20Rnd_762x51_Mag";
_man3 addMagazine "20Rnd_762x51_Mag";	
_man3 call setMissionSkill;
_man3 addRating 1e11;
_man3 addEventHandler ["Killed", server_playerDied];


// Soldier4
_man4 = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems _man4;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man4 addUniform "U_I_GhillieSuit";
_man4 addVest "V_TacVest_camo";
_man4 addBackpack "B_Carryall_oli";
_man4 addItemToVest "FirstAidKit";
_man4 addWeapon "srifle_EBR_SOS_F";
_man4 addMagazine "20Rnd_762x51_Mag";
_man4 addMagazine "20Rnd_762x51_Mag";
_man4 call setMissionSkill;
_man4 addRating 1e11;
_man4 addEventHandler ["Killed", server_playerDied];

// Soldier5
_man5 = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems _man4;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man5 addUniform "U_I_GhillieSuit";
_man5 addVest "V_TacVest_camo";
_man5 addBackpack "B_Carryall_oli";
_man5 addItemToVest "FirstAidKit";
_man5 addWeapon "srifle_EBR_SOS_F";
_man5 addMagazine "20Rnd_762x51_Mag";
_man5 addMagazine "20Rnd_762x51_Mag";
_man5 call setMissionSkill;
_man5 addRating 1e11;
_man5 addEventHandler ["Killed", server_playerDied];


// Soldier6
_man6 = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems _man4;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man6 addUniform "U_I_GhillieSuit";
_man6 addVest "V_TacVest_camo";
_man6 addBackpack "B_Carryall_oli";
_man6 addItemToVest "FirstAidKit";
_man6 addWeapon "srifle_EBR_SOS_F";
_man6 addMagazine "20Rnd_762x51_Mag";
_man6 addMagazine "20Rnd_762x51_Mag";
_man6 call setMissionSkill;
_man6 addRating 1e11;
_man6 addEventHandler ["Killed", server_playerDied];

_leader = leader _group;
[_group, _pos] call defendArea;