// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: briefing.sqf

if (!hasInterface) exitWith {};

_trimName = { _this select [1, count _this - 2] };
_aKeyName = { _arr = actionKeysNamesArray _this; if (count _arr == 0) exitWith {"<UNDEFINED>"}; _arr select 0 };

#define NKEYNAME(DIK) (keyName DIK call _trimName)
#define AKEYNAME(ACT) (ACT call _aKeyName)

waitUntil {!isNull player};

player createDiarySubject ["infos", "Infos and Help"];
player createDiarySubject ["changelog", "Changelog"];
player createDiarySubject ["credits", "Credits"];
player createDiarySubject ["admins", "Admin List"];
player createDiarySubject ["gearlevel", "Gear Level Info"];

player createDiaryRecord ["changelog",
[
"FRACTURED Logs",
"
<br/>][REMOVED] Bounty System by Centrifugal
<br/>[FIXED] Optimizations for Server
<br/>[NEW VERSION] Server Updated and re-released as 2.0

"
]];


player createDiaryRecord ["changelog",
[
"v1.4",
"
<br/>[Added] Laws of War DLC
<br/>[Added] Killfeed HUD
<br/>[Changed] Improved revive system
<br/>[Changed] Improved kill attribution
<br/>[Changed] Improved antihack
<br/>[Fixed] Prone reload freeze
<br/>[Fixed] Many minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3b",
"
<br/>[Added] Private parking
<br/>[Added] Private storage
<br/>[Added] Vehicle ownership
<br/>[Added] Vehicle locking
<br/>[Added] Vehicle selling
<br/>[Added] Mine saving
<br/>[Added] Resupply trucks
<br/>[Added] CH View Distance
<br/>[Added] Map legend
<br/>[Added] UAV side persistence
<br/>[Added] headless server cleanup
<br/>[Changed] Static designators now available to indies
<br/>[Changed] Some store prices
<br/>[Fixed] Many other minor changes and fixes
"
]];

player createDiaryRecord ["changelog",
[
"v1.3",
"
<br/>[Added] Tanoa version
<br/>[Added] Apex content on dev/preview branches
<br/>[Added] Sticky explosive charges
br/> [Added] Heavy towing and airlifting
<br/>[Added] Load dragged injured friendly in vehicles
<br/>[Added] Eject loaded injured friendly from vehicles
<br/>[Added] Autostabilize when loaded in medical vehicle
<br/>[Added] 'Finish off' action to slay injured enemies
<br/>[Added] Improved injured unit detection
<br/>[Added] Scoreboard persistence option for servers
<br/>[Added] Fatal PvP headshots option for servers
<br/>[Added] Custom death messages option for servers
<br/>[ADded] Auto-center heli turret on manual fire
<br/>[Added] UAV side persistence
<br/>[Added] More textures for some vehicles in store
<br/>[Added] Abandoned quadcopter cleanup
<br/>[Added] More admin menu logging
<br/>[Changed] Reduced heli missile damage
<br/>[Changed] Improved mission crate loot
<br/>[Changed] Vest armor values in general store
<br/>[Changed] Increased Mag Repack flexibility
<br/>[Changed] Toggled off autonomous on static designators
<br/>[Changed] Disabled rain due to weather desync
<br/>[Fixed] Engineer with toolkit can now always repair
<br/>[Fixed] Improved missile lock-on
<br/>[Fixed] Improvements to kill tracking system
<br/>[Fixed] Items and money not dropping on injured logout
<br/>[Fixed] Combat log timer not resetting on death
<br/>[Fixed] Player not always ejected on injury
<br/>[Fixed] Double kill/death count
<br/>[Fixed] Spawn cooldowns resetting on rejoin
<br/>[Fixed] Striders spawning without laser batteries
<br/>[Fixed] Disabled rain due to syncing issues
<br/>[Fixed] Various minor bugfixes and optimizations
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
<br/>	* Champ-1 (CHVD)
<br/>	* code34 (iniDBI)
<br/>	* Das Attorney (Jump MF)
<br/>	* Ed! (404Games forums)
<br/>	* Farooq (GitHub)
<br/>	* gtoddc (A3W forums)
<br/>	* HatchetHarry (GitHub)
<br/>	* Hub (TeamPlayerGaming)
<br/>	* k4n30 (GitHub)
<br/>	* Killzone_Kid (KillzoneKid.com)
<br/>	* Krunch (GitHub)
<br/>	* LouDnl (GitHub)
<br/>	* madbull (R3F)
<br/>	* Mainfrezzer (Magnon)
<br/>	* meat147 (GitHub)
<br/>	* micovery (GitHub)
<br/>	* Na_Palm (BIS forums)
<br/>	* Outlawled (Armaholic)
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
<br/>	* xx-LSD-xx (Armaholic)
<br/>	* Zenophon (BIS Forums)
<br/>
<br/><font size='16'>Thanks A LOT to everyone involved for the help and inspiration!</font>
"
]];


_WASD = AKEYNAME("MoveForward") + "," + AKEYNAME("MoveBack") + "," + AKEYNAME("TurnLeft") + "," + AKEYNAME("TurnRight");

player createDiaryRecord ["infos",
[
"Admin Spectate keys",
"
<br/>Admin menu Spectate camera controls:
<br/>
<br/>Shift + " + AKEYNAME("NextChannel") + " (next player)
<br/>Shift + " + AKEYNAME("PrevChannel") + " (previous player)
<br/>Ctrl + " + NKEYNAME(18) + " (exit camera)
<br/>Ctrl + " + AKEYNAME("Chat") + " (attach/detach camera from target)
<br/>Ctrl + " + NKEYNAME(35) + " (toggle target HUD)
<br/>" + AKEYNAME("NightVision") + " (nightvision, thermal)
<br/>" + _WASD + " (move camera around)
<br/>" + NKEYNAME(16) + " (move camera up)
<br/>" + NKEYNAME(44) + " (move camera down)
<br/>Mouse Move (rotate camera)
<br/>Mouse Wheel Up (increase camera speed)
<br/>Mouse Wheel Down (decrease camera speed)
<br/>Shift + " + _WASD + " (move camera around faster)
<br/>" + AKEYNAME("ShowMap") + " (open/close map - click on map to teleport camera)
"
]];

player createDiaryRecord ["infos",
[
"Player hotkeys",
"
<br/>List of default player hotkeys:
<br/>
<br/>" + NKEYNAME(41) + " (open player menu)
<br/>" + NKEYNAME(207) + " (toggle earplugs)
<br/>" + NKEYNAME(199) + ", " + NKEYNAME(219) + ", " + NKEYNAME(220) + " (toggle player names)
<br/>Ctrl + " + AKEYNAME("GetOut") + " (emergency eject)
<br/>" + AKEYNAME("GetOver") + " (open parachute)
<br/>Shift + " + NKEYNAME(201) + " / " + NKEYNAME(209) + " (adjust nightvision)
<br/>" + NKEYNAME(22) + " (admin menu)
"
]];

player createDiaryRecord ["infos",
[
"Hints and Tips",
"
<br/><font size='18'>A3Wasteland</font>
<br/>
<br/>* At the start of the game, spread out and find supplies before worrying about where to establish a meeting place or a base, supplies are important and very valuable.
<br/>
<br/>* When picking a base location, it is best advised to pick a place that is out of the way and not so obvious such as airports, cities, map-bound bases, etc. remember, players randomly spawn in and around towns and could even spawn inside your base should you set it up in a town.
<br/>
<br/>* If you spawn in an area with no vehicles or supplies in the immediate area, DO NOT just click respawn from the pause menu, chances are if you search an area of a few hundred meters, you will find something.
<br/>
<br/>* Always be on the lookout for nightvision. they are located in the ammo crates, and there are pairs scattered throughout vehicles. You can also purchase them from the gunstores. Nighttime without them SUCKS, and if you have them, you can conduct stealth raids on enemy bases under the cover of complete darkness.
<br/>
<br/>* When you set up a base, never leave your supplies unguarded, one guard will suffice, but it is recommended you have at least 2, maybe 3 guards at base at all times.
<br/>
<br/>* There are very aggressive AI characters that spawn with most missions and will protect the mission objectives with deadly force, be aware of them.
"
]];

player createDiaryRecord ["infos",
[
"About Wasteland",
"
<br/>Wasteland is a team versus team versus team sandbox survival experience. The objective of this mission is to rally your faction, scavenge supplies, weapons, and vehicles, and destroy the other factions. It is survival at its best! Keep in mind this is a work in progress, please direct your reports to http://forums.a3wasteland.com/
<br/>
<br/>FAQ:
<br/>
<br/>Q. What am I supposed to do here?
<br/>A. See the above description
<br/>
<br/>Q. Where can I get a gun?
<br/>A. Weapons are found in one of three places, first in ammo crates that come as rewards from missions, , and second, in the gear section of the vehicles, which also randomly spawn around the map. The last place to find a gun would be at the gunshops located throughout the map. You can also find them on dead players whose bodies have not yet been looted.
<br/>
<br/>Q. What are the blue circles on the map?
<br/>A. The circles represent town limits. If friendly soldiers are in a town, you can spawn there from the re-spawn menu; however if there is an enemy presence, you will not be able to spawn there.
<br/>
<br/>Q. Why is it so dark, I cant see.
<br/>A. The server has a day/night cycle just like in the real world, and as such, night time is a factor in your survival. It is recommended that you find sources of light or use your Nightvision Goggles as the darkness sets in.
<br/>
<br/>Q. Is it ok for me to shoot my team mates?
<br/>A. If you are member of BLUFOR or OPFOR teams, then you are NOT allowed to shoot or steal items and vehicles from other players. If you play as Independent, you are free to engage anyone as well as team up with anyone you want.
<br/>
<br/>Q. Whats with the canisters, baskets and big bags?
<br/>A. This game has a food and water system that you must stay on top of if you hope to survive. You can collect food and water from food sacks and wells, or baskets and plastic canisters dropped by dead players. Food and water will also randomly spawn around the map.
<br/>
<br/>Q. I saw someone breaking a rule, what do I do?
<br/>A. Simply go into global chat and get the attention of one of the admins or visit our forums, and make a report if the offense is serious.
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Levels",
"
<br/> When you have enough $ for A gear level, Go and apply here http://fractured-gaming.com/application-forms.php?appid=4
<br/> When your application is recieved your gear level will be changed within 48 hours.
<br/> Your Money will then be deducted from your account.
<br/> To revieve a gear level, Fill out a gear level application on the forums to upgrade your gear level.
<br/> There are 10 Levels in total.
<br/> There are 5 Prestiege Levels. (after the 1st 10 levels)
<br/> Prestiege Gear Levels allow you to spawn with either nothing or the bare minimum. 
<br/> Prestiege Gear Levels are $10,000,000 per level and Prestiege level 5 is $25,000,000
<br/> Prestiege Gear Levels are for the hardcore wasteland players with a big payoff at the end.
<br/> The Final Prestiege level allows you to pick weapons from the VR before spawning. 
"
]];

player createDiaryRecord ["gearlevel",
[
"Prestiege Level 5",
"
<br/><font size='16'>Prestiege Level 5</font>
<br/><font size='15'>Cost: $25,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> Virtural Arsenal With almost every weapon in it.

"
]];

player createDiaryRecord ["gearlevel",
[
"Prestiege Level 4",
"
<br/><font size='16'>Prestiege Level 3</font>
<br/><font size='15'>Cost: $10,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> Bergen Backpack
<br/> 45 ACP and 4 Magazines
<br/> 2 Grenades

"
]];

player createDiaryRecord ["gearlevel",
[
"Prestiege Level 3",
"
<br/><font size='16'>Prestiege Level 3</font>
<br/><font size='15'>Cost: $10,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> Bergen Backpack
<br/> 45 ACP and 2 Magazines
<br/> 1 Grenade

"
]];

player createDiaryRecord ["gearlevel",
[
"Prestiege Level 2",
"
<br/><font size='16'>Prestiege Level 2</font>
<br/><font size='15'>Cost: $10,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> Bergen Backpack
<br/> 45 ACP and 1 Magazine

"
]];

player createDiaryRecord ["gearlevel",
[
"Prestiege Level 1",
"
<br/><font size='16'>Prestiege Level 1</font>
<br/><font size='15'>Cost: $10,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> Bergen Backpack

"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 10",
"
<br/><font size='16'>Gear Level 10</font>
<br/><font size='15'>Cost: $10,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> An Olive Carryall
<br/> A Plate Carrier GL Rig
<br/> A GPS
<br/> A pair of Binoculars
<br/> 4 Grenades
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> An ECH Light Helmet
<br/> A MK 14 with 5 Standard Mags a RCO and a suppressor instead of a MX Marksmen Rifle
<br/> A 4-five .45 Pistol with an MRD Sight and suppressor instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 9",
"
<br/><font size='16'>Gear Level 9</font>
<br/><font size='15'>Cost: $9,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $1000
<br/> An Olive Carryall
<br/> A Plate Carrier GL Rig
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> An ECH Light Helmet
<br/> An MX Marksmen rifle with 4 Mags an RCO and a suppressor instead of a MX Carbine
<br/> A 4-five .45 Pistol with an MRD Sight and Suppressor instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 8",
"
<br/><font size='16'>Gear Level 8</font>
<br/><font size='15'>Cost: $8,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $800
<br/> An Olive Carryall
<br/> An Olive Tactical Vest
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> An ECH Light Helmet
<br/> An MX Carbine with 2 Mags and a Hologsight instead of a TRG-20
<br/> A 4-five .45 Pistol with an MRD Sight instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 7",
"
<br/><font size='16'>Gear Level 7</font>
<br/><font size='15'>Cost: $7,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $700
<br/> An Olive Carryall
<br/> An Olive Tactical Vest
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> An ECH Light Helmet
<br/> A TRG-20 with 2 Mags and a Hologsight and Suppressor instead of a Vermin
<br/> A 4-five .45 Pistol with an MRD Sight instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 6",
"
<br/><font size='16'>Gear Level 6</font>
<br/><font size='15'>Cost: $6,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $600
<br/> An Olive Carryall
<br/> An Olive Tactical Vest
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> An ECH Light Helmet
<br/> A TRG-20 with 2 Mags and a Hologsight instead of a Vermin
<br/> A 4-five .45 Pistol instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 5",
"
<br/><font size='16'>Gear Level 5</font>
<br/><font size='15'>Cost: $5,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $500
<br/> An Olive Carryall
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> A TRG-20 with 2 Mags and a Hologsight instead of a Vermin
<br/> A 4-five .45 Pistol instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 4",
"
<br/><font size='16'>Gear Level 4</font>
<br/><font size='15'>Cost: $4,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $400
<br/> An Olive Carryall
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> A holosight and Suppressor on your Vermin
<br/> A 4-five .45 Pistol instead of the ACP .45
<br/> An RPG-42 Alamut with 1 Rocket
<br/> You also get extra mags for the Vermin and 4-five .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 3",
"
<br/><font size='16'>Gear Level 3</font>
<br/><font size='15'>Cost: 3,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $300
<br/> An Olive Carryall
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> A holosight for your Vermin
<br/> A 4-five .45 Pistol instead of the ACP .45
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 2",
"
<br/><font size='16'>Gear Level 2</font>
<br/><font size='15'>Cost: $2,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $200
<br/> An Olive Carryall
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A pair of Red Goggles
<br/> A Vermin .45 ACP + 3 Mags
"
]];

player createDiaryRecord ["gearlevel",
[
"Gear Level 1",
"
<br/><font size='16'>Gear Level 1</font>
<br/><font size='15'>Cost: $1,000,000 ~:</font>
<br/><font size='15'>List of Perks you get at this level ~:</font>
<br/> Extra Starting Money: $100
<br/> An Olive Carryall
<br/> A GPS
<br/> A pair of Binoculars
<br/> An Extra Grenade
<br/> A First Aid Kit
<br/> A holosight for the Sting
<br/> You will also get extra mags for both your Sting and ACP .45
"
]];

player createDiaryRecord ["admins",
[
"Admin List",
"
<br/><font color='#00FFEF' size='18'>Super Admins</font>
<br/><font color='#00FFEF' size='12'>All Functions Activated (No Player Markers or Invisiblilty)</font>
<br/> * Mokey
<br/> * Ghostyy
<br/> * OutlawII
<br/> * Shine_Dwarf
<br/> * StinkySneeze (Second Best Canadian/Third Best Sniper)

<br/><font color='#0066FF' size='18'>High Admins</font>
<br/><font color='#00FFEF' size='12'>Teleport, Spectate, Slay Delete Hacked objects</font>
<br/> * Harry
<br/> * Donkey
<br/> * Zenkiton
<br/> * Rabidtroop


<br/><font color='#002FFF' size='18'>Low Admins</font>
<br/><font color='#00FFEF' size='12'>Spectate, Slay, Delete Hacked Objects</font>
<br/> * 
<br/> * 

"
]];
