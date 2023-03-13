/*

freestylesNuclearBlast_fnc_terrainCrater

Deform terain in shape of a simple crater.

Arguments:

0 - positionASL, blast origin position
1 - number, crater radius
2 - number, crater depth
*/

params["_center", "_radius", "_depth"];

private ["_heightUpdate", "_lowerLeftCorner", "_centerHeight", "_currentPosition", "_currentHeight", "_distanceToCenter", "_newHeight"];

getTerrainInfo params ["", "", "_cellsize", "_resolution", ""];

if(_cellsize > 2 * _radius) exitWith {}; // if terrain cellsize is to large do not do any deformation

_heightUpdate = [];
_lowerLeftCorner = _center vectorDiff [_radius, _radius, 0];
_centerHeight = getTerrainHeight _center;

for "_xStep" from 0 to 2 * (ceil _radius / _cellsize) do
{
	for "_yStep" from 0 to 2 * (ceil _radius / _cellsize) do
	{
		_currentPosition = _lowerLeftCorner vectorAdd [_xStep * _cellsize, _yStep * _cellsize, 0];
		_currentHeight = getTerrainHeight _currentPosition;
		_distanceToCenter = (_currentPosition distance2D _center);
		
		_newHeight = _centerHeight - (_depth - (_distanceToCenter / _radius) * _depth);
		
		if ((_distanceToCenter <= _radius) and (_newHeight < _currentHeight)) then // check that position is within circle
		{
			_currentPosition set [2, _newHeight]; // make sure to not raise the terrain
			_heightUpdate pushBack _currentPosition;
		};
	};
};

setTerrainHeight [_heightUpdate, true];