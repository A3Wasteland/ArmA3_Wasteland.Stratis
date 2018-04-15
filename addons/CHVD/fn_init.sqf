// note from AgentRev: I did some cleanup and fixed inconsistent behavior from the original version

0 spawn
{
	CHVD_scriptRunning = true;

	//Wait for mission init, in case there are variables defined some place else
	waitUntil {time > 0};
	CHVD_allowTerrain = false; // disabled because too many issues

	//Define variables, load from profileNamespace
	CHVD_allowNoGrass = false; // deprecated // if (isNil "CHVD_allowNoGrass") then { CHVD_allowNoGrass = false };
	if (isNil "CHVD_allowTerrain") then { CHVD_allowTerrain = false };
	if (isNil "CHVD_maxView") then { CHVD_maxView = 12000 };
	if (isNil "CHVD_maxObj") then { CHVD_maxObj = 12000};

	CHVD_footSyncObj = profileNamespace getVariable ["CHVD_footSyncObj", false];
	CHVD_carSyncObj = profileNamespace getVariable ["CHVD_carSyncObj", false];
	CHVD_airSyncObj = profileNamespace getVariable ["CHVD_airSyncObj", false];

	CHVD_foot = (profileNamespace getVariable ["CHVD_foot", viewDistance]) min CHVD_maxView max 200;
	CHVD_car = (profileNamespace getVariable ["CHVD_car", viewDistance]) min CHVD_maxView max 200;
	CHVD_air = (profileNamespace getVariable ["CHVD_air", viewDistance]) min CHVD_maxView max 200;

	CHVD_footObj = (profileNamespace getVariable ["CHVD_footObj", getObjectViewDistance param [0,viewDistance,[0]]]) min CHVD_maxObj max 0;
	CHVD_carObj = (profileNamespace getVariable ["CHVD_carObj", getObjectViewDistance param [0,viewDistance,[0]]]) min CHVD_maxObj max 0;
	CHVD_airObj = (profileNamespace getVariable ["CHVD_airObj", getObjectViewDistance param [0,viewDistance,[0]]]) min CHVD_maxObj max 0;

	/*if (CHVD_allowTerrain) then
	{
		CHVD_footTerrain = profileNamespace getVariable ["CHVD_footTerrain", getTerrainGrid];
		CHVD_carTerrain = profileNamespace getVariable ["CHVD_carTerrain", getTerrainGrid];
		CHVD_airTerrain = profileNamespace getVariable ["CHVD_airTerrain", getTerrainGrid];
		if (!CHVD_allowNoGrass) then
		{
			CHVD_footTerrain = CHVD_footTerrain min 10 max 3.125;
			CHVD_carTerrain = CHVD_carTerrain min 10 max 3.125;
			CHVD_airTerrain = CHVD_airTerrain min 10 max 3.125;
		};
	}
	else
	{*/
		CHVD_footTerrain = getTerrainGrid;
		CHVD_carTerrain = getTerrainGrid;
		CHVD_airTerrain = getTerrainGrid;
	//};

	CHVD_targetView = CHVD_footObj;
	CHVD_targetObj = CHVD_footObj;
	CHVD_targetTerrain = CHVD_footTerrain;

	//Begin initialization
	waitUntil {!isNull player && !isNull findDisplay 46};

	//_actionText = if (isLocalized "STR_chvd_title") then {localize "STR_chvd_title"} else {"View Distance Settings"};
	//player addAction [_actionText, CHVD_fnc_openDialog, [], -99, false, true];
	//player addEventHandler ["Respawn", format ["player addAction ['%1', CHVD_fnc_openDialog, [], -99, false, true]", _actionText]];

	//Detect when to change setting type
	0 spawn { waitUntil CHVD_fnc_updateSettings };
};