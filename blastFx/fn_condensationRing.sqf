/*

freestyleNuclearBlast_fnc_condensationRing

Create a white condensation ring which slowly expands and then dissipates. Execute only client only.


Arguments:

0 - object, object to align ring to
1 - number, height of ring above blast
2 - number, radius of ring
3 - number, velocity of ring expansion
4 - number, cloudlifetime

*/

if (!hasInterface) exitWith {};

params ["_obj", "_height", "_radius", "_speed", "_lifetime"];

private ["_curAngle", "_num", "_angleInc", "_curPos", "_pos"];


//caculate number of particles, angle and set current angle
_num = 2 * 3.141 * _radius / 2;
_curAngle = 0;
_angleInc = 360 / _num;
_pos = getPosASL _obj;


//create the ring
for "_i" from 1 to _num do {

	_curPos = [(_pos # 0) + (cos _curAngle) * _radius, (_pos # 1) + (sin _curAngle) * _radius, _pos # 2];
	
	drop [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,0], "", "Billboard", 1, _lifetime, (_curPos vectorDiff _pos) vectorAdd [0,0,_height], (_pos vectorFromTo _curPos) vectorMultiply _speed, 0, 9.996,7.84, 0, [10,10], [[1,1,1,1],[1,1,1,0]], [1,1], 1, 0, "", "", _obj, random(360)/(2 * pi), false, -1.0, [[1,1,1,1],[1,1,1,0]]];
	
	_curAngle = _curAngle + _angleInc;
};
