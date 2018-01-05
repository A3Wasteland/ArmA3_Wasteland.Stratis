// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: onKeyPress.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args:

#define UNCONSCIOUS (player call A3W_fnc_isUnconscious)

private ["_key", "_shift", "_ctrl", "_alt", "_handled"];

_key = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;

_handled = false;

// ********** Hardcoded keys **********
// keycodes are defined in client\clientEvents\customKeys.sqf
switch (true) do
{
		case (_key == 2):
	{
		player SelectWeapon "arifle_ARX_blk_F";
		player SelectWeapon "arifle_ARX_hex_F";
		player SelectWeapon "arifle_ARX_ghex_F";
		player SelectWeapon "arifle_SPAR_02_blk_F";
		player SelectWeapon "arifle_SPAR_02_khk_F";
		player SelectWeapon "arifle_SPAR_02_snd_F";
		player SelectWeapon "arifle_CTARS_blk_F";
		player SelectWeapon "LMG_03_F";
		player SelectWeapon "arifle_SPAR_03_blk_F";
		player SelectWeapon "srifle_DMR_07_ghex_F";
		player SelectWeapon "srifle_DMR_07_hex_F";
		player SelectWeapon "srifle_DMR_07_blk_F";
		player SelectWeapon "arifle_AK12_GL_F";
		player SelectWeapon "arifle_AK12_F";
		player SelectWeapon "arifle_AKM_F";
		player SelectWeapon "arifle_AKS_F";
		player SelectWeapon "arifle_CTAR_GL_blk_F";
		player SelectWeapon "arifle_CTAR_blk_F";
		player SelectWeapon "arifle_SPAR_01_GL_snd_F";
		player SelectWeapon "arifle_SPAR_01_GL_khk_F";
		player SelectWeapon "arifle_SPAR_01_GL_blk_F";
		player SelectWeapon "arifle_SPAR_01_snd_F";
		player SelectWeapon "arifle_SPAR_01_khk_F";
		player SelectWeapon "arifle_SPAR_01_blk_F";
		player SelectWeapon "hgun_PDW2000_F";
		player SelectWeapon "SMG_02_F";
		player SelectWeapon "SMG_01_F";
		player SelectWeapon "arifle_SDAR_F";
		player SelectWeapon "arifle_Mk20C_plain_F";
		player SelectWeapon "arifle_Mk20C_F";
		player SelectWeapon "arifle_Mk20_plain_F";
		player SelectWeapon "arifle_Mk20_F";
		player SelectWeapon "arifle_Mk20_GL_plain_F";
		player SelectWeapon "arifle_Mk20_GL_F";
		player SelectWeapon "arifle_TRG20_F";
		player SelectWeapon "arifle_TRG21_F";
		player SelectWeapon "arifle_TRG21_GL_F";
		player SelectWeapon "arifle_Katiba_C_F";
		player SelectWeapon "arifle_Katiba_GL_F";
		player SelectWeapon "arifle_MXC_F";
		player SelectWeapon "arifle_MXC_Black_F";
		player SelectWeapon "arifle_MX_F";
		player SelectWeapon "arifle_MX_Black_F";
		player SelectWeapon "arifle_MX_GL_F";
		player SelectWeapon "arifle_MX_GL_Black_F";
		player SelectWeapon "arifle_MXM_F";
		player SelectWeapon "arifle_MXM_Black_F";
		player SelectWeapon "srifle_DMR_01_F";
		player SelectWeapon "srifle_EBR_F";
		player SelectWeapon "srifle_DMR_06_camo_F";
		player SelectWeapon "srifle_DMR_06_olive_F";
		player SelectWeapon "srifle_DMR_03_F";
		player SelectWeapon "srifle_DMR_03_multicam_F";
		player SelectWeapon "srifle_DMR_03_khaki_F";
		player SelectWeapon "srifle_DMR_03_tan_F";
		player SelectWeapon "srifle_DMR_03_woodland_F";
		player SelectWeapon "srifle_DMR_02_F";
		player SelectWeapon "srifle_DMR_02_camo_F";
		player SelectWeapon "srifle_DMR_02_sniper_F";
		player SelectWeapon "srifle_DMR_05_blk_F";
		player SelectWeapon "srifle_DMR_05_hex_F";
		player SelectWeapon "srifle_DMR_05_tan_f";
		player SelectWeapon "srifle_LRR_LRPS_F";
		player SelectWeapon "srifle_LRR_camo_LRPS_F";
		player SelectWeapon "srifle_GM6_LRPS_F";
		player SelectWeapon "srifle_GM6_camo_LRPS_F";
		player SelectWeapon "srifle_DMR_04_F";
		player SelectWeapon "srifle_DMR_04_tan_F";
		player SelectWeapon "arifle_MX_SW_F";
		player SelectWeapon "arifle_MX_SW_Black_F";
		player SelectWeapon "LMG_Mk200_F";
		player SelectWeapon "LMG_Zafir_F";
		player SelectWeapon "MMG_01_tan_F";
		player SelectWeapon "MMG_01_hex_F";
		player SelectWeapon "MMG_02_sand_F";
		player SelectWeapon "MMG_02_camo_F";
		player SelectWeapon "MMG_02_black_F";
		player SelectWeapon "srifle_GM6_ghex_LRPS_F";
		player SelectWeapon "srifle_LRR_tna_LRPS_F";
		player SelectWeapon "arifle_SPAR_03_snd_F";
		player SelectWeapon "arifle_SPAR_03_khk_F";
	};
	case (_key == 3):
	{
		player SelectWeapon "hgun_P07_F";
		player SelectWeapon "hgun_Rook40_F";
		player SelectWeapon "hgun_ACPC2_F";
		player SelectWeapon "hgun_Pistol_heavy_02_F";
		player SelectWeapon "hgun_Pistol_heavy_01_F";
		player SelectWeapon "hgun_Pistol_01_F";
		player SelectWeapon "hgun_P07_khk_F";
	};
	case (_key == 4):
	{
		player SelectWeapon "launch_RPG32_F";
		player SelectWeapon "launch_RPG32_ghex_F";
		player SelectWeapon "launch_RPG7_F";
		player SelectWeapon "launch_NLAW_F";
		player SelectWeapon "launch_Titan_short_F";
		player SelectWeapon "launch_O_Titan_short_F";
		player SelectWeapon "launch_I_Titan_short_F";
		player SelectWeapon "launch_Titan_F";
		player SelectWeapon "launch_O_Titan_F";
		player SelectWeapon "launch_I_Titan_F";
		player SelectWeapon "launch_B_Titan_short_tna_F";
		player SelectWeapon "launch_B_Titan_tna_F";
		player SelectWeapon "launch_O_Titan_ghex_F";
		player SelectWeapon "launch_O_Titan_short_ghex_F";
	};
	// Emergency Eject - Del Key
	case (_key == 211):
	{	
		[-9, false, true, ""] execVM "client\actions\forceEject.sqf";
	};
	
	// U key
	case (_key in A3W_customKeys_adminMenu):
	{
		execVM "client\systems\adminPanel\checkAdmin.sqf";
	};

	// Tilde (key above Tab)
	case (_key in A3W_customKeys_playerMenu):
	{
		if (alive player && !UNCONSCIOUS) then { [] spawn loadPlayerMenu } else { [] call A3W_fnc_killFeedMenu };
		_handled = true;
	};

	// Home & Windows keys
	case (_key in A3W_customKeys_playerNames):
	{
		showPlayerNames = if (isNil "showPlayerNames") then { true } else { !showPlayerNames };
	};

	// Earplugs - End Key
	case (_key in A3W_customKeys_earPlugs):
	{
		if (soundVolume > 0.5) then
		{
			0.5 fadeSound 0.2;
			["You've inserted your earplugs.", 5] call mf_notify_client;
		}
		else
		{
			0.5 fadeSound 1;
			["You've taken out your earplugs.", 5] call mf_notify_client;
		};
	};
};

// ********** Action keys **********

if (!UNCONSCIOUS) then // ####################
{

//Holster / recall weapon.
if (!_handled && _key == 35) then
{
	if(vehicle player == player && currentWeapon player != "") then {
		curWep_h = currentWeapon player;
		player action ["SwitchWeapon", player, player, 100];
	}
	
	else
	{
		if(curWep_h in [primaryWeapon player,secondaryWeapon player,handgunWeapon player]) then {
			player selectWeapon curWep_h;
		};
	};
};

// Parachute
if (!_handled && _key in actionKeys "GetOver") then
{
	if (!alive player) exitWith {};

	_veh = vehicle player;

	if (_veh == player) exitWith
	{
		// allow opening parachute only above 2.5m
		if ((getPos player) select 2 > 2.5) then
		{
			true call A3W_fnc_openParachute;
			_handled = true;
		};
	};

	// 1 sec cooldown after parachute is deployed so you don't start falling again if you double-tap the key
	if (_veh isKindOf "ParachuteBase" && (isNil "A3W_openParachuteTimestamp" || {diag_tickTime - A3W_openParachuteTimestamp >= 1})) then
	{
		moveOut player;
		_veh spawn
		{
			sleep 1;
			deleteVehicle _this;
		};
	};
};

// Eject
if (!_handled && _key in actionKeys "GetOut") then
{
	_veh = vehicle player;

	if (alive player && _veh != player) then
	{
		if (_ctrl && {_veh isKindOf 'Air' && !(_veh isKindOf 'ParachuteBase')}) then
		{
			[] spawn
			{
				if !(["Are you sure you want to eject?", "Confirm", true, true] call BIS_fnc_guiMessage) exitWith {};
				[[], fn_emergencyEject] execFSM "call.fsm";
			};
			
			_handled = true;
		};
	};
};
// Override prone reload freeze (ffs BIS)
if (!_handled && _key in (actionKeys "MoveDown" + actionKeys "MoveUp")) then
{
	if ((toLower animationState player) find "reloadprone" != -1) then
	{
		[player, format ["AmovPknlMstpSrasW%1Dnon", [player, true] call getMoveWeapon]] call switchMoveGlobal;
		reload player;
	};
};

} // ####################
else // UNCONSCIOUS
{
	if (_key == 57) then // spacebar
	{
		execVM "client\functions\confirmSuicide.sqf";
		_handled = true;
	};

	if (_key == 14) then // backspace
	{
		execVM "addons\far_revive\FAR_lastResort.sqf";
		_handled = true;
	};
};

// Scoreboard
if (!_handled && _key in actionKeys "NetworkStats") then
{
	if (_key != 25 || // 25 = P
	   ((!_ctrl || {!(486539289 in actionKeys "NetworkPlayers") && isNil "TFAR_fnc_TaskForceArrowheadRadioInit"}) && // 486539289 = Left Ctrl + P
	   (!_shift || {!(704643042 in actionKeys "NetworkPlayers")}))) then // 704643042 = Left Shift + P
	{
		if (alive player && isNull (uiNamespace getVariable ["ScoreGUI", displayNull])) then
		{
			call loadScoreboard;
		};

		_handled = true;
	};
};

// Push-to-talk
if (!_handled && _key in call A3W_allVoiceChatKeys) then
{
	[true] call fn_voiceChatControl;
};

// UAV feed
if (!_handled && _key in (actionKeys "UavView" + actionKeys "UavViewToggle")) then
{
	if (["A3W_disableUavFeed"] call isConfigOn) then
	{
		_handled = true;
	};
};

// Block 3rd person and group cam while injured
if (!_handled && _key in (actionKeys "PersonView" + actionKeys "TacticalView")) then
{
	if (UNCONSCIOUS) then
	{
		_handled = true;
	};
};

_handled
