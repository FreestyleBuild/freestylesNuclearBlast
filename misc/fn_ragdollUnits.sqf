/*

freestylesNuclearBlast_fnc_ragdollUnits

Ragdoll units aways from an explosion, works for player and ai. Needs to be spawned on server only.


Arguments:

0 - positionASL, explosion origin
1 - arrray of objects, units to ragdoll away
2 - number, strength multiplier for ragdoll effect
3 - number, delay before waking up units again
*/


params["_position", "_units", "_force", "_delay"];

private ["_vector", "_oldState"];

_oldState = [];


{
	if ((incapacitatedState _x) == "UNCONSCIOUS") then
	{
		_oldState pushBack true;
	}
	else
	{
		_oldState pushBack false;
	};


	if ((not(isPlayer _x)) or (count (weapons _x) > 0)) then
	{
		_vector = _position vectorFromTo (getPosASL _x);
		_x addForce [_vector vectorMultiply _force, _x selectionPosition "spine"];
	};	
} forEach _units;


sleep _delay;

{
	[_x, (_oldState # _forEachIndex)] remoteExecCall ["setUnconscious", _x] ;
} forEach _units;