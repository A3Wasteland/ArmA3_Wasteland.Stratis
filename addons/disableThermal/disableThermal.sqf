// Creator: CRE4MPIE
// Editted by: Isaac Harding


if (isServer) exitwith {}; //SpeedWeasel's Fix for CPS issues http://forums.a3wasteland.com/index.php?topic=1989.msg13160#msg13160

_layer = 85125; 
_launchers =["launch_I_Titan_short_F","launch_O_Titan_short_F","launch_B_Titan_short_F","launch_Titan_short_F","launch_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_F","launch_B_Titan_tna_F","launch_O_Titan_ghex_F","launch_B_Titan_short_tna_F","launch_O_Titan_short_ghex_F", "launch_B_Titan_tna_F", "launch_B_Titan_short_tna_F", "H_HelmetO_ViperSP_ghex_F"];  // launcher array


while {true} do 
{ 
if (currentVisionMode player == 2) then																		// check for TI Mode
{
	if (currentweapon player in _launchers) then															// check if player has launcher as current weapon
		{ 																										
             _layer cutText ["THERMAL IMAGING OFFLINE", "BLACK", 0.001, false];	// Blackout screen with Text
			playSound "FD_CP_Not_Clear_F";
            waituntil {currentVisionMode player != 2};
            _layer cutText ["", "PLAIN", 0.001, false];
		}
	else
	{
	if (alive (getConnectedUAV player)) then																// check if player is connected to a UAV			
		{																											
             _layer cutText ["THERMAL IMAGING OFFLINE", "BLACK", 0.001, false];	// Blackout screen with Text
			playSound "FD_CP_Not_Clear_F";
            waituntil {currentVisionMode player != 2};
            _layer cutText ["", "PLAIN", 0.001, false];
		}
		else
		{
			setViewDistance 3000;																			// set viewdistance for all other thermals																					
			waituntil {currentVisionMode player != 2};
			setViewDistance -1;																				// reset viewdistance to default
		}
	};	
};	
	
	sleep 1;
};
