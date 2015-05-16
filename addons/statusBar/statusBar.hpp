#define ST_RIGHT 0x01

class osefStatusBar {
	idd = -1;
	onLoad = "uiNamespace setVariable ['osefStatusBar', _this select 0]";
	onUnload = "uiNamespace setVariable ['osefStatusBar', objNull]";
	onDestroy = "uiNamespace setVariable ['osefStatusBar', objNull]";
	fadein = 0;
	fadeout = 0;
	duration = 10e10;
	movingEnable = 1;
	controlsBackground[] = {};
	objects[] = {};
	class controls {
		class statusBarText {
			idc = 1000;
			w = safezoneW * 0.6;               // 60% width
			x = safezoneX + (safezoneW * 0.2); // 20% position from left
			h = 0.04;                          // 4% height
			y = safezoneY + safezoneH - 0.035; // 3.5% position from bottom
			shadow = 1;
			colorBackground[] = { 0, 0, 0, 0.3 }; // uncomment and increase 4th number to have a background
			font = "PuristaSemibold";
			size = 0.035;
			type = 13;
			style = 1;
			text="Inicializando ...";
			class Attributes {
				align = "center";
				color = "#FFFFFF";
			};
		};
	};
};
