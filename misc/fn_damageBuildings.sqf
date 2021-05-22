/*

freestylesNuclearBlast_fnc_damageBuildings

Applies damage to an array of buildings. Without destruction effects.


Arguments:

0 - array of objects, buildings to apply damage to
1 - array of numbers, amount of damage ranging from 0 to 1. If just a number same damage is applied to all buildings.
2 - bool, use damage effects, deafults to false

*/


params ["_buildings", "_damage", ["_effects", false]];


if (_damage isEqualType 0) then
{
	{

		//dont damage units, which have damage disabled
		if (isDamageAllowed _x) then
		{
			_x setDamage [((damage _x) + _damage), _effects];
		};
		
	} forEach _buildings;
}
else
{
	{

		//dont damage units, which have damage disabled
		if (isDamageAllowed _x) then
		{
			_x setDamage [((damage _x) + (_damage # _forEachIndex)), _effects];
		};
		
	} forEach _buildings;
};
