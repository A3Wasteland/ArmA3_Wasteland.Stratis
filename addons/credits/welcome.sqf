//	@file Version: 1.0
//	@file Name: intro.sqf
//	@file Author: Cael817, original file by HellsGateGaming.com and IT07
//	@file Created: 20140724 19:34

_onScreenTime = 5;

sleep 15;

_role1 = "Welcome to A3WASTELAND ZA#101 STRATIS";
_role1names = ["The #1 Wasteland server in Africa!"];
_role2 = "Server Owner and Head Admin";
_role2names = ["CRE4MPIE"];
_role3 = "Server Restarts";
_role3names = ["This server is restarted regularly to ensure optimal server performance!"]; 
_role4 = "Join us on Teamspeak";
_role4names = ["cptts.gameservers.com:9194"];
_role5 = "Feedback";
_role5names = ["Please report any bugs or issues on teamspeak!"];
_role6 = "Object saving";
_role6names = ["Locked Objects are saved for 7 days. This includes base-parts and crates."];
_role7 = "Vehicle saving";
_role7names = ["Vehicles are automatically saved when bought from stores or completed missions."];
_role8 = "Player saving";
_role8names = ["Player data is automatically saved"];
_role9 = "Addons";
_role9names = ["There are many supported client mods - get the links on Teamspeak :) "];
_role10 = "Forums";
_role10names = ["http://arma3za.clanservers.com/"];
_role11 = "WARNING";
_role11names = ["Please respect other players and admins! Teamkilling, Teamswitching and Teamstealing will not be tolerated !"];

{
sleep 2;
_memberFunction = _x select 0;
_memberNames = _x select 1;
_finalText = format ["<t size='0.50' color='#f2cb0b' align='left'>%1<br /></t>", _memberFunction];
_finalText = _finalText + "<t size='0.70' color='#FFFFFF' align='left'>";
{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
_finalText = _finalText + "</t>";
_onScreenTime + (((count _memberNames) - 1) * 0.5);
[
_finalText,
[safezoneX + safezoneW - 0.8,0.50], //DEFAULT: 0.5,0.35
[safezoneY + safezoneH - 0.8,0.7], //DEFAULT: 0.8,0.7
_onScreenTime,
0.5
] spawn BIS_fnc_dynamicText;
sleep (_onScreenTime);
} forEach [

[_role1, _role1names],
[_role2, _role2names],
[_role3, _role3names],
[_role4, _role4names],
[_role5, _role5names],
[_role6, _role6names],
[_role7, _role7names],
[_role8, _role8names],
[_role9, _role9names],
[_role10, _role10names],
[_role11, _role11names]
];