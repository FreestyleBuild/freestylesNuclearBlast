/*

freestylesNuclearBlast_fnc_5psiEffects

Effects for 5psi overpressure wave. Adjusted for current distance from blast.


Arguments:

0 - positionASL, blast origin
1 - number, current relative range from last to max 5 psi range (distance to blast / 5 psi range)
2 - array of objects, affetced buidlings
3 - array of objects, affected vehicles
4 - array of objects, affected units
5 - number, fire prop, use -1 to disable

*/


params ["_position", "_distance", "_buildings", "_vehicles", "_units", "_fires"];

private ["_buildingDamages", "_vehicleDamages", "_unitDamages", "_protectionFactor", "_vehicleKnock"];

//damage arrays
_buildingDamages = [];
_vehicleDamages = [];
_unitDamages = [];


//calculate damage for buildings
{
	//formula f(i) = 1.5 ^ (- i ^ 4), plus random(-0.2 to 0.1)
	_buildingDamages pushBack ((1.5 ^ ((- _distance) ^ 4)) + ((random 0.3) - 0.2));
} forEach _buildings;


//do fires
if (_fires != -1) then 
{
	[_buildings, _fires, 240, 60] spawn freestylesNuclearBlast_fnc_spawnFires;
};

//calculate damage for vehicles
{
	//formula f(i) = 1.5 ^ (- i ^ 4), plus random(-0.4 to 0)
	_vehicleDamages pushBack ((1.5 ^ (-(_distance ^ 4))) + (-1 * (random 0.4)));
} forEach _vehicles;


//calculate damage for units
{
	//relative hight above ground, 0 equals lying face down, 1 eqauls standing straight up
	_protectionFactor = ((((eyePos _x) # 2) - ((getPosASL _x) # 2)) - 0.1) / 1.5;
	_protectionFactor = _protectionFactor max 0;
	
	_protectionFactor = _protectionFactor ^ 2 + 0.5;
	_protectionFactor = _protectionFactor min 1;

	//formula f(i) = 1.5 ^ (- i ^ 4), plus random(-0.2 to 0.1)
	_unitDamages pushBack (((1.5 ^ (-(_distance ^ 4))) + ((random 0.3) - 0.2)) * _protectionFactor);
} forEach _units;


//knockback vehicles
_vehicleKnock = [_position, _vehicles, (1 - _distance) + 3] spawn freestylesNuclearBlast_fnc_throwVehicles;
//waitUntil {scriptDone _vehicleKnock};


//damage buildings
[_buildings, _buildingDamages] spawn freestylesNuclearBlast_fnc_damageBuildings;

//damage vehicles
[_vehicles, _vehicleDamages, true] spawn freestylesNuclearBlast_fnc_damageBuildings;


//knockback units, duration is linear from 15 to 5 seconds
[_position, _units, (1 - _distance) * 1000 + 500, (1 - _distance) * 10 + 5] spawn freestylesNuclearBlast_fnc_ragdollUnits;


//damage units
[_units, _unitDamages, "explosive"] spawn freestylesNuclearBlast_fnc_applyDamage;