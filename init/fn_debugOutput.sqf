/*

freestylesNuclearBlast_fnc_debugOutput

Creates main debug output, including markers for effect ranges.


Arguments:

0 - positionASL, blast origin
1 - number, fireball radius
2 - number, 1psi radius
3 - number, 5psi radius
4 - number, 20psi radius
5 - number, 5000rem radius
6 - number, 500rem radius
7 - number, 100% burns radius
8 - number, 50% burns radius
9 - crater radius

*/



params["_position", "_radFireball", "_rad1psi", "_rad5psi", "_rad20psi", "_rad5000rem", "_rad500rem", "_rad100thermal", "_rad50thermal", "_radCrater"];


//print ace output
systemChat ("Ace Medical: " + str(missionNamespace getVariable ["FNB_aceActivated", "Error, aceActivated not initialized"]));


//output radius stats
hint formatText ["Fireball: %1 m %2 1 psi: %3 m %2 5 psi: %4 m %2 20 psi: %5 m %2 500 rem: %6 m %2 5000 rem: %7 m %2 100 Thermal: %8 m %2 50 Thermal: %9 m %2 Crater: %10 m %2", _radFireball, lineBreak, _rad1psi, _rad5psi, _rad20psi, _rad500rem, _rad5000rem, _rad100thermal, _rad50thermal, _radCrater];


//draw markers
_mark1psi = createMarker ["1 psi Airblast"  + str(time), _position];
_mark1psi setMarkerColor "ColorGrey";
_mark1psi setMarkerShape "ELLIPSE";
_mark1psi setMarkerBrush "Solid";
_mark1psi setMarkerSize [_rad1psi, _rad1psi];


_mark5psi = createMarker ["5 psi Airblast"  + str(time), _position];
_mark5psi setMarkerColor "ColorYellow";
_mark5psi setMarkerShape "ELLIPSE";
_mark5psi setMarkerBrush "Solid";
_mark5psi setMarkerSize [_rad5psi, _rad5psi];


_mark20psi = createMarker ["20 psi Airblast"  + str(time), _position];
_mark20psi setMarkerColor "ColorRed";
_mark20psi setMarkerShape "ELLIPSE";
_mark20psi setMarkerBrush "Solid";
_mark20psi setMarkerSize [_rad20psi, _rad20psi];


_mark50thermal = createMarker ["50% 3rd Degree burns" + str(time), _position];
_mark50thermal setMarkerColor "ColorOrange";
_mark50thermal setMarkerBrush "Border";
_mark50thermal setMarkerShape "ELLIPSE";
_mark50thermal setMarkerSize [_rad50thermal, _rad50thermal];


_mark100thermal = createMarker ["100% 3rd Degree burns" + str(time), _position];
_mark100thermal setMarkerColor "ColorRed";
_mark100thermal setMarkerBrush "Border";
_mark100thermal setMarkerShape "ELLIPSE";
_mark100thermal setMarkerSize [_rad100thermal, _rad100thermal];


_mark500rem = createMarker ["500 Rem" + str(time), _position];
_mark500rem setMarkerColor "ColorGreen";
_mark500rem setMarkerBrush "Border";
_mark500rem setMarkerShape "ELLIPSE";
_mark500rem setMarkerSize [_rad500rem, _rad500rem];


_mark5000rem = createMarker ["5000 Rem" + str(time), _position];
_mark5000rem setMarkerColor "ColorBlue";
_mark5000rem setMarkerBrush "Border";
_mark5000rem setMarkerShape "ELLIPSE";
_mark5000rem setMarkerSize [_rad5000rem, _rad5000rem];


_markCrater = createMarker ["Crater" + str(time), _position];
_markCrater setMarkerColor "ColorBlack";
_markCrater setMarkerShape "ELLIPSE";
_markCrater setMarkerSize [_radCrater, _radCrater];	