/*

freestylesNuclearBlast_fnc_shockwave

Creates shockwave damage effects


Arguments:

0 - positionASL, blast origin
1 - number, 20psi radius
2 - number, 5psi radius
3 - number, 1psi radius

*/


params ["_position", "_rad20psi", "_rad5psi", "_rad1psi"];

private["_trees", "_buildings", "_vehicles", "_units", "_ringWidth", "_iterationN", "_currentRadius", "_indexBuildings", "_currentBuildings", "_currentUnits", "_currentVehicles"];


//get affected objects, sorted by proximity (except for trees)
_trees = nearestTerrainObjects [_position, ["TREE", "SMALL TREE", "BUSH", "FOREST","FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE"], _rad20psi, false];
_buildings = nearestObjects [_position ,["Building"], _rad1psi];
_vehicles =  nearestObjects [_position, ["Car", "LandVehicles", "Air", "Ship"], _rad1psi];
_units = _position nearObjects ["Man", _rad1psi];


//hide destroyed trees, better for performance
{
	_x hideObjectGlobal true;
} forEach _trees;


//width of ring which is processed
_ringWidth = _rad20psi min 50; 


//number of full iterations needed
_iterationN = ceil (_rad1psi / _ringWidth);


//current interation range, starts at 0
_currentRadius = 0;


for "_i" from 1 to _iterationN do
{
	//update radius
	if (_i == _iterationN) then
	{
		_currentRadius = _rad1psi;
	}
	else
	{	
		_currentRadius = _currentRadius + _ringWidth;
	};
	
	//index variables for sorted arrays
	_indexBuildings = 0;
	_indexVehicles = 0;
	_indexUnits = 0;
	
	
	//arrays for currently affected objects
	_currentBuildings = [];
	_currentVehicles = [];
	_currentUnits = [];
	
	
	//get currently affected buildings	
	{
		if ((_x distance _position) <= _currentRadius) then
		{
			_indexBuildings = _forEachIndex;
			_currentBuildings pushBack _x;
		};
	} forEach _buildings;
	
	//remove affected buildings from main array
	_buildings deleteRange [0, _indexBuildings + 1];
	
	
	//get currently affected vehicles
	_currentVehicles = _vehicles select {(_x distance _position) <= _currentRadius};
	//remove affected vehicles from main array
	_vehicles = _vehicles select {(_x distance _position) > _currentRadius};
	
	
	//get currently affected units
	_currentUnits = _units select {(_x distance _position) <= _currentRadius};
	//romove affected units from main array
	_units = _units select {(_x distance _position) > _currentRadius};
	
	
	//select correct damage script
	if (_currentRadius <= _rad20psi) then 
	{
		[_position, _currentRadius / _rad20psi, _currentBuildings, _currentVehicles, _currentUnits] spawn freestylesNuclearBlast_fnc_20psiEffects;
	}
	else
	{
		if(_currentRadius <= _rad5psi) then
		{
			[_position, (_currentRadius - _rad20psi) / (_rad5psi - _rad20psi), _currentBuildings, _currentVehicles, _currentUnits] spawn freestylesNuclearBlast_fnc_5psiEffects;
		}
		else
		{
			if(_currentRadius <= _rad1psi) then
			{
				[_position, (_currentRadius - _rad5psi) / (_rad1psi - _rad5psi), _currentBuildings, _currentVehicles, _currentUnits] call freestylesNuclearBlast_fnc_1psiEffects;
			};
		};
	};
	
	sleep (_ringWidth / 333);
};