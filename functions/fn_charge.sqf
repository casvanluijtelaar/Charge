/*
 * Author: supercas240
 *
 * Takes an array of AI Units and makes them
 * charge towards the target with custom charge AI.
 *
 * Parameters:
 *    0: Array of units
 *    1: Target position or object
 */

params ["_units", "_target"];

_group = group (_units select 0);

// set AI in charge mode
_group setSpeedMode "FULL";
_group allowFleeing 0;

{ 
     _x disableAI "TARGET";
     _x disableAI "AUTOCOMBAT";
     _x disableAI "AUTOTARGET";
     _x disableAI "SUPPRESSION";
     _x disableAI "COVER";
     _x disableAI "WEAPONAIM";
     _x disableAI "FSM";

     _x enableAI "PATH";
     _x setunitpos "UP";
     _x enableStamina false;
     _x setCombatBehaviour "CARELESS";

     // start moving towards location1
     _x doMove _target;

} forEach _units;

// keep track of all units that have reached the target
_unitsReachedTarget = 0;

// loop while there are still units charging
while { (count _units) > _unitsReachedTarget } do {

     // performance
     waitUntil { sleep 1; true; };
     
     {
          if((_x checkAIFeature "TARGET") == false && (_x distance2D _target) < 5) then {

               // enable AI
               _x enableAI "TARGET";
               _x enableAI "AUTOCOMBAT";
               _x enableAI "AUTOTARGET";
               _x enableAI "SUPPRESSION";
               _x enableAI "COVER";
               _x enableAI "WEAPONAIM";
               _x enableAI "FSM";
               _x enableStamina true;
               _x setCombatBehaviour "COMBAT";

               _x setSkill ["aimingSpeed", 1];
               _x setSkill ["spotTime", 1];
               _x setSkill ["spotDistance", 1];

               _unitsReachedTarget = _unitsReachedTarget + 1;
          };
     } forEach _units;
};
