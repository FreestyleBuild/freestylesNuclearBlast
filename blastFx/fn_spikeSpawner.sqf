/*
freestylesNuclearBlast_fnc_spikeSpawner


Spawn objects for smoke pillar/spikes on the server and return array containing them. Execute on server only.


Arguments:

0 - positionASL, center of explosion
1 - number, amount of spikes to spawn
2 - number, speed of spikes
3 - type name, type of object to spawn
*/

params["_position", "_amount", "_speed", "_type"];

private["_spikes", "_obj", "_direction"];


_spikes = [];


for "_i" from 1 to _amount do
{
	//create object
	_obj = _type createVehicle _position;
	_obj setPosASL _position;
	
	//launch it
	_direction = vectorNormalized [random(200) - 100, random(200) - 100, 120];
	_obj setVelocity (_direction vectorMultiply _speed);
	
	_spikes pushBack _obj;
};

_spikes;