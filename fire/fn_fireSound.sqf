/*

freestylesNuclearBlast_fnc_fireSound

Play sound effects for fires. Spawn on server only.


Arguments:

0 - object, fire center object
1 - number, lifetime of sound

*/

params["_object", "_lifetime"];

private["_sound"];

_sound = selectRandom ["A3\Sounds_F\sfx\fire2_loop.wss", "A3\Sounds_F\sfx\fire3_loop.wss", "A3\Sounds_F\sfx\fire1_loop.wss"];

for "_i" from 1 to (ceil (_lifetime / 4)) do
{
	playSound3D [_sound, _object, false, getPosASL _object, 3];
	sleep 4;
};

