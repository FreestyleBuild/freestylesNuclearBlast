/*

freestylesNuclearBlast_fnc_1psiEffects

Effects for 1psi overpressure wave. Adjusted for current distance from blast.


Arguments:

0 - positionASL, blast origin
1 - number, current relative range from last to max 1 psi range (distance to blast / 1 psi range)
2 - array of objects, affetced buidlings
3 - array of objects, affected vehicles
4 - array of objects, affected units

*/


params ["_position", "_distance", "_buildings", "_vehicles", "_units"];

private ["_buildingDamages", "_vehicleDamages", "_unitDamages", "_protectionFactor", "_vehicleKnock"];

//damage arrays
_buildingDamages = [];
_vehicleDamages = [];
_unitDamages = [];


//calculate damage for buildings
{
	_buildingDamages pushBack ((2 ^ (- _distance)) -0.4);
} forEach _buildings;


//calculate damage for vehicles
{
	_vehicleDamages pushBack ((2 ^ (- _distance)) -0.4);
} forEach _vehicles;


//calculate damage for units
{
	//relative hight above ground, 0 equals lying face down, 1 eqauls standing straight up
	_protectionFactor = ((((eyePos _x) # 2) - ((getPosASL _x) # 2)) - 0.1) / 1.5;
	_protectionFactor = _protectionFactor max 0;
	
	_protectionFactor = _protectionFactor ^ 2 + 0.5;
	_protectionFactor = _protectionFactor min 1;

	_unitDamages pushBack (((2 ^ (- _distance)) -0.3) * _protectionFactor);
} forEach _units;


//damage buildings
[_buildings, _buildingDamages] spawn freestylesNuclearBlast_fnc_damageBuildings;

//damage vehicles
[_vehicles, _vehicleDamages, true] spawn freestylesNuclearBlast_fnc_damageBuildings;


//knockback units, duration 5 seconds
[_position, _units, (1 - _distance) * 100 + 50, 5] spawn freestylesNuclearBlast_fnc_ragdollUnits;


//damage units
[_units, _unitDamages, "explosive"] spawn freestylesNuclearBlast_fnc_applyDamage;