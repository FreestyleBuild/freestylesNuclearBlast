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
	6 - fireball and light
	7 - condensation rings
	8 - lingering smoke
	9 - mushroom cloud
4 - number, fire propability, use -1 to disable
5 - number, duration of radiation zone around blast area in minutes, -1 to disable

*/

//only execute on the server
if (!isServer) exitWith
{
	if _debug then
	{
		systemChat "Warning: Execute Freestyles Nuclear Blast script only on server/singlerplayer";
	};
};

params["_origin", "_yield", ["_debug", true], ["_effects", [true, true, true, true, true, true, true, true, true, true]], ["_fires", 0.1], ["_staticRadiation", - 1]];

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
	_shockwaveScript = [_origin, _rad20psi, _rad5psi, _rad1psi, _fires] spawn freestylesNuclearBlast_fnc_shockwave;
};

//crater generation
if (_effects # 0) then
{
	[_origin, _radCrater] call freestylesNuclearBlast_fnc_generateCrater;
};


//effects controll
_effects deleteRange [0, 3];

[_origin, _yield, _effects, _radFireball, _rad20psi, _rad1psi, 300, 40] spawn freestylesNuclearBlast_fnc_effectsControll;


if (_staticRadiation != -1) then
{
	[_origin, _radCrater, _radFireball * 2, 30, 180, 0.5, 0.2, 2 * _staticRadiation] spawn freestylesNuclearBlast_fnc_staticRadiation;
};