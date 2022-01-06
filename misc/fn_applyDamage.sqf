/*

freestylesNuclearBlast_fnc_applyDamage

Applies damage to an array of characters. Using the appropriate functions.


Arguments:

0 - array of objects, units to apply damage to
1 - array of numbers, amount of damage ranging from 0 to 1, if 2 or higher damage is guaranteed to be lethal. If just a number same damage is applied to all units.
3 - ace damage type, optional, used if FNB_aceActivated is true

*/


params["_units", "_damage", ["_aceType", "explosive"]];



if (_damage isEqualType 0) then
{
	{

		//dont damage unit which have damage disabled
		if (isDamageAllowed _x) then
		{

			if (missionNamespace getVariable ["FNB_aceActivated", false]) then //ACE damage handling
			{
				[_x, _damage, _aceType] remoteExecCall ["freestylesNuclearBlast_fnc_aceDamage", _x, true];
			}
			else
			{
				_x setDamage ((damage _x) + _damage);
			};
		
		};
		
	} forEach _units;
}
else
{
	
	{

		//dont damage unit which have damage disabled
		if ((isDamageAllowed _x) and (_forEachIndex < (count _damage))) then
		{

			if (missionNamespace getVariable ["FNB_aceActivated", false]) then //ACE damage handling
			{
				[_x, _damage # _forEachIndex, _aceType] remoteExecCall ["freestylesNuclearBlast_fnc_aceDamage", _x, true];
			}
			else
			{
				_x setDamage ((damage _x) + (_damage # _forEachIndex));
			};
		
		};
		
	} forEach _units;
};

