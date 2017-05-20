_do_splr = 
{
_splr = _this select 0;	
createGearDialog [(_splr), "RscDisplayGear"];			
};
_a6a6s = 10; _n2c = "Select Player:";shnext = false; nlist = [];  selecteditem = "";
if (isNil "listplr") then 
{
	{if ((_x != player) and (getPlayerUID _x != "")) then {nlist set [count nlist, name _x];};} forEach Entities "CAManBase";
	{if ((count crew _x)>0) then {{if ((_x != player) and (getPlayerUID _x != "")) then {nlist set [count nlist, name _x];};} forEach crew _x;};
	} foreach (Entities "LandVehicle"+ Entities "Air" + Entities"Ship");
	petuniamenu = 
	{
		_pmenu = [["",true],[_n2c, [-1], "", -5, [["expression", ""]], "1", "0"]];
		for "_i" from (_this select 0) to (_this select 1) do
		{_arr = [format['%1',nlist select (_i)], [_i - (_this select 0) + 2],  "", -5, [["expression", format["selecteditem = nlist select %1;",_i]]], "1", "1"];_pmenu set [_i+2, _arr];};
		if (count nlist >  (_this select 1)) then {_pmenu set [(_this select 1)+2, ["Next", [12], "", -5, [["expression", "shnext = true;"]], "1", "1"]];}
		else {_pmenu set [(_this select 1)+2, ["", [-1], "", -5, [["expression", ""]], "1", "0"]];};
		_pmenu set [(_this select 1)+3, ["Exit", [13], "", -5, [["expression", "selecteditem = 'exitscript';"]], "1", "1"]];
		showCommandingMenu "#USER:_pmenu";
	};
	_j = 0; _a6a6s = 10; if (_a6a6s>9) then {_a6a6s=10;};
	while {selecteditem==""} do
	{
		[_j,(_j+_a6a6s) min (count nlist)] call petuniamenu;_j=_j+_a6a6s;
		WaitUntil {selecteditem!="" or shnext};	
		shnext = false;
	};
	if (selecteditem!= "exitscript") then
	{
		_name = selecteditem;
		{if(format[name _x] == _name) then {[_x] call _do_splr;};} forEach Entities "CAManBase";
	};
	listplr = !listplr;
};