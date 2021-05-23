/*

freestylesNuclearBlast_fnc_effectsControll

Controlls creation of effects. Execute on server.


Arguments:

0 -  positonASL, blast origin
1 - number, blast yield in kT
2 - array of bools, which effects are activated
	0 - smoke pillars
	1 - dust wave
	2 - sound effects
	3 - fireball and light
	4 - condensation rings
	5 - lingering smoke
3 - number, fireball radius
4 - number, lifetime for long living particlesQuality
5 - number, lifetime for schort lived particles
*/

params["_position", "_yield", "_effects","_radFireball", "_rad20psi", "_rad1psi", "_lifetimeLong", "_lifetimeShort"];

private["_object", "_spikesLarge", "_spikesSmall", "_n"];


//create main object
_object = "Sign_Sphere10cm_F" createVehicle [0,0,0];
_object setPosASL _position;
_object setVectorUp [0,0,1];



//create smoke spike effects
if (_effects # 0) then
{
	if (_yield <= 2.5) then
	{
		_spikesLarge = [_position, ceil (random 3) + 5, 60, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesLarge, _radFireball / 2, 1.5 * _rad20psi / 60, _radFireball / (1.5 * _rad20psi) / 2, _lifetimeLong] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	
		_spikesSmall = [_position, ceil (random 5) + 10, 80, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesSmall, _radFireball / 4, 2 * _rad20psi / 80, _radFireball / 2 / (2 * _rad20psi), _lifetimeLong] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	}
	else
	{
		_spikesLarge = [_position, ceil (random 3) + 5, 60, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesLarge, _radFireball / 2, 1.5 * _rad20psi / 60, _radFireball / (1.5 * _rad20psi) / 2, _lifetimeShort] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	
		_spikesSmall = [_position, ceil (random 5) + 10, 80, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesSmall, _radFireball / 4, 2 * _rad20psi / 80, _radFireball / 2 / (2 * _rad20psi), _lifetimeShort] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	};
};

//create dust wave effect
if (_effects # 1) then
{
	[_object, _radFireball, _rad1psi] remoteExec ["freestylesNuclearBlast_fnc_dustWave", 0]
};


//create lingering smoke
if (_effects # 5) then
{
	[_object, 20, 2, _lifetimeLong] remoteExec ["freestylesNuclearBlast_fnc_smoke", 0];
};

//sound effects
if (_effects # 2) then
{
	[_position, _yield] remoteExec ["freestylesNuclearBlast_fnc_soundFX", 0]
};


//fireball and light
if (_effects # 3) then
{
	[_object, _radFireball] remoteExec ["freestylesNuclearBlast_fnc_flash", 0];
};


//condensation rings

if (_effects # 4) then
{
	if (((fog >= 0.05) || (rain >= 0.05)) && (_yield >= 2.5)) then 
	{
	
		//calculate amount of rings
		if(_yield >= 10 && _yield <= 50) then {_n = 1;};
		if(_yield > 50 && _yield <= 1000) then {_n = 2;};
		if(_yield > 1000) then {_n = 3;};
		
		
		//create the rings
		for "_i" from 0 to _n do 
		{
			[_object, _radFireball * 0.5 + _i * _radFireball * 0.1, _radFireball - (_i + 1) * _radFireball * 0.1, 7, _lifetimeShort] remoteExec ["freestylesNuclearBlast_fnc_condensationRing", 0];
			sleep 0.5;
		};

	};
};



sleep 60;

//delete object
deleteVehicle _object;