// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: briefing.sqf

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["changelog", "Changelog"];
player createDiarySubject ["credits", "Credits"];


player createDiaryRecord ["changelog",
[
"3 February 2015",
"
<br/> [Added] Few more guns to the weapon store
<br/> [Added] Few more vehicle textures 
<br/> [Changed] Supporter Camo's and rank 2 supporter loadout
"
]];


player createDiaryRecord ["changelog",
[
"2 February 2015",
"
<br/> [Added] More vehicle paint variants
<br/> [Changed] AH-9B Pawnee now has DAGR missiles
"
]];

player createDiaryRecord ["changelog",
[
"1 February 2015",
"
<br/> [Changed] Supporter System Rewrite
<br/> [Changed] ATM limit raised to $500,000.
<br/> [Added] Custom clothing colours for gangs and clans
<br/> [Added] Metis Launcher and Scorpion SA-61 to the Gunstore
"
]];


player createDiaryRecord ["changelog",
[
"31 January 2015",
"
<br/> [Added] Roadblock Mission
<br/> [Changed] Territory System (Testing)
"
]];


player createDiaryRecord ["changelog",
[
"28 January 2015",
"
<br/> [Added] Selling vehicles at the vehicle store.
<br/> [Added] Service vehicles at the vehicle store.
<br/> [Removed] Vehicle Contents on Air dropped Vehicles
"
]];

player createDiaryRecord ["changelog",
[
"27 January 2015",
"
<br/> [Updated] Supporter Loadout List.
<br/> [Updated] Player Spawn Weapon Changed to MP7.
<br/> [Changed] Player role names more generic
<br/> [Added] Air dropped Vehicles now save.
<br/> [Removed] Sell Vehicle and Re-arm helipads.
<br/> [Adjusted] General Store Prices in-line with economy.

"
]];

player createDiaryRecord ["changelog",
[
"26 January 2015",
"
<br/> [Added] 2 More mission crate variants
<br/> [Added] Flares to Supply Drops
<br/> [Added] Whitelisted BLUFOR - ask on teamnspeak (Testing)
"
]];


player createDiaryRecord ["changelog",
[
"22 January 2015",
"
<br/> [Added] You can now request Airdrops =)
"
]];

player createDiaryRecord ["changelog",
[
"20 January 2015",
"
<br/> [Updated] Version 1.1 of Arma 3 Wasteland Merge
"
]];

player createDiaryRecord ["changelog",
[
"20 January 2015",
"
<br/> [Updated] Agia Marina Slums
<br/> [Updated] Slight Performance Optimization
<br/> [Removed] Temp removal of basketball courts
<br/> [Fixed] NPC Loadout had wrong RPGs
"
]];

player createDiaryRecord ["credits",
[
"Credits",
"
<br/><font size='16' color='#BBBBBB'>Developed by A3Wasteland.com:</font>
<br/>	* AgentRev (TeamPlayerGaming)
<br/>	* JoSchaap (GoT/Tweakers.net)
<br/>	* MercyfulFate
<br/>	* His_Shadow (KoS/KillonSight)
<br/>	* Bewilderbeest (KoS/KillonSight)
<br/>	* Torndeco
<br/>	* Del1te (404Games)
<br/>
<br/><font size='16' color='#BBBBBB'>Original Arma 2 Wasteland missions by:</font>
<br/>	* Tonic
<br/>	* Sa-Matra
<br/>	* MarKeR
<br/>
<br/><font size='16' color='#BBBBBB'>Improved and ported to Arma 3 by 404Games:</font>
<br/>	* Deadbeat
<br/>	* Costlyy
<br/>	* Pulse
<br/>	* Domuk
<br/>
<br/><font size='16' color='#BBBBBB'>Other contributors:</font>
<br/>	* 82ndab-Bravo17 (GitHub)
<br/>	* afroVoodo (Armaholic)
<br/>	* Austerror (GitHub)
<br/>	* AWA (OpenDayZ)
<br/>	* bodybag (Gameaholic.se)
<br/>	* code34 (iniDBI)
<br/>	* Das Attorney (Jump MF)
<br/>	* Ed! (404Games forums)
<br/>	* Farooq (GitHub)
<br/>	* HatchetHarry (GitHub)
<br/>	* Hub (TeamPlayerGaming)
<br/>	* k4n30 (GitHub)
<br/>	* Krunch (GitHub)
<br/>	* madbull (R3F)
<br/>	* Mainfrezzer (Magnon)
<br/>	* meat147 (GitHub)
<br/>	* Na_Palm (BIS forums)
<br/>	* red281gt (GitHub)
<br/>	* RockHound (BierAG)
<br/>	* s3kShUn61 (GitHub)
<br/>	* Sa-Matra (BIS forums)
<br/>	* Sanjo (GitHub)
<br/>	* SCETheFuzz (GitHub)
<br/>	* Shockwave (A3W forums)
<br/>	* SicSemperTyrannis (iniDB)
<br/>	* SPJESTER (404Games forums)
<br/>	* spunFIN (BIS forums)
<br/>	* Tonic (BIS forums)
<br/>	* wiking.at (A3W forums)
<br/>
<br/><font size='16'>Thanks A LOT to everyone involved for the help and inspiration!</font>
"
]];


