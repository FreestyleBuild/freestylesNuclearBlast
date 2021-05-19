/*

freestylesNuclearBlast_fnc_radiationDamage

Apply radiation damage to units in blast area. Includes nuclear radioation and thermal.
Amount of damage depends on zones for each category, damage between categores can add up.


Arguments:

0 - positionASL, blast origin position
1 - number, radius for 5000 rem radiation (lethal within days)
2 - number, radius for 500 rem radiation (likely lethal within 1 month)
3 - number, radius for guaranteed 3rd degree burns
4 - number, radius for 50% chance of 3rd degree burns

*/


params["_position", "_5000rem", "_500rem", "_100burn", "_50burn"];

private["_burnedUnits", "_radiatedUnits", "_burnDamage", "_radiationDamage", "_baseDam"];


//get affected Units
_burnedUnits = _position nearObjects ["Man", _50burn];
_radiatedUnits = _position nearObjects ["Man", _500rem];


//variable to store damage amount
_burnDamage = [];
_radiationDamage = [];


//radioation damage
{
	//damage for full 500 rem exposure
	_baseDam = 0.75;
	
	
	//adjust if 5000 rem applies
	if ((_position distance _x) < _5000rem) then
	{
		_baseDam = _baseDam * 4;
	};
	
	
	//adjust for visibility
	_baseDam = _baseDam * ([_x, "FIRE"] checkVisibility [_position, eyePos _x]);
	
	_radiationDamage pushBack _baseDam;
	
} forEach _radiatedUnits;


//burn damage
{
	//damage for 50% chance of 3rd degree burns
	if ((random 1) < 0.5) then
	{
		_baseDam = 0.2;
	}
	else
	{
		_baseDam = 0;
	};
	
	
	//adjust if 5000 rem applies
	if ((_position distance _x) < _100burn) then
	{
		_baseDam = 0.4;
	};
	
	
	//adjust for visibility
	_baseDam = _baseDam * ([_x, "FIRE"] checkVisibility [_position, eyePos _x]);
	
	_burnDamage pushBack _baseDam;
	
} forEach _radiatedUnits;


//apply the calculated damage

//instantly for burns
[_burnedUnits, _burnDamage, "ropeburn"] call freestylesNuclearBlast_fnc_applyDamage;

//overtime for radiation (5 minutes)
[_radiatedUnits, _radiationDamage, 300, 150, "ropeburn"] spawn freestylesNuclearBlast_fnc_damageOverTime;



