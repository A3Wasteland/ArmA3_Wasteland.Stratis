// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createArmedCiv.sqf

if (!isServer) exitWith {};

private ["_weaponTypes", "_group", "_position", "_civillian"];
								
_weaponTypes = 
				["arifle_AK12_GL_F",
				"arifle_TRG21_GL_F",
				"LMG_Zafir_F",
				"MMG_01_tan_F",
				"SMG_01_F",
				"SMG_02_F",
				"arifle_SDAR_F",
				"arifle_MK20C_F",
				"launch_Titan_F",
				"launch_Titan_short_F",
				"arifle_MK20_F",
				"arifle_TRG20_F",
				"arifle_TRG21_F"];
					
_group = _this select 0;
_position = _this select 1;

_civillian = _group createUnit ["C_man_1", _position, [], 0, "NONE"];

_civillian additem "NVGoggles";
_civillian assignitem "NVGoggles";				// unassign and remove NVG if they have them

//removeAllWeapons _civillian;
//removeAllItems _civillian;
//removeAllAssignedItems _civillian;
//removeUniform _civillian;
//removeVest _civillian;
//removeBackpack _civillian;
sleep 0.1;
//removeHeadgear _civillian;
//removeGoggles _civillian;

_civillian forceAddUniform "U_IG_Guerilla2_1";
_civillian addWeapon "hgun_Pistol_heavy_02_F";
_civillian addBackpack "B_Carryall_oli";
_civillian addItemtoBackpack "FirstAidKit";
_civillian addItemtoBackpack "Titan_AT";
_civillian addItemtoBackpack "Titan_AA";
_civillian addVest "V_PlateCarrierGL_mtp";
_civillian addItemToVest "6Rnd_45ACP_Cylinder";
_civillian addItemToVest "6Rnd_45ACP_Cylinder";
_civillian addItemToVest "HandGrenade";
_civillian addItemToVest "HandGrenade";
_civillian addItemtoBackpack "SatchelCharge_Remote_Mag";

[_civillian, _weaponTypes call BIS_fnc_selectRandom, 3] call BIS_fnc_addWeapon;
_civillian addPrimaryWeaponItem "acc_flashlight";
_civillian enablegunlights "forceOff";					//set to "forceOn" to force use of lights (during day too default = AUTO)

_civillian spawn refillPrimaryAmmo;


//_civillian call setMissionSkill;						// not for mission :P
_civillian setBehaviour "COMBAT";

//_civillian setSkill ["aimingspeed", 1];
//_civillian setSkill ["spotdistance", 1];
//_civillian setSkill ["aimingaccuracy", 1];
//_civillian setSkill ["aimingshake", 1];
//_civillian setSkill ["spottime", 1];
//_civillian setSkill ["spotdistance", 1];
//_civillian setSkill ["commanding", 1];
//_civillian setSkill ["general", 1];
_civillian allowFleeing 0;

_civillian addEventHandler ["Killed", server_playerDied];

_civillian



