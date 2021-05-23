/*
freestylesNuclearBlast_fnc_smokeSpikes


Spawn effect on given smoke spikes objects. Executes on clients.


Arguments:

0 - array of objects, smoke spike objects
1 - number, base size of particles
2 - number, amount of time to spawn effects for 
3 - number, intervall of spawning
4 - number, particle lifetime
5 - number, how strong particles are affected by wind
*/

if (!hasInterface) exitWith {};

params ["_spikes", "_size", "_time", "_intervall", "_cloudLifetime", "_rubbing"];

private ["_startTime", "_color", "_colorTarget"];


_startTime = time;
_color = [1,1,1,0.5];
_colorTarget = [1,1,1,0];


while {time < (_startTime + _time)} do
{
	{
		drop [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard", 1, _cloudLifetime, [0,0,0], [0,0,0], 0.1, 10,7.84, _rubbing, [_size], [_color,_colorTarget], [0.2,0.2], 2, 0.1, "", "", _x, random(360)/(2 * pi), false, 1, [_color,_colorTarget]];
	} forEach _spikes;
	sleep _intervall;
};