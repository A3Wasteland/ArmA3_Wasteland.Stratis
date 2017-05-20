_uid = getPlayerUID player;

if (_uid call isAdmin) then {

	if (isNil "matt76_bullets" ) then {matt76_bullets=0};
 
	if (matt76_bullets==0) then 
	{
  	 	matt76_bullets=1;
   		vehicle player removeAllEventHandlers "Fired";
   		cutText ["                       \nRocket Bullets Loaded..","PLAIN"];
   		CCGLogger = ["AdminLog", format["Admin turned on Rocket Bullets !!!! [%1 (%2)]", name player, getPlayerUID player]];
   		publicVariableServer "CCGLogger";   
   		vehicle player addeventhandler ["Fired",{call mattBullets} ];
   
		mattBullets = 
   		{
			if (isNull cursorTarget) then 
		{
			CCGAdmin = screenToWorld [0.5,0.5];
		} 
		else 
		{
			CCGAdmin = getpos cursorTarget;
		};
		_spwnboom = "Bo_Mk82" createVehiclelocal CCGAdmin;
   		};
	}
	else
	{
		matt76_bullets=0;
		cutText ["                       \nBack to Normal Bullets..","PLAIN"];
    	CCGLogger = ["AdminLog", format["Admin turned off Rocket Bullets, we can calm down now [%1 (%2)]", name player, getPlayerUID player]];
    	publicVariableServer "CCGLogger"; 
		vehicle player removeAllEventHandlers "Fired";
	};
};	