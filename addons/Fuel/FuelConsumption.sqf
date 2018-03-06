scriptName "tm4_fuelUptake";
/*--------------------------------------------------------------------
   file: tm4_fuelUptake.sqf
   ========================
   Author: Tom_48_97 <@Tom_48_97>
   Description: This script increases the fuel consumption of the 
   player's vehicle. It just needs to be exec on client side
--------------------------------------------------------------------*/
#define __filename "tm4_fuelUptake.sqf"
 
if (isServer and isDedicated) exitWith {};
waitUntil {!isNull player && player == player};
 
if (isNil "tm4_handler_fuelUptake") then {
   tm4_handler_fuelUptake = [] spawn {
      if (isNil "tm4_prom_spotrebaPaliva") then {
         tm4_prom_spotrebaPaliva = [[] call {(0.00066314157*1.00619)}, [] call {((0.0016314157+0.00014159)/(pi*2))}, [] call {((0.0026314157+0.00025159)/(pi*2))}, [] call {((0.0036314157+0.00026159)/(pi*2))} ];
      };
      while {alive player} do   {
         diag_log ["LOG:", __filename, diag_tickTime, "THREAD STARTED"];
         waitUntil {
            sleep 1;
            alive player
         };
         while {alive player} do {
            waitUntil {vehicle player != player && player == driver vehicle player };
            _vh = vehicle player;
            while {vehicle player != player && player == driver (vehicle player) && alive player} do {
               waitUntil {isEngineOn _vh};
               diag_log ["LOG:", __filename, "isEngineOn vehicle player == TRUE"];
               while {isEngineOn _vh && alive player} do {
                  if !(driver _vh == player || alive player || alive _vh) exitWith {};
                  _vh setFuel ((fuel _vh) - (tm4_prom_spotrebaPaliva select 0));
                  if !(_vh isKindOf "Truck_F" || _vh isKindOf "Van_01_base_F" || _vh isKindOf "AIR") Then {
                     if (speed _vh > 10 && speed _vh < 91) then {
                        _vh setFuel ((fuel _vh) - (tm4_prom_spotrebaPaliva select 1));
                     };
                     if (speed _vh > 90 && speed _vh < 130) then {
                        _vh setFuel ((fuel _vh) - (tm4_prom_spotrebaPaliva select 2));
                     };
                     if (speed _vh > 130) then {
                        _vh setFuel ((fuel _vh) - (tm4_prom_spotrebaPaliva select 3));
                     };
                     sleep .20;
                  };
                  if !(driver _vh == player || alive player || alive _vh || isEngineOn _vh) exitWith {};
                  sleep 1;
               };
               diag_log ["LOG:", __filename, "isEngineOn vehicle player == FALSE || driver vehicle player == player || isEngineOn vehicle player"];
               sleep .5;
            };
            sleep 1;
            diag_log ["LOG:", __filename, "vehicle player != player || player == driver (vehicle player) || alive player"];
            /*terminate tm4_handler_fuelUptake; */
         };
         diag_log ["LOG:", __filename, "terminated"];
      };
      diag_log ["LOG:", __filename, "exited"];
      /*terminate tm4_handler_fuelUptake; */
   };
} else {
   diag_log ["LOG:", __filename, diag_tickTime,"THREAD ALREADY EXISTS"];
};