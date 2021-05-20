/*

freestylesNuclearBlast_fnc_calculateRanges

Caclculate the ranges for the different blast effects.


Arguments:

0 - number, yield in kT

*/


params["_yield"];


private ["_radFireball", "_rad1psi", "_rad5psi", "_rad20psi", "_rad5000rem", "_rad500rem", "_rad100thermal", "_rad50thermal", "_radCrater"];


_radFireball = (_yield ^ 0.39991) * 79.30731 - 0.33774;
_rad1psi = (_yield ^ 0.33308) * 1179.03371;
_rad5psi = (_yield ^ 0.33325) * 458.29634;
_rad20psi = (_yield ^ 0.33355) * 216.89585 + (_yield ^ 0.1798) * 1.17158;
_rad5000rem = (_yield ^ 0.21107) * 424.37067 + (_yield ^ 3) * 2.40299e-6 - 0.00175 * (_yield ^ 2) + (_yield ^ 0.21107) * 85.15598;
_rad500rem = (_yield ^ 0.16353) * 228.38886 + (_yield ^ 3) * 7.86898e-8 - 0.00175 * (_yield ^ 2) + (_yield ^ 0.16353) * 625.25398;
_rad100thermal = (_yield ^ 0.43788) * 517.81986 + (_yield ^ 3) * 3.17366e-11 - (_yield ^ 2) * 4.76245e-6 + (_yield ^ (-1.11864)) * 3.50645;
_rad50thermal = (_yield ^ 0.9993) * 283.0527 + (_yield ^ 5) * 9.10689e-22 + (_yield ^ 0.41672) * 598.33159 - 280.91567 * _yield;
_radCrater = (_yield ^ 0.3342305) * 19.13638 + 0.4707669;

_result = [_radFireball, _rad1psi, _rad5psi, _rad20psi, _rad5000rem, _rad500rem, _rad100thermal, _rad50thermal, _radCrater];
_result;