if (isNil "key_combos_ftw") then {key_combos_ftw = true;};	//use keys combinations to show and toggle options
if (isNil "_zombie_R_gay") then {_zombie_R_gay = false;};  		//Show zombies on start
if (isNil "I_fuck_Animals") then {I_fuck_Animals = false;};  		//Show animals on start
if (isNil "show_dead_lolz") then {show_dead_lolz = false;};  		//Show dead bodies on start
if (isNil "show_tentz") then {show_tentz = false;};		//Show tents on start
if (isNil "player_HUD_k") then {player_HUD_k = true;};		//Show players on HUD (ESP) on start
if (isNil "fuck_gps_lol") then {fuck_gps_lol = false;};  	//Move gps and remove it's fckn frame
if (isNil "simple_car_iconz") then {simple_car_iconz = true;};		//Show "simple" car icon instead default icons
if (isNil "builtin_tp") then {builtin_tp = false;};		//Use built-in teleport
if (isNil "alternate_tp") then {alternate_tp = false;};		//Use alternative teleport (could be used to tp on buildings)(not works for vehicles)(credits to monky)


_addMAP2DAMI = false;				//Add map on start (GPS or MAP nesessary for functionality)
_addGPS2DAMI = false;				//Add map on start (GPS or MAP nesessary for functionality)

who_is_UDA = "You";  					//Text to identify You on map/gps. Leave blank ("") if You want to see only black icon

zmc = [1, 0, 0, 1];				//Zombie icon color
amc = [0, 0, 0, 1];				//Animals icon color
pmc = [0, 0, 1 , 1];				//Player icon color
pdmc = [1, 0, 0, 1];				//HUD player text color
vmc = [0.0980392, 0.0980392, 0.439216, 1];	//Vehicle icon color
wmc = [0.4, 0, 0, 1];				//Heliwrecks icon color
tmc = [0.294118, 0, 0.509804, 1];		//Tent icon color
_howfarzed = 1000;					//Distance from You to show zombie/animals icons
_bigASSmap = 15000;				//Size of map (longest x or y) in meters

// End of configuration


disableSerialization;
_mini_gpz = (uinamespace getvariable "BIS_RscMiniMap") displayCtrl 101;
_mini_gpz_frame = (uinamespace getvariable "BIS_RscMiniMap") displayCtrl 101000;
_mm_w = 0.35;
_mm_h = 0.301;

esp_ftw_bro = 
{
	wat_is_opt = 
	[
		["",true],
		//["Toggle options:(current state)", [-1], "", -5, [["expression", ""]], "1", "0"],
		[format["Built-in HUD(ESP): %1",player_HUD_k], [2], "", -5, [["expression", "player_HUD_k = !player_HUD_k;"]], "1", "1"],
		[format["Built-in Teleport: %1",builtin_tp], [3], "", -5, [["expression", "builtin_tp = !builtin_tp;"]], "1", "1"],
		[format["Simple car icons: %1",simple_car_iconz], [4], "", -5, [["expression", "simple_car_iconz = !simple_car_iconz;"]], "1", "1"],
		[format["Show tents: %1",show_tentz], [5], "", -5, [["expression", "show_tentz = !show_tentz;"]], "1", "1"],
		[format["Show nearby zombies: %1",_zombie_R_gay], [6], "", -5, [["expression", "_zombie_R_gay = !_zombie_R_gay;"]], "1", "1"],
		[format["Show nearby animals: %1",I_fuck_Animals], [7], "", -5, [["expression", "I_fuck_Animals = !I_fuck_Animals;"]], "1", "1"],
		[format["Show dead bodies: %1",show_dead_lolz], [8], "", -5, [["expression", "show_dead_lolz = !show_dead_lolz;"]], "1", "1"],
		[format["Use alternative teleport: %1",alternate_tp], [9], "", -5, [["expression", "alternate_tp = !alternate_tp;"]], "1", "1"]
		];  
	showCommandingMenu "#USER:wat_is_opt";
};



if (isnil "mapm") then 
{
	if (_addMAP2DAMI and !("ItemMap" in items player)) then {player addweapon "ItemMap";};			
	if (_addGPS2DAMI and !("ItemGPS" in items player)) then {player addweapon "ItemGPS";};
	mapm = true; 
	plist = []; 
	vlist = [];
	cList = [];
	aList = [];	
	sList = [];
	dList = [];
	maphalf = _bigASSmap/2; mapscanrad = sqrt (2*maphalf*maphalf);
	_map = (findDisplay 12) displayCtrl 51;	
	if player_HUD_k then {setGroupIconsVisible [false,true];};
	
	titleText ["Loading tents and helicrashes...","PLAIN DOWN"];titleFadeOut 2;
	helicrashes = nearestObjects [[maphalf,maphalf],["UH1Wreck_DZ"],mapscanrad];
	tents = nearestObjects [[maphalf,maphalf],["TentStorage"],mapscanrad];

	if fuck_gps_lol then
	{
		_mini_gpz_frame ctrlShow false;				//hide gps frame
		//_mm_x = (SafeZoneW + SafeZoneX) - (_mm_w + 0.005); 	//bottom right
		//_mm_y = (SafeZoneH + SafeZoneY) - (_mm_h + 0.005); 	//bottom right
		//_mm_x = SafeZoneX + 0.005; 				//top left
		//_mm_y = SafeZoney + 0.005; 				//top left
		_mm_x = (SafeZoneW + SafeZoneX) - (1 - 0.555); 		//move left a bit (to not cover main right icons)
		_mm_y = (SafeZoneH + SafeZoneY) - (1 - 0.480); 		//move left a bit (to not cover main right icons)
		_mini_gpz ctrlsetposition [_mm_x, _mm_y, _mm_w, _mm_h];
		_mini_gpz ctrlcommit 0.01;
	};
	titleText ["Adding map markers...","PLAIN DOWN"];titleFadeOut 2;
	_mapdraw = _map ctrlSetEventHandler ["Draw", "_this call drawic;"];
	_minimapdraw = _mini_gpz ctrlSetEventHandler ["Draw", "_this call drawic;"];
	if key_combos_ftw then 
	{
		F7_DUH_K = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 65) then {call esp_ftw_bro;};"];
		DT_me = (findDisplay 46) displayAddEventHandler ["KeyUp","if ((_this select 1) == 57) then {detach (vehicle player);};"];
	};

	sleep 0.1;
		   
} 
else 
{
	mapm = nil;
	_map ctrlremoveeventhandler ["Draw", _mapdraw];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", F7_DUH_K];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", DT_me];
	
	if fuck_gps_lol then
	{		
		_mm_x = (SafeZoneW + SafeZoneX) - (1 - 0.625);
		_mm_y = (SafeZoneH + SafeZoneY) - (1 - 0.480);
		_mini_gpz_frame ctrlShow true;
		_mini_gpz ctrlsetposition [_mm_x, _mm_y, _mm_w, _mm_h];
		_mini_gpz ctrlcommit 0.01;  
	};

	sleep 0.1;
	titleText ["Markers removed...","PLAIN DOWN"];titleFadeOut 2;
	sleep 5;
	player addaction [("<t color=""#0074E8"">" + ("Tools Menu") +"</t>"),"admintools\Eexcute.sqf","",5,false,true,"",""];
};
 

keyctrl = 
{

};



drawic = 
{
	if (!isnil "mapm") then 
	{
	
	        private["_ctrl"];
	        _ctrl =  _this select 0;
		_iscale = (1 - ctrlMapScale _ctrl) max .2;

		_irad = 30;
	        _color = [0, 0, 0, 1];
	        _icon = "\ca\ui\data\icon_zora_ca.paa";
		if _zombie_R_gay then {{if (!isnull _x) then {_ctrl drawIcon ["\ca\ui\data\iconman_ca.paa", zmc, getPosASL _x, _iscale*30, _iscale*30, getDir _x, "", 1];};} foreach zombies;};
		if I_fuck_Animals then {{if (!isnull _x) then {_ctrl drawIcon ["\ca\ui\data\icon_animals_ca.paa", amc, getPosASL _x, _iscale*15, _iscale*15, 0, "", 1];};} foreach animalsl;};
		if show_tentz then {{if (!isnull _x) then {_ctrl drawIcon ["\ca\ui\data\markers\waypoint.paa", tmc, getPosASL _x, 30, 30, 0, "", 1];};} foreach tents;};
		if show_dead_lolz then {{if ((!isnull _x) and !(_x isKindOf "zZombie_base") and (_x isKindOf "Man")) then {_ctrl drawIcon ["\ca\ui\data\map_chapel_ca.paa", amc, getPosASL _x, _iscale*30, _iscale*30, 0, "", 1];};} foreach AllDead;};
	
		{if  (!isnull _x) then {_ctrl drawIcon ["\ca\air2\data\ui\icon_uh1y_ca.paa", wmc, getPosASL _x, 30, 30, 0, "", 1];};} foreach helicrashes;
		{
			if (!isnull _x) then 
			{
				_icon = getText(configFile >> "CfgVehicles" >> typeOf _x >> "icon");_irad = 30;
				if ((simple_car_iconz) and (_x iskindof "landvehicle")) then 
				{_icon = "\ca\ui\data\iconpapercar_ca.paa";_irad = 20;};
				if (_x iskindof "Air") then {_irad = 40;};
			        _ctrl drawIcon [_icon, vmc, getPosASL _x, _iscale*_irad, _iscale*_irad, getDir _x, "", 1];
		        };
		} foreach (Entities "LandVehicle"+ Entities "Air" + Entities"Ship");
	
		{
			if ((!isnull _x) and (getPlayerUID _x != "") and !(vehicle _x != _x)) then 
			{	
				if (_x == player) then {_color = [0, 0, 0, 1];} else {_color = pmc;};
		       		_ctrl drawIcon ["\ca\ui\data\iconman_ca.paa", _color, getPosASL _x, _iscale*30, _iscale*30, getDir _x, "", 1];
		        };
		} foreach Entities "CAManBase";

	};

};

portal =
{	
	if (!isnil "mapm") then
	{				
		if ((_this select 1) and (builtin_tp)) then
		{
			_pos = _this select 0;
			if alternate_tp then {_dummyveh = "PBX" createVehicleLocal [_pos select 0, _pos select 1];player moveInDriver _dummyveh;deleteVehicle _dummyveh;}
			else {_markerveh="Can_Small" createVehicleLocal [_pos select 0, _pos select 1];(vehicle player) attachto [_markerveh,[0.0,0.0,0.2]];};
			
			_myuvbPos = player getVariable["lastPosition",[]];
			if (vilayer_sux_dik) then {player setVariable["lastPosition",getPosASL player];};
			_myPos = player getVariable["lastPos",[]];
			if (count _myPos > 0) then {player setVariable["lastPos",getPosATL player];player setVariable["lastPos",[]];};
			openMap [false, false];onMapSingleClick "";
		}
		else {onMapSingleClick "";};
	}
};

// Main cicle
waituntil 
{	

 	if (!isnil "mapm") then 
	{

		start_time = diag_tickTime;

		if ((visiblemap) and (builtin_tp))then 
		{
			onMapSingleClick "[_pos, _alt] call portal;";

		};

		if (_zombie_R_gay) then {zombies = getPosATL player nearEntities ["zZombie_Base", _howfarzed];} else {zombies = [];};
		if (I_fuck_Animals) then {animalsl = getPosATL player nearEntities ["CAAnimalBase", _howfarzed];} else {animalsl = [];};
             
	        {
		      	if (!(_x in aList) and I_fuck_Animals) then 			 
			{
				private ["_pos", "_mkr"]; 
				_pos = getPos _x;
		
				_mkr = createMarkerLocal [format ["AML%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
				_mkr setMarkerTypeLocal "waypoint";  
				_mkr setMarkerSizeLocal [0,0];
				_mkr setMarkerColorLocal "ColorBlack";
				_mkr setMarkerTextLocal format["%1", gettext (configFile >> 'CfgVehicles' >> (typeof _x) >> 'displayName')]; 
				aList set [count aList, _x];
				[_x, _mkr] spawn 
				{ 
					private ["_u", "_m"]; 
					_u = _this select 0; 
					_m = _this select 1; 
					while {mapm and I_fuck_Animals and (getDammage _u < 1) } do 
					{ 
						_m setMarkerPosLocal ([(getPos _u select 0) + 20, getPos _u select 1, 0]); 
						sleep 0.01; 
					}; 
					deleteMarkerLocal _m;	
					if (_u in aList) then 
					{ 
						aList set [(aList find _u), -1]; 
						aList = aList - [-1]; 			
						
					}; 					
					true;
				}; 
			};
		} forEach animalsl;
		if show_dead_lolz then
		{
	                {
			      	if (!(_x in dList) and !(_x isKindOf "zZombie_base") and (_x isKindOf "Man")) then 			 
				{
					private ["_pos", "_mkr"]; 
					_pos = getPos _x;
			
					_mkr = createMarkerLocal [format ["DBP%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
					_mkr setMarkerTypeLocal "waypoint";  
					_mkr setMarkerSizeLocal [0,0];
					_mkr setMarkerColorLocal "ColorBlack";
					_mkr setMarkerTextLocal format["%1", _x getVariable["bodyName","unknown"]]; 
					_mkr setMarkerPosLocal ([(getPosATL _x select 0) + 15, getPosATL _x select 1, 0]); 
					dList set [count dList, _x];
					[_x, _mkr] spawn 
					{ 
						private ["_u", "_m"]; 
						_u = _this select 0; 
						_m = _this select 1; 
						while {mapm and show_dead_lolz and (!isnull _u)} do 
						{ 
							sleep 0.5; 
						}; 
						deleteMarkerLocal _m;	
						if (_u in dList) then 
						{ 
							dList set [(dList find _u), -1]; 
							dList = dList - [-1]; 			
							
						}; 					
						true;
					}; 
				};
			} forEach AllDead;
		};

		{ 
			if !(_x in vList) then 
			{ 
				private ["_pos", "_mkr"]; 
				_pos = getPos _x;
				_mkr = createMarkerLocal [format ["VHC%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
				_mkr setMarkerTextLocal format["%1", gettext (configFile >> 'CfgVehicles' >> (typeof _x) >> 'displayName')]; 
				_mkr setMarkerTypeLocal "waypoint"; 
				_mkr setMarkerColorLocal "ColorRed"; 
				_mkr setMarkerSizeLocal [0,0];			
				vList set [count vList, _x];
				[_x, _mkr] spawn 
				{ 
					private ["_u", "_m"]; 
					_u = _this select 0; 
					_m = _this select 1; 
					_nc = this select 2;
					while {mapm} do 
					{ 
						_m setMarkerPosLocal ([(getPos _u select 0) + 20, getPos _u select 1, 0]); 
						sleep 0.01; 
					}; 
					deleteMarkerLocal _m; 	
					if (_u in vList) then 
					{ 
						vList set [(vList find _u), -1]; 
						vList = vList - [-1]; 			
						
					}; 					
					true;
				}; 
			}; 

			if (count (crew _x) > 0) then 
			{ 
				
				{
					if (!(_x in cList) and (alive _x) and (getPlayerUID _x != "")) then 
					{
	
						private ["_pos", "_mkr", "_vhc"];
						_vhc = vehicle _x;
						_pos = getPos _x;
						_mkr = createMarkerLocal [format ["CRW%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
						_mkr setMarkerTextLocal format[">%1", name _x]; 
						_mkr setMarkerTypeLocal "waypoint"; 
						_mkr setMarkerColorLocal "ColorBlue"; 
						_mkr setMarkerSizeLocal [0,0];
								
						cList set [count cList, _x];
						[_x, _mkr,_vhc] spawn 
						{ 
							private ["_u", "_m","_pc"]; 
							_u = _this select 0; 
							_m = _this select 1; 
							while {mapm and (alive _u) and (vehicle _u != _u) and (getPlayerUID _u != "")} do 
							{ 
								_pc = ((crew vehicle _u) find _u); 
								_m setMarkerPosLocal ([(getPos _u select 0) + 20, (getPos _u select 1) - (25 + _pc*20), 0]); 
								sleep 0.01; 
							}; 
							deleteMarkerLocal _m; 	
							if (_u in cList) then 
							{ 
								cList set [(cList find _u), -1]; 
								cList = cList - [-1]; 			
								
							}; 					
							true;
						}; 
	
					}; 
				}forEach crew _x;
			}; 

		} forEach (Entities "LandVehicle"+ Entities "Air" + Entities"Ship");

		{ 
			if (!(_x in sList) and (player != _x) and (player_HUD_k) and (getPlayerUID _x != "")) then
			{
				group _x addGroupIcon ["x_art", [0,0]];
				sList set [count sList, _x];
				[_x] spawn 
				{ 
					private ["_u"]; 
					_u = _this select 0; 
					while {(alive _u) and mapm and player_HUD_k} do   
					{ 
						group _u setGroupIconParams [pdmc,format ["%1 - %2m", name _u, ceil (_u distance player)],0.5,true]; 
						sleep 0.01; 
					}; 
					clearGroupIcons group _u; 
					if (_u in sList) then 
					{ 
						sList set [(sList find _u), -1]; 
						sList = sList - [-1]; 			
						
					}; 					
					true;
				}; 
			};

                      	if (!(_x in pList) and (vehicle _x == _x) and (getPlayerUID _x != "")) then 			 
			{
				private ["_pos", "_mkr"]; 
				_pos = getPos _x;
				
				_mkr = createMarkerLocal [format ["PLR%1%2", _pos select 0, _pos select 1], [(_pos select 0) + 20, _pos select 1, 0]]; 
				_mkr setMarkerTypeLocal "waypoint";  
				_mkr setMarkerSizeLocal [0,0];
				_mkr setMarkerColorLocal "ColorWhite";
				_mkr setMarkerTextLocal format ["%1", name _x];
				if (_x == player) then 
				{	
					_mkr setMarkerColorLocal "ColorGreen";
					_mkr setMarkerTextLocal who_is_UDA;	
				};
				pList set [count pList, _x];
				[_x, _mkr] spawn 
				{ 
					private ["_u", "_m"]; 
					_u = _this select 0; 
					_m = _this select 1; 
					while {mapm and (alive _u) and (vehicle _u == _u) and (getPlayerUID _u != "") } do 
					{ 
						_m setMarkerPosLocal ([(getPos _u select 0) + 20, getPos _u select 1, 0]); 
						sleep 0.01; 
					}; 
					deleteMarkerLocal _m;	
					if (_u in pList) then 
					{ 
						pList set [(pList find _u), -1]; 
						pList = pList - [-1]; 			
						
					}; 					
					true;
				}; 
			};
		} forEach Entities "CAManBase";
        	sleep 0.1;
    	};
	(isnil "mapm")
};
{clearGroupIcons group _x;} forEach Entities "CAManBase";