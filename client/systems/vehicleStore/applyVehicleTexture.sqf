// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
/*********************************************************#
# @@ScriptName: applyVehicleTexture.sqf
# @@Author: Nick 'Bewilderbeest' Ludlam <bewilder@recoil.org>, AgentRev
# @@Create Date: 2013-09-15 19:33:17
# @@Modify Date: 2013-09-24 23:03:48
# @@Function: Applies a custom texture or color to a vehicle
#*********************************************************/

// Generally called from buyVehicles.sqf

private ["_veh", "_texture", "_textureSource", "_selections", "_textures"];

_veh = param [0, objNull, [objNull]];
_texture = param [1, "", ["",[]]];
_selections = param [2, [], [[]]];

if (isNull _veh || count _texture == 0) exitWith {};

_veh setVariable ["BIS_enableRandomization", false, true];

_textures = _veh getVariable ["A3W_objectTextures", []];

scopeName "applyVehicleTexture";
private _vehCfg = configFile >> "CfgVehicles" >> typeOf _veh;

// if _texture == ["string"], extract data from TextureSources config
if (_texture isEqualType [] && {_texture isEqualTypeAll ""}) then
{
	_textureSource = _texture select 0;
	private _srcTextures = getArray (_vehCfg >> "TextureSources" >> _textureSource >> "textures");

	if (_srcTextures isEqualTo []) exitWith { breakOut "applyVehicleTexture" };

	_texture = [];
	{ _texture pushBack [_forEachIndex, _x]	} forEach _srcTextures;
};

// Apply texture to all appropriate parts
if (_texture isEqualType "") then
{
	if (_selections isEqualTo []) then
	{
		{ _selections pushBack _forEachIndex } forEach getArray (_vehCfg >> "hiddenSelections"); // gather all selections

		// test color: vehicle player setObjectTextureGlobal [0, "#(rgb,1,1,1)color(0.5,0.03,0.3,1)"];

		_selections = _selections - (switch (true) do // EXCLUDED SELECTIONS
		{
			case (_veh isKindOf "Kart_01_Base_F"):                 { [1,2,3] };

//			case (_veh isKindOf "LSV_01_base_F"):                  { [1,3] };
//			case (_veh isKindOf "LSV_02_base_F"):                  { [1] };

			case (_veh isKindOf "Offroad_01_base_F"):              { [1] };
			case (_veh isKindOf "Offroad_02_base_F"):              { [1,2,3] };

			case (_veh isKindOf "Van_01_base_F"):                  { [2] };
			case (_veh isKindOf "Van_02_base_F"):                  { [1,2,3,4] };

//			case (_veh isKindOf "Truck_01_base_F"):                { [] };
			case (_veh isKindOf "Truck_02_MRL_base_F"):            { [1] };
			case (_veh isKindOf "Truck_02_base_F"):                { [2] };
//			case (_veh isKindOf "Truck_03_base_F"):                { [] };

			case (_veh isKindOf "UGV_01_base_F"):                  { [1] };

//			case (_veh isKindOf "MRAP_01_base_F"):                 { [1] };
//			case (_veh isKindOf "MRAP_02_base_F"):                 { [] };
//			case (_veh isKindOf "MRAP_03_base_F"):                 { [] };

			case (_veh isKindOf "APC_Wheeled_01_base_F"):          { [3] };
			case (_veh isKindOf "APC_Wheeled_02_base_F"):          { [3] };
			case (_veh isKindOf "APC_Wheeled_03_base_F"):          { [4] };

			case (_veh isKindOf "AFV_Wheeled_01_up_base_F"):       { [5] };
			case (_veh isKindOf "AFV_Wheeled_01_base_F"):          { [3] };

			case (_veh isKindOf "LT_01_base_F"):                   { [2] };

			case (_veh isKindOf "B_APC_Tracked_01_CRV_F"):         { [4] };
			case (_veh isKindOf "APC_Tracked_01_base_F"):          { [3] };
			case (_veh isKindOf "APC_Tracked_02_base_F"):          { [3] };
			case (_veh isKindOf "APC_Tracked_03_base_F"):          { [2] };

			case (_veh isKindOf "B_MBT_01_TUSK_F"):                { [3] };
			case (_veh isKindOf "MBT_01_arty_base_F"):             { [3] };
			case (_veh isKindOf "MBT_01_base_F"):                  { [2] };
			case (_veh isKindOf "MBT_02_arty_base_F"):             { [4] };
			case (_veh isKindOf "MBT_02_base_F"):                  { [3] };
			case (_veh isKindOf "MBT_03_base_F"):                  { [3] };
			case (_veh isKindOf "MBT_04_base_F"):                  { [2] };

//			case (_veh isKindOf "Heli_Transport_01_base_F"):       { [] };
			case (_veh isKindOf "Heli_Transport_02_base_F"):       { [3] };
//			case (_veh isKindOf "Heli_Transport_03_base_F"):       { [] };
//			case (_veh isKindOf "Heli_Transport_04_base_F"):       { [] };

//			case (_veh isKindOf "Heli_Attack_02_base_F"):          { [] };

//			case (_veh isKindOf "VTOL_Base_F"):                    { [] };
			case (_veh isKindOf "Plane_Civil_01_base_F"):          { [2,3] };
			case (_veh isKindOf "Plane_Fighter_01_Base_F"):        { [2,3,4,5,6,7,8,9] };
			case (_veh isKindOf "Plane_Fighter_02_Base_F"):        { [3,4,5] };
			case (_veh isKindOf "Plane_Fighter_04_Base_F"):        { [3,4,5] };
//			case (_veh isKindOf "Plane"):                          { [] };

//			case (_veh isKindOf "UAV_03_base_F"):                  { [] };
			case (_veh isKindOf "UAV_05_Base_F"):                  { [2,3,4,5] };

			case (_veh isKindOf "Boat_Civil_01_base_F"):           { [1] };

			default                                                { [] };
		});
	};

	{
		_veh setObjectTextureGlobal [_x, _texture];
		[_textures, _x, _texture] call fn_setToPairs;
	} forEach _selections;
}
else
{
	{
		_sel = _x select 0;
		_tex = _x select 1;

		_veh setObjectTextureGlobal [_sel, _tex];
		[_textures, _sel, _tex] call fn_setToPairs;
	} forEach _texture;
};

_veh setVariable ["A3W_objectTextures", if (isNil "_textureSource") then { _textures } else { [_textureSource] }, true];
_veh setVariable ["A3W_objectTextures_missionDir", call currMissionDir, true]; // dirty workaround for bohemia's setObjectTextureGlobal client-server path mismatch retarded bullshit - https://feedback.bistudio.com/T80668
