
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
};