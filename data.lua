--[[ Hierarchy of splits 
,
/
;
]]

shield_time = 30 * 15
max_hp = 4
monster_palettes = {
    split("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"),
    split("1,2,5,4,5,6,7,4,6,7,11,12,13,14,15")
}

-- name: image, type, def, description,
--[[
    delay=step_def[1],
    grid=step_def[2],
    xv=step_def[3] * side,
    yv=step_def[4],
    collides=step_def[5],
    telegraph=step_def[6],
    max_tiles=step_def[7] or 8,
    bounces_x=step_def[8],
    bounces_y=step_def[9],
    absolute_x=
    absolute_y=
]]
    --[[
108,attack, 0/0b0000000000000100.11100100000000000000/0/0/0/40,bomb.f,1
106,attack, 0/0b0000010011100100.0000000000000000/0/0/0/30,bomb.n,1
115,attack, 0/0b0000010000000000.0000000000000000/0/0/0/5;0/0b0000000000000100.0000000000000000/0/0/0/10;0/0b0000000000000000.0000001000000000/0/0/0/15,sword,3
    ]]
all_abilities = string_multilookup([[
slap,104,attack,    0/0b0000010000000000.0000000000000000/0/0/0/0,0
rock,112,attack,    0/0b0000000000000100.0000000000000000/0/0/0/25,0
sword,97,attack,    0/0b1010010000000000.0000000000000000/0/0/0/0,1
spear,101,attack,   0/0b0000010000000000.0000000000000000/7/0/0/0/2,1
wave,100,attack,    0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,1
bomb,107,attack,    0/0b0000000001001110.0100000000000000/0/0/0/35,1
sling,96,attack,    0/0b0100000000000000.0000000000000000/30/0/1/5/8,1
rico,105,attack,    0/0b0100000000000000.0000000000000000/5/-5/1/15/10/1/1,2
lance,109,attack,   0/0b0000010001000100.0000000000000000/0/0/0/0,2
scythe,102,attack,  0/0b1010111000000000.0000000000000000/0/0/0/0,2
split,103,attack,   0/0b1010000000000000.0000000000000000/3/0/0/15,2
bouncer,113,attack, 0/0b0000010000000000.0000000000000000/6/0/0/15/6/1/0,2
wall,110,attack,    0/0b0000000000000000.1000000000000000/0/30/0/30/4/0/0/0/1,2
mortar,114,attack,  0/0b0000000000000000.0000011001100000/0/0/0/35/4/0/0/1/1,2
double,111,attack,  0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0;15/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,3
pinch,116,attack,   0/0b0000000000000001.0000000000000000/0/-30/0/10/4/0/0/0/1;10/0b0000000000000000.1000000000000000/0/30/0/10/4/0/0/0/1,3
shield,98,shield,,1
turret,99,turret,,2
curse,119,curse,,-1
]])

all_mods = string_multilookup([[
growth,120,3,gets stronger each use%in battle
fast,121,0,roll the next die faster
claim,122,10,claim up to 2 of the tiles hit
pause,123,4,time stands still for%a moment longer
invasion,124,2,+1 pip if standing%in enemy territory
rage,125,2,+2 pips if less than%half health
poison,126,1,deals poison damage instead
stun,127,2,stuns the enemy for%a moment
]])

local monster_defs = string_multilookup([[
mage1,12,0,wave;1,3,60,move_pattern=xx_,abil_pattern=__x
fighter1,8,0,sword;1;claim/sword;1,5,28,move_pattern=xx_,abil_pattern=__x
duelist1,14,0,wave;1/sword;2/sword;1;claim,7,32,move_pattern=xxx_,abil_pattern=___x
engineer1,6,0,turret;2/sling;1,8,65,flies=1,abil_pattern=_x
boss1,10,0,bomb;2/wave;1/shield;1/sword;3,20,15,flies=1,abil_pattern=____x_x__,move_pattern=xxxx_____
bomber1,4,0,bomb;2,10,99
mage2,12,1,wave;2,8,40,move_pattern=xx_,abil_pattern=__x
fighter2,8,1,sword;3/spear;3,10,30,abil_pattern=_x
boss2,10,1,sling;3/turret;3/shield;3/wave;3,30,20,flies=1,abil_pattern=______x_x_x_,move_pattern=xxxx___x_x_x
bomber2,4,2,bomb;2,15,39,abil_pattern=_x_
engineer2,6,2,turret;4/sling;2/shield;2,10,45,flies=1,abil_pattern=_x
duelist2,14,2,wave;3/sword;4/spear;4/shield;2,14,21,move_pattern=xxx_,abil_pattern=___x
mage3,12,2,wave;4/wave;4,15,40,move_pattern=xx_,abil_pattern=__x
boss3,10,2,wave;3/wave;1/shield;1/spear;1,40,21,move_pattern=xxx_,abil_pattern=___x
]])


-- third mod crash