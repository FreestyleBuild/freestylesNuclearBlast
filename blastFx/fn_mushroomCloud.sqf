/*

freestylesNuclearBlast_fnc_mushroomCloud

Create the mushroom cloud for the blast. Executes on clients only.


Arguments:

0 - object, blast effects center object
1 - number, size, particle size for mushroom cloud, will be the stems diameter
2 - number, height of bottom part of the musshroom cloud
3 - number, height of cloud peak
4 - number, particle lifetime
5 - number, vertical speed for cloud rising (m/s)
*/

if (!hasInterface) exitWith {};

params["_object", "_size", "_bottom", "_top", "_lifetime", "_vSpeed"];

private["_cloud", "_color", "_colorTarget", "_capSize", "_intervall", "_height", "_radius", "_iter"];


_capSize = _top - _bottom;


//cloud creates the stem and later on the cap of the mushroom
_cloud = "#particlesource" createVehicleLocal [0,0,0];
_cloud attachTo [_object, [0,0,0]];


//create basic colors
_color = [1,1,1,0.7];
_colorTarget = [1,1,1,0];


//create rising cap
for "_i" from 1 to 10 do
{
	drop [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard", 1, _top / _vSpeed, [0,0,0], [0,0,_vSpeed], 0.1, 9.996,7.84, 0, [_capSize], [_color,_color], [0.2,0.2], 10, 0.1, "", "", _object, random(360)/(2 * pi), false, -1.0, [_color,_color]];
};


//create stem particles
_intervall = (_size / _vSpeed / 5); //5 particles per step

_color = [1,1,1,1];
_colorTarget = [1,1,1,0];


for "_i" from 1 to ceil((_top / _vSpeed) / _intervall) do
{
	drop [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard", 1, _lifetime, [0,0,_i * _vSpeed * _intervall], [0,0,0], 0.1, 9.996,7.84, 0, [_size], [_color,_colorTarget], [0.2,0.2], 10, 0.1, "", "", _object, random(360)/(2 * pi), false, -1.0, [_color,_colorTarget]];
	
	sleep _intervall;
};


//create cap
_color = [1,1,1,0.5];
_colorTarget = [1,1,1,0];

_height = (_top + _bottom) / 2;
_radius = _capSize / 2;

_iter = 3;

for "_i" from 1 to _iter do
{
	//drop particles
	_cloud setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard", 1, _lifetime, [0,0,_height], [0,0,0], 0.1, 9.996,7.84, 0, [_capSize], [_color,_colorTarget], [0.2,0.2], 10, 0.1, "", "", _cloud, random(360)/(2 * pi), false, -1.0, [_color,_colorTarget]];
	_cloud setParticleRandom [0, [_capSize / 20, _capSize / 20, _capSize / 20], [0, 0, 0], 0.1, 0.1, [0, 0, 0, 0], 0, 0, 360, 0];;
	_cloud setParticleCircle [_radius, [0,0,0]];
	_cloud setDropInterval (5 / (_radius));
	
	
	//adjust parameters
	_height = _height - ((2 - 1.3 ^ (_i / _iter)) * (_height - _bottom));
	_radius = _radius + 0.5 * _capSize;
	_capSize = (2 - 1.3 ^ (_i / _iter)) * _capsize;
	
	//wait until next expansion
	sleep 3;
};

deleteVehicle _cloud;
