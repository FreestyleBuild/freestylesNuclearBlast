/*

freestylesNuclearBlast_fnc_initBlast

Initializes the nuclear blast. Spawn only on server.


Arguments:

0 - positionASL, blast origin
1 - number, yield in kT of TNT equivalent
2 - bool, wether to print debug or not
3 - array of bools, enbale different effects and damage types
	0 - crater generation
	1 - blast wave damage
	2 - direct radiation damage, including thermal and nuclear effects 
	3 - smoke spike effects
	4 - dust wave effect
	5 - sound effects
	6 - mushroom and fireball

*/


params["_origin", "_yield", ["_debug", true], ["_effects", [true, true, true, true, true, true, true]]];

private ["_radiationScript", "_shockwaveScript", "_spikesLarge", "_spikesSmall"];


//check if ace medical is active, could be moved into a init function
missionNamespace setVariable ["FNB_aceActivated", isClass(configFile >> "CfgPatches" >> "ace_medical"), true];


//calculate radii for different effects
([_yield] call freestylesNuclearBlast_fnc_calculateRanges) params ["_radFireball", "_rad1psi", "_rad5psi", "_rad20psi", "_rad5000rem", "_rad500rem", "_rad100thermal", "_rad50thermal", "_radCrater"];


//debug outputs
if (_debug) then 
{
	[_origin, _radFireball, _rad1psi, _rad5psi, _rad20psi, _rad5000rem, _rad500rem, _rad100thermal, _rad50thermal, _radCrater] spawn freestylesNuclearBlast_fnc_debugOutput;	
};


//radiation and heat damage
if (_effects # 2) then 
{
	_radiationScript = [_origin, _rad5000rem, _rad500rem, _rad100thermal, _rad50thermal, 300] spawn freestylesNuclearBlast_fnc_radiationDamage;
	waitUntil {scriptDone _radiationScript};
};


//blast wave damage
if(_effects # 1) then
{
	_shockwaveScript = [_origin, _rad20psi, _rad5psi, _rad1psi] spawn freestylesNuclearBlast_fnc_shockwave;
};

//crater generation
if (_effects # 0) then
{
	[_origin, _radCrater] call freestylesNuclearBlast_fnc_generateCrater;
};

//create smoke spike effects
if (_effects # 3) then
{
	if (_yield <= 2.5) then
	{
		_spikesLarge = [_origin, ceil (random 3) + 5, 60, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesLarge, _radFireball / 2, 1.5 * _rad20psi / 60, _radFireball / (1.5 * _rad20psi) / 2, 300] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	
		_spikesSmall = [_origin, ceil (random 5) + 10, 80, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesSmall, _radFireball / 4, 2 * _rad20psi / 80, _radFireball / 2 / (2 * _rad20psi), 300] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	}
	else
	{
		_spikesLarge = [_origin, ceil (random 3) + 5, 60, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesLarge, _radFireball / 2, 1.5 * _rad20psi / 60, _radFireball / (1.5 * _rad20psi) / 2, 40] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	
		_spikesSmall = [_origin, ceil (random 5) + 10, 80, "G_40mm_HE"] call freestylesNuclearBlast_fnc_spikeSpawner;
		[_spikesSmall, _radFireball / 4, 2 * _rad20psi / 80, _radFireball / 2 / (2 * _rad20psi), 40] remoteExec ["freestylesNuclearBlast_fnc_smokeSpikes", 0];
	};
};

//create dust wave effect
if (_effects # 4) then
{
	[_origin, _radFireball, _rad1psi] remoteExec ["freestylesNuclearBlast_fnc_dustWave", 0]
};

//sound effects
if (_effects # 5) then
{
	[_origin, _yield] remoteExec ["freestylesNuclearBlast_fnc_soundFX", 0]
};


//mushroom cloud and fireball
if (_effects # 6) then
{
	[_origin, _radFireball] spawn freestylesNuclearBlast_fnc_effectsControll;
};