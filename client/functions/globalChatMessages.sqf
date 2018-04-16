/*
	----------------------------------------------------------------------------------------------

	Copyright © 2016 soulkobk (soulkobk.blogspot.com)

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU Affero General Public License as
	published by the Free Software Foundation, either version 3 of the
	License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU Affero General Public License for more details.

	You should have received a copy of the GNU Affero General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.

	----------------------------------------------------------------------------------------------

	Name: globalChatMessages.sqf
	Version: 1.0.0
	Author: soulkobk (soulkobk.blogspot.com)
	Creation Date: 5:31 PM 18/10/2016
	Modification Date: 5:31 PM 18/10/2016

	Change Log:
	1.0.0 -	original base script.

	----------------------------------------------------------------------------------------------
*/

_globalChatPrefix = "FRACbot";

_globalChatMessagesSleep = 30*60; // 30 minutes sleep per full loop.

_globalChatMessages = [
    ["You are playing on Fractured's A3Wasteland Stratis server.",120],
    ["Discord -> discord.frac.gg",120],
    ["Website -> Fractured-Gaming.com",120],
    ["Server restarts are at 6am, 12pm, 6pm and 12am daily (CST).",120],
    ["Gearlevel Information -> Can be found in the map menu.",120],
    ["You can view your stats or anyone elses stats -> stats.frac.gg ",120],
    ["If you encounter a bug, please post it on the forums -> forums.fractured-gaming.com .",120],
    ["Servers cost money, and they aint cheap! Donate -> donate.frac.gg",120],
    ["Want to be a FRAC Member? Apply on the forums!.",120],
    ["Server Rules:",1],
    ["NO Hacking, Cheating or Exploiting!",30],
    ["NO Racism, Heterosexism, or Bashing Religion! This is to include the terminology.",30],
    ["NO Advertising Any Other VOIP or Community/Clan/Guild!",30],
    ["NO Abusing VOIP!",30],
    ["English Only When Using VOIP or Side/Global Chat!",30],
    ["If You Don't Like It Here, Then Leave! If Not, we will show you the door!",30],
    ["Don't Be An Asshole!",30],
    ["Admins Can/Will Ban At Their Own Discretion To Stop Toxicity On The Server",30]
];

/*	------------------------------------------------------------------------------------------
	DO NOT EDIT BELOW HERE!
	------------------------------------------------------------------------------------------	*/

if (((count _globalChatMessages) >= 1) && (hasInterface)) then
{
	if (_globalChatMessagesSleep < 600) then
	{
		_globalChatMessagesSleep = 600;
	};
	while {true} do
	{
		uiSleep _globalChatMessagesSleep;
		{
			_currentMessage = _x select 0;
			_currentSleep = _x select 1;
			server globalChat format ["%1 -> %2",_globalChatPrefix,_currentMessage];
			uiSleep _currentSleep;
		} forEach _globalChatMessages;
	};
};
