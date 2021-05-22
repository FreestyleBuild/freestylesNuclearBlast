/*

freestylesNuclearBlast_fnc_20psiEffects

Effects for 20psi overpressure wave. Adjusted for  curretn distnce from blast


Arguments:

0 - positionASL, blast origin
1 - number, current relative range from last to max 20 psi range (distance to blast / 20 psi range)
2 - array of objects, affetced buidlings
3 - array of objects, affected vehicles
4 - array of objects, affected units

*/


params ["_position", "_intensity", "_buildings", "_vehicles", "_units"];


//destroy buildings
[_buildings, 1] call freestylesNuclearBlast_fnc_damageBuildings;

//destroy vehicles
[_vehicles, 1] call freestylesNuclearBlast_fnc_damageBuildings;

//kill units
[_units, 2, "explosive"] call freestylesNuclearBlast_fnc_applyDamage;