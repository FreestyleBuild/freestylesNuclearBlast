/*

freestylesNuclearBlast_fnc_flash

Create fireball and light effects. Execute on client only.


Arguments:

0 - object, source object for fireball
1 - number, fireball radius
*/

if (!hasInterface) exitWith {};


params["_object", "_radius"];

private["_light", "_brigthness", "_fire"];



//create light source
_brigthness = 10150;

_light = "#lightpoint" createVehicleLocal [0,0,0];
_light lightAttachObject [_object,[0,0,0]];
_light setLightBrightness _brigthness;
_light setLightColor [1,1,1];
_light setLightUseFlare true;
_light setLightFlareSize (_radius * 15);
_light setLightDayLight true;
_light setLightFlareMaxDistance 100000;



//create fireball
_fire = "Sign_Sphere100cm_F" createVehicleLocal [0,0,0];
_fire attachTo [_object, [0,0,0]];

[_fire, _radius] spawn
{
	params["_f", "_r"];
	
	//fireball lifetime 2 sec
	
	for "_i" from 1 to 50 do
	{
		_f setObjectScale (_r * _i / 50);
		sleep 0.01;
	};
	
	sleep 0.5;
	
	for "_i" from 1 to 50 do
	{
		_f setObjectScale (_r * (1 - (_i / 50)));
		sleep 0.01;
	};
	
	deleteVehicle _f;
};


//create initial flash (0.1 sec + 0.1 sec)
sleep 0.1;
for "_i" from 1 to 10 do
{
	_brigthness = _brigthness - 1000;
	_light setLightBrightness _brigthness;
	sleep 0.01;
};

//increase brigthness to create double flash (0.5 sec)
for "_i" from 1 to 50 do
{
	_brigthness = _brigthness + 200;
	_light setLightBrightness _brigthness;
	sleep 0.01;
};

//reduce brightness after second flash (0.39 sec)
for "_i" from 1 to 13 do
{
	_brigthness = _brigthness - 775;
	_light setLightBrightness _brigthness;
	sleep 0.03;
};

//set color to orange to illuminate the fireball/effects
_light setLightColor [1,0.3,0];
_light setLightDayLight true;


//increase brighness (0.5 sec)
for "_i" from 1 to 25 do 
{
	_brigthness = _brigthness + 5;
	_light setLightBrightness _brigthness;
	sleep 0.02;
};


// let light fade out (~30 sec)
while{_brigthness > 0} do 
{
		_brigthness = _brigthness + (random [-5, -2, -1]);
		_light setLightBrightness _brigthness;
		sleep 0.3;
};


//delete light source
deleteVehicle _light;