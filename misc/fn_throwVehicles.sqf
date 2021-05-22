/*

freestylesNuclearBlast_fnc_throwVehicles

Throw vehicles aways from an explosion. Needs to be called on server only.


Arguments:

0 - positionASL, explosion origin
1 - arrray of objects, vehilces to throw away
2 - number, strength multiplier for ragdoll effect
*/


params["_position", "_vehicles", "_force"];

private ["_vector"];


{
	if (isDamageAllowed _x) then
	{
		_vector = _position vectorFromTo (getPosASL _x);
		_vector set [2, 1];
		_x addForce [_vector vectorMultiply (_force * (getMass _x)), [0,0,1.5]];
	};	
} forEach _vehicles;

