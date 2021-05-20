/*

freestylesNuclearBlast_fnc_damageBuildings

Applies damage to an array of buildings. Without destruction effects.


Arguments:

0 - array of objects, buildings to apply damage to
1 - array of numbers, amount of damage ranging from 0 to 1. If just a number same damage is applied to all buildings.

*/


params ["_buildings", "_damage"];


if (_damage isEqualType 0) then
{
	{

		//dont damage unit which have damage disabled
		if (isDamageAllowed _x) then
		{
			_x setDamage [((damage _x) + _damage), false];
		};
		
	} forEach _buildings;
}
else
{
	{

		//dont damage unit which have damage disabled
		if (isDamageAllowed _x) then
		{
			_x setDamage [((damage _x) + (_damage # _forEachIndex)), false];
		};
		
	} forEach _buildings;
};
