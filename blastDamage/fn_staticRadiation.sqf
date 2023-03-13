/*

freestylesNuclearBlast_fnc_staticRadiation

Apply radiation damage to units which enter blast area afterwards.


Arguments:

0 - positionASL, blast origin position
1 - number, inner radius, extreme radiation (e.g. close to crater)
2 - number, outer radius for the radiation to occur
3 - number, intervall at which area is checked for units
4 - number, duration over which radiation damage is applied
5 - number, damage applied in inner radius per intervall
6 - number, damage applied in outer radius per intervall
7 - number, amount of times area is checked, total duration is this time intervall
*/

params["_position", "_innerRadius", "_outerRadius", "_intervall", "_duration", "_innerDamage", "_outerDamage", "_iterations"];

private["_radiatedUnits", "_radiationDamage", "_baseDam"];


for "_i" from 1 to _iterations do
{
	//get affected Units
	_radiatedUnits = (ASLtoAGL _position) nearEntities ["Man", _outerRadius];


	//variable to store damage amount
	_radiationDamage = [];


	//radioation damage
	{
		//damage for area in outer radius
		_baseDam = _outerDamage;
		
		
		//adjust if inner radius applies
		if ((_position distance _x) < _innerRadius) then
		{
			_baseDam = _innerDamage;
		};
		
		_radiationDamage pushBack _baseDam;
		
	} forEach _radiatedUnits;


	//apply the calculated damage

	//spawn ui effects for players
	[_radiatedUnits, _radiationDamage, _duration] spawn freestylesNuclearBlast_fnc_spawnRadiationEffects;

	//overtime for radiation (5 minutes)
	[_radiatedUnits, _radiationDamage, _duration, 150, "burn"] spawn freestylesNuclearBlast_fnc_damageOverTime;
	sleep _intervall;
};