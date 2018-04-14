// disableThermal.sqf
// by CRE4MPIE
// ver 0.3
// 2015-04-29 11:44pm
// contributions from BIStudio Forums, edited by CRE4MPIE, optimized by AgentRev

_launchers = ["launch_I_Titan_short_F","launch_O_Titan_short_F","launch_B_Titan_short_F","launch_Titan_short_F","launch_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_F","launch_B_Titan_tna_F","launch_O_Titan_ghex_F","launch_B_Titan_short_tna_F","launch_O_Titan_short_ghex_F", "launch_B_Titan_tna_F", "launch_B_Titan_short_tna_F", "H_HelmetO_ViperSP_ghex_F"];  // launcher array
_vehicles = ["B_HMG_01_high_F","B_static_AA_F","B_static_AT_F","B_GMG_01_F","B_T_LSV_01_AT_F","O_T_LSV_02_AT_F","B_AFV_Wheeled_01_cannon_F","B_AFV_Wheeled_01_up_cannon_F","I_LT_01_scout_F","I_LT_01_cannon_F","I_LT_01_AT_F","I_LT_01_AA_F","O_T_MBT_04_cannon_F","O_T_MBT_04_command_F"];

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
