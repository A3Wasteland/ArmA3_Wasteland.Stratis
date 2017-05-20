titleText ["Cargod enabled","PLAIN DOWN"]; titleFadeOut 4;

	player removeAction line1;
	player removeAction line2;
	player removeAction godmode;
	player removeAction tele;
	player removeAction guns;
	player removeAction mainveh;
	player removeAction cgod;
	player removeAction hplay;
while {alive ( vehicle player )} do 
{
	vehicle player setfuel 1;
	vehicle player setvehicleammo 1;
	vehicle player setdammage 0;
	sleep 0.001;
};
