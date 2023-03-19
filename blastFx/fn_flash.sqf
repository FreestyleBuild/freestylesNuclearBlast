/*

freestylesNuclearBlast_fnc_flash

Create fireball and light effects. Execute on client only.


Arguments:

0 - object, source object for fireball
1 - number, fireball radius
2 - number, hight to which fireball rises
3 - number, speed at which fireball rises per second
4 - number, distance at which light start to fade
*/

if (!hasInterface) exitWith {};


params["_object", "_radius", "_finalHeight", "_vSpeed", "_lightFadeDist"];

private["_light", "_brigthness", "_fire", "_height", "_fade"];



//create light source
_brigthness = 10150;

_light = "#lightpoint" createVehicleLocal [0,0,0];
_light lightAttachObject [_object,[0,0,0]];
_light setLightIntensity _brigthness;
_light setLightColor [1,1,1];
_light setLightUseFlare true;
_light setLightFlareSize (_radius * 15);
_light setLightDayLight true;
_light setLightFlareMaxDistance 100000;
_light setLightAttenuation [_lightFadeDist, 0, 0, 4.31918e-005];



//create fireball
_fire = "Sign_Sphere100cm_Geometry_F" createVehicleLocal [0,0,0];
_fire attachTo [_object, [0,0,0]];

[_fire, _radius * 2.5] spawn
{
	params["_f", "_r"];
	
	
	sleep 0.5;
	
	//increase size (5 secs)
	for "_i" from 1 to 50 do 
	{
		_f setObjectScale (_r * _i / 50);
		sleep 0.1;
	};
	
	sleep 2.5;
	
	//shrink size (0.5) secs
	/*for "_i" from 1 to 50 do
	{
		_f setObjectScale (_r * (1 - (_i / 50)));
		sleep 0.01;
	};*/
	
	deleteVehicle _f;
};

_light setLightColor [1,0.7,0.3];

//create initial flash (0.3 sec + 0.2 sec)
sleep 0.3;
for "_i" from 1 to 10 do
{
	_brigthness = _brigthness - 750;
	_light setLightIntensity _brigthness;
	_light setLightFlareSize (_radius * (_i * (- 14/10) + 15));
	sleep 0.02;
};


//increase brigthness to create double flash (4 sec)
for "_i" from 1 to 50 do
{
	_brigthness = _brigthness + 200;
	_light setLightIntensity _brigthness;
	_light setLightFlareSize (_radius * (_i * (+ 14/50) + 1));
	sleep 0.08;
};

sleep 3;

_height = 0;

//reduce brightness after second flash (10 sec)
for "_i" from 1 to 100 do
{
	_brigthness = _brigthness - 100.75;
	_light setLightIntensity _brigthness;
	_light setLightFlareSize (_radius * (_i * (- 14/100) + 15));
	_light setLightColor [1,0.7 - (0.4/100 * _i),0.3  - (0.3/100 * _i)];
	//_light setLightAmbient [1,0.7 - (0.4/100 * _i),0.3  - (0.3/100 * _i)];
	
	if (_height < _finalHeight) then
	{
		_height = _height + _vSpeed * 0.1;
		_light lightAttachObject [_object,[0,0,_height]];
	};
	sleep 0.1;
};

//illuminate the fireball/effects
/*_light setLightColor [1,0.3,0];
_light setLightDayLight true;
_light setLightFlareSize _radius;*/

//increase brighness (0.5 sec)
for "_i" from 1 to 25 do 
{
	_brigthness = _brigthness + 5;
	_light setLightIntensity _brigthness;
	
	if (_height < _finalHeight) then
	{
		_height = _height + _vSpeed * 0.02;
		_light lightAttachObject [_object,[0,0,_height]];
	};
	sleep 0.02;
};


//let light shine for a bit and rise with the clouds (_finalHeight / _vSpeed seconds)

while {_height < _finalHeight} do
{
	_height = _height + _vSpeed * 0.01;
	_light lightAttachObject [_object,[0,0,_height]];
	_light setLightFlareSize (_radius *  (0.5 max (1 - (_height / _finalHeight))));
	sleep 0.01;
};



// let light fade out (~20 sec)


_fade = (_brigthness / 50) max 10;
while{_brigthness > 0} do 
{	
		_brigthness = _brigthness - _fade;		
		_light setLightIntensity _brigthness;
		
		sleep 0.05;
};


//delete light source
deleteVehicle _light;