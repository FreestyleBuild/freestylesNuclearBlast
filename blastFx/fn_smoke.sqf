/*

freestylesNuclearBlast_fnc_smoke

Creates lingering smoke at the bottom of the explosion. Execute on clients only.


Arguments:

0 - object, blast effects object
1 - number, particle size
2 - number, number of smoke iterations
3 - number, particle lifetime
*/

if (!hasInterface) exitWith {};

params["_object", "_size", "_steps", "_lifetime"];

private["_color", "_colorTarget", "_smoke"];


_color = [1,1,1,1];
_colorTarget = [1,1,1,0];


_smoke = "#particlesource" createVehicleLocal [0,0,0];
_smoke attachTo [_object,[0,0,0]];


_smoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,0], "", "Billboard", 1, _lifetime, [0,0,0], [0,0,0], 0, 9.994,7.84, 0, [_size], [_color,_colorTarget], [0.2,0.2], 2, 0, "", "", _object, random(360)/(2 * pi), true, -1.0, [_color,_colorTarget]];

//drop smoke particles
for "_i" from 1 to _steps do
{
	_smoke setParticleCircle [_size / 2 + (_size * (_i - 1)), [0,0,0]];
	_smoke setDropInterval 0.1;
	sleep 3;
};

deleteVehicle _smoke;