// Virtual Arsenal Supporter Customization - 
// by CRE4MPIE
// Inspired by fn_r3m3dy - thx xD
// PS: Arrays are a bitch


// Remember to change your createvehicle.txt to log for logic only and not kick ( 3 "^Logic")
// Add exception to antihack for BIS_fnc_arsenal,bis_fnc_setidentity in filterExecAttempt.sqf
// payload.sqf	if (!isNull (uiNamespace getVariable ["RscDisplayArsenal", displayNull]) && !_isAdmin) exitWith { _cheatFlag = "Virtual Arsenal" };



// Supporter Loadout  
_supportersEnabled = ["A3W_supportersEnabled"] call isConfigOn;
_supporterLevel = player getVariable ["supporter", 0];


switch (_supporterLevel) do {	
		case 1: // Supporter
			{			
					
				["Open",true] call BIS_fnc_arsenal;


				systemChat format["Welcome %1, Enjoy your Supporter Loadout!", name player];
		};	
};

//waitUntil {isNull (uiNamespace getVariable ["RscDisplayArsenal", displayNull])};
	


	