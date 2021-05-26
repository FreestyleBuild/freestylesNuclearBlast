/*

freestyleNuclearBlast_fnc_createFire

Create simple fire effects at a given location. Execute on clients only.
Use setParticleFire to damage units.


Arguments:

0 - object, center of the fire
1 - number, fire radius, only integers
2 - array of numbers, particle fire params
	0 - core intensity, damage at center
	1 - core distance, damage range
	2 - damage time, how often damage is applied
3 - number, fire duration
4 - realtivePosition, center off set from center object

*/

if (!hasInterface) exitWith {};

params["_object", "_radius", "_fireParams", "_lifetime", "_offset"];

private["_emmiters", "_temp", "_color", "_colorTarget", "_colorEmm", "_dist", "_light", "_smoke"];


//create colors for particles
_color = [1, 1, 1, 1];

_colorTarget = [250 / 255, 250 / 255, 250 / 255, 1];

_colorEmm = [1000, 1000, 1000, 1];

//variable to save particle emmiters to
_emmiters = [];


//create flames
for "_i" from 1 to (ceil (_radius / 2)) do
{
	//create particle source
	_temp = "#particlesource" createVehicleLocal [0,0,0];
	_temp attachTo [_object, _offset];
	
	
	_temp setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1], "", "Billboard", 1, 15, [0,0,0], [0,0,0.1], 0, 9.996,7.84, 0, [2, 1], [_color ,_colorTarget ], [1,1], 1, 0.1, "", "", _object, 0.0, false, -1.0, [_colorEmm , _colorEmm]];
	_temp setParticleRandom [1, [0.5, 0.5, 0], [0.1, 0.1, 0.1], 0, 1, [0, 0, 0, 0], 0, 0];
	_temp setParticleCircle [_i,[0,0,0]];
	_temp setParticleFire _fireParams;
	_temp setDropInterval 0.3;
	
	
	_emmiters pushBack _temp;
};


//create distortion

_dist = "#particlesource" createVehicleLocal [0,0,0];
_dist attachTo [_object, _offset vectorAdd [0,0, _radius]];
_dist setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 5, [0,0,2 + _radius / 2], [0,0,0], 30, 9.996,7.84, 0.2, [_radius,_radius], [[1,1,1,0],[1,1,1,1],[1,1,1,0]], [0.1], 1, 0, "", "", _object, 0.0, false, -1.0, [_color ,_colorTarget]];
_dist setDropInterval 0.5;


//create smoke effect

_smoke = "#particlesource" createVehicleLocal [0,0,0];
_smoke attachTo [_object, _offset vectorAdd [0,0, _radius]];
_smoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1], "", "Billboard", 1, 35, [0,0, _radius / 4], [0,0,0], 0.2, 8.9,7.84, 0.4, [2 + _radius / 2,_radius * 0.7], [_color ,[0,0,0,0] ], [0.3], 4, 0.3, "", "", _object, 0.0, false, -1.0, [_color ,_colorTarget]];
_smoke setParticleRandom [5, [_radius / 10, _radius / 10, _radius / 10], [0.1, 0.1, 0.1], 0.5, 0, [0.05, 0.05, 0.05, 0.2], 0.3, 0.1];
_smoke setParticleCircle [_radius / 2, [0,0,0]];
_smoke setDropInterval 0.07;



//create light
_light = "#lightpoint" createVehicleLocal [0,0,0];
_light lightAttachObject [_object, _offset];
_light setLightBrightness 5;
_light setLightColor [0.9,0.4,0];
_light setLightUseFlare true;
_light setLightFlareSize _radius * 3;
_light setLightDayLight true;
_light setLightFlareMaxDistance 100;


0 = [_light, _radius * 3] spawn{
	params["_l", "_r"];

	private _h = 1;
	while {not (isNull _l)} do
	{
		_h = 1 + (random(60) - 30) / 100;
		_l setLightBrightness (5 * _h);
		_l setLightFlareSize (_r * _h);
		sleep 0.07;
	};
};


//let fire burn
sleep _lifetime;


{
	deleteVehicle _x;
} forEach _emmiters;

sleep 10;

deleteVehicle _light;
deleteVehicle _smoke;
deleteVehicle _dist;