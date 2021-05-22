/*

freestylesNuclearBlast_fnc_dustWave

Create persisiten dust and shockwave dust kick-up effect. Execute on clients only.


Arguments:

0 - positionASL, blast origin
1 - number, particle base size 
2 - number, outer radius for max wave size
*/

if (!hasInterface) exitWith {};


params["_position", "_size", "_outer"];

private["_stepSize", "_obj", "_wave", "_color", "_targetColor", "_currentRadius"];


_color = [0.8, 0.60, 0.4,0.1];
_targetColor = [0.8, 0.60, 0.4,0];


//create objects and particle spawner
_obj = "Sign_Sphere10cm_F" createVehicleLocal _position;
_obj setPosASL _position;


_wave = "#particlesource" createVehicleLocal [0,0,0];
_wave attachTo [_obj,[0,0,0]];


//setup outer particles (persistent)
_wave setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,1], "", "Billboard", 1, _size / 100, [0,0,0], [0,0,0], 0, 9.996,7.84, 0, [_size], [_targetColor,_color,_targetColor], [1,1], 1, 0, "", "", _obj, 0.0, true, -1.0, [_color,_targetColor]];

_stepSize = _size;
_currentRadius = _size / 2;

while {_currentRadius <= _outer} do 
{
	_wave setParticleCircle [_currentRadius, [0,0,0]];

	_wave setDropInterval 1/(2 * 3.141 * _currentRadius * 1.3);
		
	_currentRadius = _currentRadius + _stepSize;
		
	sleep (_stepSize / 200);
};

deleteVehicle _wave;
deleteVehicle _obj;




