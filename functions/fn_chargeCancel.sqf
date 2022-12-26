/*
 * Author: supercas240
 *
 * resets attached Unit's group back to a base AI
 *
 */
params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [objNull, "Please select a Unit"] call BIS_fnc_showCuratorFeedbackMessage;
};

if (!alive _unit) exitWith {
     [objNull, "Unit must be alive"] call BIS_fnc_showCuratorFeedbackMessage;
};

if (isPlayer _unit) exitWith {
     [objNull, "Cannot be used on players"] call BIS_fnc_showCuratorFeedbackMessage;
};

if (!(side group _unit in [west, east, independent, civilian])) exitWith {
     [objNull, "Please select a Unit with side"] call BIS_fnc_showCuratorFeedbackMessage;
};

_units = units group _unit;

{ 
	_x enableAI "AUTOCOMBAT";
	_x enableAI "TARGET";
	_x enableAI "AUTOTARGET";
	_x enableAI "SUPPRESSION";
	_x enableAI "COVER";
	_x enableAI "WEAPONAIM";
    _x enableAI "FSM";

	_x enableStamina true;
	_x setCombatBehaviour "COMBAT";

	doStop _x;
    (group _x) enableAttack true;

} forEach _units;
