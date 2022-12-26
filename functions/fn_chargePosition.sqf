/*
 * Author: supercas240
 *
 * To be used on Zeus Module only. Makes attached group
 * charge towards the position selected by the curator
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

[units group _unit, {

     _selected = _this select 0;
     _units = _this select 1;
     _position = _this select 2;

     if(_selected) then {[_units, _position] spawn AOW_fnc_charge; };

}, [], "Target"] call zen_common_fnc_selectPosition;

true;