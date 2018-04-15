//@file Version: 1.1
//@file Name: gearcheck.sqf
//@file Author: Cael817, With help of AgentRev, based of something i found


// Supporter Loadout  
_gearsEnabled = ["A3W_gearsEnabled"] call isConfigOn;
_gearLevel = player getVariable ["gear", 0];


sleep 1;
switch (_gearLevel) do 
{
    case 1:
    {
		player execVM "addons\gear\gearLevel1.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 1 gear loaded.";
		};
		
    case 2:
   {
		player execVM "addons\gear\gearLevel2.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 2 gear loaded";
   };
   
	case 3:
   {
		player execVM "addons\gear\gearLevel3.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 3 gear loaded";
   };
   
    case 4:
   {
		player execVM "addons\gear\gearLevel4.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 4 gear loaded";
   };
   
    case 5:
   {
		player execVM "addons\gear\gearLevel5.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 5 gear loaded";
   };
   
    case 6:
   {
		player execVM "addons\gear\gearLevel6.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 6 gear loaded";
   };
   
    case 7:
   {
		player execVM "addons\gear\gearLevel7.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 7 gear loaded";
   };
   
    case 8:
   {
		player execVM "addons\gear\gearLevel8.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 8 gear loaded";
   };
   
    case 9:
   {
		player execVM "addons\gear\gearLevel9.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 9 gear loaded!";
   };

    case 10:
   {
		player execVM "addons\gear\gearLevel10.sqf"; 
		sleep 5;
		hint "Congrats! Your Level 10 gear loaded!";
   };
 
    case 11:
   {
		player execVM "addons\gear\gearLevel11.sqf"; 
		sleep 5;
		hint "Congrats! Prestiege Gear Level 1 Loaded!";
   };
   
    case 12:
   {
		player execVM "addons\gear\gearLevel12.sqf"; 
		sleep 5;
		hint "Congrats! Prestiege Gear Level 2 Loaded!";
   };
   
    case 13:
   {
		player execVM "addons\gear\gearLevel13.sqf"; 
		sleep 5;
		hint "Congrats! Prestiege Gear Level 3 Loaded!";
   };

    case 14:
   {
		player execVM "addons\gear\gearLevel14.sqf"; 
		sleep 5;
		hint "Congrats! Prestiege Gear Level 4 Loaded!";
   };
   
	case 15:
   {
		player execVM "addons\gear\gearLevel15.sqf"; 
		sleep 5;
		hint "Congrats! Virtual Arsenal Loaded!";
   };
   
    case 16:
   {
		player execVM "addons\gear\gearLevel16.sqf"; 
		sleep 5;
		hint "Fractured Member Event Gear Level Loaded!";
   };
   
    default
    {
		hint "Check Map Info To Learn More About Gear Levels Or Visit Fractured-Gaming.com!";
    };
};
