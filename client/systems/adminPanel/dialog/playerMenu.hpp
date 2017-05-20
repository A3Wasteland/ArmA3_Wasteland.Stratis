// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
#define playerMenuDialog 55500
#define playerMenuPlayerGun 55502
#define playerMenuPlayerList 55505
#define playerMenuSpectateButton 55506
#define playerMenuWarnMessage 55509
#define playerMenuPlayerUID 55510
#define playerMenuPlayerSteam 55511

class PlayersMenu
{
	idd = playerMenuDialog;
	movingEnable = false;
	enableSimulation = true;

	class controlsBackground {

		class MainBackground: IGUIBack
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {0,0,0,0.6};

			x = -0.225;
			y = -0.16;
			w = 1.4375;
			h = 1.42;
		};

		class TopBar: IGUIBack
		{
			idc = -1;
			colorText[] = {1, 1, 1, 1};
			colorBackground[] = {A3W_UICOLOR_R, A3W_UICOLOR_G, A3W_UICOLOR_B, 0.8};

			x = -0.225;
			y = -0.16;
			w = 1.4375;
			h = 0.12;
		};

		class DialogTitleText: w_RscText
		{
			idc = -1;
			text = "NYC Target Player";

			font = "PuristaMedium";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			x = -0.225;
			y = -0.16;
			w = 0.575;
			h = 0.1;
		};

		class PlayerUIDText: w_RscEdit
		{
			idc = playerMenuPlayerUID;
			style = ST_LEFT + ST_FRAME;
			text = "UID:";
			sizeEx = 0.030;
			x = 0.605;
			y = -0.012;
			w = 0.5875;
			h = 0.06;
			colorSelection[] = {0.2,0.4,0.6,1};
			colorDisabled[] = {1,1,1,0.3};
			canModify = 0;
		};
		
		class PlayerSteamButton: w_RscStructuredText
		{
			idc = playerMenuPlayerSteam;
			size = 0.032;
			text = "<img image='\A3\ui_f\data\gui\RscCommon\RscButtonMenuSteam\steam_ca.paa' size='1.1'/>"; // set in importValues.sqf
			colorBackground[] = {0,0,0,1};
			x = 0.76 * (4/3) * SZ_SCALE_ABS + safezoneX;
			y = 0.2225 * SZ_SCALE_ABS + safezoneY;
			w = 0.025 * SZ_SCALE_ABS;
			h = 0.025 * SZ_SCALE_ABS;

			class Attributes
			{
				align = "center";
				valign = "bottom";
			};
		};

		class PlayerGunText: w_RscText
		{
			idc = playerMenuPlayerGun;
			text = "Money:";
			sizeEx = 0.030;
			x = 0.6075;
			y = 0.06;
			w = 0.3875;
			h = 0.04;
		};

	};

	class controls {

		class PlayerEditBox:w_RscEdit
		{
			idc=playerMenuWarnMessage;
			x = 0.6125;
			y = 1.04;
			w = 0.575;
			h = 0.2;
			colorDisabled[] = {1,1,1,0.3};
			sizeEx = 0.032;
		};

		class PlayerListBox: w_RscList
		{
			idc = playerMenuPlayerList;
			onLBSelChanged="[2,_this select 1] execVM ""client\systems\adminPanel\importvalues.sqf"";";
			
			x = -0.2125;
			y = -0.02;
			w = 0.8;
			h = 1.26;
		};

		class SpectateButton: w_RscButton
		{
			idc = playerMenuSpectateButton;
			text = "Spectate";
			onButtonClick = "[0] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.6125;
			y = 0.16;
			w = 0.1625;
			h = 0.1;
		};

		class SlayButton: w_RscButton
		{
			idc = -1;
			text = "Slay";
			onButtonClick = "[2] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.6125;
			y = 0.48;
			w = 0.1625;
			h = 0.1;
		};

		class UnlockTeamSwitchButton: w_RscButton
		{
			idc = -1;
			text = "Unlock Team";
			onButtonClick = "[3] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.805;
			y = 0.16;
			w = 0.1625;
			h = 0.1;
		};

		class UnlockTeamKillerButton: w_RscButton
		{
			idc = -1;
			text = "Unlock TK";
			onButtonClick = "[4] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 1;
			y = 0.16;
			w = 0.1625;
			h = 0.1;
		};

		class RemoveAllMoneyButton: w_RscButton
		{
			idc = -1;
			text = "Remove All £";
			onButtonClick = "[5] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.8125;
			y = 0.48;
			w = 0.1625;
			h = 0.1;
		};

		class RemoveAllWeaponsButton: w_RscButton
		{
			idc = -1;
			text = "Eject Player";
			onButtonClick = "[6] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 1;
			y = 0.48;
			w = 0.1625;
			h = 0.1;
		};

		class CheckPlayerGearButton: w_RscButton
		{
			idc = -1;
			text = "Negate Monies";
			onButtonClick = "[7] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.6125;
			y = 0.64;
			w = 0.1625;
			h = 0.1;
		};

		class WarnButton: w_RscButton
		{
			idc = -1;
			text = "Warn";
			onButtonClick = "[1] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.6125;
			y = 0.9;
			w = 0.1625;
			h = 0.1;
		};

		class tbc3: w_RscButton
		{
			idc = -1;
			text = "Cock Head"; //--- ToDo: Localize;
			onButtonClick = "[12] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 1;
			y = 0.64;
			w = 0.1625;
			h = 0.1;
		};

		class tbc2: w_RscButton
		{
			idc = -1;
			text = "Kick Player";  //--- ToDo: Localize;			
			onButtonClick = "[11] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.8125;
			y = 0.64;
			w = 0.1625;
			h = 0.1;
		};

		class tp2them: w_RscButton
		{
			idc = -1;
			text = "TP  2 Them"; //--- ToDo: Localize;
			onButtonClick = "[8] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.6125;
			y = 0.32;
			w = 0.1625;
			h = 0.1;
		};

		class tp2me: w_RscButton
		{
			idc = -1;
			text = "TP  2 Me"; //--- ToDo: Localize;
			onButtonClick = "[9] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 0.8125;
			y = 0.32;
			w = 0.1625;
			h = 0.1;
		};

		class healtarget: w_RscButton
		{
			idc = -1;
			text = "Heal Target"; //--- ToDo: Localize;
			onButtonClick = "[10] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 1;
			y = 0.32;
			w = 0.1625;	
			h = 0.1;
		};
		
		class ForceHALOJumpButton: w_RscButton
		{
			idc = -1;
			text = "Unstick";
			onButtonClick = "[13] execVM 'client\systems\adminPanel\playerSelect.sqf'";
			x = 1;
			y = 0.9;
			w = 0.1625;
			h = 0.1;
		};
	};
};

