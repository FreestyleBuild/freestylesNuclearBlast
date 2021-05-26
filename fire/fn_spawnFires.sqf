/*

freestylesNuclearBlast_fnc_spawnFires

Creates fires on given buildings with given chance. Execute on server only.


Arguments:

0 - array of objects, possible burnign buildings
1 - number, propability to ignite buildigs, from 0 to 1
2 - number, burning time base, modified by random value
3 - number, max random number added to base time

*/

params ["_buildings", "_prop", "_lifetime", "_lifetimeVar"];

private["_radius", "_box", "_time", "_obj", "_objects"];


if (!isServer) exitWith {};

_objects = [];

{
	if (((random 1) <= _prop) and (((getPosASL _x) # 2) > 2) and (_x isKindOf "House_F")) then
	{
		_box = 0 boundingBoxReal _x;
		
		_radius = (((_box # 1) # 0) - ((_box # 0) # 0)) min (((_box # 1) # 1) - ((_box # 0) # 1));
		
		if (_radius >= 1) then
		{
		
			_time = _lifetime + (random _lifetimeVar);
			
			_obj = "Land_WoodenLog_F" createVehicle [0,0,0];
			_obj setPosASL (getPosASL _x);
			
			[_obj, _radius, [0.25,_radius,0.1], _time, [0,0,2]] remoteExec ["freestylesNuclearBlast_fnc_createFire", 0];
			[_obj, _time] spawn freestylesNuclearBlast_fnc_fireSound;
			
			_objects pushBack _obj;
		};

	};
} forEach _buildings;


sleep (_lifetime + _lifetimeVar + 10);

{
	deleteVehicle _x;
} forEach _objects;