/*

freestylesNuclearBlast_fnc_effectsControll

Controlls creation of effects. Execute on server.


Arguments:

0 - positonASL, blast origin
1 - number, blast yield in kT
2 - array of bools, which effects are activated
	0 - smoke pillars
	1 - dust wave
	2 - sound effects
	3 - fireball and light
	4 - condensation rings
	5 - lingering smoke
	6 - mushroom cloud
3 - number, fireball radius
4 - number, lifetime for long living particlesQuality
5 - number, lifetime for schort lived particles
*/

params["_position", "_yield", "_effects","_radFireball", "_rad20psi", "_rad1psi", "_lifetimeLong", "_lifetimeShort", "_spikeSize", "_spikeSpeed", "_spikeScript"];

private["_object", "_spikesLarge", "_spikesSmall", "_n", "_rad"];


//create main object
_object = "Sign_Sphere10cm_F" createVehicle [0,0,0];
_object setPosASL _position;
_object setVectorUp [0,0,1];



//create smoke spike effects
if (_effects # 0) then
{
	if (_yield <= 2.5) then
	{
		
		//large spikes
		_spikeSpeed = 40 * (0.9 * _yield + 0.73);
		_spikesLarge = [];
		
		_spikeScript = [_position, ceil ((random 3) + 4) * (0.9 * _yield + 0.73) + 5, _spikeSpeed, "B_556x45_Ball", _spikesLarge, 0.5, 0.1] spawn freestylesNuclearBlast_fnc_spikeSpawner;
		
		waitUntil {scriptDone _spikeScript};
		
		[_spikesLarge, _radFireball / 2, (0.9 * _yield + 0.73) * _rad20psi / _spikeSpeed, 1.5 * _radFireball / (1.5 * (0.9 * _yield + 0.73) * _rad20psi), _lifetimeLong, 0] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
		
		
		//small spikes
		_spikeSpeed = 90 * (0.9 * _yield + 0.73);
		_spikesSmall = [];
		
		_spikeScript = [_position, ceil ((random 5) + 14) * (0.9 * _yield + 0.73) + 7, _spikeSpeed, "B_556x45_Ball", _spikesSmall, 0.6, 0.2] spawn freestylesNuclearBlast_fnc_spikeSpawner;
		
		waitUntil {scriptDone _spikeScript};
		
		[_spikesSmall, _radFireball / 4, (0.9 * _yield + 0.73) * _rad20psi / _spikeSpeed, _radFireball / 2 / ((0.9 * _yield + 0.73) * _rad20psi) / 1.5, _lifetimeLong, 0] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	}
	else
	{
		//large spikes
		_spikeSize =  (_radFireball / 2) min 100;
		_spikeSpeed = 75;
		_spikesLarge = [];
		
		_spikeScript = [_position, ceil (random 3) + 5, _spikeSpeed, "B_556x45_Ball", _spikesLarge] spawn freestylesNuclearBlast_fnc_spikeSpawner;
		
		waitUntil {scriptDone _spikeScript};
		
		[_spikesLarge, _spikeSize, 1.5 * _rad20psi / _spikeSpeed, _spikeSize / (0.25 * _rad20psi), _lifetimeShort, 0.1] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	
		
		//small spikes
		_spikeSize =  (_radFireball / 4) min 50;
		_spikeSpeed = 100;
		_spikesSmall = [];
		
		_spikeScript = [_position, ceil (random 5) + 10, _spikeSpeed, "B_556x45_Ball", _spikesSmall] spawn freestylesNuclearBlast_fnc_spikeSpawner;
		
		waitUntil {scriptDone _spikeScript};
		
		[_spikesSmall, _spikeSize, 2 * _rad20psi / _spikeSpeed, _spikeSize / (0.75 * _rad20psi), _lifetimeShort, 0.1] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
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
	_rad = (_radFireball / 2);
	
	if (_yield <= 2.5) then
	{
		_rad = ((0.9 * _yield + 0.73) * 30)
	};
	
	[_object,  _rad, 2, _lifetimeLong] remoteExec ["freestylesNuclearBlast_fnc_smoke", 0];
};

//sound effects
if (_effects # 2) then
{
	[_position, _yield] remoteExec ["freestylesNuclearBlast_fnc_soundFX", 0]
};


//fireball and light
if (_effects # 3) then
{
	if (_yield <= 2.5) then
	{
		[_object, _radFireball / 2, _radFireball / 2, 5, _rad1psi] remoteExec ["freestylesNuclearBlast_fnc_flash", 0];
	}
	else
	{
		[_object, _radFireball, _rad20psi * 1.1, 50, _rad1psi] remoteExec ["freestylesNuclearBlast_fnc_flash", 0];
	};
};


//condensation rings

if (_effects # 4) then
{
	if (((fog >= 0.05) || (rain >= 0.05)) && (_yield > 9.99)) then 
	{
	
		//calculate amount of rings
		if(_yield >= 9.99 && _yield <= 50) then {_n = 1;};
		if(_yield > 50 && _yield <= 1000) then {_n = 2;};
		if(_yield > 1000) then {_n = 3;};
		
		
		//create the rings
		for "_i" from 0 to (_n - 1) do 
		{
			[_object, _rad20psi * 0.75 + _i * _radFireball * 0.5, _radFireball - (_i + 1) * _radFireball * 0.1, 7, _lifetimeShort] remoteExec ["freestylesNuclearBlast_fnc_condensationRing", 0];
			sleep 0.5;
		};

	};
};


//mushroom cloud

if ((_effects # 6) and (_yield > 2.5)) then
{
	sleep 8; // wait for fireball to start rising
	[_object, _radFireball, _rad20psi, _rad20psi * 1.4, _lifetimeLong, 50] remoteExec ["freestylesNuclearBlast_fnc_mushroomCloud", 0];
};

sleep (((_rad20psi * 1.4) / 50) + 30);

//delete object
deleteVehicle _object;