/*
 * Author: supercas240
 *
 * To be used on Zeus Module only. Makes attached group
 * charge towards the nearest enemy player position.
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
 
_group = group _unit;
_players = allPlayers select { side _x != side _group };
_nearestPlayer = [_players, leader _group] call BIS_fnc_nearestPosition;

_units = units _group;
[_units, getPosASL _nearestPlayer] call AOW_fnc_charge;

true;