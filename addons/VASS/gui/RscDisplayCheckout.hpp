class TER_VASS_RscCheckout: VASS_RscControlsGroupNoScrollbars
{
	idc = IDC_RSCDISPLAYCHECKOUT_CHECKOUT;
	fade = 1;
	x = safeZoneX;
	y = safeZoneY;
	w = safeZoneW;
	h = safeZoneH;
	onLoad = "[""onLoad"",_this] execVM ""addons\VASS\gui\scripts\RscDisplayCheckout.sqf"";";
	class controls
	{
		class back: VASS_RscText
		{
			style=144;
			tileW="8 / (32 * pixelW)";
			tileH="4 / (32 * pixelH)";
			colorText[]={1,1,1,0.1};
			text="\a3\3DEN\Data\Displays\Display3DENEditAttributes\backgroundDisable_ca.paa";
			x = 0;
			y = 0;
			w = 0;//safeZoneW;
			h = 0;//safeZoneH;
		};
		class Title: VASS_RscText
		{
			text = "Confirm Purchase"; //--- ToDo: Localize;
			colorBackground[]=
			{
				"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
				"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
			};
			x = -10.6 * GUI_GRID_W + 0.5 * safeZoneW;
			y = -11.7 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 21.2 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class GuiBack: VASS_RscText
		{
			colorBackground[]={0,0,0,0.8};
			x = -10.6 * GUI_GRID_W + 0.5 * safeZoneW;
			y = -10.6 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 21.2 * GUI_GRID_W;
			h = 21.3 * GUI_GRID_H;
		};
//	};
//	class controls
//	{
		class TabsChange: VASS_RscToolbox
		{
			idc = IDC_RSCDISPLAYCHECKOUT_TABSCHANGE;
			x = -10.5 * GUI_GRID_W + 0.5 * safeZoneW;
			y = -10.5 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 21 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			strings[] = {"ADDED","REMOVED"};
		};
		class LnbItemsAddedHeader: VASS_RscListNBox
		{
			idc = IDC_RSCDISPLAYCHECKOUT_LNBHEADERITEMS;
			disableOverflow = true;
			x = -10.5 * GUI_GRID_W + 0.5 * safeZoneW;
			y = -9.4 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 21 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			columns[] = {-0.01, 0.08, 0.15, 0.65, 0.8};
		};
		class LnbItemsAdded: LnbItemsAddedHeader
		{
			idc = IDC_RSCDISPLAYCHECKOUT_LNBITEMSADDED;
			y = -8.4 * GUI_GRID_H + 0.5 * safeZoneH;
			h = 15.8 * GUI_GRID_H;
		};
		class LnbItemsRemoved: LnbItemsAdded
		{
			show = false;
			idc = IDC_RSCDISPLAYCHECKOUT_LNBITEMSREMOVED;
		};
		class BtnBuy: VASS_RscButtonMenu
		{
			idc = IDC_RSCDISPLAYCHECKOUT_BTNBUY;
			text = "BUY"; //--- ToDo: Localize;
			x = -10.5 * GUI_GRID_W + 0.5 * safeZoneW;
			y = 9.6 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class BtnReturn: VASS_RscButtonMenu
		{
			idc = IDC_RSCDISPLAYCHECKOUT_BTNRETURN;
			text = "RETURN"; //--- ToDo: Localize;
			x = 1 * GUI_GRID_W + 0.5 * safeZoneW;
			y = 9.6 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 9.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class StxtMoney: VASS_RscStructuredText
		{
			idc = IDC_RSCDISPLAYCHECKOUT_STXTMONEY;
			x = -10.5 * GUI_GRID_W + 0.5 * safeZoneW;
			y = 7.5 * GUI_GRID_H + 0.5 * safeZoneH;
			w = 21 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
		};
	};
};

/* #Nyvoze
$[
	1.063,
	["wadawda",[["0.5","0.5",0,0],"((safezoneW / safezoneH) min 1.2) / 40","(((safezoneW / safezoneH) min 1.2) / 1.2) / 25","GUI_GRID"],0,0,0],
	[1100,"Title",[2,"Confirm Purchase",["-10.6 * GUI_GRID_W + GUI_GRID_X","-11.7 * GUI_GRID_H + GUI_GRID_Y","21.2 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2200,"GuiBack",[2,"",["-10.6 * GUI_GRID_W + GUI_GRID_X","-10.6 * GUI_GRID_H + GUI_GRID_Y","21.2 * GUI_GRID_W","21.3 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"LbItems",[2,"",["-10.5 * GUI_GRID_W + GUI_GRID_X","-10.5 * GUI_GRID_H + GUI_GRID_Y","21 * GUI_GRID_W","18.9 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2600,"BtnBuy",[2,"BUY",["-10.5 * GUI_GRID_W + GUI_GRID_X","9.6 * GUI_GRID_H + GUI_GRID_Y","9.5 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2700,"BtnReturn",[2,"RETURN",["1 * GUI_GRID_W + GUI_GRID_X","9.6 * GUI_GRID_H + GUI_GRID_Y","9.5 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"StxtMoney",[2,"",["-10.5 * GUI_GRID_W + GUI_GRID_X","8.5 * GUI_GRID_H + GUI_GRID_Y","21 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
