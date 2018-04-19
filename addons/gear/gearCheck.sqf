//@file Version: 1.1
//@file Name: gearcheck.sqf
//@file Author: Cael817, With help of AgentRev, based of something i found
//@file Modified: soulkobk 12:46 PM 19/04/2018

_gearsEnabled = ["A3W_gearsEnabled"] call isConfigOn;
_gearLevel = player getVariable ["gear", 0];

sleep 1;

switch (_gearLevel) do
{
    case 1: { player call va_gearLevel01; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 2: { player call va_gearLevel02; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 3: { player call va_gearLevel03; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 4: { player call va_gearLevel04; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 5: { player call va_gearLevel05; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 6: { player call va_gearLevel06; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 7: { player call va_gearLevel07; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 8: { player call va_gearLevel08; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 9: { player call va_gearLevel09; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 10: { player call va_gearLevel10; sleep 5; hint format ["Congrats! Your Level %1 Gear Loaded.",_gearLevel]; };
    case 11: { player call va_gearLevel11; sleep 5; hint format ["Congrats! Your Prestige Level %1 Gear Loaded.",_gearLevel - 10]; };
    case 12: { player call va_gearLevel12; sleep 5; hint format ["Congrats! Your Prestige Level %1 Gear Loaded.",_gearLevel - 10]; };
    case 13: { player call va_gearLevel13; sleep 5; hint format ["Congrats! Your Prestige Level %1 Gear Loaded.",_gearLevel - 10]; };
    case 14: { player call va_gearLevel14; sleep 5; hint format ["Congrats! Your Prestige Level %1 Gear Loaded.",_gearLevel - 10]; };
    case 15: { player hideObject false; player call va_gearLevel15; sleep 5; hint format ["Congrats! Your Prestige Level %1 Gear Loaded (Virtual Arsenal).",_gearLevel - 10]; };
    case 16: { player call va_gearLevel16; sleep 5; hint format ["Congrats! Your Member Level %1 Gear Loaded (Fractured Gaming Event).",_gearLevel - 10]; };
    default { hint "Check The Map Info To Learn More About Gear Levels Or Visit www.Fractured-Gaming.com"; };
};
