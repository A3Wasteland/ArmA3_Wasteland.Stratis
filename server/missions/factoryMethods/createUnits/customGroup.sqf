// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: customGroup.sqf
//  @file Author: AgentRev
 
if (!isServer) exitWith {};
 
private ["_group", "_pos", "_nbUnits", "_unitTypes", "_uPos", "_unit"];
 
_group = _this select 0;
_pos = _this select 1;
_nbUnits = param [2, 7, [0]];
_radius = param [3, 10, [0]];
 
_unitTypes =
[
    "C_man_polo_1_F", "C_man_polo_1_F_euro", "C_man_polo_1_F_afro", "C_man_polo_1_F_asia",
    "C_man_polo_2_F", "C_man_polo_2_F_euro", "C_man_polo_2_F_afro", "C_man_polo_2_F_asia",
    "C_man_polo_3_F", "C_man_polo_3_F_euro", "C_man_polo_3_F_afro", "C_man_polo_3_F_asia",
    "C_man_polo_4_F", "C_man_polo_4_F_euro", "C_man_polo_4_F_afro", "C_man_polo_4_F_asia",
    "C_man_polo_5_F", "C_man_polo_5_F_euro", "C_man_polo_5_F_afro", "C_man_polo_5_F_asia",
    "C_man_polo_6_F", "C_man_polo_6_F_euro", "C_man_polo_6_F_afro", "C_man_polo_6_F_asia"
];
 
for "_i" from 1 to _nbUnits do
{
    _uPos = _pos vectorAdd ([[random _radius, 0, 0], random 360] call BIS_fnc_rotateVector2D);
    _unit = _group createUnit [(selectRandom _unitTypes), _uPos, [], 0, "Form"];
    _unit setPosATL _uPos;
 
    [_unit] call randomSoldierLoadOut;
 
    _unit addPrimaryWeaponItem "acc_flashlight";
    _unit enablegunlights "forceOn";
 
    _unit addRating 1e11;
    _unit spawn addMilCap;
    _unit spawn refillPrimaryAmmo;
    _unit call setMissionSkill;
    _unit addEventHandler ["Killed", server_playerDied];
};
 
[_group, _pos] call defendArea;
