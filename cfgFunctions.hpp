class freestylesNuclearBlast
{
	class blast_fx
	{
		file = "FreestylesNuclearBombs\freestylesNuclearBlast\blastFx";
		class spikeSpawner {};
		class smokeSpikes {};
		class dustWave {};
		class soundFX {};
		class flash {};
		class effectsControll {};
		class condensationRing {};
		class smoke {};
		class mushroomCloud {};
	};
	
	class blast_damage
	{
		file = "FreestylesNuclearBombs\freestylesNuclearBlast\blastDamage";
		class generateCrater {};
		class radiationDamage {};
		class shockwave {};
		class 20psiEffects {};
		class 5psiEffects {};
		class 1psiEffects {};
		class staticRadiation {};
		class terrainCrater {};
	};
	
	class misc_fncs
	{
		file = "FreestylesNuclearBombs\freestylesNuclearBlast\misc";
		class applyDamage {};
		class damageOverTime {};
		class damageBuildings {};
		class ragdollUnits {};
		class throwVehicles {};
		class aceDamage {};
	};
	
	class init_fnc
	{
		file = "FreestylesNuclearBombs\freestylesNuclearBlast\init";
		class initBlast {}; //freestylesNuclearBlast_fnc_initBlast
		class debugOutput {};
		class calculateRanges {};
	};
	
	class ui_effects
	{
		file = "FreestylesNuclearBombs\freestylesNuclearBlast\uiEffects";
		class radiatedUI {};
		class spawnRadiationEffects {};
	};
	
	class fire
	{
		file = "FreestylesNuclearBombs\freestylesNuclearBlast\fire";
		class createFire {};
		class fireSound {};
		class spawnFires {};
	};
};
