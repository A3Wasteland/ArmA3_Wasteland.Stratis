// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: applyPlayerData.sqf
//	@file Author: AgentRev

// This is where you load player status & inventory data which will be wiped upon death, for persistent variables use c_applyPlayerInfo.sqf instead

private ["_data", "_name", "_value"];

_data = _this;

removeAllWeapons player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadgear player;

{
	_name = _x select 0;
	_value = _x select 1;
	_uid = getPlayerUID player;

	switch (_name) do
	{
		case "Damage": { player setDamage _value };
		case "HitPoints": { { player setHitPointDamage _x } forEach _value };
		case "Hunger": { hungerLevel = _value };
		case "Thirst": { thirstLevel = _value };
		case "Money": { player setVariable ["cmoney", _value, true] };
		/*case "Position":
		{
			if (count _value == 3) then
			{
				{ if (typeName _x == "STRING") then { _value set [_forEachIndex, parseNumber _x] } } forEach _value;
				player setPosATL _value;
			};
		};
		case "Direction": { player setDir _value };*/
		case "Uniform":
		{
			// If uniform cannot be worn by player due to different team, try to convert it, else give default instead
			if (_value != "") then
			{
				if (player isUniformAllowed _value) then
				{
					player addUniform _value;
				}
				else
				{
					_newUniform = [player, _value] call uniformConverter;

					if (player isUniformAllowed _newUniform) then
					{
						player addUniform _newUniform;
					}
					else
					{
						player addUniform ([player, "uniform"] call getDefaultClothing);
					}
				};
			};
		};
		case "Vest": { if (_value != "") then { player addVest _value } };
		case "Backpack":
		{
			removeBackpack player;

			if (_value != "") then
			{
				if (_value isKindOf "Weapon_Bag_Base" && !(_value isKindOf "B_UAV_01_backpack_F")) then
				{
					player addBackpack "B_AssaultPack_rgr"; // NO SOUP FOR YOU
				}
				else
				{
					player addBackpack _value;
				};
			};
		};
		case "Goggles": { if (_value != "") then { player addGoggles _value } };
		case "Headgear":
		{
			// If wearing one of the default headgears, give the one belonging to actual team instead
			if (_value != "") then
			{
				_defHeadgear = [player, "headgear"] call getDefaultClothing;
				_defHeadgears =
				[
					[typeOf player, "headgear", BLUFOR] call getDefaultClothing,
					[typeOf player, "headgear", OPFOR] call getDefaultClothing,
					[typeOf player, "headgear", INDEPENDENT] call getDefaultClothing
				];

				if (_value != _defHeadgear && {_defHeadgear != ""} && {{_value == _x} count _defHeadgears > 0}) then
				{
					player addHeadgear _defHeadgear;
				}
				else
				{
					player addHeadgear _value;
				};
			};
		};
		case "LoadedMagazines":
		{
			player addBackpack "B_Carryall_Base"; // temporary backpack to hold mags
			{ player addMagazine _x } forEach _value;
		};
		case "PrimaryWeapon": { player addWeapon _value; removeAllPrimaryWeaponItems player };
		case "SecondaryWeapon": { player addWeapon _value };
		case "HandgunWeapon": { player addWeapon _value; removeAllHandgunItems player };
		case "PrimaryWeaponItems": { { if (_x != "") then { player addPrimaryWeaponItem _x } } forEach _value };
		case "SecondaryWeaponItems": { { if (_x != "") then { player addSecondaryWeaponItem _x } } forEach _value };
		case "HandgunItems": { { if (_x != "") then { player addHandgunItem _x } } forEach _value };
		case "AssignedItems":
		{
			{
				if ([player, _x] call isAssignableBinocular) then
				{
					// Temporary fix for http://feedback.arma3.com/view.php?id=21618
					if (_x == "Laserdesignator" && {{_x == "Laserbatteries"} count magazines player == 0}) then
					{
						[player, "Laserbatteries"] call fn_forceAddItem;
					};

					player addWeapon _x;
				}
				else
				{
					if (["_UavTerminal", _x] call fn_findString != -1) then
					{
						_x = switch (playerSide) do
						{
							case BLUFOR: { "B_UavTerminal" };
							case OPFOR:  { "O_UavTerminal" };
							default      { "I_UavTerminal" };
						};
					};

					player linkItem _x;
				};
			} forEach _value;
		};
		case "CurrentWeapon": { player selectWeapon _value };
		case "Stance": { [player, [player, _value] call getFullMove] call switchMoveGlobal };
		case "UniformWeapons": { { (uniformContainer player) addWeaponCargoGlobal _x } forEach _value };
		case "UniformItems": { { (uniformContainer player) addItemCargoGlobal _x } forEach _value };
		case "UniformMagazines": { [uniformContainer player, _value] call processMagazineCargo };
		case "VestWeapons": { { (vestContainer player) addWeaponCargoGlobal _x } forEach _value };
		case "VestItems": { { (vestContainer player) addItemCargoGlobal _x } forEach _value };
		case "VestMagazines": { [vestContainer player, _value] call processMagazineCargo };
		case "BackpackWeapons": { { (backpackContainer player) addWeaponCargoGlobal _x } forEach _value };
		case "BackpackItems": { { (backpackContainer player) addItemCargoGlobal _x } forEach _value };
		case "BackpackMagazines": { [backpackContainer player, _value] call processMagazineCargo };
		case "PartialMagazines": { { player addMagazine _x } forEach _value };
		case "WastelandItems": { { [_x select 0, _x select 1, true] call mf_inventory_add } forEach _value };
	};
	
	
_DMR = [

"76561198101460017",  //shmuttyBong
"76561198051425814",  //Archangel
"76561198132352042",  //FaceCheck132
"76561198126735088",  //MadewithLove
"76561198116019975",  //Byron
"76561198090739457",  //Jason_ZA
"76561198088132277",  //Sin
"76561198077772816",  //Bag0Bones
"76561198066991264",  //Dustin
"76561198051422146",  //BattleBoy
"76561198050060371",  //Muffinz
"76561198049672105",  //RaZe
"76561198044310692",  //Slothboy
"76561198041390741",  //Insanity
"76561198035185995",  //Rampage
"76561198034981100",  //TribusZA
"76561198026836597",  //Ninja_Monkey
"76561198012265592",  //TidyDox
"76561198089992647",  //PlikkyJ DMR
"76561198044693803"   //ChrisBotes DMR
];

_SWWD = [
"76561198011008664", // Blasie
"76561198011088763", // Crusty
"76561198032758675", // Saadsel
"76561198048862475", // Badger
"76561198057051280", // AcidBuddy
"76561198101478573", // BAASMANS
"76561198106526709", // Frank0
"76561198117632922", // Panga
"76561198126770614", // Wolf
"76561198139502677", // SL3T
"76561198147195498", // ACHMED
"76561198147245553", // PUNISHER
"76561198022113458", // GreyTear
"76561198021080452",  //Dugg
"76561198030714684", // Diesel
"76561198010859952"  // Hagar
];


_rank1 = [

"76561198110667514", //Garrard
"76561198036559449", //Panthera
"76561198148526747" //LtAsario

];

_rank2 = [
"76561197998311851", // ScorpionL2K
"76561198028683000", //BagelZA
"76561198117222837", //TankZA
"76561198135180830", //Moon
"76561198061859745", // FlashPaperGrind
"76561198135590015" //LXM182

];

_rank3 = [
"76561197960927169",  // CRE4MPIE
"76561198010345274", //N3O
"76561198003449278", //DTHECK
"76561198032477175" //EVIL_BETTY

];

_rank4 = [
"76561197960921111" // dummy

];

_rank5 = [
"76561197960921111" // dummy

];
	
switch (true) do {
	case (_uid in _DMR):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\camo_fuel.jpg"];   			
		};
		
			case (_uid in _SWWD):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\SWWD.jpg"];  	
		};
		
			case (_uid in _rank1):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\camo_fuel.jpg"];  		
		};		
		
			case (_uid in _rank2):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\redcamo.jpg"];  		
		};		
		
			case (_uid in _rank3):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\IceCamo.jpg"];  		
		};		
		
			case (_uid in _rank4):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\kitty.jpg"];  		
		};		
		
			case (_uid in _rank5):
		{
			player setObjectTextureGlobal  [0, "client\images\vehicleTextures\kitty.jpg"];  		
		};		
	};
	
} forEach _data;
