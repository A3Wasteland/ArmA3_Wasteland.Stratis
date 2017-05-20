sleep 90;

private ["_messages", "_timeout"];

_messages = [
    ["A3Wasteland", worldName],
	["Welcome", (name player)],
	["Cuntee`", "Loves You Dearly!"],
	["THIS IS A PvP SERVER!", "I REPEAT, THIS IS A PvP SERVER! YOU WILL BE KILLED BY OTHER PLAYERS!!"],
	["Website", "NYCwasteland.com"],
	["Join Our Teamspeak", "NYCwasteland.com"],
	["Server Owner", "jimbob"],
	["Server Admins", "EVILBOY4LIFE666, Anthony"],
	["Server's Lame Cunts", "(CHEK6)ROADKILL, xlxREDBULLxlx"],
	["NO KIDDIES!", "This game is rated M for mature, Children are not allowed on this server and will be banned on sight!"],
	["Filter NYCwasteland", "In the ArmA 3 Launcher to Favorite all three of our Servers."],
	["Remember To", "Lock all base parts, War-chests and Crates to ensure their saving!"],
	["Database Wipes", "Base parts are wiped the 20th of each month, Vehicles are wiped every Sunday night for optimum playability."],
	["Earplugs", "Put in your earplugs by using the END key."],
	["Holster", "Holster And UN-Holster your Weapon by using the H key."],
	["Server", "Restarts every 6 hours."]
];

_timeout = 5;
{
	private ["_title", "_content", "_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.50' color='#a81e13' align='left' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='left'>%2</t>"), _title, _content];
	[_titleText,[safezoneX + safezoneW - 0.8,0.50],[safezoneY + safezoneH - 0.8,0.7],_timeout,0.5] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;
