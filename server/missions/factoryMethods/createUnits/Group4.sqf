//	@file Version: 1.0
//	@file Name: midGroup.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 21:58
//	@file Args:

if (!isServer) exitWith {};

private ["_group", "_pos", "_leader", "_man2", "_man3", "_man4", "_man5", "_man6"];

_group = _this select 0;
_pos = _this select 1;

// Leader
_leader = _group createUnit ["C_man_polo_1_F", [(_pos select 0) + 10, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _leader;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_leader addUniform "U_C_Driver_1_black";
_leader addVest "V_BandollierB_blk";
_leader addBackpack "B_Carryall_oli";
_leader addMagazine "30Rnd_mas_556x45_T_Stanag";
_leader addWeapon "arifle_mas_hk416_e";
_leader addPrimaryWeaponItem "optic_Hamr";
_leader addMagazine "30Rnd_mas_556x45_T_Stanag";
_leader addMagazine "30Rnd_mas_556x45_T_Stanag";
_leader addMagazine "Titan_AA";
_leader addWeapon "launch_B_Titan_F";
_leader addMagazine "Titan_AA";
_leader addHeadgear "H_ShemagOpen_khk";
_leader addGoggles "G_Bandanna_blk";
_leader call setMissionSkill;
_leader addRating 1e11;
_leader addEventHandler ["Killed", server_playerDied];


// Soldier2
_man2 = _group createUnit ["C_man_polo_2_F", [(_pos select 0) - 30, _pos select 1, 0], [], 1, "Form"];
removeAllAssignedItems _man2;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man2 addUniform "U_C_Driver_1_black";
_man2 addVest "V_BandollierB_blk";
_man2 addBackpack "B_Carryall_oli";
_man2 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man2 addWeapon "arifle_mas_hk416_e";
_man2 addPrimaryWeaponItem "optic_Hamr";
_man2 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man2 addMagazine "Titan_AA";
_man2 addWeapon "launch_B_Titan_F";
_man2 addMagazine "Titan_AA";
_man2 addHeadgear "H_ShemagOpen_khk";
_man2 addGoggles "G_Bandanna_blk";
_man2 call setMissionSkill;
_man2 addRating 1e11;
_man2 addEventHandler ["Killed", server_playerDied];


// Soldier3
_man3 = _group createUnit ["C_man_polo_3_F", [_pos select 0, (_pos select 1) + 30, 0], [], 1, "Form"];
removeAllAssignedItems _man3;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man3 addUniform "U_C_Driver_1_black";
_man3 addVest "V_BandollierB_blk";
_man3 addBackpack "B_Carryall_oli";
_man3 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man3 addWeapon "arifle_mas_hk416_e";
_man3 addPrimaryWeaponItem "optic_Hamr";
_man3 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man3 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man3 addHeadgear "H_ShemagOpen_khk";
_man3 addGoggles "G_Bandanna_blk";
_man3 call setMissionSkill;
_man3 addRating 1e11;
_man3 addEventHandler ["Killed", server_playerDied];


// Soldier4
_man4 = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems _man4;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man4 addUniform "U_C_Driver_1_black";
_man4 addVest "V_BandollierB_blk";
_man4 addBackpack "B_Carryall_oli";
_man4 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man4 addWeapon "arifle_mas_hk416_e";
_man4 addPrimaryWeaponItem "optic_Hamr";
_man4 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man4 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man4 addHeadgear "H_ShemagOpen_khk";
_man4 addGoggles "G_Bandanna_blk";
_man4 call setMissionSkill;
_man4 addRating 1e11;
_man4 addEventHandler ["Killed", server_playerDied];


// Soldier5
_man5 = _group createUnit ["C_man_polo_5_F", [_pos select 0, (_pos select 1) + 40, 0], [], 1, "Form"];
removeAllAssignedItems _man5;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man5 addUniform "U_C_Driver_1_black";
_man5 addVest "V_BandollierB_blk";
_man5 addBackpack "B_Carryall_oli";
_man5 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man5 addWeapon "arifle_mas_hk416_e";
_man5 addPrimaryWeaponItem "optic_Hamr";
_man5 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man5 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man5 addHeadgear "H_ShemagOpen_khk";
_man5 addGoggles "G_Bandanna_blk";
_man5 call setMissionSkill;
_man5 addRating 1e11;
_man5 addEventHandler ["Killed", server_playerDied];


// Soldier6
_man6 = _group createUnit ["C_man_polo_4_F", [_pos select 0, (_pos select 1) - 30, 0], [], 1, "Form"];
removeAllAssignedItems _man6;
sleep 0.1; // Without this delay, headgear doesn't get removed properly
_man6 addUniform "U_C_Driver_1_black";
_man6 addVest "V_BandollierB_blk";
_man6 addBackpack "B_Carryall_oli";
_man6 addWeapon "arifle_mas_hk416_e";
_man6 addPrimaryWeaponItem "optic_Hamr";
_man6 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man6 addMagazine "30Rnd_mas_556x45_T_Stanag";
_man6 addHeadgear "H_ShemagOpen_khk";
_man6 addGoggles "G_Bandanna_blk";
_man6 call setMissionSkill;
_man6 addRating 1e11;
_man6 addEventHandler ["Killed", server_playerDied];

_leader = leader _group;
[_group, _pos] call defendArea;