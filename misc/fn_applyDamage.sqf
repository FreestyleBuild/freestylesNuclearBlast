/*

freestylesNuclearBlast_fnc_applyDamage

Applies damage to a character. Using the appropirate functions.


Arguments:

0 - object, unit to apply damage to
1 - number, amount of damage ranging from 0 to 1, if 2 or higher damage is guaranteed to be lethal.
3 - ace damage type, optional, used is FNB_aceActivated is true

*/


params["_unit", "_damage", ["_aceType", "explosive"]];


//dont damage unit which have damage disabled
if (not (isDamageAllowed _unit)) exitWith{};

if (missionNamespace getVariable ["FNB_aceActivated", false]) then
{
	//TODO: handle damage with ace functions
}
else
{
	_unit setDamage [((damage _unit) + _damage), false];
};