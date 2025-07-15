shield_time = 30 * 10
max_hp = 4
monster_palettes = {
    split("1,2,3,1,5,6,7,3,5,6 ,14,12,13,14,15"),
    split("1,2,3,0,5,6,7,9,1,5,10,12,13,14,15"),
    split("1,2,3,4,5,6,7,8,12,10,11,12,13,14,15"),
    split("1,2,3,4,5,6,7,8,8,10,11,12,13,14,15"),
}
gridpatterns = split"64,66,68,64,64,66,68,64,70,72,66,74,70,72,66,74,74,66,72,70,74,66,72,70,64,72,66,64,64,72,66,64"

all_abilities = smlu([[
slap,104,attack,    0/0b0000010000000000.0000000000000000/0/0/0/0,0
rock,112,attack,    0/0b0000000000000100.0000000000000000/0/0/0/25,0
cane,106,attack,    0/0b1010000000000000.0000000000000000/0/0/0/0,0
shield,98,shield,   0/0b0100000000000000.0000000000000000/0/0/0/0,1
sword,97,attack,    0/0b1010010000000000.0000000000000000/0/0/0/0,1
splash,108,attack,  0/0b0000100000000000.0000000000000000/5/-5/0/0/1;0/0b0000001000000000.0000000000000000/5/5/0/0/1,1
spear,101,attack,   0/0b0000010000000000.0000000000000000/7/0/0/0/2,1
wave,100,attack,    0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,2
bomb,107,attack,    0/0b0000000001001110.0100000000000000/0/0/0/35,2
sling,96,attack,    0/0b0100000000000000.0000000000000000/30/0/1/5/8,3
rico,105,attack,    0/0b0100000000000000.0000000000000000/5/-5/1/15/10/1/1,3
scythe,102,attack,  0/0b1010111000000000.0000000000000000/0/0/0/0,3
split,103,attack,   0/0b1010000000000000.0000000000000000/3/0/0/15,3
bouncer,113,attack, 0/0b0000010000000000.0000000000000000/6/0/0/15/6/1/0,3
mortar,114,attack,  0/0b0000000000000000.0000011001100000/0/0/0/35/4/0/0/1/1,3
wall,110,attack,    0/0b0000000000000000.1000000000000000/0/30/0/15/4/0/0/0/1,4
double,111,attack,  0/0b0000010000000000.0000000000000000/6/0/0/15/8/0/0;30/0b0000010000000000.0000000000000000/6/0/0/15/8/0/0,4
pinch,116,attack,   0/0b0000000000000001.0000000000000000/0/-30/0/10/4/0/0/0/1;10/0b0000000000000000.1000000000000000/0/30/0/10/4/0/0/0/1,4
s.bash,109,shield,  0/0b0100111000000000.0000000000000000/0/0/0/0,4
turret,99,turret,wave,4
sp.turret,117,turret,split,5
bigwave,115,attack,     0/0b0000111100000000.0000000000000000/2/0/0/30/8/0/0/0/1,5
sy.turret,118,turret,scythe,-1
sl.turret,118,turret,sling,-1
curse,119,curse,,-1
backrow1,0,attack,      0/0b0000000000000000.0000000000001111/0/0/0/30/4/0/0/1/1,-1
backrow2,0,attack,      0/0b0000000000000000.0000000011111111/0/0/0/30/4/0/0/1/1,-1
rico2,105,attack,       0/0b0100000000000000.0000000000000000/5/-5/1/15/30/1/1,-1
rico3,105,attack,       0/0b0100000000000000.0000000000000000/4/-8/0/20/999/0/1,-1
rico4,105,attack,       0/0b0100000000000000.0000000000000000/16/2/0/20/64/1/1,-1
fastbomb,107,attack,    0/0b0000000001001110.0100000000000000/0/0/0/20,-1
donut,107,attack,       0/0b0000000011101010.1110000000000000/0/0/0/35,-1
crisscross,0,attack,    0/0b0000000000000000.0000000000001000/0/3/0/20/16/0/0/1/1;0/0b0000000000000000.0000000000010000/0/-3/0/20/16/0/0/1/1;0/0b0000000000000000.0000100000000000/0/3/0/20/16/0/0/1/1;0/0b0000000000000000.0001000000000000/0/-3/0/20/16/0/0/1/1,-1
fullscreen,107,attack,  0/0b1111111111111111.1111111111111111/0/0/0/35/32/0/0/1/1,-1
d.turret,117,turret,rico,-1
]])

all_mods = smlu([[
growth,120,3,+1 each use in%battle (max = 5)
pierce,121,2,ignores shields
claim,122,8,claim up to 2%of the tiles hit
pause,123,4,time stands still%for a moment longer
invasion,124,2,+1 if standing%in enemy tile
rage,125,2,+2 if less than%half health
poison,126,2,deals poison damage%instead of normal
stun,127,2,stuns the enemy%for a moment
]])

local monster_defs = smlu([[
harpy1,38,0,wave;1,4,60,flies=1,move_pattern=xx_,abil_pattern=__x
dog1,36,0,sword;1;claim/sword;1,5,28,move_pattern=xx_,abil_pattern=__x
fox1,14,0,wave;1/splash;2/splash;1/rock;2;claim,6,36,move_pattern=xxx_,abil_pattern=___x
owl1,34,0,turret;2/sling;1,8,65,flies=1,abil_pattern=_x
boss1,40,0,bomb;3/wave;2/shield;1/sword;3,20,15,flies=1,abil_pattern=____x_x__,move_pattern=xxxx_____
scorpion1,32,0,bomb;2,10,99
harpy2,38,1,wave;1;growth/rico;1;growth,8,40,flies=1,move_pattern=xx_,abil_pattern=__x
dog2,36,1,sword;3/spear;3,10,30,abil_pattern=_x
fox2,14,1,wave;2;claim/splash;4/sling;4,14,21,move_pattern=xxx_,abil_pattern=___x
owl2,34,1,turret;6/sling;3/shield;2,10,45,flies=1,abil_pattern=_x
scorpion2,32,1,backrow1;4/backrow2;2,15,32,abil_pattern=_x__
boss2,42,0,pinch;4/mortar;4/double;4/shield;3,30,20,flies=1,abil_pattern=______x_x_x_,move_pattern=xxxx___x___x
harpy3,38,2,bigwave;4/wave;1;stun/wave;4,13,40,flies=1,move_pattern=xx_,abil_pattern=__x
fox3,14,2,sling;4;poison/sword;4;poison/fastbomb;4;poison,20,21,move_pattern=xxx_,abil_pattern=___x
scorpion3,32,2,bomb;2;claim/rico2;4/shield;3,20,35,abil_pattern=_x_
boss3,44,0,donut;4/rico2;3/crisscross;3,30,21,move_pattern=x___x___,abil_pattern=__x___x_
boss4p,46,3,fullscreen;2;poison/turret;5/sling;4;poison/rico3;5/s.bash;2,40,25,move_pattern=xxx_xxx___,abil_pattern=___x_xx___
boss4g,46,0,fullscreen;1/rico3;2;growth/shield;1;growth/scythe;5;claim;claim,40,24,move_pattern=xxx_xxx___,abil_pattern=___x_xx___
boss4,46,4,fullscreen;1;invasion/sl.turret;10/rico3;10/s.bash;4;invasion,40,23,move_pattern=xxx_xxx___xxx_xxx___,abil_pattern=___x_xx______x_xxx__
]])

-- col / time / api / mpi
local all_levels = smlu([[
harpy1
harpy1,dog1/3
fox1/4,fox1/5
owl1
boss1
scorpion1,scorpion1,scorpion1
dog2/4,dog1/3,dog1/2
owl1,fox1,scorpion1
fox2,harpy1,harpy1
boss2
scorpion2/6,scorpion2/8/0/2/,dog2
harpy2,harpy2,dog2
harpy3,fox2
owl2,owl2
boss3
fox3,harpy3
scorpion3,scorpion3
boss4p
boss4g
boss4
]],true)