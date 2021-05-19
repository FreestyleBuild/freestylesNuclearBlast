class CfgFunctions
{	
	class freestylesNuclearBlast
	{
		class blast_fx
		{
			file = "freestylesNuclearBlast\blastFx";
		};
		
		class blast_damage
		{
			file = "freestylesNuclearBlast\blastDamage";
			class generateCrater {};
		};
		
		class init_fnc
		{
			file = "freestylesNuclearBlast\init";
			class initBlast{}; //freestylesNuclearBlast_fnc_initBlast
		};
	};
};