/*

freestylesNuclearBlast_fnc_radiatedUI


Create post process effects for players which are expoed to radiation.
Call only on players machine.


Arguments:

0 - number, duration of effect in seconds
1 - number, intensity of effect
2 - number, time the effects fade in

*/


params["_duration", "_intensity", "_fadeIn"];

private ["_colorInv", "_chromAbb", "_filmGrain", "_ppEffects"];


_colorInv = ["ColorInversion", 2500, [-0.5 * _intensity / 4, -0.5 * _intensity / 4, -0.5 * _intensity / 4], _duration, _fadeIn];
_chromAbb = ["ChromAberration", 200, [0.05, 0.05, true], _duration, _fadeIn];
_filmGrain = ["FilmGrain", 2000, [0.4 * _intensity / 4, 1.15, 1, 0.2, 1.0, 0], _duration, _fadeIn];


_ppEffects = [_colorInv, _chromAbb, _filmGrain];




//based on examples from https://community.bistudio.com/wiki/Post_process_effects
{
	_x spawn 
	{ 
		params ["_name", "_priority", "_effect", "_duration", "_fade"];
		private ["_handle"];
		
		while 
		{ 
			_handle = ppEffectCreate [_name, _priority]; 
			_handle < 0 
		} 
		do 
		{ 
			_priority = _priority + 1; 
		}; 
		
		_handle ppEffectEnable true; 
		_handle ppEffectAdjust _effect; 
		_handle ppEffectCommit _fade;
		
		waitUntil {ppEffectCommitted _handle}; 
		
		uiSleep (_duration - _fade); 
		
		_handle ppEffectEnable false; 
		
		ppEffectDestroy _handle; 
	};

} forEach _ppEffects;
