// Bowens' "Other player to you" Script // Player selection From ALPmakers' Spectator Script //
 
telet =
{
 
_splr = _this select 0;    
(_splr) attachto [player,[0.0,3.0,0.5]];
 
sleep 5;
 
detach (_splr);
 
 
};
 
 
_n2sh = 10; _n2c = "Select Player:";shnext = false; nlist = [];  selecteditem = "";
 
if (isNil "teletoplr") then
{
 
    {if ((_x != player) and (getPlayerUID _x != "")) then {nlist set [count nlist, name _x];};} forEach Entities "CAManBase";
    {if ((count crew _x)>0) then {{if ((_x != player) and  (getPlayerUID _x != "")) then {nlist set [count nlist, name _x];};}  forEach crew _x;};
    } foreach (Entities "LandVehicle"+ Entities "Air" + Entities"Ship");
    shnmenu =
    {
        _pmenu = [["",true],[_n2c, [-1], "", -5, [["expression", ""]], "1", "0"]];
        for "_i" from (_this select 0) to (_this select 1) do
        {_arr = [format['%1',nlist select (_i)], [_i - (_this select 0) +  2],  "", -5, [["expression", format["selecteditem = nlist select  %1;",_i]]], "1", "1"];_pmenu set [_i+2, _arr];};
        if (count nlist >  (_this select 1)) then {_pmenu set [(_this  select 1)+2, ["Next", [12], "", -5, [["expression", "shnext = true;"]],  "1", "1"]];}
        else {_pmenu set [(_this select 1)+2, ["", [-1], "", -5, [["expression", ""]], "1", "0"]];};
        _pmenu set [(_this select 1)+3, ["Exit", [13], "", -5, [["expression", "selecteditem = 'exitscript';"]], "1", "1"]];
        showCommandingMenu "#USER:_pmenu";
    };
    _j = 0; _n2sh = 10; if (_n2sh>9) then {_n2sh=10;};
    while {selecteditem==""} do
    {
        [_j,(_j+_n2sh) min (count nlist)] call shnmenu;_j=_j+_n2sh;
        WaitUntil {selecteditem!="" or shnext};    
        shnext = false;
    };
 
 
    if (selecteditem!= "exitscript") then
    {
        _name = selecteditem;
        {if(format[name _x] == _name) then {[_x] call telet;};} forEach Entities "CAManBase";
    };
    teletoplr = !teletoplr;
 
};