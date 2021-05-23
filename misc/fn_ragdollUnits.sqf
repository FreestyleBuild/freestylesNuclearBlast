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


	if (((not(isPlayer _x)) or (count (weapons _x) > 0)) and (isDamageAllowed _x)) then
	{
		_vector = _position vectorFromTo (getPosASL _x);
		_vector set [2, 1];
		[_x, [_vector vectorMultiply _force, _x selectionPosition "spine3"]] remoteExecCall ["addForce", _x];
	};	
} forEach _units;


//wait atleats 5 seconds
sleep (_delay min 5);

{
	[_x, (_oldState # _forEachIndex)] remoteExecCall ["setUnconscious", _x] ;
} forEach _units;