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

*/


params["_origin", "_yield", ["_debug", true], ["_effects", [true, true, true, true]]];

private ["_radiationScript"];


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


//crater generation
if (_effects # 0) then
{
	[_origin, _radCrater] call freestylesNuclearBlast_fnc_generateCrater;
};


