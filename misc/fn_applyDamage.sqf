/*

freestylesNuclearBlast_fnc_applyDamage

Applies damage to an array of characters. Using the appropriate functions.


Arguments:

0 - array of objects, units to apply damage to
1 - array of numbers, amount of damage ranging from 0 to 1, if 2 or higher damage is guaranteed to be lethal
3 - ace damage type, optional, used is FNB_aceActivated is true

*/


params["_units", "_damage", ["_aceType", "explosive"]];


{

	//dont damage unit which have damage disabled
	if (isDamageAllowed _x) then
	{

		if (missionNamespace getVariable ["FNB_aceActivated", false]) then
		{
			//TODO: handle damage with ace functions
		}
		else
		{
			_x setDamage ((damage _x) + (_damage # _forEachIndex));
		};
	
	};
	
} forEach _units;