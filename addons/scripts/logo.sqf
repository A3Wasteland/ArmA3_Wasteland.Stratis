// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2016 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: logo.sqf
//	@file Author: Matt76
//	@file Description: CCG Watermark

_pic = "mapConfig\Loading.paa";

[
    '<img align=''left'' size=''2'' shadow=''0'' image='+(str(_pic))+' />',
    safeZoneX+0.00,
    safeZoneY+safeZoneH-0.16,
    99999,
    0,
    0,
    3090
] spawn bis_fnc_dynamicText;