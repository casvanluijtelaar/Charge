class CfgVehicles
{
	class Logic;
	class Module_F: Logic {};

	class Module_base: Module_F {
		author = "supercas240";
        category = "AOW_Modules";
        icon = "\AOW_CHARGE\assets\icon.paa";

		functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
		curatorCanAttach = 1;
	};

	class AOW_Charge_Position: Module_base
	{
		displayName = "Charge Position";
        function = "AOW_fnc_chargePosition";
	};

	class AOW_Charge_Player: Module_base
	{
		displayName = "Charge Nearest Player";
        function = "AOW_fnc_chargeNearestPlayer";
	};

	
	class AOW_Charge_Cancel: Module_base
	{
		displayName = "Cancel Charge";
        function = "AOW_fnc_chargeCancel";
	};
};