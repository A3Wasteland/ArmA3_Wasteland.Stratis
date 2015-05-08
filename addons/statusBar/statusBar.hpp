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
			x = safezoneX + (safezoneW * 0.3); // 30% offset each side
			y = safezoneY + safezoneH - 0.035;
			w = safezoneW * 0.4; // 40% width
			h = 0.04;
			shadow = 1;
			colorBackground[] = { 0, 0, 0, 0.3 };  // uncomment and increase 4th number to have a background
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
