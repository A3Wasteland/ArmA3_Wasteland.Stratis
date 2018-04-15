// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: setMissionSkill.sqf
//	@file Author: AgentRev
//	@file Created: 21/10/2013 19:14
//	@file Args:

if (!isServer) exitWith {};

private ["_unit", "_skill", "_accuracy"];
_unit = _this;

if (["A3W_missionsDifficulty"] call isConfigOn) then
{
	_skill = 0.5; // Default skill for ARMA3 is 0.5
	_accuracy = 1; // Relative multiplier; absolute default accuracy for ARMA3 is 0.25
}
else
{
	_skill = 0.33;
	_accuracy = 0.75;
};

_unit allowFleeing 0;
_unit setSkill _skill;
_unit setSkill ["aimingAccuracy", (_unit skill "aimingAccuracy") * _accuracy];
_unit setSkill ["courage", 1];

// Available skills are explained here: http://community.bistudio.com/wiki/AI_Sub-skills
// Skill values are between 0 and 1
// A3Wasteland 1.Xx - AI skill set added by soulkobk (soulkobk.blogspot.com)

#define __DEBUG_SKILLSET__

_skillSet = selectRandom ["VERY LOW","LOW","REGULAR","MEDIUM","HIGH"];

switch (_skillSet) do
{
	case "VERY LOW":
	{
		_unit setSkill ["aimingSpeed", 0.05];
		_unit setSkill ["spotDistance", 0.05];
		_unit setSkill ["aimingAccuracy", 0.02];
		_unit setSkill ["aimingShake", 0.02];
		_unit setSkill ["spotTime", 0.1];
		_unit setSkill ["spotDistance", 0.3];
		_unit setSkill ["commanding", 0.3];
		_unit setSkill ["general", 0.2];
	};
	case "LOW":
	{
		_unit setSkill ["aimingSpeed", 0.1];
		_unit setSkill ["spotDistance", 0.1];
		_unit setSkill ["aimingAccuracy", 0.05];
		_unit setSkill ["aimingShake", 0.05];
		_unit setSkill ["spotTime", 0.2];
		_unit setSkill ["spotDistance", 0.4];
		_unit setSkill ["commanding", 0.4];
		_unit setSkill ["general", 0.3];
	};
	case "REGULAR":
	{
		_unit setSkill ["aimingSpeed", 0.15];
		_unit setSkill ["spotDistance", 0.15];
		_unit setSkill ["aimingAccuracy", 0.1];
		_unit setSkill ["aimingShake", 0.1];
		_unit setSkill ["spotTime", 0.3];
		_unit setSkill ["spotDistance", 0.5];
		_unit setSkill ["commanding", 0.5];
		_unit setSkill ["general", 0.6];
	};
	case "MEDIUM":
	{
		_unit setSkill ["aimingSpeed", 0.2];
		_unit setSkill ["spotDistance", 0.2];
		_unit setSkill ["aimingAccuracy", 0.2];
		_unit setSkill ["aimingShake", 0.2];
		_unit setSkill ["spotTime", 0.4];
		_unit setSkill ["spotDistance", 0.6];
		_unit setSkill ["commanding", 0.6];
		_unit setSkill ["general", 0.7];
	};
	case "HIGH":
	{
		_unit setSkill ["aimingSpeed", 0.3];
		_unit setSkill ["spotDistance", 0.3];
		_unit setSkill ["aimingAccuracy", 0.3];
		_unit setSkill ["aimingShake", 0.3];
		_unit setSkill ["spotTime", 0.5];
		_unit setSkill ["spotDistance", 0.8];
		_unit setSkill ["commanding", 0.8];
		_unit setSkill ["general", 0.9];
		_skillSet = "HIGH";
	};
};

#ifdef __DEBUG_SKILLSET__
	diag_log format ["SET %1 AI SKILL SET TO %2",_unit,_skillSet];
#endif