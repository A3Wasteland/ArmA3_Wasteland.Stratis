// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: payload.sqf
//	@file Author: AgentRev, Tonic, AWA (OpenDayZ.net)
//	@file Created: 01/06/2013 21:31

// This file can be moved to "A3Wasteland_settings\antihack" in order to be loaded externally from the server, which removes the need for it to be in the mission PBO

if (isServer || !hasInterface) exitWith {};

params ["_flagChecksum", "_rscParams"];
private ["_cheatFlag", "_cfgPatches", "_escCheck", "_patchClass", "_patchName", "_ctrlCfg", "_memAnomaly", "_currentRecoil", "_loopCount"];

waitUntil {!isNull player};

// diag_log "ANTI-HACK starting...";

_cfgPatches = configFile >> "CfgPatches";
_escCheck = true;

for "_i" from 0 to (count _cfgPatches - 1) do
{
	_patchClass = _cfgPatches select _i;

	if (isClass _patchClass) then
	{
		_patchName = toLower configName _patchClass;

		if (_patchName in ["devcon","loki_lost_key"]) exitWith
		{
			_cheatFlag = ["hacking addon", configName _patchClass];
		};

		if (_patchName in
		[
			"rhs_main", // RHS - Game Options
			"mcc_sandbox", // MCC keys
			"agm_core", // AGM Options
			"ace_optionsmenu", // ACE Options
			"alive_ui" // ALiVE
		])
		then { _escCheck = false };
	};
};

if (isNil "_cheatFlag" && _escCheck) then
{
	{
		for "_i" from 0 to (count _x - 1) do
		{
			_ctrlCfg = _x select _i;
			if (getText (_ctrlCfg >> "action") != "" || getText (_ctrlCfg >> "onButtonClick") != "") exitWith
			{
				_cheatFlag = ["hack menu", format ["foreign Esc menu button '%1'", (getText (_ctrlCfg >> "text")) select [0, 64]]];
			};
		};

		if (!isNil "_cheatFlag") exitWith {};
	}
	forEach
	[
		configFile >> "RscDisplayMPInterrupt" >> "controls",
		configFile >> "RscDisplayMPInterrupt" >> "controlsBackground"
	];
};

if (isNil "_cheatFlag") then
{
	// Hack menu validator based on Tonic's SpyGlass
	_flagChecksum spawn
	{
		disableSerialization;
		scopeName "sendFlag";
		private "_cheatFlag";

		_flagChecksum = _this;

		while {true} do
		{
			{
				if (!isNull findDisplay (_x select 0)) then
				{
					_cheatFlag = _x select 1;
					breakTo "sendFlag";
				};
			}
			forEach
			[
				[19, "RscDisplayIPAddress"],
				[30, "RscDisplayTemplateLoad (Gladtwoown)"],
				[32, "RscDisplayIntel"],
				[64, "RscDisplayPassword (ShadowyFaze)"],
				[69, "RscDisplayPort"],
				[71, "RscDisplayFilter (Gladtwoown)"],
				[125, "RscDisplayEditDiaryRecord (Gladtwoown)"],
				[132, "RscDisplayHostSettings"],
				[165, "RscDisplayPublishMission"],
				[166, "RscDisplayPublishMissionSelectTags (Gladtwoown)"],
				[167, "RscDisplayFileSelect (Lystic)"],
				[2727, "RscDisplayLocWeaponInfo"],
				[3030, "RscConfigEditor_Main (ShadowyFaze)"]
			];

			_isAdmin = serverCommandAvailable "#kick";

			if (!isNull (findDisplay 49 displayCtrl 0)) exitWith { _cheatFlag = "RscDisplayInterruptEditorPreview" };
			if (!isNull findDisplay 17 && !isServer && !_isAdmin) exitWith { _cheatFlag = "RscDisplayRemoteMissions (Wookie)" };
			if (!isNull findDisplay 316000 && !_isAdmin) exitWith { _cheatFlag = "Debug console" }; // RscDisplayDebugPublic
			//if (!isNull (uiNamespace getVariable ["RscDisplayArsenal", displayNull]) && !_isAdmin) exitWith { _cheatFlag = "Virtual Arsenal" };
			if (!isNull findDisplay 157 && isNull (uiNamespace getVariable ["RscDisplayModLauncher", displayNull])) exitWith { _cheatFlag = "RscDisplayPhysX3Debug" };

			_display = findDisplay 54;
			if (!isNull _display) then
			{
				sleep 0.5;
				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayInsertMarker (JME)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1001) != toLower localize "STR_A3_RscDisplayInsertMarker_Title"),
					{if !(buttonAction (_display displayCtrl _x) in ["","call A3W_fnc_markerLogInsert"]) exitWith {true}; false} forEach [1,2]
				];
			};

			_display = findDisplay 148;
			if (!isNull _display) then
			{
				sleep 0.5;
				{
					(_display displayCtrl _x) ctrlRemoveAllEventHandlers "LBDblClick";
					(_display displayCtrl _x) ctrlRemoveAllEventHandlers "LBSelChanged";
				} forEach [103, 104];

				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayConfigureControllers (JME)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1001) != toLower localize "str_opt_customizable_controllers"),
					(toLower ctrlText (_display displayCtrl 1002) != toLower localize "str_opt_controllers_scheme")
				];
			};

			_display = findDisplay 131;
			if (!isNull _display) then
			{
				sleep 0.5;
				(_display displayCtrl 102) ctrlRemoveAllEventHandlers "LBDblClick";
				(_display displayCtrl 102) ctrlRemoveAllEventHandlers "LBSelChanged";

				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayConfigureAction";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1000) != toLower localize "STR_A3_RscDisplayConfigureAction_Title"),
					{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,104,105,106,107,108,109]
				];
			};

			_display = findDisplay 163;
			if (!isNull _display) then
			{
				sleep 0.5;
				(_display displayCtrl 101) ctrlRemoveAllEventHandlers "LBDblClick";
				(_display displayCtrl 101) ctrlRemoveAllEventHandlers "LBSelChanged";

				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayControlSchemes (JME)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(toLower ctrlText (_display displayCtrl 1000) != toLower localize "STR_DISP_OPTIONS_SCHEME"),
					{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1,2]
				];
			};

			_display = findDisplay 129;
			if (!isNull _display) then
			{
				sleep 0.5;
				{
					if (_x && !isNull _display) then
					{
						_cheatFlag = "RscDisplayDiary (Molaron)";
						breakTo "sendFlag";
					};
				}
				forEach
				[
					(ctrlText (_display displayCtrl 1111) == "Namespace:"),
					{if (buttonAction (_display displayCtrl _x) != "") exitWith {true}; false} forEach [1600,1601,1602]
				];
			};

			sleep 1;
		};

		[player, "hack menu", _cheatFlag, _flagChecksum] remoteExecCall ["A3W_fnc_flagHandler", 2];

		waitUntil {alive player};

		[getPlayerUID player, _flagChecksum] call A3W_fnc_clientFlagHandler;
	};

	// Fix mag duping glitch
	0 spawn
	{
		waitUntil {!isNil "A3W_clientSetupComplete"};
		waitUntil
		{
			_cfg = configfile >> "CfgWeapons" >> currentWeapon player;

			if (getNumber (_cfg >> "type") == 8^4 && {(vehicle player) currentWeaponTurret ((assignedVehicleRole player) param [1,[-1]]) == "" && ["camera_get_weapon_info", false] call getPublicVar}) then
			{
				_target = configName _cfg;
				_mag = currentMagazine player;
				player removeWeapon _target;
				[player, _mag] call fn_forceAddItem;
				player addWeapon _target;
				player selectWeapon _target;
			};

			false
		};
	};

	// Decode _rscParams
	{
		_x set [1, toString (_x select 1)];
		_x set [2, toString (_x select 2)];
	} forEach _rscParams;
};

// diag_log "ANTI-HACK: Starting loop!";

_loopCount = 12; // _loopCount >= 12 means every minute

while { true } do
{
	waitUntil {time > 0};

	if (_loopCount >= 12) then
	{
		if (isNil "_cheatFlag") then
		{
			{
				if (!isNil _x) exitWith
				{
					// diag_log "ANTI-HACK: Found a hack variable!";

					_cheatFlag = ["hack variable", _x];
				};
				sleep 0.01;
			} forEach [
					"DurkSintax_Pro_RE", "iBeFlying", "dayz_godmode", "var_curCheatMenu", "Main_Fury_Menu_", "Hack_Pos_Orig", "REdasfsfwef", "ly_re_onetime", "XXMMWW_keybinds",
					"FUNMENUON", "JJMMEE_INIT_MENU", "activeITEMlistanzahl", "Detected_Remote_Execution", "O_fnc_quickGod", "g0dmode", "Pro_RE", "FireTide_Menu", "fn_runCheat",
					"xyzaa", "GOLDENS_GLOBAL_SHIT_YEAH", "HaxSmokeOn", "Lysto_Lyst", "pathtoscrdir", "ewrfdfcsf", "Ug8YtyGyvguGF", "LYSTIC_MENU_LOADED", "qofjqpofq", "c0lorthem",
					"shnmenu", "letmeknow", "DAYZ_CA1_Lollipops", "TONIC_HAS_A_GAPER_NUKE_2", "fazelist", "S_NyanCat_Toggle", "faze_fill", "PL4YER_CANN0N_T0GGLE", "aKTitans",
					"Fury_Are_G0ds", "LY_Exec", "bulshaaaatyB3", "inf_ammo_loop_infiSTAR", "youoiuoiasdfsd8433fadsfasd_Koko__hkeys", "Wookie_Pro_RE", "nook3_vars", "Wookie_Init_Menu",
					"TTT5OptionNR", "Team_Fury_Reck_Prebs", "faze_funcs_inited", "mein1", "biggies_pro_re", "godlol", "Lystic_Init", "FAG_NEON", "Lystic_Exec", "faze_getControl",
					"Fanatic_Menu", "vehicleg0dv3_BushWookie", "earthBob", "t0ggl3", "morphm3", "fsdddInfectLOL", "cargod", "Init_Menu_Fury", "fn_loadlife", "abcdefGEH", "RandyRandRanderson",
					"Wep_Spawn_Shitt", "Fury_Nuke", "SimpA3MNU", "faze_hax_dbclick", "LY_Init", "W00kie_Pro_RE", "LY_fly", "fdsgdr42424", "battleHIGH_vehpub", "WHY_ARE_THERE_SO_MANY_FISH_IN_THE_BIG_BLUE_OCEAN",
					"MenuInitLol", "wierdo", "mdh_ash", "faze_initMenu", "SG_Turtz_Are_H000t", "fuckfestv2", "UuuNIX_M_I_S_S_I_L_E_Z", "xZombieBait", "W00kie_Init_Menu", "rainbow_var",
					"biggies_menu_open", "HAAJASDOKAD_mein", "CharlieSheenkeybinds", "POOP_Main", "colt_lmaoooo", "W_O_O_K_I_E_Pro_RE", "O_fnc_initFSteal", "toggle_keyEH", "occxbstb",
					"JME_M_E_N_U_initMenu", "dawr5wdfsf23", "FURY_IS_SEXC", "LOKI_GUI_Key_Color", "awaexpqc", "MPGHALLDAYEVRYDAY47LETSDOTHISBBYYAAAAAAA", "infi_STAR_exec", "M_R_IRecommend",
					"xtags_star_xx", "ChangingBullets_xx", "MLRN_ENCRYPT", "byebyezombies", "Root_Main4", "igodokxtt", "unlimammo", "tw4etinitMenu", "TORNADO_NOT_MOVE_NIGGA", "XXX_h4x",
					"HydroxusRandomVarSwag2222", "oh_nmoe_pls", "Team_OMFG_WE_ARE_SEXC", "spoodydshakfhkfuntimehappydsa_dummysmenu", "plrshldblckls", "Jme_Is_God", "Monky_funcs_inited",
					"SOMEONE_dsfnsjf", "fuckmegrandma", "qopfkqpofqk", "ShadowyFaz3VehZ", "Veh_Spawn_Shitt", "backtomenu", "wuat_fpsMonitor", "Monky_hax_toggled", "mehatingjews", "InfiniteAmmo",
					"PersonWhomMadeThisCorroded_Init", "nuke_vars", "tvwyqcpf", "debug_star_colorful", "SOMEONE_DurkSintax_Pro_RE", "neo_fnc_throw", "confuser", "W00kieMenu_hax_toggled",
					"AntiAntiAntiAntiHax", "Dummy_Menu", "XMVJEIUI133794_mein", "aim", "GodLolPenis", "MainMenubyThirtySix", "Feg_get_my_Bitch", "vehiclegooov3ood_BushWookie", "biggies_scroll_open",
					"ANTI_ANTI_HAX", "Fire_ZeusMode", "antiantiantiantih4x", "riasgremory_G0d_Mode", "BigFuckinBullets_0202020DDDEEDED", "monkytp", "hax_toggled", "SOMEONE_Sweg_all_day",
					"FUCK_ME_keybinds", "JJJJ_MMMM___EEEEEEE_INIT_MENU", "B0X_CANN0N_T0GGLE", "omgwtfbbq", "bowonky", "ExtasyMenu_Binds", "PRO_SKILLZ_2015_ALLDAY_Noobs", "for_sure_its_esp",
					"dontAddToTheArray", "rainbowbitch",	"n0clip", "GLASS911_Init", "dal33tRE", "fuckfest", "BigFuckinBullets", "lmzsjgnas", "n912", "TBMKnlist", "PLAY", "ALTISLIFENEXT3",
					"FND_fnc_subs", "setcash", "Dummy_Ghost", "entf", "check_loaded", "LY_Menu", "AndysClosed", "Fanatic_Main_Bereich", "imgoingnukeyou", "fnc_usec_damageHandler",
					"CheatCurator", "andy_loopz", "InitFileOne", "Status_BB", "TZ_BB_A3", "TZ_BB_KB_Hint", "TZ_BB_BindHandler", "AH_BRAZZERS_TZ_BB", "kamakazi_lystic", "fuckfest", "D_AMEZ_COA",
					"Intro", "Repair", "Heal", "T3le", "TNK", "I_like_turtles", "BIGM", "GMod", "E3p", "Does_Tonic_Like_to_take_Turtle_penis_in_the_ass_LODESTARS", "lel", "vars", "PSwap",
					"toLower_new", "BCast", "thfile", "tlmadminrq", "infiSTARBLACK", "carepkg", "scrollAim", "BlurExec", "sbpc", "CALLRE", "menu_run", "ZedProtect", "actid1", "vehicles1",
					"MapClicked", "MapClickedPosX", "MouseUpEvent", "scrollPlayerlist", "keypress_xxx", "D_AMEZ_COA", "envi", "G_A_N_G_S_T_A", "ZoombiesCar", "timebypass", "returnString_z",
					"isori", "tangrowth27", "PVAH_AdminRequest", "AH_OFF_LOL", "infiSTAR_fillRE", "qwak", "infoe", "font", "title_dialog", "sexymenu_adds_Star", "boolean_1", "initre337",
					"skype_option", "bleh", "magnetomortal", "fnc_allunits", "sbp", "PV_IAdminMenuCode", "PVAH_WriteLogRequest", "skype_img", "Lhacks", "Lpic", "LtToTheRacker", "Lexstr",
					"take1", "Called", "epochExec", "sdgff4535hfgvcxghn", "adadawer24_1337", "W_O_O_K_I_E_Car_RE", "kW_O_O_K_I_E_Go_Fast", "epchDeleted", "lystobindkeys", "lystoKeypress",
					"fnc_usec_unconscious",	"toggle_1", "shiftMenu", "dbClicked", "b_loop", "re_loop", "v_bowen", "bowen", "melee_startAttack", "asdasdasd", "antihax2", "PV_AdminMenuCode",
					"AdminLoadOK", "AdminLoadOKAY", "PV_TMPBAN", "T_o_g_g_l_e_BB", "fixMenu", "PV_AdminMenuCodee", "AdminPlayer", "PVAH_AdminRequestVariable","epochBackpack", "JME_Red",
					"JME_MENU_Sub", "JME_menu_title", "JME_Sub", "JME_OPTIONS", "god", "heal", "grass", "fatguybeingchasedbyalion", "night", "day", "infammo", "nvg", "thermal", "fredtargetkill",
					"loopfredtpyoutome", "epochTp",	"AdminLst", "BB_Pr0_Esp", "BBProEsp", "epochMapMP", "CALLRESVR", "EPOCH_spawnVehicle_PVS", "adminlite", "adminlitez", "antihacklite",
					"inSub", "scroll_m_init_star", "markerCount", "zombies", "startmenu_star", "LystoDone", "MOD_EPOCH", "Admin_Lite_Menu", "admingod", "adminESPicons", "fnc_MapIcons_infiSTAR",
					"BIS_MPF_remoteExecutionServer4", "adminadd", "shnext", "infiSTAR_fill_Weapons", "adminZedshld", "adminAntiAggro", "admin_vehicleboost", "admin_low_terrain", "admin_debug",
					"admincrate", "exstr", "nlist", "PV_AdminMainCode", "TPCOUNTER", "PVDZ_Hangender", "fn_filter", "vehiList", "Remexec_Bitch", "zeus_star", "tmmenu", "skipTime",
					"AntihackScrollwheel", "survcam", "infiniteammo", "PVAH_AHTEMPBAN", "lalf", "toggle", "iammox", "telep", "dayzlogin3", "dayzlogin4", "changeBITCHinstantly", "antiAggro_zeds",
					"BigFuckinBullets", "adminicons", "fn_esp", "aW5maVNUQVI_re_1", "passcheck", "isInSub", "qodmotmizngoasdommy", "ozpswhyx", "xdistance", "wiglegsuckscock", "diz_is_real__i_n_f_i_S_T_A_R",
					"pic", "veh", "unitList", "list_wrecked", "addgun", "ESP", "BIS_fnc_3dCredits_n", "dayzforce_save", "ViLayer", "blackhawk_sex", "activeITEMlist", "items1",
					"adgnafgnasfnadfgnafgn", "Metallica_infiSTAR_hax_toggled", "rem", "HMDIR", "vehC", "HDIR", "carg0d", "init_Fncvwr_menu_star", "altstate", "black1ist", "ARGT_JUMP",
					"ARGT_KEYDOWN", "ARGT_JUMP_w", "ARGT_JUMP_a", "bpmenu", "color_black", "fffffffffff", "markPos", "pos", "TentS", "VL", "MV", "monky", "pbx", "Cock_random_F", "_nearPlayers",
					"nametagThread", "spawnmenu", "sceptile15", "sandshrew", "zombieDistanceScreen", "cargodz", "R3m0te_RATSifni", "wepmenu", "WookieESP", "ggggggggggggggggggg",
					"admin_d0", "RAINBOWREMEXECVEH", "omgwtfbbq", "namePlayer", "thingtoattachto", "testIndex", "g0d", "spawnvehicles_star", "kill_all_star", "sCode", "dklilawedve", "peter_so_fly_CUS",
					"selecteditem", "moptions", "delaymenu", "gluemenu", "infiSTAR_fillHax", "itemmenu", "gmadmin", "fapEsp", "mapclick", "VAGINA_secret", "spawnweapons1", "abcd", "skinmenu",
					"playericons", "changebackpack", "keymenu", "godall", "theKeyControl", "infiSTAR_FILLPLAYER", "whitelist", "pfEpochTele", "custom_clothing", "img", "surrmenu", "footSpeedIndex",
					"ctrl_onKeyDown", "plrshldblcklst", "DEV_ConsoleOpen", "executeglobal", "cursoresp", "Asdf", "planeGroup", "teepee", "spwnwpn", "musekeys", "dontAddToTheArray", "morphtoanimals",
					"aesp", "Monky_initMenu", "tMenu", "recon", "curPos", "playerDistanceScreen", "ihatelife", "MY_KEYDOWN_FNC", "Bowen_RANDSTR", "ProDayz","AmovPercMstpSnonWnonDnon_exerciseKata",
					"idonteven", "walrein820", "RandomEx", "TAG_onKeyDown", "changestats", "derp123", "heel", "rangelol", "unitsmenu", "ARGT_JUMP_s", "ARGT_JUMP_d", "globalplaya", "ALL_MAGS_TO_SEARCH",
					"xtags", "pm", "lmzsjgnas", "vm", "bowonkys", "glueallnigga", "hotkeymenu", "espfnc", "playeresp", "zany", "dfgjafafsafccccasd", "atext", "boost", "Franko0oo_MeE1nnu_FIX_TOGGLE",
					"vspeed", "inv", "rspwn", "loldami", "T", "bowonky", "aimbott", "Admin_Layout", "markeresp", "allMrk", "MakeRandomSpace", "helpmenu", "rustlinginit", "invall", "initarr",
					"reinit", "ALexc", "DAYZ_CREATEVEHICLE", "FUK_da_target", "damihakeplz", "damikeyz_veryhawt", "mapopt", "hangender", "slag", "jizz", "kkk", "ebay_har", "sceptile279",
					"TargetPlayer", "tell_me_more_infiSTAR", "airborne_spawn_vehicle_infiSTAR", "sxy_list_stored", "advert_SSH", "Flare8", "Flare7", "SuperAdmin_MENU", "YouAskForMyHelp",
					"fsdandposanpsdaon", "antiloop", "anti", "spawn_explosion_target_ebay", "whatisthis4", "ratingloop_star", "epochRemoteNukeAll", "PVAH_admin_rq", "PVAH_writelog_rq", "sandslash",
					"muk", "pidgeotto", "charmeleon", "pidgey", "lapras", "LYST1C_UB3R_L33T_Item", "MathItem", "fapLayer", "cooldown", "raichu", "infiSTAR_chewSTAR_dayz_1", "infi_STAR_output",
					"infi_STAR_code_stored", "keybindings", "keypress", "menu_toggle_on", "aiUnit", "runHack", "Dwarden", "poalmgoasmzxuhnotx", "ealxogmniaxhj", "ohhpz", "fn_genStrFront", "shazbot1",
					"cip", "Armor1", "GMod", "stop", "possible", "friendlies", "mapscanrad", "maphalf", "DelaySelected", "SelectDelay", "GlobalSleep", "vehD", "ALL_WEPS_TO_SEARCH", "jopamenu", "ggggg",
					"tlm", "Listw", "toggle_keyEH", "infammoON", "pu", "chute", "dayzforce_savex", "PVDZ_AdminMenuCode", "PVDZ_SUPER_AdminList", "DarkwrathBackpack", "PVDZ_hackerLog", "BP_OnPlayerLogin",
					"material", "mapEnabled", "markerThread", "addedPlayers", "playershield", "spawnitems1", "sceptile27", "Proceed_BB", "ESPEnabled", "wpnbox", "fnc_temp", "MMYmenu_stored", "VMmenu_stored",
					"LVMmenu_stored", "BIS_MPF_ServerPersistentCallsArray", "PV_CHECK", "admin_animate1", "patharray", "ZobieDistanceStat", "infiSTARBOTxxx", "keyspressed", "fT", "tpTarget", "HumanityVal",
					"yanma", "absol", "SimpleMapHackCount", "keyp", "aggron", "magazines_spawn", "weapons_spawn", "backpack_spawn", "MajorHageAssFuckinfBulletsDude", "Wannahaveexplosivesforbullets",
					"TheTargetedFuckingPlayerDude", "haHaFuckAntiHakcsManIbypasDatShit", "aintNoAntiHackCatchMyVars", "objMYPlayer", "Awwwinvisibilty", "vehiclebro", "wtfyisthisshithere", "terrainchangintime",
					"Stats", "menu", "ssdfsdhsdfh", "onisinfiniteammobra", "youwantgodmodebro", "yothefuckingplayerishere", "Namey", "sendmsg12", "jkh", "DELETE_THIS", "move_forward", "leftAndRight",
					"forwardAndBackward", "upAndDown", "distanceFromGround", "hoverPos", "bulletcamon", "cheatlist", "espOn", "removegrass", "timeday", "norekoil", "nocollide", "esp2ez",
					"fastwalk", "entupautowalk", "BensWalker", "dropnear", "executer", "killme", "magnetmenu", "magnet", "loadMenu", "refreshPlayers", "ALREADYRAN", "players", "BigBenBackpack", "W34p0ns",
					"amm0", "Att4chm3nt", "F0od_Dr1nk", "M3d1c4l", "T0ol_it3ms", "B4ckp4cks", "It3m5", "Cl0th1ng", "walkloc", "nwaf", "cherno", "cherno_resident", "cherno_resident_2", "dubky", "oaks",
					"swaf", "swmb", "getX", "PlayerShowDistance", "M_e_n_u_2", "colorme", "keybindloop", "Tractor_Time", "murkrow", "noctowl", "isExecuted", "piloswine", "AddPlayersToMap", "markers",
					"miltank", "Malvsm", "Malcars", "malfly", "keyForward", "PermDialogSelected", "TempDialogSelected", "pfKeygen", "pfScanUnits", "pfPickPlayer", "pfshnext", "pfnlist", "pfselecteditem",
					"pfshnmenu", "pfPlayerMonitor", "pfPlayersToMonitor", "pfShowPlayerMonitor", "pfPlayerMonitorMutex", "marker", "E_X_T_A_S_Y_Init_Menu", "monkaiinsalt", "_xxpoaawpjhfutyftfglyhytgwdwdgghhvx",
					"monkaiin", "part88", "adminKeybinds", "PV_DevUIDs", "fapEspGroup", "Repair", "RepairIT", "rainbowTarget", "rainbowTarget1", "rainbowTarget2", "rainbowTarget3", "VehicleMenue",
					"Menue_Vehicle", "my_anus_hurtz", "life_no_injection", "Tonic_has_a_gaping_vagina", "teletoplr", "telet", "ygurv1f2", "BIGM", "E3p", "fnc_PVAH_AdminReq", "infiSTAR_MAIN_CODE",
					"MAIN_CODE_INJECTED", "D34DXH34RT_E5P", "Arsenal", "B0X_CANN0N_T0GGLE", "aim", "HOLY_FUCK_FDKFHSDJFHSDKJ_vehicles_m", "lazy_ILHA_is_lazy", "POOP_Item", "die_menu_esp_v1",
					"XXMMWW_main_menu", "MM_150", "BIS_tracedShooter", "JME_HAS_A_GIANT_DONG", "nukepos", "fuckfest", "Deverts_keyp", "jfkdfjdfjdsfjdsfjkjflfjdlfjdlfjru_keyp", "eroticTxt",
					"asdadaio9d0ua298d2a0dza2", "trap", "boomgoats", "morphme", "morph", "blfor", "blfor2", "blfor3", "rdfor", "rdfor2", "rdfor3", "napa", "civ", "keybindz", "PEDO_IS_FUKED", "MAINON",
					"PLAYERON", "PLAYEROFFNEXT1", "PLAYERNEXT2", "ALTISLIFEON", "ALTISLIFEOFFNEXT1", "ALTISLIFENEXT2", "ALTISLIFEOFFNEXT2", "ALTISLIFENEXT3", "FUNMENUOFFNEXT1", "FUNMENUNEXT2",
					"FUNMENUOFFNEXT2", "FUNMENUNEXT3", "MAINOFF", "PLAYEROFF", "ALTISLIFEOFF", "FUNMENUOFF", "H4X_Miriweth_Menu_Click_Hax", "IrEcOCMmeNEnd_God_MODE", "TTTT_IIII___TTTTTTT_REPGAs",
					"EC_GOD_TOGGLE", "admin_d0_server", "PedoMazing_Friends", "ly5t1c", "JJMMEE_Swagger", "Bobsp", "Speed_Hack_cus", "pList_star_peter_cus", "RGB", "neo_throwing", "Blue_I_Color_LP",
					"box", "bombs", "InfiSTAR_RUNNING_AH_on_Player", "Orange_I_Color_LP", "Menu_I_On_Color_LP", "Menu_I_Off_Color_LP", "Speed_Hack_cus", "cus_SPEED_DOWN", "pnc", "SpyglassFakeTrigger",
					"infammook", "input_text", "Tit_Choppertimer", "GLASS911_Executer_for_menu", "E5P", "ThirtySix_Unlim_Ammo", "ThirtySix_God", "menuheader", "life_fnc_sessionUpdateCalled", "blu_t_color_LP",
					"FAG_RedSoldiers", "titles_n_shit", "eXecutorr", "menu_headers", "refresh_players", "fn_loadMap", "weapon_list", "vehicle_list", "get_display", "create_display", "CTRL_BTN_LIST",
					"execMapFunc", "mapFunc", "OPEN_LISTS", "init_menu", "biggies_white_tex", "Abraxas_Unl_Life", "Abraxas_Life", "waitFor", "Mystic_ESP", "scriptex3cuter", "rym3nucl0s3",
					"eses_alis", "PersonWhomMadeThisCorroded_Menu", "Flo_Simon_KillPopUp", "keybindz2", "text_colour", "key_combos_ftw", "PlayerInfiniteAmmo", "Im_a_Variable", "aaaa", "fnc_LBDblClick_RIGHT",
					"OMFG_MENU", "N_6", "RscCombo_2100_mini", "RscListbox_1501_mini", "andy_suicide", "life_nukeposition", "JxMxE_hide", "JME_Keybinds", "JME_has_yet_to_fuck_this_shit", "JME_deleteC", "JME_Tele",
					"JME_ANAL_PLOW", "JME_M_E_N_U_initMenu", "JME_M_E_N_U_hax_toggled", "W_O_O_K_I_E_FUD_Pro_RE", "W_O_O_K_I_E_FUD_Car_RE", "W_O_O_K_I_E_FUD_Car_RE", "JxMxE_Veh_M", "JxMxE_LifeCash500k",
					"W_O_O_K_I_E_FUD_FuckUp_GunStore", "W_O_O_K_I_E_FUD_M_E_N_U_initMenu", "W_O_O_K_I_E_FuckUp_GunStore_a", "JME_KillCursor", "JME_OPTIONS", "JME_M_E_N_U_fill_TROLLmenu", "ASSPLUNGE", "FOXBYPASS",
					"POLICE_IN_HELICOPTA", "JxMxE_EBRP", "W_O_O_K_I_E_M_E_N_U_funcs_inited", "Menu_Init_Lol", "E_X_T_A_S_Y_Atm", "W_O_O_K_I_E_Pro_RE", "W_O_O_K_I_E_Debug_Mon", "W_O_O_K_I_E_Debug_1337",
					"Veh_S_P_A_W_N_Shitt", "sfsefse", "tw4etgetControl", "JxMxEsp", "JxMxE_GOD", "JxMxE_Heal", "efr4243234", "sdfwesrfwesf233", "sdgff4535hfgvcxghn", "adadawer24_1337",
					"lkjhgfuyhgfd", "E_X_T_A_S_Y_M_E_N_U_funcs_inited", "dayz_serverObjectMonitor", "fsfgdggdzgfd", "Wookie_List", "JxMxE_TP", "Wookie_Car_RE", "Wookie_Debug_Mon",
					"advertising_banner_infiSTAR", "atext_star_xa", "Monky_hax_dbclick", "AntiAntiAntiAntiHax", "antiantiantiantih4x", "JxMxE_Infect", "hub", "_fghiopahrheyavhfasfa",
					"scrollinit", "gfYJV", "Lystic_LMAOOOOOOOOOOOOOOOOOOO", "Lystic_Re", "E_X_T_A_S_Y_Keybinds", "Menulocations", "scroll_m_init_star", "exstr1", "pathtoscrdir3",
					"JxMxE_secret", "Monky_initMenu", "player_zombieCheck", "E_X_T_A_S_Y_Recoil", "playericons", "go_invisible_infiSTAR", "serverObjectMonitor", "enamearr", "initarr3", "locdb", "sCode",
					"infAmmoIndex", "nukeDONEstar", "Wookie_List", "FUCKTONIC", "E_X_T_A_S_Y_FuckUp_GunStore_a", "E_X_T_A_S_Y_Cash_1k_t", "E_X_T_A_S_Y_Cash_a", "E_X_T_A_S_Y_LicenseDrive",
					"E_X_T_A_S_Y_Menu_LOOOOOOOOOL", "Metallica_vehicleg0dv3_infiSTAR", "JJJJ_MMMM___EEEEEEE_INIT_MENU", "JJJJ_MMMM___EEEEEEE_GAPER", "JJJJ_MMMM___EEEEEEE_SMOKExWEEDxEVERYDAY_BUM_RAPE",
					"JJJJ_MMMM___EEEEEEE_OPTIONS", "JJJJ_MMMM___EEEEEEE_M_E_N_U_fill_Target", "E3p", "Jesus_MODE", "ESP", "MissileStrike", "AL_Liscenses", "NoIllegal", "NoWeight", "m0nkyaatp_sadksadxa",
					"m0nkyaatp_RANDSTR", "myvar23", "player_adminlevel", "TNK", "I_like_turtles", "BIGM", "Does_Tonic_Like_to_take_Turtle_penis_in_the_ass_LODESTARS", "_cghujkfosafhasifahdesrrctuynoiuasrdhoyuo",
					"Does_Tonic_Like_to_take_Turtle_penis_in_the_ass_LODESTAR1", "GMod", "No_No_No_Tonic_likes_A_Big_Fat_Sheep_Cock_Right_in_the_bum_G0d_Mode", "Sload", "aKFerm", "aKMMenu", "aKLikeaG0d",
					"riasgremory_G0d_Mode", "aKCarG0d", "riasgremory_Car_Jesus", "aKE5p", "riasgremory_isseilol", "aKPMark", "l33tMapESPLunsear", "riasgremory_Noobs", "riasgremory_Bitches",
					"riasgremory_Map_Markers", "aKUnMmo", "jenesuispasuncheateur_unamo", "aKVoit", "Loljesaispasquoiecriremdr", "isseigremory", "gremorysama", "aKTaCu", "aKCardetroy", "aKGetKey",
					"aKKillcursor", "aKNoEscort", "aKEscort", "aKtroll", "aKTPall", "aKUnrestrain", "aKNoEscortMe", "aKNoTaze", "aKJailplayer", "aKLisense", "riasgremory_titans_shit_reold", "Tonic_merde",
					"jaimepaslepoisin_HLEAL", "TTTT_IIII___TTTTTTT_RAP_FR", "TTTT_IIII___TTTTTTT_REPGA", "TTTT_IIII___TTTTTTT_REPGAs", "jaimepaslepoisin_HLEAL", "Root_Pistol4", "Root_Rifle4",
					"Root_Machinegun4", "Root_Sniper4", "Root_Launcher4", "Root_Attachement4", "VAR56401668319_secret", "myPubVar", "XXMMWW_boxquad", "A3RANDVARrpv1tpv", "fnc_nestf", "smissles", "wooden_velo",
					"vabox", "_grgrgsrgjyxkgfs", "PrintSomeMemes", "MinecraftMemeTownCancer"];
		};

		if (isNil "_cheatFlag" && isNil "_memAnomaly") then
		{
			// Diplay validator based on Tonic's SpyGlass

			scopeName "memScan";

			{
				_x params ["_rscName", "_onLoadServer", "_onUnloadServer"];

				_onLoad = getText (configFile >> _rscName >> "onLoad");
				_onUnload = getText (configFile >> _rscName >> "onUnload");

				{
					_x params ["_valName", "_clientVal", "_serverVal"];

					if (_clientVal != "") then
					{
						private _lowClientVal = toLower _clientVal;

						if (_clientVal != _serverVal) then
						{
							[[toArray getPlayerUID player, _rscName, _x], _flagChecksum] remoteExec ["A3W_fnc_logMemAnomaly", 2];
							_memAnomaly = true;
						};

						if (_lowClientVal find "uinamespace" == -1) then
						{
							_cheatFlag = ["script injector", _x];
						};

						if (!isNil "_memAnomaly" || !isNil "_cheatFlag") then { breakTo "memScan" };
					};
				}
				forEach
				[
					["onLoad", _onLoad, _onLoadServer],
					["onUnload", _onUnload, _onUnloadServer]
				];

				sleep 0.01;
			} forEach _rscParams;
		};

		_loopCount = 0;
	};

	if (isNil "_cheatFlag") then
	{
		// diag_log "ANTI-HACK: Recoil hack check started!";

		_currentRecoil = unitRecoilCoefficient player;
		_minRecoil = ((["A3W_antiHackMinRecoil", 1.0] call getPublicVar) max 0.02) - 0.001;

		if (_currentRecoil < _minRecoil && _currentRecoil != -1) then
		{
			// diag_log "ANTI-HACK: Detected recoil hack!";

			_cheatFlag = ["recoil hack", str ceil (_currentRecoil * 100) + "% recoil"];
		};
	};

	if (!isNil "_cheatFlag") exitWith
	{
		//diag_log str [profileName, getPlayerUID player, _cheatFlag select 0, _cheatFlag select 1];

		[player, _cheatFlag select 0, _cheatFlag select 1, _flagChecksum] remoteExecCall ["A3W_fnc_flagHandler", 2];

		waitUntil {alive player};

		[getPlayerUID player, _flagChecksum] call A3W_fnc_clientFlagHandler;
	};

	sleep 5;
	_loopCount = _loopCount + 1;
};
