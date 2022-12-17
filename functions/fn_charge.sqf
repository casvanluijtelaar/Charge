
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

_range = _logic getVariable ["Range", 10000]; 
_group = group _unit;

[_group, _range] call AOW_fnc_rush;
