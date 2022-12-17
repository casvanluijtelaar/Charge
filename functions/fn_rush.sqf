// finds the closest player target within starting range and less than 200 in elevation change
_fn_findTarget = {
    _newDist = _range; 
    _all = allPlayers;
    _all = _all select {side _x != civilian && {side _x != side _group}};
    _target = objNull;
    {
        _distance = (leader _group) distance2d _x;
        if (_distance < _newDist && {getpos _x select 2 < 200}) then {_target = _x;_newDist = _distance;};
        true
    } count _all; 
    _target
};


_fn_startRush = {
    _group setSpeedMode "FULL";
    _group setFormation "WEDGE";
    _group enableAttack false;
    _group allowFleeing 0;

    {
        _x disableAI "AUTOCOMBAT";
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "SUPPRESSION";
        _x disableAI "COVER";

        _x enableAI "PATH";
        _x setunitpos "UP";
        _x enableStamina false;
        _unit setbehaviour "CARELESS";

        _x setSkill ["aimingSpeed", 1];
        _x setSkill ["spotTime", 1];
        _x setSkill ["spotDistance", 1];
        true
    } count units _group;
};

_fn_moveTo = { { _x domove (getposATL _target); } count units _group; };

_fn_endRush = {
    _group enableAttack true;

    {
        _x enableAI "AUTOCOMBAT";
        _x enableAI "TARGET";
        _x enableAI "AUTOTARGET";
        _x enableAI "PATH";
        _unit setbehaviour "COMBAT";
        _x enableStamina true;

    } count units _group;
};

_fn_hasUnitReachedPlayer = {
    _newDist = 999999; 
    {
        _distance = _target distance2d _x;
        if (_distance < _newDist) then {_newDist = _distance;};
    } count units _group;

    if(_newDist < 10) then {
        true;
    } else {
        false;
    };
};

// init
params ["_group",["_range",500],["_cycle",15]];

// get actual AI group
if (!local _group) exitWith {};
if (_group isEqualType objNull) then {_group = group _group;};


// for every alive unit in group
while {{alive _x} count units _group > 0} do {

    // wait one second and check if the group leader is in simulation range
    waitUntil {sleep 1; simulationenabled leader _group};
    
    // find nearest player target within _range
    _target = call _fn_findTarget;
    _targetPos = getPos _target;

    // if a target is found
    if (!isNull _target) then {
        // go into rush mode and move towards target
        call _fn_startRush;
        call _fn_moveTo;

        waitUntil {
            // performance, loop once a second
            sleep 1;

            // check for new closest target
            _newTarget = call _fn_findTarget;
            _newTargetPos = getPos _newTarget;

            // if this new target is more than 10 meters away update target
            if((_targetPos distance2D _newTargetPos) > 10) then { 
                _target = _newTarget;
                _targetPos = _newTargetPos;
                call _fn_moveTo; 
            };

            // a target can no longer be found
            _isTargetNull = isNull _newTarget;
            // if any AI in unit is closer than 10 meters from player
            _isAtTarget = call _fn_hasUnitReachedPlayer;

            // stop the loop if either is true
            _isTargetNull || _isAtTarget;
        };

        call _fn_endRush;   
        break;
    };
    
    sleep 10;
};

// end
true