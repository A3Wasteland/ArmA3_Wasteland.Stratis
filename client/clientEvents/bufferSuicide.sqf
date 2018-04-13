// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: bufferSuicide.sqf
//	@file Author: Mokey
//	@file Created: 4/12/2018 09:16

disableSerialization;

waitUntil {!isNull findDisplay 49}; // 49 = Esc menu

_getPublicVar = if (!isNil "getPublicVar") then { getPublicVar } else { missionNamespace getVariable "getPublicVar" };
_isConfigOn = if (!isNil "isConfigOn") then { isConfigOn } else { missionNamespace getVariable "isConfigOn" };
if (!isNil "_getPublicVar" && !isNil "_isConfigOn") then
  {
    [] spawn
    {
      disableSerialization;
      while {!isNull findDisplay 49} do
      {
        if (alive player) then
        {
          _respawnBtn = (findDisplay 49) displayCtrl 1010;
          if (ctrlEnabled _respawnBtn) then
          {
            _respawnBtn ctrlEnable false;
          }
          else
          {
            uiSleep 10;
          };
        };
      };
    };
  };
