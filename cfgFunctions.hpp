class CfgFunctions
{	
	class freestylesNuclearBlast
	{
		class blast_fx
		{
			file = "freestylesNuclearBlast\blastFx";
			class spikeSpawner {};
			class smokeSpikes {};
			class dustWave {};
			class soundFX {};
			class flash {};
			class effectsControll {};
			class condensationRing {};
			class smoke {};
		};
		
		class blast_damage
		{
			file = "freestylesNuclearBlast\blastDamage";
			class generateCrater {};
			class radiationDamage {};
			class shockwave {};
			class 20psiEffects {};
			class 5psiEffects {};
			class 1psiEffects {};
		};
		
		class misc_fncs
		{
			file = "freestylesNuclearBlast\misc";
			class applyDamage {};
			class damageOverTime {};
			class damageBuildings {};
			class ragdollUnits {};
			class throwVehicles {};
		};
		
		class init_fnc
		{
			file = "freestylesNuclearBlast\init";
			class initBlast {}; //freestylesNuclearBlast_fnc_initBlast
			class debugOutput {};
			class calculateRanges {};
		};
		
		class ui_effects
		{
			file = "freestylesNuclearBlast\uiEffects";
			class radiatedUI {};
			class spawnRadiationEffects {};
		};
	};
};