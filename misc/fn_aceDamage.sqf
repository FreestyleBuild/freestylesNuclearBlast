/*

freestylesNuclearBlast_fnc_aceDamage

Apply damage to a unit using ACE, applied to the body region. (Discributed if "exposive" is used).
Values greater or equal to 2 are lethal.


Arguments:

0 - unit, blast origin position
1 - number, damage values, 2 for lethal
2 - string, ACE damage type

*/

params["_unit", "_damage", "_type"];


//_regions = ["head", "body", "hand_l", "hand_r", "leg_l", "leg_r"];

//_types = ["backblast", "bite", "bullet", "explosive", "falling", "grenade", "punch", "ropeburn", "shell", "stab", "unknown", "vehiclecrash"]


if (_damage >= 2) then
{
	[_unit, 10, "body", _type] call ace_medical_fnc_addDamageToUnit
}
else
{
	[_unit, _damage * 4, "body", _type] call ace_medical_fnc_addDamageToUnit
};



