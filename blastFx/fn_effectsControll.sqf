/*

freestylesNuclearBlast_fnc_effectsControll

Controlls creation of nuclear mushroom and fireball. Execute on server.


Arguments:

0 -  positonASL, blast origin
1 - number, fireball radius
*/

params["_position", "_radius"];

private["_object"];


//create main object
_object = "Sign_Sphere100cm_F" createVehicle [0,0,0];
_object setPosASL _position;


[_object, _radius] remoteExec ["freestylesNuclearBlast_fnc_flash", 0];




sleep 60;

//delete object
deleteVehicle _object;