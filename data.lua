shield_time = 30 * 5
max_hp = 3
monster_palettes = {
    split("1,2,3,1,5,6,7,3,5,6 ,14,12,13,14,15"),
    split("1,2,3,0,5,6,7,9,1,5,10,12,13,14,15"),
    split("1,2,3,4,5,6,7,8,12,10,11,12,13,14,15"),
    split("1,2,3,4,5,6,7,8,8,10,11,12,13,14,15"),
}
gridpatterns = split"64,66,68,64,64,66,68,64,70,72,66,74,70,72,66,74,74,66,72,70,74,66,72,70,64,72,66,64,64,72,66,64"

classes = smlu([[
1,king,0,0,0,sling;1/sling;1/spear;1/spear;1/shield;1/sword;2
2,queen,2,0,5,sword;2/shield;1/spear;1/slap;1/scythe;1;superclaim/scythe;2
3,priestess,4,0,15,wave;1/wave;1/wall;0;stun/sword;1/bomb;2/shield;1
4,engineer,6,1,0,hydra;1/splash;1/cane;1/hydra;1/rock;1/shield;1
5,farmer,8,2,0,slap;1/shield;1/rock;0;growth/scythe;1/spear;1/sy.hydra;1;claim
6,apothecary,10,3,0,bomb;1;poison/slap;2;poison/sword;1/bomb;1/cane;1/sling;1
]])

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
katana,158,attack,  0/0b1000010000100000.0000000000000000/0/0/0/0,2
rico,105,attack,    0/0b0100000000000000.0000000000000000/5/5/1/15/10/1/1,2
sling,96,attack,    0/0b0100000000000000.0000000000000000/30/0/1/5/8,3
scythe,102,attack,  0/0b1010111000000000.0000000000000000/0/0/0/0,3
split,103,attack,   0/0b1010000000000000.0000000000000000/3/0/0/15,3
bounce,113,attack, 0/0b0000010000000000.0000000000000000/6/0/0/15/9/1/0,3
mortar,114,attack,  0/0b0000000000000000.0000011001100000/0/0/0/35/4/0/0/1/1,3
wall,110,attack,    0/0b0000000000000000.1000000000000000/0/30/0/15/4/0/0/0/1,3
double,111,attack,  0/0b0000010000000000.0000000000000000/6/0/0/20/8/0/0;30/0b0000010000000000.0000000000000000/6/0/0/20/8/0/0,4
pinch,116,attack,   0/0b0000000000000001.0000000000000000/0/-30/0/10/4/0/0/0/1;10/0b0000000000000000.1000000000000000/0/30/0/10/4/0/0/0/1,4
s.bash,109,shield,  0/0b0100111000000000.0000000000000000/0/0/0/0,4
3.rock,159,attack,  0/0b0000000000000100.0000000000000000/0/0/0/25;15/0b0000000000000100.0000000000000000/0/0/0/25;30/0b0000000000000100.0000000000000000/0/0/0/25,4
hydra,99,turret,wave,4
sling.f,96,attack,    0/0b0100010001000100.0100010001000100/0/0/1/1/8,5,9
sp.hydra,117,turret,split,5
bigwave,115,attack,     0/0b0000111100000000.0000000000000000/2/0/0/30/8/0/0/0/1,5
wavewide1,100,attack,    0/0b0000011000000000.0000000000000000/4/0/0/15/8/0/0,-1
wavewide2,100,attack,    0/0b0000110000000000.0000000000000000/4/0/0/15/8/0/0,-1
sy.hydra,118,turret,scythe,-1
sl.hydra,118,turret,sling,-1
curse,119,curse,,-1
backrow1,0,attack,      0/0b0000000000000000.0000000000001111/0/0/0/30/4/0/0/1/1,-1
backrow2,0,attack,      0/0b0000000000000000.0000000011111111/0/0/0/30/4/0/0/1/1,-1
rico.s1,105,attack,     0/0b0100000000000000.0000000000000000/3/-3/1/15/4/1/1,-1
rico.s2,105,attack,     0/0b0100000000000000.0000000000000000/3/3/1/15/4/1/1,-1
rico2,105,attack,       0/0b0100000000000000.0000000000000000/5/-5/1/15/30/1/1,-1
rico3,105,attack,       0/0b0100000000000000.0000000000000000/4/-8/0/20/999/0/1,-1
rico4,105,attack,       0/0b0100000000000000.0000000000000000/16/2/0/20/64/1/1,-1
fastbomb,107,attack,    0/0b0000000001001110.0100000000000000/0/0/0/20,-1
donut,107,attack,       0/0b0000000011101010.1110000000000000/0/0/0/35,-1
crisscross,0,attack,    0/0b0000000000000000.0000000000001000/0/3/0/20/16/0/0/1/1;0/0b0000000000000000.0000000000010000/0/-3/0/20/16/0/0/1/1;0/0b0000000000000000.0000100000000000/0/3/0/20/16/0/0/1/1;0/0b0000000000000000.0001000000000000/0/-3/0/20/16/0/0/1/1,-1
fullscreen,107,attack,  0/0b1111111111111111.1111111111111111/0/0/0/35/32/0/0/1/1,-1
fullscreen.a,107,attack,  0/0b1111111111111111.0111111111111111/0/0/0/35/32/0/0/1/1,-1
fullscreen.b,107,attack,  0/0b1111111111111111.1111111111111110/0/0/0/35/32/0/0/1/1,-1
fullscreen.c,107,attack,  0/0b1111111111111111.1111101111111111/0/0/0/35/32/0/0/1/1,-1
fullscreen.d,107,attack,  0/0b1111111111111111.1111111111011111/0/0/0/35/32/0/0/1/1,-1
d.hydra,117,turret,rico,-1
r1.hydra,117,turret,rico.s1,-1
r2.hydra,117,turret,rico.s2,-1
donut.hydra,117,turret,donut,-1
start,246,attack,    0/0b0100000000000000.0000000000000000/30/0/1/5/8,-1
]])

all_mods = smlu([[
growth,120,3,+1 each use in%battle (max = 5)
pierce,121,4,breaks shield. double%damage if broken
claim,122,6,claim the first tile%you hit
superclaim,125,2,claim up to 2%of the tiles hit
pause,123,2,time stands still%for a moment longer
invasion,124,5,+1 if standing%in enemy tile
rage,125,2,+2 if less than%half health
poison,126,2,deals poison damage%instead of normal
stun,127,2,stuns the enemy%for a moment
snipe,255,5,+1 if standing%in back row
]])
-- weaken: +1 damage per hit
-- wound (like poison): damage when they move for n seconds
-- +1 on back row
-- +1 in daytime, add 2 sec of daytime

--fox1,14,0,wave;1/splash;1/splash;1/rock;1;claim,6,46,move_pattern=xxx_,abil_pattern=___x
local monster_defs = smlu([[
harpy1,38,0,wave;1,4,60,flies=1,move_pattern=xx_,abil_pattern=__x
dog1,36,0,sword;1;superclaim/sword;1,5,32,move_pattern=xx__,abil_pattern=__x_
fox1,14,0,splash;1;claim/splash;1/splash;1,6,46,move_pattern=xxx_,abil_pattern=___x
owl1,34,0,hydra;1/hydra;1/sling;1,8,65,flies=1,abil_pattern=_x
boss1,40,0,bomb;1/wave;1/shield;1/sword;1,15,15,flies=1,abil_pattern=____x_x____,move_pattern=xxxx_______
scorpion1,32,0,bomb;1,8,99
harpy2,38,1,wavewide1;2/wavewide2;2,8,50,flies=1,move_pattern=xx_,abil_pattern=__x
dog2,36,1,sword;2/spear;2,10,32,abil_pattern=_x
fox2,14,1,rico.s1;2/rico.s2;1/rico.s1;1/rico.s2;2,14,33,move_pattern=xxx_,abil_pattern=___x
owl2,34,1,hydra;2/sling;2/shield;1,10,55,flies=1,abil_pattern=_x
scorpion2,32,1,backrow1;1/backrow2;1,15,66,abil_pattern=_x__
boss2,42,0,pinch;2/mortar;2/double;1/shield;3,20,23,flies=1,abil_pattern=______x_x_x_,move_pattern=xxxx___x___x
dog3,36,1,sword;2;claim/spear;2/scythe;2,15,15,abil_pattern=_____xx_,move_pattern=xxx_____
harpy3,38,2,bigwave;1/wave;1;stun/wave;3,13,45,flies=1,move_pattern=xx_,abil_pattern=__x
fox3,14,2,rico2;2/wave;2,20,33,move_pattern=xxx_,abil_pattern=___x
owl3,34,1,r1.hydra;3/r2.hydra;3/shield;2,25,28,flies=1,abil_pattern=xx____,move_pattern=___x_x
scorpion3,32,2,bomb;3;claim/shield;2,20,35,abil_pattern=_x_
boss3,44,0,donut;4/rico2;3/crisscross;3,30,28,move_pattern=x___x___,abil_pattern=__x___x_
boss4p,46,3,fullscreen;2;poison/hydra;3/sling;3;poison/rico3;3/s.bash;2,30,28,move_pattern=xxx_xxx___xxx_xxx___,abil_pattern=___x_xx______x_xxx__
boss4g,46,0,fullscreen;1/rico3;1;growth/shield;1;growth/scythe;3;claim;claim,30,24,move_pattern=xxx_xxx___,abil_pattern=___x_xx___
boss4,46,4,fullscreen.a;1/fullscreen.b;1/fullscreen.c;1/fullscreen.d;1/sl.hydra;3/s.bash;2,40,28,move_pattern=xxx_xxx___xxx_xxx___,abil_pattern=___x_xx______x_xxx__
]])

-- col / time / api / mpi
local all_levels = smlu([[
harpy1/6
harpy1,dog1/3
fox1/4/0/2/2,fox1/5
owl1
boss1
scorpion1,scorpion1,scorpion1
dog2/4,dog1/3,dog1/2
owl1,scorpion1
fox2/4/0/2/2,fox2
boss2
harpy2/7/0/2/2,harpy2/7/0/1/1,dog1/3,dog1/4
dog2/3,dog2/4,scorpion2/8
harpy3,fox2/4
owl2/8,owl2
boss3
fox3,fox2,scorpion3
owl3/6,dog1/4
dog3/2,dog3/4/0/2/2
harpy3,harpy2/8/0/1/1,harpy2/6/0/1/1,harpy1/5/0/2/2,harpy1/7/0/2/2
boss4
]],true)

-- need to change poison.