/*
freestylesNuclearBlast_fnc_spikeSpawner


Spawn objects for smoke pillar/spikes on the server and return array containing them. Execute on server only.


Arguments:

0 - positionASL, center of explosion
1 - number, amount of spikes to spawn
2 - number, speed of spikes
3 - type name, type of object to spawn
4 - array, array to put spike in
5 - number, optional, horizontal deviation multiplier, default 1
6 - number, optional, deviation of speed, interpreted as percent, default 0, min 0 max 1
*/

params["_position", "_amount", "_speed", "_type", "_spikes", ["_hDev", 1], ["_speedDev", 0]];

private["_obj", "_direction"];



for "_i" from 1 to _amount do
{
	//create object
	_obj = _type createVehicle _position;
	_obj setPosASL _position;
	
	//launch it
	_direction = vectorNormalized [_hDev * (random(200) - 100),_hDev * (random(200) - 100), 120];
	[_obj ,(_direction vectorMultiply (_speed * (1 + (random 2 * _speedDev) - _speedDev)))] remoteExec ["setVelocity", 0];
	
	_spikes pushBack _obj;
};

_spikes;