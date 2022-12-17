
class CfgVehicles
{
	class Logic;
	class Module_F: Logic 
	{
		class AttributesBase
		{
			class Combo;
		};
	};

	class AOW_Charge: Module_F
	{


		author = "cas";
        category = "AOW_Modules";
        displayName = "Charge players";
        function = "AOW_fnc_charge";
        icon = "\AOW_CHARGE\assets\icon.paa";

		functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 2;
        scopeCurator = 2;
		curatorCanAttach = 1;

		class Attributes: AttributesBase
		{
			class Range: Combo
			{
				property = "AOW_Charge_range";
				displayName = "Player Detection Range";
				tooltip = "how far until a unit detects an enemy player and enters charge mode";
				typeName = "NUMBER";
				defaultValue = "50";

				class Values
				{
					class 10M	{ name = "10m";	value = 10; };
					class 20M	{ name = "20m";	value = 20; };
					class 50M	{ name = "50m";	value = 50; };
					class 75M	{ name = "75m";  value = 75; };
					class 100M	{ name = "100m"; value = 100; };
				};
			};
		};

		class ModuleDescription
		{
            description = "Allows this unit to change nearby players";
            sync[] = {};
        };

	};
};