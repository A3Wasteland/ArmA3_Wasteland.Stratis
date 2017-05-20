// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createRandomSoldierIS.sqf
/*
 * Creates a random civilian IS soldier.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_soldierTypes", 
		 "_uniformTypes", 
		 "_vestTypes", 
		 "_backpackTypes"
		 "_gogglesTypes",
		 "_weaponTypes", 
		 "_headgearTypes"
		 "_group", 
		 "_position", 
		 "_rank", 
		 "_soldier"];

_soldierTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_uniformTypes = ["U_C_Driver_4"];
_vestTypes = ["V_BandollierB_blk"];
_headgearTypes = ["H_Cap_blk_ION", "H_Cap_blk", "H_Cap_red",];
_backpackTypes = ["B_AssaultPack_blk"];
_gogglesTypes = ["G_Balaclava_TI_blk_F", "G_Balaclava_TI_G_blk_F", "G_Lowprofile","G_Bandanna_beast"];
_weaponTypes = ["LMG_Zafir_ARCO_F", "arifle_AKM_F", "arifle_AKS_F", "arifle_CTAR_GL_blk_F","arifle_SPAR_01_GL_blk_F"];

_group = _this select 0;
_position = _this select 1;
_rank = param [2, "", [""]];

_soldier = _group createUnit [_soldierTypes call BIS_fnc_selectRandom, _position, [], 0, "NONE"];
_soldier addUniform (_uniformTypes call BIS_fnc_selectRandom);
_soldier addVest (_vestTypes call BIS_fnc_selectRandom);
_soldier addHeadgear (_headgearTypes call BIS_fnc_selectRandom);
_soldier addGoggles (_gogglesTypes call BIS_fnc_selectRandom);
_soldier addBackpack (_backpackTypes call BIS_fnc_selectRandom);
[_soldier, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;

if (_rank != "") then
{
	_soldier setRank _rank;
};

_soldier spawn refillPrimaryAmmo;
_soldier spawn addMilCap;
_soldier call setMissionSkill;

_soldier addEventHandler ["Killed", server_playerDied];

_soldier
