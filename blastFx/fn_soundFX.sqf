/*

freestylesNuclearBlast_fnc_soundFX

Create sound effects. Executes on clients only.


Arguments:

0 - positionASL, blast origin
1 - number, blast yield in kilotons
*/

params["_position", "_yield"];

private["_strength"];

if(_yield <= 2.5) then
{
	_strength = 1;
}
else
{
	if(_yield <= 5) then
	{
		_strength = 2;
	}
	else
	{
		if(_yield <= 10) then
		{	
			_strength = 3;
		}
		else
		{
			_strength = 4;
		};
	};
};

sleep ((player distance _position) / 300);

[_strength] spawn BIS_fnc_earthquake;

player say3d ["SmallExplosion", 0, 0.01, true, 0];