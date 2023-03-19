/*

freestylesNuclearBlast_fnc_generateCrater

Generates a crater of given radius on given position. Radius is adjusted for explosions above ground level.
Call on server only.


Arguments:

0 - positionASL, crater center
1 - number, crater radius in meters

*/

params["_position", "_radius"];

private["_heightOffset", "_type", "_obj", "_num", "_angleInc", "_curAngle", "_curPos", "_hideObjs"];


//calculate new crater radius depending on detonation height, higher detonation = smaller crater
_radius = ((_radius ^ 2) - (((_position # 2) - (getTerrainHeightASL _position)) ^ 2))^ 0.5;


//exit if crater is to smalll
if (_radius <= 0) exitWith{};

//get objects inside crater which need to be hidden
_hideObjs = nearestTerrainObjects [[_position # 0, _position # 1], [], _radius];
_hideObjs append ([_position # 0, _position # 1] nearObjects _radius);

//hide the objects
{
	if ((isDamageAllowed _x) and not (isPlayer _x)) then 
	{
		_x setDamage [1, false]; //destroy objects, does not need to be ace compatible
		_x hideObjectGlobal true;
	};	
} forEach _hideObjs;


//spawn crater object for very small craters and exit
if (_radius < 10) exitWith {
	_position = [_position # 0, _position # 1, 1.6];
	createVehicle ["Land_ShellCrater_02_extralarge_F", _position, [], 0, "CAN_COLLIDE"];
};

/* Used for crater walls, disabled for now
//calculate height offset, used for smaller craters to not create too high crater walls
_heightOffset = 0;
if (_radius < 50) then {
	_heightOffset = -50 + _radius;
	_heightOffset = _heightOffset / 10;
};

//generate the crater

//update position to be on appropriate altitude 
_position = [_position # 0, _position # 1, _heightOffset];

//type of objects used for crater wall
_type = "Land_R_rock_general2";

//number of wall pieces needes
_num = floor(2 * pi * _radius / 15);

//angle between two pieces
_angleInc = 360 / _num;

//current angle
_curAngle = 0;


//create circle of crater walls
for "_i" from 0 to _num do {

	//calculate position for next wall
	_curPos = [(_position # 0) + (cos _curAngle) * _radius, (_position # 1) + (sin _curAngle) * _radius, _position # 2];
	
	//variable to hold most recent wall piece
	_obj = createVehicle [_type, _curPos, [], 0, "CAN_COLLIDE"];
	
	//turn wall side ways
	_obj setVectorDir vectorNormalized([cos _curAngle, sin _curAngle, 0]);
	
	_curAngle = _curAngle + _angleInc;
};
*/
//create a decal and scale it
_obj = createVehicle ["Land_DirtPatch_02_F", _position, [], 0, "CAN_COLLIDE"];
_obj setObjectScale _radius / 4;
_obj enableSimulationGlobal false;

// create deformation
[_position, _radius, (_radius * 0.5) min 500] call freestylesNuclearBlast_fnc_terrainCrater;