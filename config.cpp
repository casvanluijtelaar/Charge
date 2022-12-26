class CfgPatches
{
	class ADDON
	{
		name = "Charge";
		author = "supercas240";
		url = "https://steamcommunity.com/sharedfiles/filedetails/?id=2902845412";

		requiredVersion = 0.1;
		units[] = {"AOW_Charge_Position", "AOW_Charge_Player", "AOW_Charge_Cancel"};
		requiredAddons[] = {"zen_main"};
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"