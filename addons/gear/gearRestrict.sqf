// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: gearRestrict.sqf
//	@file Author: [FRAC] Mokey
//	@file Created: 4/18/2018 17:48

_restrictedRockets = [
"RPG7_F",
"RPG32_F",
"RPG32_HE_F",
"MRAWS_HEAT_F",
"MRAWS_HE_F",
"Vorona_HEAT",
"Vorona_HE",
"NLAW_F",
"Titan_AT",
"Titan_AP",
"Titan_AA"
];

_restrictedMags = [
"30Rnd_545x39_Mag_Green_F",
"30Rnd_545x39_Mag_F",
"30Rnd_545x39_Mag_Tracer_Green_F",
"30Rnd_545x39_Mag_Tracer_F",
"20Rnd_556x45_UW_mag",
"30Rnd_556x45_Stanag_green",
"30Rnd_556x45_Stanag_red",
"30Rnd_556x45_Stanag",
"30Rnd_556x45_Stanag_Tracer_Green",
"30Rnd_556x45_Stanag_Tracer_Red",
"30Rnd_556x45_Stanag_Tracer_Yellow",
"100Rnd_580x42_Mag_F",
"100Rnd_580x42_Mag_Tracer_F",
"30Rnd_580x42_Mag_F",
"30Rnd_580x42_Mag_Tracer_F",
"30Rnd_65x39_caseless_mag",
"30Rnd_65x39_caseless_green_mag_Tracer",
"30Rnd_65x39_caseless_mag_Tracer",
"30Rnd_65x39_caseless_green",
"30Rnd_762x39_Mag_Green_F",
"30Rnd_762x39_Mag_F",
"30Rnd_762x39_Mag_Tracer_Green_F",
"30Rnd_762x39_Mag_Tracer_F",
"16Rnd_9x21_Mag","16Rnd_9x21_green_Mag",
"16Rnd_9x21_red_Mag",
"16Rnd_9x21_yellow_Mag",
"30Rnd_9x21_Mag",
"30Rnd_9x21_Mag_SMG_02",
"30Rnd_9x21_Green_Mag",
"30Rnd_9x21_Mag_SMG_02_Tracer_Green",
"30Rnd_9x21_Mag_SMG_02_Tracer_Red",
"30Rnd_9x21_Red_Mag",
"30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",
"30Rnd_9x21_Yellow_Mag","10Rnd_338_Mag",
"130Rnd_338_Mag",
"7Rnd_408_Mag",
"5Rnd_127x108_Mag",
"10Rnd_127x54_Mag",
"5Rnd_127x108_APDS_Mag",
"150Rnd_556x45_Drum_Mag_F",
"150Rnd_556x45_Drum_Mag_Tracer_F",
"200Rnd_556x45_Box_Red_F",
"200Rnd_556x45_Box_F",
"200Rnd_556x45_Box_Tracer_Red_F",
"200Rnd_556x45_Box_Tracer_F",
"100Rnd_65x39_caseless_mag",
"100Rnd_65x39_caseless_mag_Tracer",
"200Rnd_65x39_cased_Box",
"200Rnd_65x39_cased_Box_Tracer",
"20Rnd_650x39_Cased_Mag_F",
"150Rnd_762x54_Box",
"150Rnd_762x54_Box_Tracer",
"20Rnd_762x51_Mag",
"10Rnd_762x54_Mag",
"10Rnd_93x64_DMR_05_Mag",
"150Rnd_93x64_Mag",
"30Rnd_45ACP_Mag_SMG_01",
"30Rnd_45ACP_Mag_SMG_01_tracer_green",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Red",
"30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow"
];

_restrictedGrenades = [
"Chemlight_blue",
"Chemlight_green",
"Chemlight_red",
"Chemlight_yellow",
"I_IR_Grenade",
"O_IR_Grenade",
"B_IR_Grenade",
"MiniGrenade",
"HandGrenade",
"SmokeShellBlue",
"SmokeShellGreen",
"SmokeShellOrange",
"SmokeShellPurple",
"SmokeShellRed",
"SmokeShell",
"SmokeShellYellow",
"TrainingMine_Mag",
"3Rnd_UGL_FlareGreen_F",
"3Rnd_UGL_FlareCIR_F",
"3Rnd_UGL_FlareRed_F",
"3Rnd_UGL_FlareWhite_F",
"3Rnd_UGL_FlareYellow_F",
"3Rnd_SmokeBlue_Grenade_shell",
"3Rnd_SmokeGreen_Grenade_shell",
"3Rnd_SmokeOrange_Grenade_shell",
"3Rnd_SmokePurple_Grenade_shell",
"3Rnd_SmokeRed_Grenade_shell",
"3Rnd_Smoke_Grenade_shell",
"3Rnd_SmokeYellow_Grenade_shell",
"3Rnd_HE_Grenade_shell",
"1Rnd_HE_Grenade_shell",
"UGL_FlareGreen_F",
"UGL_FlareCIR_F",
"UGL_FlareRed_F",
"UGL_FlareWhite_F",
"UGL_FlareYellow_F",
"1Rnd_SmokeBlue_Grenade_shell",
"1Rnd_SmokeGreen_Grenade_shell",
"1Rnd_SmokeOrange_Grenade_shell",
"1Rnd_SmokePurple_Grenade_shell",
"1Rnd_SmokeRed_Grenade_shell",
"1Rnd_Smoke_Grenade_shell",
"MiniGrenade",
"HandGrenade"
];

_blackListedItems = [
"optic_Nightstalker",
"optic_tws",
"optic_tws_mg",
"H_HelmetO_ViperSP_hex_F",
"H_HelmetO_ViperSP_ghex_F",
"launch_NLAW_F",
"launch_B_Titan_F",
"launch_I_Titan_F",
"launch_O_Titan_F",
"launch_Titan_F",
"launch_B_Titan_short_F",
"launch_I_Titan_short_F",
"launch_O_Titan_short_F",
"launch_Titan_short_F",
"launch_MRAWS_olive_F",
"launch_MRAWS_olive_rail_F",
"launch_MRAWS_green_F",
"launch_MRAWS_green_rail_F",
"launch_MRAWS_sand_F",
"launch_MRAWS_sand_rail_F",
"launch_O_Vorona_brown_F",
"launch_O_Vorona_green_F",
"Laserdesignator",
"Laserdesignator_02",
"Laserdesignator_03",
"B_GMG_01_A_high_weapon_F",
"B_GMG_01_A_weapon_F",
"B_GMG_01_high_weapon_F",
"B_GMG_01_weapon_F",
"B_HMG_01_A_high_weapon_F",
"B_HMG_01_A_weapon_F",
"B_HMG_01_high_weapon_F",
"B_HMG_01_support_F",
"B_HMG_01_support_high_F",
"B_HMG_01_weapon_F",
"B_Mortar_01_support_F",
"B_Mortar_01_weapon_F",
"B_UAV_01_backpack_F",
"I_UAV_01_backpack_F",
"O_UAV_01_backpack_F",
"NVGogglesB_blk_F",
"NVGogglesB_grn_F",
"NVGogglesB_gry_F",
"B_Parachute"

];


_restrictedRocketsCount = (count _restrictedRockets) -1;
_count = 0;
_limitRockets = 1;
while {_count < _restrictedRocketsCount} do
{
    for "_x" from 0 to _restrictedRocketsCount do
    {
        _selectRockets = _restrictedRockets select _x;
        _countRockets = {_selectRockets == _x} count (backpackItems player);
        if (_countRockets > _limitRockets) then
        {
            for "_i" from 1 to (_countRockets - _limitRockets) do
            {
              player removeItem _selectRockets;
            };
        };
    };
    _count = _count + 1;
};

_restrictedMagsCount = (count _restrictedMags) -1;
_count = 0;
_limitMags = 4;
while {_count < _restrictedMagsCount} do
{
    for "_x" from 0 to _restrictedMagsCount do
    {
        _selectMags = _restrictedMags select _x;
        _countMags = {_selectMags == _x} count (ItemsWithMagazines player);
        if (_countMags > _limitMags) then
        {
            for "_i" from 1 to (_countMags - _limitMags) do
            {
              player removeItem _selectMags;
            };
        };
    };
    _count = _count + 1;
};


_restrictedGrenadesCount = (count _restrictedGrenades) -1;
_count = 0;
_limitGrenades = 2;
while {_count < _restrictedGrenadesCount} do
{
    for "_x" from 0 to _restrictedGrenadesCount do
    {
        _selectGrenades = _restrictedGrenades select _x;
        _countGrenades = {_selectGrenades == _x} count (ItemsWithMagazines player);
        if (_countGrenades > _limitGrenades) then
        {
            for "_i" from 1 to (_countGrenades - _limitGrenades) do
            {
              player removeItem _selectGrenades;
            };
        };
    };
    _count = _count + 1;
};


_allItems = (items player) + (assignedItems player) + (player weaponAccessories (currentWeapon player));
		{
			if (_x in _blackListedItems) then
			{
                                player unassignItem _x;
                                player removeItem _x;
				player removePrimaryWeaponItem _x;
				player removeHandGunItem _x;
				player removeItemFromUniform _x;
				player removeItemFromVest _x;
				player removeItemFromBackpack _x;
			};
		} forEach _allItems;
