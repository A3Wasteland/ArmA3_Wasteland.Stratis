while {true} do
{
  waitUntil {alive vehicle player};
 [] execVM "fusionsmenu\admin\activate.sqf";


  waitUntil {!alive player};
};