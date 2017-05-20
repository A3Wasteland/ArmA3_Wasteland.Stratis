waituntil {!alive player ; !isnull (finddisplay 46)};
if ((getPlayerUID player) in ["76561198049621925","76561198049329273","76561198021648470"]) then {
;
act = player addaction [("<t color=""#00e874"">" + ("Tools Menu") +"</t>"),"fusionsmenu\admin\tools.sqf","",5,false,true,"",""];

};
