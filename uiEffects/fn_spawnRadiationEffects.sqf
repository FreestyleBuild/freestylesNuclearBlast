/*

freestylesNuclearBlast_fnc_spawnRadiationEffects


Call radiation effects on affected players.


Arguments:

0 - array of objects, affected units
1 - array of numbers, damage units received
2 - number, effect duration
*/

params["_units", "_damage", "_duration"];


{
	if ((isPlayer _x) and ((_damage # _forEachIndex) != 0)) then
	{
		[_duration, _damage # _forEachIndex, 1] remoteExec ["freestylesNuclearBlast_fnc_radiatedUI", _x];
	};
}forEach _units;