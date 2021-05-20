/*

freestylesNuclearBlast_fnc_damageOverTime

Applies damage to an array of characters over a period of time, itervall between applying damage can be adjusted.
Uses freestylesNuclearBlast_fnc_applyDamage to damage the unit itself.
Spawn this funtionc on server only.


Arguments:

0 - array of objects, unit to apply damage to
1 - array of numbers, amount of damage to apply to the unit, can be any number greater 0
2 - number, time in seconds in which the damage is applied
3 - number, number of ticks in which damage is applied, should be an integer
4 - ace damage type, optional, used is FNB_aceActivated is true

*/

params["_units", "_damageOrg", "_time", "_ticks", ["_aceType", "explosive"]];

private["_tickTime"];


//copy damage array
_damage = +_damageOrg;

//calculate delay between ticks
_tickTime = _time / _ticks;



//calculate tick damage for each unit
{
	_damage set [_forEachIndex, _x / _ticks];	
} forEach _damage;


//apply damage after each tick
for "_i" from 1 to _ticks do
{
	[_units, _damage, _aceType] call freestylesNuclearBlast_fnc_applyDamage;
	sleep _tickTime;
}; 
