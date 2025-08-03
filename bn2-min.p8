pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function tp(n,e)
return{n*16-16,e*13+19}
end
function gp(n,e)
return{mid(n\16+1,1,8),mid((e-27)\13+1,1,4)}
end
function addfields(n,e,t)
for e in all(split(e))do
local e,t=unpack(split(e,"="))
if t=="false"then n[e]=false
elseif t=="true"then n[e]=true
else
n[e]=t
end
end
for e,t in pairs(t)do
n[e]=t
end
end
function sfn(n)
for n in all(split(n,"\n"))do
if(#n>3)local n=split(n)local e=n[1]deli(n,1)_ENV[e](unpack(n))
end
end
function smlu(e,t)
local n={}
for e in all(split(e,"\n"))do
if#e>3then
local e=split(e,",")
if(t)add(n,e)else n[e[1]]=e
end
end
return n
end
function nl_print(e,t,n,o)
for e in all(split(e,"%"))do
print(e,t,n,o)
n+=8
end
end
function temp_camera(t,o,l)
local n,e=peek2(24360),peek2(24362)
camera(n+t,e+o)
l()
camera(n,e)
end
function temp_camera_sfn(n,e,t)
temp_camera(n,e,function()sfn(t)end)
end
function palreset()
pal()
palt(2)
end
function get_bit(n,e)
return n&32768>>>e~=0
end
function ssfx(n)
sfx(n,0)
end
function sandify(o,l,e,r,i,t,d)
for n=0,e do
local a=n/e-.5
for e=0,r do
local o=sget(o+n,l+e)
if(o~=(d or 14))make_creature_particle(i+n,t+e,o,a/2,t+6+rnd(4))
end
end
end
FADE_PALS_1=smlu([[129,2  ,141,4  ,134,6  ,7  ,136,9  ,10 ,142,139,13 ,14 ,15 ,0
0. ,129,129,2  ,141,134,6  ,2. ,2  ,9  ,9. ,141,134,0  ,15 ,0
0. ,0  ,129,129,141,134,6. ,2. ,2  ,9  ,9. ,141,134,0  ,134,0
0. ,0  ,0. ,0  ,0. ,141,134,2. ,0  ,0  ,0. ,141,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,141,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,0  ,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,0  ,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
]],true)
function scrnt(n,...)
nongrid={}
sandify(...)
poke(24404,0)
for t=0,170,4do
n(true)
local e={}
for n=max(#nongrid-1000,1),#nongrid do
local n=nongrid[n]
n.update()
n.draw()
add(e,n)
end
nongrid=e
pal(FADE_PALS_1[mid(t\5-25,1,6)],1)
flip()
end
end
function draw_pips(n,e,t,o)
local l=n\5
local r,n=n-l*5,0
for l=1,l do
rectfill(e,t-n-2,e+2,t-n,o)
n+=4
end
for l=1,r do
rectfill(e,t-n,e+2,t-n,o)
n+=2
end
end
function draw_mods(n,t,o)
for e=1,#n do
spr(all_mods[n[e]][2],t,o+e*6-6)
end
end
function coslerp(e,t,n,o)
return(cos(min(e/t,.5))*-.5+.5)*(o-n)+n
end
shield_time=150
max_hp=3
monster_palettes={
split"1,2,3,1,5,6,7,3,5,6 ,14,12,13,14,15",
split"1,2,3,0,5,6,7,9,1,5,10,12,13,14,15",
split"1,2,3,4,5,6,7,8,12,10,11,12,13,14,15",
split"1,2,3,4,5,6,7,8,8,10,11,12,13,14,15"
}
gridpatterns=split"64,66,68,64,64,66,68,64,70,72,66,74,70,72,66,74,74,66,72,70,74,66,72,70,64,72,66,64,64,72,66,64"
classes=smlu[[1,king,0,0,0,sling;1/sling;1/spear;1/spear;1/shield;1/sword;2
2,queen,2,0,5,sword;2/shield;1/spear;1/slap;1/scythe;1;superclaim/scythe;2
3,priestess,4,0,15,wave;1/wave;1/wall;0;stun/sword;1/bomb;2/shield;1
4,engineer,6,1,0,turret;1/splash;1/cane;1/turret;1/rock;1/shield;1
5,farmer,8,2,0,slap;1/shield;1/rock;0;growth/scythe;1/spear;1/sy.turret;1;claim
6,apothecary,10,3,0,bomb;1;poison/slap;2;poison/sword;1/bomb;1/cane;1/sling;1
]]
all_abilities=smlu[[slap,104,attack,    0/0b0000010000000000.0000000000000000/0/0/0/0,0
rock,112,attack,    0/0b0000000000000100.0000000000000000/0/0/0/25,0
cane,106,attack,    0/0b1010000000000000.0000000000000000/0/0/0/0,0
shield,98,shield,   0/0b0100000000000000.0000000000000000/0/0/0/0,1
sword,97,attack,    0/0b1010010000000000.0000000000000000/0/0/0/0,1
splash,108,attack,  0/0b0000100000000000.0000000000000000/5/-5/0/0/1;0/0b0000001000000000.0000000000000000/5/5/0/0/1,1
spear,101,attack,   0/0b0000010000000000.0000000000000000/7/0/0/0/2,1
wave,100,attack,    0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,2
bomb,107,attack,    0/0b0000000001001110.0100000000000000/0/0/0/35,2
katana,158,attack,  0/0b1000010000100000.0000000000000000/0/0/0/0,2
rico,105,attack,    0/0b0100000000000000.0000000000000000/5/-5/1/15/10/1/1,2
sling,96,attack,    0/0b0100000000000000.0000000000000000/30/0/1/5/8,3
scythe,102,attack,  0/0b1010111000000000.0000000000000000/0/0/0/0,3
split,103,attack,   0/0b1010000000000000.0000000000000000/3/0/0/15,3
bouncer,113,attack, 0/0b0000010000000000.0000000000000000/6/0/0/15/6/1/0,3
mortar,114,attack,  0/0b0000000000000000.0000011001100000/0/0/0/35/4/0/0/1/1,3
wall,110,attack,    0/0b0000000000000000.1000000000000000/0/30/0/15/4/0/0/0/1,4
double,111,attack,  0/0b0000010000000000.0000000000000000/6/0/0/15/8/0/0;30/0b0000010000000000.0000000000000000/6/0/0/15/8/0/0,4
pinch,116,attack,   0/0b0000000000000001.0000000000000000/0/-30/0/10/4/0/0/0/1;10/0b0000000000000000.1000000000000000/0/30/0/10/4/0/0/0/1,4
s.bash,109,shield,  0/0b0100111000000000.0000000000000000/0/0/0/0,4
3.rock,159,attack,  0/0b0000000000000100.0000000000000000/0/0/0/25;15/0b0000000000000100.0000000000000000/0/0/0/25;30/0b0000000000000100.0000000000000000/0/0/0/25,4
turret,99,turret,wave,4
sling.f,96,attack,    0/0b0100010001000100.0100010001000100/0/0/1/1/8,5,9
sp.turret,117,turret,split,5
wavewide1,100,attack,    0/0b0000011000000000.0000000000000000/4/0/0/15/8/0/0,-1
wavewide2,100,attack,    0/0b0000110000000000.0000000000000000/4/0/0/15/8/0/0,-1
bigwave,115,attack,     0/0b0000111100000000.0000000000000000/2/0/0/30/8/0/0/0/1,5
sy.turret,118,turret,scythe,-1
sl.turret,118,turret,sling,-1
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
d.turret,117,turret,rico,-1
r1.turret,117,turret,rico.s1,-1
r2.turret,117,turret,rico.s2,-1
donut.turret,117,turret,donut,-1
start,246,attack,    0/0b0100000000000000.0000000000000000/30/0/1/5/8,-1
]]
all_mods=smlu[[growth,120,3,+1 each use in%battle (max = 5)
pierce,121,4,ignores shields
claim,122,6,claim the first tile%you hit
superclaim,125,2,claim up to 2%of the tiles hit
pause,123,2,time stands still%for a moment longer
invasion,124,5,+1 if standing%in enemy tile
rage,125,2,+2 if less than%half health
poison,126,2,deals poison damage%instead of normal
stun,127,2,stuns the enemy%for a moment
snipe,255,5,+1 if standing%in back row
]]
local e,n=smlu[[harpy1,38,0,wave;1,4,60,flies=1,move_pattern=xx_,abil_pattern=__x
dog1,36,0,sword;1;superclaim/sword;1,5,32,move_pattern=xx__,abil_pattern=__x_
fox1,14,0,splash;1;claim/splash;1/splash;1,6,46,move_pattern=xxx_,abil_pattern=___x
owl1,34,0,turret;1/turret;1/sling;1,8,65,flies=1,abil_pattern=_x
boss1,40,0,bomb;1/wave;1/shield;1/sword;1,15,15,flies=1,abil_pattern=____x_x____,move_pattern=xxxx_______
scorpion1,32,0,bomb;1,8,99
harpy2,38,1,wavewide1;2/wavewide2;2,8,50,flies=1,move_pattern=xx_,abil_pattern=__x
dog2,36,1,sword;2/spear;2,10,32,abil_pattern=_x
fox2,14,1,rico.s1;2/rico.s2;1/rico.s1;1/rico.s2;2,14,33,move_pattern=xxx_,abil_pattern=___x
owl2,34,1,turret;2/sling;2/shield;1,10,55,flies=1,abil_pattern=_x
scorpion2,32,1,backrow1;2/backrow2;2,15,66,abil_pattern=_x__
boss2,42,0,pinch;2/mortar;2/double;2/shield;3,20,23,flies=1,abil_pattern=______x_x_x_,move_pattern=xxxx___x___x
dog3,36,1,sword;2;claim/spear;2/scythe;2,15,15,abil_pattern=_____xx_,move_pattern=xxx_____
harpy3,38,2,bigwave;1/wave;1;stun/wave;3,13,45,flies=1,move_pattern=xx_,abil_pattern=__x
fox3,14,2,rico2;2;poison/wave;2,20,28,move_pattern=xxx_,abil_pattern=___x
owl3,34,1,r1.turret;3/r2.turret;3/shield;3,25,28,flies=1,abil_pattern=xx____,move_pattern=___x_x
scorpion3,32,2,bomb;3;claim/shield;3,20,35,abil_pattern=_x_
boss3,44,0,donut;4/rico2;3/crisscross;3,30,21,move_pattern=x___x___,abil_pattern=__x___x_
boss4p,46,3,fullscreen;2;poison/turret;3/sling;3;poison/rico3;3/s.bash;2,30,28,move_pattern=xxx_xxx___xxx_xxx___,abil_pattern=___x_xx______x_xxx__
boss4g,46,0,fullscreen;1/rico3;1;growth/shield;1;growth/scythe;3;claim;claim,30,24,move_pattern=xxx_xxx___,abil_pattern=___x_xx___
boss4,46,4,fullscreen.a;1/fullscreen.b;1/fullscreen.c;1/fullscreen.d;1/sl.turret;3/s.bash;2,40,28,move_pattern=xxx_xxx___xxx_xxx___,abil_pattern=___x_xx______x_xxx__
]],smlu([[harpy1/6
harpy1,dog1/3
fox1/4/0/2/2,fox1/5
owl1
boss1
scorpion1,scorpion1,scorpion1
dog2/4,dog1/3,dog1/2
owl1,scorpion1
fox2/4/0/2/2,fox2
boss2
harpy2,harpy2
dog2/3,dog2/4,scorpion2/8
harpy3,fox2/4
owl2/8,owl2
boss3
fox3,fox3,scorpion3
owl3/6,dog1/4
dog3/2,dog3/4/0/2/2
harpy3,harpy2/8/0/1/1,harpy2/6/0/1/1,harpy1/5/0/2/2,harpy1/7/0/2/2
boss4
]],true)
function draw_die2d(r,i,d,t,e)
local o=true
if(t and e.kind~="hp")o=tf\14%2==0
local l=split"0,15,15,15,30,15,45,15,15,0,15,30"
for n=1,6do
temp_camera(-l[n*2-1]-i,-l[n*2]-d,function()
if(e and not o and e.faces[n])sfn[[rectfill,-2,-1,11,10,12
rectfill,-1,-2,10,11,12
]]t[n].draw_face(0,0,n)else r[n].draw_face(0,0,n)
end)
end
end
function make_nongrid(n,e)
local n={
pos={n,e}
}
add(nongrid,n)
return n
end
function valid_move_target(n,e,t,o)
if(n<1or n>8or e<1or e>4)return false
local n=grid[e][n]
if(n.creature)return false
if(o and n.space.side~=t)return false
return true
end
function add_go_to_grid(n)
local e=grid[n.pos[2]][n.pos[1]]
if#e==0then
add(e,n)
else
local t=1
while(true)if t>#e then add(e,n)break elseif n.layer<=e[t].layer then add(e,n,t)break end t+=1
end
end
function make_gridobj(n,e,t,o)
local n={
pos={n,e},
layer=t or 10,
spri=o
}
add_go_to_grid(n)
n.move=function(e,t)
del(grid[n.pos[2]][n.pos[1]],n)
n.pos={e,t}
add_go_to_grid(n)
end
n.draw=function()
local e=tp(n.pos[1],n.pos[2])
spr(n.spri,e[1],e[2],2,2)
end
return n
end
function find_open_square_for(t,e,o,l)
local n,n=grid[o][e],1
if(t~=1)n=-1
local n=l or{
{0,0},{-n,0},{-n,-1},{-n,1},{0,-1},{0,1},{n,0},{n,-1},{n,1}
}
for n in all(n)do
local n,e=e+n[1],o+n[2]
if n>=1and n<=8and e>=1and e<=4then
local o=grid[e][n]
if(o.space.side==t and o.creature==nil)return{n,e}
end
end
return nil
end
function push_to_open_square(n)
local e=find_open_square_for(n.side,n.pos[1],n.pos[2])
if e then
n.move(e[1],e[2])
else
local e=n.pos[1]-n.side
if(e>=1and e<=8)n.move(e,n.pos[2])
end
end
function make_damage_spot(n,r,o,l,e,t)
local n=make_gridobj(n,r,1)
addfields(n,"decay=0",{
side=l,
damage=o,
countdown_max=e or 0,
countdown=e or 0,
abil=t
})
n.update=function()
local e=grid[n.pos[2]][n.pos[1]]
if n.countdown>0then
n.countdown-=1
elseif n.countdown==0then
if e.creature and e.creature.side~=n.side and e.creature.iframes<=0then
if(has_mod(n.abil,"stun"))e.creature.stun_time=65
if(has_mod(n.abil,"poison"))e.creature.poison_timer=60*n.damage else e.creature.take_damage(n.damage,has_mod(n.abil,"pierce"))
if(e.creature==pl)pl.iframes=15
end
local o=count(t.mods,"claim")+count(t.mods,"superclaim")*2
if(e.space.side~=n.side and t.tiles_claimed<o)e.space.flip(n.side,240)t.tiles_claimed+=1
e.space.bounce_timer=13
n.countdown-=1
ssfx(n.side==1and 8or 9)
else
n.decay+=1
if(n.decay>8)del(e,n)
end
end
n.draw=function()
local e,t=tp(n.pos[1],n.pos[2]),grid[n.pos[2]][n.pos[1]]
e[2]+=t.space.offset_y
local t=9
if(n.side~=1)t=8
if(has_mod(n.abil,"poison"))t=12
if n.countdown>0then
local n=1-n.countdown/n.countdown_max
local r,i,n,e,o,l=6*n+2,4*n+2,e[1]+1,e[2]+1,e[1]+14,e[2]+11
line(n,e,n+r,e,t)
line(n,e,n,e+i,t)
line(n,l,n+r,l,t)
line(n,l,n,l-i,t)
line(o,e,o-r,e,t)
line(o,e,o,e+i,t)
line(o,l,o-r,l,t)
line(o,l,o,l-i,t)
else
if(n.decay<5)rectfill(e[1]+1,e[2]+1,e[1]+14,e[2]+11,t)
end
if l==-1and o>=2then
fillp(56190.5)
if(o>=3)fillp(23130.5)
rectfill(e[1]+2,e[2]+2,e[1]+13,e[2]+10,0)
fillp()
end
end
end
function make_gridspace(e,t)
local o=1
if(e>4)o=-1
local n=make_gridobj(e,t,0,spri)
n.side=o
n.main_side=o
n.bounce_timer=15+e+t
n.offset_y=0
n.update=function()
end
n.draw=function()
n.offset_y=-(cos(n.bounce_timer/10)-.5)*(n.bounce_timer/5)
n.bounce_timer=max(n.bounce_timer-1,0)
local o=tp(n.pos[1],n.pos[2])
o[2]+=n.offset_y
local e=gridpatterns[e-1+(t-1)*8+1]
if(n.side==-1)pal(split"0,2,3,4,5,3,13,8,9,10,11,12,1,14,15,0")else palreset()
spr(e,o[1],o[2],2,2)
palreset()
end
grid[n.pos[2]][n.pos[1]].space=n
n.flip=function(e,t)
if(e==n.side)return
if(e==n.main_side)n.side=n.main_side return
n.main_side=n.side
n.side=e
end
return n
end
function parse_ability(n)
local n=split(n,";")
local e=all_abilities[n[1]]
return make_ability(e,n[2],{n[3]},e[6])
end
function has_mod(n,e)
return count(n.mods,e)>0
end
function make_ability(n,e,t,l)
local n={
base=n,
name=n[1],
image=n[2],
type=n[3],
def=n[4],
rarity=n[6],
pips=e
}
n.mods={}
n.original_pips=e
for e in all(t)do add(n.mods,e)end
n.copy=function()
return make_ability(n.base,n.original_pips,n.mods)
end
n.get_pips=function()
if pl then
local e=grid[pl.pos[2]][pl.pos[1]].space
if(has_mod(n,"invasion")and e.side==-1)return n.pips+1
if(has_mod(n,"snipe")and pl.pos[1]==1)return n.pips+1
if(has_mod(n,"rage")and pl.health<=pl.max_health/2)return n.pips+1
end
return n.pips
end
n.draw_face=function(e,t,r)
local o=n.name=="curse"and 8or 7
rectfill(e,t-1,e+9,t+10,o)
rectfill(e-1,t,e+10,t+9,o)
pal(1,l or 1)
spr(n.image,e+1,t+1,1,1)
pal(1,1)
draw_mods(n.mods,e,t)
draw_pips(n.get_pips(),e+7,t+9,12)
if(r==4)spr(141,e-2,t+4)
end
n.use=function(t,o,l,e)
if(n.base=="none")return
n.tiles_claimed=0
_ENV["abil_"..n.type](t,n.get_pips(),n,o,l,e)
local e=4+e
if(has_mod(n,"growth")and n.pips<e)n.pips+=1n.original_pips+=1
end
return n
end
function abil_grid_spaces(o,l,r,i)
local t={}
for n=0,7do
for e=0,3do
if get_bit(o,n*4+e%4)then
local n,e=l+n*i,r+e-1
if(n>=1and n<=8and e>=1and e<=4)add(t,{n,e})
end
end
end
return t
end
function abil_shield(n,e,t,o,l,r)
n.shield_timer=max(shield_time*e,n.shield_timer)
local i=tp(o,l)
if(n==pl)ssfx(15)
bounce_hp[#bounce_hp]=10
add(attack_runners,make_attack_runner(t.def,e,t,o,l,r))
end
function abil_attack(r,e,n,t,o,l)
add(attack_runners,make_attack_runner(n.def,e,n,t,o,l))
end
function abil_curse()
sfx(19,1)
local n=0
for e=1,50do
local e=grid[rnd(4)\1+1][rnd(8)\1+1]
if e.space.side==1then
e.space.side=-1
n+=1
if(n>=1)return
end
end
end
function make_turret(n,e,t,o,l)
local n=make_creature(e,t,l,n,12)
local e=n.update
n.rate=90
n.time=0
n.update=function()
e()
n.time+=1
if(n.time%n.rate==n.rate\2)o.use(n,n.pos[1],n.pos[2],n.side)
if(n.time>=450)n.kill()
end
return n
end
function abil_turret(n,t,o,l,r,e)
local n,o=e,make_ability(all_abilities[o.def],t,o.mods)
local n=find_open_square_for(e,l,r,{{n,0},{-n,0},{0,-1},{0,1},{n,-1},{n,1},{-n,-1},{-n,1}})
if(n)local n=make_turret(t,n[1],n[2],o,e)
end
function make_attack_runner(n,r,i,d,a,t,l)
local n,e=split(n,";"),{}
for n in all(n)do
local n=split(n,"/")
add(e,{
delay=n[1],
grid=n[2],
xv=n[3]*t,
yv=n[4],
collides=n[5]==1,
telegraph=n[6],
max_tiles=n[7]or 8,
bounces_x=n[8]==1,
bounces_y=n[9]==1,
absolute_x=n[10]==1,
absolute_y=n[11]==1,
alive=true
})
end
local n=0
function update(f)
local o=false
function damage_and_stop(n,e,o)
if(l)add(s.fake_hit,{e,o})else make_damage_spot(e,o,r,t,n.telegraph,i)
if n.collides then
local e=grid[o][e].creature
if(e and e.side~=t)n.alive=false
end
end
for e in all(e)do
local l=e.xv==0and e.yv==0
if e.virtual_objs and e.alive then
for n in all(e.virtual_objs)do
if e.xv~=0or e.yv~=0then
n.timers={n.timers[1]-1,n.timers[2]-1}
local t=false
if n.xv~=0and n.timers[1]<=0then
if n.pos[1]<=1and n.xv<0or n.pos[1]>=8and n.xv>0then
if(e.bounces_x)n.xv=-n.xv else n.off_grid=true
end
n.pos[1]+=sgn(n.xv)
t=true
n.timers[1]=30/abs(n.xv)-1
end
if n.yv~=0and n.timers[2]<=0then
if n.pos[2]<=1and n.yv<0or n.pos[2]>=4and n.yv>0then
if(e.bounces_y)n.yv=-n.yv else n.off_grid=true
end
n.pos[2]+=sgn(n.yv)
t=true
n.timers[2]=30/abs(n.yv)-1
end
if(t and not n.off_grid)damage_and_stop(e,n.pos[1],n.pos[2])n.max_tiles-=1
if(not n.off_grid and n.max_tiles>0)o=true
end
end
end
if not e.virtual_objs then
if n>=e.delay then
e.virtual_objs={}
local n=t*-3.5+4.5
for n in all(abil_grid_spaces(e.grid,e.absolute_x and n or d,e.absolute_y and 2or a,t))do
if(not l)local t={e.xv==0and 0or 30/abs(e.xv),e.yv==0and 0or 30/abs(e.yv)}add(e.virtual_objs,{pos=n,timers=t,max_tiles=e.max_tiles,xv=e.xv,yv=e.yv,off_grid=false})o=true
damage_and_stop(e,n[1],n[2])
end
else
o=true
end
end
end
if(not o)f.alive=false
n+=1
end
s={
update=update,
alive=true,
fake_hit={}
}
if l then
local n=0
while(s.alive)n+=1s:update()
else
s:update()
end
return s
end
function make_effect_simple(n,l,c,r,e,t,o,i,d,a,f)
e=e or 0
t=t or-.2
o=o or 30
local n,l=make_nongrid(n,l),0
n.draw=function()
palreset()
fillp(i)
pal(12,tf\2%2==0and 7or 12)
spr(r,n.pos[1],n.pos[2],d or 1,a or 1,f)
palreset()
fillp()
end
n.update=function()
n.pos[1]+=e
n.pos[2]+=t
l+=1
if(l>o)del(nongrid,n)
end
return n
end
function make_creature_particle(n,e,t,r,o)
local n,e,l=make_nongrid(n,e),-50+rnd(2),(rnd()-.5)*1.8
addfields(n,"",{
color=t,
yv=l,
xv=r+(.5-rnd())*.25
})
n.draw=function()
pset(n.pos[1],n.pos[2],t)
end
n.update=function()
e+=1
if(rnd()<.04or e>=0)t=rnd{15,15,5}
if e<l*10-30then
n.yv+=.1
else
n.yv+=.02
n.yv*=.5
if(n.xv>-3)n.xv+=-rnd()*.25
end
if n.pos[2]>o then
n.yv=n.yv*-.15
if(n.yv>-.1)n.yv=0n.y=o
end
n.pos={n.pos[1]+n.xv,n.pos[2]+n.yv}
if(e>32and rnd()<.1)del(nongrid,n)
end
return n
end
creature_index=1
function make_creature(n,l,e,t,o)
local n=make_gridobj(n,l,10,o)
addfields(n,
"movetime=0,yo=-7,damage_time=0,shield_timer=0,stun_time=0,stun_co=1,alive=true,overextended_timer=0,poison_timer=0,iframes=0,telegraph_x=0,telegraph_y=0",
{
lastpos={0,0},
side=e,
dir=e,
health=t,
max_health=t,
index=creature_index
})
n.clay_time=o>=40and 45or 15
creature_index+=1
n.draw=function()
local e,t,o,l=tp(n.pos[1],n.pos[2]),n.spri,0,grid[n.pos[2]][n.pos[1]].space
function ds(r,i)
local d=n.side*-sin(n.overextended_timer/60)*3
spr(t,e[1]+o+r+d+n.telegraph_x,e[2]+n.yo+i+l.offset_y+n.telegraph_y,2,2,n.side==-1)
end
if(n.clay_time>0)if t<12then pal(split"2,2,2,2,2,2,1,1,1,1,1,1,1,1,15,1")clip(0,e[2]+n.yo+max((n.clay_time-10)*4,-4),128,22)ds(n.clay_time\5,0)ds(-n.clay_time\6,0)ds(0,n.clay_time\7)ds(0,-n.clay_time\8)ds(0,0)clip()palreset()elseif t<40then ds(0,0)else ds(n.clay_time*n.clay_time*.125,n.clay_time*n.clay_time*-.25)end n.clay_time-=1return
if(n.movetime>0)fillp(21845.75)
if(n.damage_time>0)pal(split"7,7,7,7,7,7,7,7,7,7,7,7,7,7,7")o=-n.damage_time*n.dir
if(n.poison_timer>0)pal(split"1,2,3,12,12,6,7,12,9,10,12,12,13,14,15,0")
if(n.iframes%2==0)ds(0,0)
fillp()
palreset()
if(n.stun_time>0)spr(143+tf\10%2,e[1]+3,e[2]-6)
end
n.update=function()
local e=grid[n.pos[2]][n.pos[1]].space
if(n.iframes>0)n.iframes-=1
if e.side~=n.side then
n.overextended_timer+=1
if(n.overextended_timer>=30)n.overextended_timer=0push_to_open_square(n)
else
n.overextended_timer=0
end
for e in all(split"poison_timer,damage_time,movetime,shield_timer,stun_time")do
n[e]=max(n[e]-1,0)
end
end
local l=n.move
n.move=function(e,t)
if(not n.alive)return
local o=tp(n.pos[1],n.pos[2])
if(n.clay_time<=0)make_effect_simple(o[1],o[2]+n.yo,nil,n.spri,0,-1,3,43690.75,2,2,n.side==-1)ssfx(n==pl and 14or-1)n.movetime=3
grid[n.pos[2]][n.pos[1]].creature=nil
n.lastpos={n.pos[1],n.pos[2]}
l(e,t)
grid[t][e].creature=n
if(n.poison_timer>0)n.take_damage(1,true)local n=tp(e,t)
end
n.take_damage=function(e,t)
if(ended)return
if not t then
if(n.shield_timer>0)n.shield_timer=0sfx(20,1)return
end
if(n==pl)for n=max(n.health-e+1,1),n.health do bounce_hp[n]=10end
n.health-=e
n.damage_time=5
local e=tp(n.pos[1],n.pos[2])
sfx(n==pl and 11or 10,1)
if(n.health<=0)n.kill()sfx(n==pl and 13or 12,1)
end
n.kill=function()
n.alive=false
local t,o,e=n.spri%16*8,n.spri\16*8,tp(n.pos[1],n.pos[2])
sandify(t,o,15,15,e[1],e[2]+n.yo)
grid[n.pos[2]][n.pos[1]].creature=nil
del(grid[n.pos[2]][n.pos[1]],n)
end
grid[n.pos[2]][n.pos[1]].creature=n
return n
end
pl=nil
function make_player()
local n=make_creature(1,2,1,max_hp,player_sprite)
addfields(n,"die_speed=1",{
max_health=n.health,
die={}
})
return n
end
function make_monster(r,i,n,o,d,a,t,e)
local l=false
if(grid[o][n].creature)l=true
local n=make_creature(n,o,-1,a,r)
n.palette=monster_palettes[i]
n.abilities=d
n.speed=t
n.abil_timer=t\2
n.move_timer=t
n.next_ability=rnd(n.abilities)
addfields(n,"time=0",e or{})
if(e.move_pattern)n.move_pattern={}for t=1,#e.move_pattern do add(n.move_pattern,e.move_pattern[t]=="x")end n.move_pattern_i=1
if(e.abil_pattern)n.abil_pattern={}for t=1,#e.abil_pattern do add(n.abil_pattern,e.abil_pattern[t]=="x")end n.abil_pattern_i=1
n.pick_next_move_target=function()
n.move_target=nil
local e=nil
if n.flies then
for t=1,10do
if(n.favor_col and rnd()<.45)e=n.favor_col
local e,t=e or flr(rnd(4))+5,flr(rnd(4))+1
if(valid_move_target(e,t,n.side,true))n.move_target={e,t}break
end
else
if(n.favor_col and rnd()<.45)e=n.favor_col
local o={{-1,0},{1,0},{0,-1},{0,1}}
for t=1,4do
local t=rnd(o)
del(o,t)
local o,l=nil,nil
if(e)o=mid(e-n.pos[1],-1,1)
local e,t=(o or t[1])+n.pos[1],(l or t[2])+n.pos[2]
if(valid_move_target(e,t,n.side,false))n.move_target={e,t}break
end
end
end
local e=n.update
n.update=function()
e()
if(ended)return
if(n.stun_time>0)return
n.time+=1
n.move_timer-=1
if(n.overextended_timer<=0and not n.move_target)n.pick_next_move_target()
if n.move_timer<=0then
local e=n.overextended_timer<=0
if n.move_pattern then
if(not n.move_pattern[n.move_pattern_i])e=false
n.move_pattern_i=n.move_pattern_i%#n.move_pattern+1
end
if e then
if n.move_target then
if(valid_move_target(n.move_target[1],n.move_target[2],n.side,n.flies))n.move(n.move_target[1],n.move_target[2])
n.move_target=nil
end
end
n.move_timer=n.speed
end
n.abil_timer-=1
if n.abil_timer<=0then
local e=true
if n.abil_pattern then
if(not n.abil_pattern[n.abil_pattern_i])e=false
n.abil_pattern_i=n.abil_pattern_i%#n.abil_pattern+1
end
if(e)n.next_ability.use(n,n.pos[1],n.pos[2],n.side)n.animate_time=5n.next_ability=rnd(n.abilities)
n.abil_timer=n.speed
end
if(n.abil_pattern and n.abil_timer==8and n.abil_pattern[n.abil_pattern_i])ssfx(18)
end
local e=n.draw
n.draw=function()
if n.move_target then
local o,l=mid(n.move_target[1]-n.pos[1],-1,1),mid(n.move_target[2]-n.pos[2],-1,1)
if(not n.move_pattern or n.move_pattern and n.move_pattern[n.move_pattern_i])local t,e=1-n.move_timer/n.speed,0if t>.85then e=3elseif t>.65then e=2elseif t>.25then e=1end n.telegraph_x=e*o n.telegraph_y=e*l
end
if(n.move_timer==n.speed)n.telegraph_x=0n.telegraph_y=0
palreset()
if(n.palette~=nil)pal(n.palette)e()palreset()else e()
if(n.clay_time>0)return
local t=tp(n.pos[1],n.pos[2])
local e,t=t[1]+3,t[2]+10
line(e,t,e+9,t,1)
line(e,t,e+9*(n.health/n.max_health),t,9)
if(n.shield_timer>0)line(e,t,e+9,t,7)
palreset()
if(n.abil_pattern and n.abil_timer==9and n.abil_pattern[n.abil_pattern_i])make_effect_simple(e+2,t-18,nil,134,0,-.25,14)
end
if(l)push_to_open_square(n)
n.pick_next_move_target()
return n
end
function parse_monster(n,o,l)
local t,e=split(n[4],"/"),{}
for n in all(t)do add(e,parse_ability(n))end
local t={}
for e=7,#n do
local n=split(n[e],"=")
t[n[1]]=n[2]
end
return make_monster(n[2],n[3],o,l,e,n[5],n[6],t)
end
function make_die(e)
local n,t={},split(e,"/")
for e=1,6do
n[e]=parse_ability(t[e])
end
return n
end
selected_class_index=1
function update_newgame()
if(btnp(2))selected_class_index=(selected_class_index-2)%#classes+1ssfx(14)
if(btnp(3))selected_class_index=selected_class_index%#classes+1ssfx(14)
local n=classes[selected_class_index]
if(btnp(5)and dget(0)>=n[4]and dget(1)>=n[5])ssfx(12)scrnt(draw_newgame,n[3]\8,0,16,16,92,60)inmediasres,show_title,imr_pressed,imrtimer=false,false,false,0 begin_game(n[3],n[6])
end
function draw_newgame(t)
camera(0,coslerp(tf,64,-128,0))
sfn[[rectfill,0,0,128,128,7
spr,146,27,7

rectfill,0,30,128,96,5
line,0,29,128,29,3
line,0,96,128,96,3
spr,147,03,21
spr,147,13,21
spr,147,23,21
spr,147,33,21
spr,147,43,21
spr,147,53,21
spr,147,63,21
spr,147,73,21
spr,147,83,21
spr,147,93,21
spr,147,103,21
spr,147,113,21
spr,147,118,21
spr,147,03,97,1,1,1,1
spr,147,13,97,1,1,1,1
spr,147,23,97,1,1,1,1
spr,147,33,97,1,1,1,1
spr,147,43,97,1,1,1,1
spr,147,53,97,1,1,1,1
spr,147,63,97,1,1,1,1
spr,147,73,97,1,1,1,1
spr,147,83,97,1,1,1,1
spr,147,93,97,1,1,1,1
spr,147,103,97,1,1,1,1
spr,147,113,97,1,1,1,1
spr,147,118,97,1,1,1,1

spr,79,124,-4
spr,79,124,123
spr,79,-4,-4,1,1,1,1
spr,79,-4,123,1,1,1,1
rect,0,0,127,127,6

spr,95,105,20
spr,95,55,-3
spr,95,123,40
spr,95,42,123
spr,95,82,124
spr,146,36,102

rectfill,85,30,114,95,15
line,83,30,83,95,15
line,116,30,116,95,15
rectfill,78,40,121,48,7
spr,64,92,66,2,2
rectfill,92,82,107,95,1

rectfill,0,-4,128,-1,1

print,⬆️,96,17,0
print,⬇️,96,104,0
print,choose your character,4,4,3
]]
local n,e=classes[selected_class_index],1
if dget(1)<n[5]then
e=8
print("unlocked after "..n[5].." rounds ("..dget(1)..")",6,116,e)
pal(split"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1")
elseif dget(0)<n[4]then
e=8
print("unlocked after "..n[4].." wins ("..dget(0)..")",18,116,e)
pal(split"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1")
else
local n="  to begin"
sfn[[print,to begin,52,116,1
spr,130,41,116
]]
end
if(not t)spr(n[3],92,60,2,2)
local t=make_die(n[6])
draw_die2d(t,12,42)
if(tf%60>45)parse_ability"curse;0".draw_face(57,57,-1)
palreset()
print(n[2],100-#n[2]*2,42,e)
end
function draw_gameplay()
draw_time=(draw_time+1)%1024
cls(inmediasres and 7or 15)
if(not inmediasres)sfn[[rectfill,0,0,128,32,7
spr,222,64,9
spr,208,24,13,3,1
spr,204,8,13,2,1
spr,205,1,13,1,1
spr,224,81,8,4,1
spr,220,84,13
spr,220,94,13
spr,221,107,13
spr,221,116,13
spr,211,37,24,2,1
spr,213,76,24,2,1
spr,214,108,24,1,1
spr,222,72,9
spr,223,113,9
spr,222,121,9
rectfill,61,12,62,13,12
fillp,0b1100110011001100.1
line,110,10,124,10,6
line,70,10,82,10,6
fillp,0b1101110111011101.1
line,34,9,82,9,6
fillp,0
]]for n in all(walls)do spr(n[1],n[2],n[3],2,2)end fillp(32160.5)rectfill(0,28,128,31,7)fillp()
local e={{},{},{},{}}
for n=1,4do
for e=1,8do
local t=grid[n][e]
for n=1,#t do
t[n].draw()
end
local n=tp(e,n)
end
for n in all(e[n])do n.draw()end
end
for n in all(nongrid)do
n.draw()
end
palreset()
if(temp_runner)for n in all(temp_runner.fake_hit)do local n=tp(n[1],n[2])spr(137+draw_time\2%4,n[1]+4,n[2]+2)end
if(not inmediasres)sfn[[rectfill,0,86,128,96,15
line,5,86,29,86,15
line,49,86,79,86,15
line,90,86,128,86,15
sspr,0,96,16,4,3,84
sspr,16,96,16,4,70,84
sspr,16,100,16,4,104,83
sspr,0,100,16,4,44,84
sspr,32,96,24,4,0,108
sspr,32,96,24,4,100,95
sspr,32,96,24,4,42,120
sspr,32,100,24,4,74,111
sspr,32,100,24,4,25,91
]]else rectfill(imrtimer*4-200,0,128,96,7)
if(not pl)return
if(not imr_pressed and not ended)if die3d.visible then local n,e,t=die_frames[die_time\die_spin%8+1],die3d.x-8,die3d.y-8temp_camera_sfn(die3d.x,0,[[rectfill,0, 105, 14, 107, 5
rectfill,-1, 106, 15, 106, 5     
]])function sprf(...)spr(n,...)end pal(split"0,0,0,0,0,0,0")temp_camera_sfn(-e,-t,[[sprf,1,0, 2, 2
sprf,-1,0, 2, 2
sprf,0,1, 2, 2
sprf,0,-1, 2, 2
palreset
sprf,0,0, 2, 2
]])die_time+=1elseif pl.current_ability~=nil and not ended then local n=pl.die[pl.current_ability]spr(76,die3d.x-7,die3d.y-7,3,2)n.draw_face(die3d.x-5,die3d.y-3)local n=n.name local e=print(n,0,-100)print(n,64-e/2+5,114,1)spr(130+draw_time\10%2,64-e/2-5,114)end
if not inmediasres then
local n=game_frames_frac/30/.00002
if(n<night_time)spr(155,110,1)print(night_time-n,119,3,0)else spr(231,115,1)night_palette_imm=not ended is_night=true
local e=2
for n=1,pl.max_health+1do
local t=0
if(bounce_hp[n]>0)bounce_hp[n]-=1t=sin(bounce_hp[n]/25)*4
if n==pl.max_health+1and pl.shield_timer>0then
if(pl.shield_timer>30or pl.shield_timer\2%3==0)spr(145,e,2+t)
elseif n<=pl.health then
spr(128,e,2+t)
elseif n<=pl.max_health then
spr(129,e,2+t)
end
e+=9
end
if(victory)local n=-coslerp(victory_time,60,-46,28)temp_camera_sfn(0,n,[[rectfill,0,-5,128,46,7
rect,-1,-5,128,46,1
fillp,0b0101101001011010.1
rectfill,-1,47,127,48,1
fillp
print,victory!,48,0,1
print,the die         with energy,8,13,2
print,from your defeated foes...,8,21,2
spr,97,26,-2
spr,97,94,-2,1,1,1
print,upgrade,14,36,12
]])print("rattles",40+sin(6699.39%(victory_time\3)/20)*1.25,-n+sin(9437.9%(victory_time\3)/20)*.75+13,1)spr(130+tf\10%2,4,-n+35)
if(defeat)temp_camera_sfn(0,-coslerp(defeat_time,80,-46,38),[[rectfill,0,-5,128,46,6
rect,-1,-5,128,46,1
fillp,0b0101101001011010.1
rectfill,-1,47,127,48,1
fillp
print,you are slain,38,0,0
spr,203,4,-2
spr,203,117,-2,1,1,1
spr,203,4,35
spr,203,117,35,1,1,1
print,the die seeks out,30,18,8
print,a new champion...,30,26,8
]])
end
if(time_scale<1or pause_extend>0)and not victory then
poke(24404,96)
for n=11,90do
local e=mid(n/16-.5,0,1)
local e=sin(n/26+draw_time/128)*e
sspr(0,n,128,1,e*1.25,n)
end
poke(24404,0)
if(draw_time%20>10)spr(133,59,54)
end
if show_title then
sfn[[clip,0,0,127,9
print,the relic of power & ruin,14,6,8
clip,0,9,127,16
print,the relic of power & ruin,13,6,8
clip
]]
if(victory_time>90)sfn[[rect,54,14,65,25,8
spr,240,40,16,3,1
spr,243,64,16
spr,247,72,16,2,1
]]
end
end
function gameplay_tick()
game_frames_frac+=ended and 0or.00002
local e,t=0,{}
for n=1,8do
for o=1,4do
local n=grid[o][n]
if(n.creature and n.creature.health>0and n.creature.side~=1)e+=1
for n in all(n)do
add(t,n)
end
end
end
for n in all(t)do n.update()end
for n in all(nongrid)do
n.update()
end
for n in all(attack_runners)do
n:update()
if(not n.alive)del(attack_runners,n)
end
if(e==0and not victory)victory=true music(11)victory_time=0
if(pl.health<=0and not defeat)defeat=true music(10)defeat_time=0
if(rnd()<.25)make_creature_particle(128,rnd(60)+20,15,-3,rnd(52)+28)
local n=0
for e=1,4do
for t=1,8do
n+=grid[e][t].space.side
end
end
if n==32and not ended then
victory=true
music(11)
elseif n==-32and not ended then
defeat=true
music(10)
end
end
function update_gameplay()
ended=victory or defeat
if victory then
if(level==20)dset(0,dget(0)+1)set_state"win"return
victory_time=min(victory_time+1,10000)
if inmediasres then
if(victory_time>65)show_title=true
if(victory_time>180)set_state"newgame"
elseif victory_time>60and btnp(5)then
dset(1,dget(1)+1)
for n=1,6do
player_abilities[n]=player_abilities[n].copy()
end
set_state"upgrade"
end
time_scale=1
end
if defeat then
defeat_time+=1
if(defeat_time%5==0)defeat_wall=rnd(#walls)\1+1walls[defeat_wall][3]+=2
for n in all(walls)do
if(n[3]~=16and rnd()<.5)n[3]+=.25
end
time_scale=1
if(defeat_time>240)set_state"newgame"music(12)
end
temp_runner=nil
if pl.stun_time<=0and not ended then
move_target=nil
if(btnp(0)and pl.pos[1]>1)move_target={pl.pos[1]-1,pl.pos[2]}
if(btnp(1)and pl.pos[1]<8)move_target={pl.pos[1]+1,pl.pos[2]}
if(btnp(2)and pl.pos[2]>1)move_target={pl.pos[1],pl.pos[2]-1}
if(btnp(3)and pl.pos[2]<4)move_target={pl.pos[1],pl.pos[2]+1}
if move_target and not inmediasres then
if pl.overextended_timer==0then
if(valid_move_target(move_target[1],move_target[2],pl.side))pl.move(move_target[1],move_target[2])time_scale=1
else
time_scale=1
end
end
local n=pl.die[pl.current_ability]
if n~=nil then
if(n.type=="attack")temp_runner=make_attack_runner(n.def,1,n,pl.pos[1],pl.pos[2],1,true)
end
if btnp(5)and pl.current_ability~=nil then
if(inmediasres)imr_pressed=true
n.use(pl,pl.pos[1],pl.pos[2],1)
pl.die[pl.current_ability]=n.copy()
pl.current_ability=nil
pl.animate_time=5
throw()
time_scale=1
end
end
if time_scale>0then
if(pause_extend>0)pause_extend-=1else gameplay_tick()
else
end
if die3d.visible and not ended then
die3d.yv+=.3*pl.die_speed
if die3d.y>100then
if(die3d.yv>4)sfx(16,1)
if(die3d.yv>1)for n=1,die3d.yv*10do local n=make_creature_particle(die3d.x+rnd(10)-5,106,5,rnd(1)-.5,106+rnd(3))n.yv=rnd(2)*-.5end
die3d.yv=die3d.yv*-.35
die3d.y=100
die3d.xv*=.5
die_spin*=2
end
if die_time>45then
pl.die_speed=1
die3d.xv=0
die3d.yv=0
if pl.stun_time<=0then
die3d.visible=false
pl.current_ability=flr(rnd(6))+1
if(is_night and pl.current_ability==4)pl.current_ability=-1
time_scale=0
if(has_mod(pl.die[pl.current_ability],"pause"))pause_extend+=30
end
end
die3d.xv*=.975
die3d.x+=die3d.xv
die3d.y+=die3d.yv
end
imrtimer=min(imrtimer+1,1000)
end
function spawn()
pl=make_player()
for n=1,6do
pl.die[n]=player_abilities[n].copy()
end
pl.die[-1]=make_ability(all_abilities["curse"],0,{}).copy()
end
function do_level_intro()
for n=1,60do
if(n==30)spawn()
_draw()
palreset()
pal(FADE_PALS_1[max((30-n)\5,1)],1)
flip()
end
end
level=0
function start_level()
if(not inmediasres)music(0)
victory=false
defeat=false
draw_time=0
victory_time=0
defeat_time=0
is_night=false
time_scale=1
level+=1
attack_runners={}
nongrid={}
grid={}
game_frames_frac=0
pause_extend=0
bounce_hp={}
for n=1,max_hp+1do
bounce_hp[n]=0
end
night_time=max(65-level*5,45)
if(level==15)night_time=0
for n=1,4do
grid[n]={}
for e=1,8do
grid[n][e]={}
end
end
for n=1,4do
for e=1,8do
make_gridspace(e,n)
end
end
die3d={}
walls=smlu([[199,-8,16
233,4,16
199,16,16
199,28,16
199,40,16
201,52,16
235,60,16
199,76,16
199,88,16
199,100,16
199,112,16
199,124,16
]],true)
defeat_wall=0
local n=n[level]
for n in all(n)do
local n,t,o,l,r=unpack(split(n,"/"))
x=flr(rnd(4))+5
y=flr(rnd(4))+1
if(inmediasres)x=6y=2n="dog1"
local n=parse_monster(e[n],x,y)
n.favor_col=t
n.time=o or 0
n.abil_pattern_i=l or 0
n.move_pattern_i=r or 0
end
if(inmediasres)spawn()imrtimer=0else do_level_intro()imrtimer=1000
throw()
end
function throw()
local n=split"160,162,164,166,168,170,172,174"
die_frames={}
for e=1,8do
local e=rnd(#n)\1+1
add(die_frames,n[e])
deli(n,e)
end
die_time=0
die_spin=2
die3d.visible=true
die3d.x=20
die3d.y=64
die3d.xv=2.5
die3d.yv=0
end
current_upgrades=nil
selected_upgrade_index=1
applied={}
faces_options2=split"x_____,_x____,__x___,___x__,____x_,_____x"
upgrade_mods_names=split"growth,pierce,claim,pause,invasion,superclaim,poison,stun,snipe"
upgrade_mods={}
for n in all(upgrade_mods_names)do
for e=1,all_mods[n][3]do
add(upgrade_mods,n)
end
end
function make_upgrade(t,n)
local n={
faces={},
kind=n
}
for e=1,6do
n.faces[e]=t[e]~="_"and t[e]or false
end
local l={
{0,3},{3,3},{6,3},{9,3},{3,0},{3,6}
}
n.draw=function(e,t)
if(n.kind=="hp")spr(142,e+4,t-2)print("+1 hp",e-3,t+7,0)else for o=1,6do local e,t,n=l[o][1]+e,l[o][2]+t+6,({["3"]=14,["2"]=14,["-"]=8,["1"]=12,x=12,[false]=5})[n.faces[o]]rectfill(e,t,e+1,t+1,n)end if sub(n.kind,1,1)=="+"then print("up",e+8,t-1,12)elseif all_abilities[n.kind]~=nil then local n=all_abilities[n.kind]spr(n[2],e+8,t-3)spr(n[5]+149,e-4,t-4)else spr(all_mods[n.kind][2],e+8,t)end
end
return n
end
function draw_random_abil()
local e,n=split"1,1,1,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4"[level],{}
for e=-1,5do
n[e]={}
end
for e,t in pairs(all_abilities)do
add(n[t[5]],e)
end
if(rnd()>.35)return rnd(n[e])else return rnd(n[e+1])
end
function update_upgrade()
pl=nil
if current_upgrades==nil then
music(12)
current_upgrades={}
local n={"hp",rnd(upgrade_mods),rnd(upgrade_mods),rnd(upgrade_mods),draw_random_abil(),draw_random_abil(),draw_random_abil()}
if(level%3==0)n={"+1","+1","+1","+1"}
local e=split"11____,____11,__11__,1__1__,_2____,2_____,___2__,3-____,_1___1,_1__1_"
for o=1,4do
local l=flr(rnd(#n)+1)
local t=n[l]
deli(n,l)
local n="______"
if(t=="+1")local n=rnd(#e)\1+1current_upgrades[o]=make_upgrade(e[n],t)deli(e,n)else n=rnd(faces_options2)current_upgrades[o]=make_upgrade(n,t)
end
end
if(btnp(2))selected_upgrade_index=(selected_upgrade_index-2)%#current_upgrades+1ssfx(14)
if(btnp(3))selected_upgrade_index=selected_upgrade_index%#current_upgrades+1ssfx(14)
if btnp(5)and tf>32then
ssfx(12)
poke(24404,96)
local n=selected_upgrade_index*27-16
player_abilities=applied
if(current_upgrades[selected_upgrade_index].kind=="hp")max_hp+=1
current_upgrades=nil
selected_upgrade_index=1
scrnt(draw_upgrade,4,n,22,23,4,n,7)
set_state"gameplay"
start_level()
end
end
function draw_upgrade(t)
camera(0,coslerp(tf,64,-128,0))
sfn[[rectfill,30,0,128,128,7
line,31,0,128,0,6

line,31,127,127,127,6
spr,146,27,7

rectfill,0,0,30,128,3
line,0,0,30,0,1
line,0,0,0,127,1
line,0,127,30,127,1

rectfill,31,60,128,109,5
line,31,60,128,60,3
line,31,109,128,109,3
spr,147,33,52
spr,147,43,52
spr,147,53,52
spr,147,63,52
spr,147,73,52
spr,147,83,52
spr,147,93,52
spr,147,103,52
spr,147,113,52
spr,147,33,110,1,1,1,1
spr,147,43,110,1,1,1,1
spr,147,53,110,1,1,1,1
spr,147,63,110,1,1,1,1
spr,147,73,110,1,1,1,1
spr,147,83,110,1,1,1,1
spr,147,93,110,1,1,1,1
spr,147,103,110,1,1,1,1
spr,147,113,110,1,1,1,1

line,127,0,127,127,6

spr,79,124,-4
spr,79,124,123
spr,79,-4,-4
spr,79,-4,123

spr,95,105,20
spr,95,55,-3
spr,95,123,40
spr,95,42,123
spr,95,82,124
spr,146,56,46

line,38,30,38,53,3

rectfill,0,-4,128,-1,1

print,⬆️,12,4,7
print,⬇️,12,119,7
print,choose upgrade,38,22,3
]]
local n="level "..level+1 .."/20"
print(n,82,5,5)
if current_upgrades~=nil then
local e=current_upgrades[selected_upgrade_index]
applied={}
for n=1,6do
applied[n]=player_abilities[n].copy()
if(e.faces[n])local t=""if e.kind=="hp"then t="+1 health"elseif sub(e.kind,1,1)=="+"then local e=({["3"]=3,["2"]=2,["-"]=-1,["1"]=1,[false]=0})[e.faces[n]]applied[n].pips=max(applied[n].pips+e,0)applied[n].original_pips=applied[n].pips t="level up abilities"elseif all_abilities[e.kind]~=nil then local e=all_abilities[e.kind]applied[n]=make_ability(e,applied[n].pips,applied[n].mods)t=applied[n].name else applied[n].mods[min(#player_abilities[n].mods+1,2)]=e.kind t=all_mods[e.kind][4]end nl_print(t,42,34,1)
end
for n=1,#current_upgrades do
temp_camera(-4,-(n*27-16),function()
if(n==selected_upgrade_index and t)return
rectfill(0,0,22,23,7)
current_upgrades[n].draw(5,5)
local e=3
if(n==selected_upgrade_index)e=12
rect(0,0,22,23,e)
end)
end
draw_die2d(player_abilities,50,65,state=="gameplay"and player_abilities or applied,e)
end
end
function update_win()
end
function draw_win()
cls()
print("you win!!!",44,50,7)
print("wins: "..dget(0),50,60,7)
end
states={
newgame={update=update_newgame,draw=draw_newgame},
gameplay={update=update_gameplay,draw=draw_gameplay},
upgrade={update=update_upgrade,draw=draw_upgrade},
win={update=update_win,draw=draw_win}
}
player_sprite=0
function begin_game(n,e)
player_abilities=make_die(e)
level=0
reset()
set_state"gameplay"
player_sprite=n
start_level()
end
function _init()
night_palette_imm=false
cartdata"dievirus"
menuitem(1,"clear wins",function()
dset(0,0)
end)
inmediasres=true
begin_game(0,"start;5/start;5/start;5/start;5/start;5/start;5")
end
function _draw()
palreset()
states[state].draw()
pal(split"129,2,141,4,134,6,7,136,9,10,142,139,13,14,15,0",1)
if(night_palette_imm)pal(split"129,2,141,4,134,5,6,136,9,10,142,3,13,14,15,0",1)night_palette_imm=false
if(pal_override_imm)pal(pal_override_imm)pal_override_imm=nil
end
function _update()
states[state].update()
tf+=1
end
function set_state(n)
state=n
if(n=="newgame")music(12)
tf=0
end
__gfx__
eeeeeee0099eeeeeeee0e000000eeeeeeeeee00000eeeeee22eeeeeee22eeeeeeeee99999eeeeeeeeeeceeffffeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee999999eeeeeee000044040eeeeeeee00aaaa0eeeee2eee4444ee2e0eeeeee994b9b9eeeeeeeeeeec9ffffeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee99eeee
eeeeee0404404eeeeeee00404404eeeeeeee0909909eeeeee222556652ee0ee0eee940bb0beeeeeeeeeee990ff0feeeeeeeeeeebb9bbeeeeeeeeeeeee99ee999
eeeeee004424eeeeeee0e044414eeeeeeee0099949eeeeeeee22505605e0eee0eee94bb4b9eeeeeeeecec999f19eeeeeee8b99bb9b828eeeeeeeeeee99bbbb9e
909eee000440eeeeeeeeee04444eeeeeeee00499990eeeeeeee445525ee0ee0eee9994bbb0e0e0eeeeeec991111eeeeeee8828889bb72beeeeeeeeeebb8888ee
909eeee00000eeeeeeeeeee444eeeeeeeee00099700eeeeeeee444554eee00eeee9994bb90e0e0eeeeeeec1c110eeeeee288288828bbb99eeeeeeeee8bb787be
e0eee422000eeeeeeeeee991449eeee0e9e00747770eeeeeee99244449ee0eeeee99154450e0e0eeeeeeccc000eeeeeee8288eeee88b9e7eeeeeeee88bbbbb99
ee0e44422992eeee0eee99114419eee0e96607777cc6eeeee559422229e0eeeeee99151159000eeeeee888b8100eeeeeee820eeeee888eeeeeeeee8888bbebb9
ee0422449924eeeee0ee11111111ee0ee6999677cc96eeeee544944445e0eeeeee91151109e0eeeeeeee8b811109eeeeee88b8eeeeee88eeeebeee88228beeee
ee42ee4994e444eeee091e1111e1190ee66ee06444096eee54ee4999e50eeeeeee915111001beeeeeee888b811ffeeeeeee8bb9eeeeeeeeeeb9bee828bbb8eee
ee40ee9924ee44eeee94e656565e149ee6666e77990699ee55ee4556e55eeeeeeee150005ee0eeeeeef888bffffeeeeeeee229bbeeeeeeeee9b9ee88200b88ee
eeeee090000eeeeeeeee05656565e0eee6666ccc776666eeeeee2224e0eeeeeeeeeb55555ee0eeeeeef888b80000eeeeeeee88bb9eeeeeeeee9b9e2888bb8880
eeee000e000deeeeeeee5656e65eeeeeee66cccccc6666eeeee2224220eeeeeeeeee55e55ee0eeeeeeef8880ed00eeeeeeeee8899beeeeeeeee9bb82800be88e
eeee00ddd0dddeeeeeee65eeee6eeeeeeee6ccccccc66eeeee2224e222eeeeeeeeee5eee5ee0eeeeeeedee00d00deeeeeee02228bb0eeeeeeeeeeb882ee8be80
eee0ddddd444deeeeeee5ddddd444deeeeeccdddd449deeeeed5dee5ddeeeeeeeeee5ddd5de0eeeeeeeedd0dd444eeeeee000888b000eeeeeeeeb888eee8beee
ee444dddddeeeeeeeee444ddddddeeeeee994dddddeeeeeeed555dd555ddddeeeed444dd4440eeeeeeeed444ddeeeeeeeeeee0000eeeeeeeeeebb8eeeee88bee
eeeeeeeeeeeeeeeeeeeeeeebbeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9999eeeeeeeeee7777eeeeeeeeee4eeeeee4eeeeeeeee9ee9999ee9eee
eeeeeee000eeeeeeeeeeee8b8bbebeeeeeeeeeeeeeeeeeeeeeee88888eeeeeeeeee8e998888e8eeeeee755775eeeeeeeee4e7777e4eeeeeeeeeee977779eeeee
eeeee88b0eeeeeeeeeeee8b8b8bbbbeeeeeeeeeeeeeeeeeeee88222288ee88eeeeee88877778eeeeeee7705507eeeeeeeee444444eeeeeeeeeee97707709eeee
eeee88b8eeeeeeeeeeee88bb8b82b29eeeeeeeeeeeeeeeeeeee2bbb2282822ee888ee770770eeeeeeee777777eeeeeeeeee777777eeeeeeeee9e97757759e9ee
eee88eeeeeeeeeeeeeee8ba98820202aeeeeeee0000eeeeeeeeb8bbb228b87eeee8ee777777eeeeeeeee79979eeeeeeeeee7707707eeeeeeeeee97757759eeee
ee88eeeeeeee00eeeeeb999a882a0a2aeeeeeeee0bbbb99aeeb8bbbbb28bbb8eee888e07777eeeeeeeeee2999eee7eeeeee777777eeeeeeeee7ee977777ee7ee
e822eeeeeee8808eeee999aa9827272eeeee000b888b9aeeee8bb8bbb0bee79eeeee87007707eeeeeeee12299eee7eeeeeee77777ee99eeeeee7ee5777ee7eee
e28beeeeee88787eeee8999aa822222eeeeee08bb78bbeeeee8b8b222bbbe7eeeeee77055507eeeeeee122299ee7eeeeeeeee777eee9eeeeeee5777777775eee
e8b2eee28888b0beeeee89a9aeb222aee0eee8bbbbbbeeeeee88bee888b8beeeeeee77775777eeeeeee11222777eeeeeeeee44b7ee7799eeeeee55577755eeee
e82bbe88288b000eeeee8299a9ee9aaee00e8bbbbbbbaaeeee88eee88b8bbeeeeeeeee77757eeeeeeee111222eeeeeeeeeebbb4477ee9eeeeeeeee5555eeeeee
e82b2828822bbbeeeeeeb8299aee9aeeee00b8bbb8bbbeaeee8bee8b8888eeeeeeeeee5555888eeeeeee10000eeeeeeeeee7444beeeee99eeeeeee5555eeeeee
ee282882bbbeeeeeeeebbb8299beaeeeee08888b888beeeeee8ee9be8b8eeeeeeeeee00000ee8eeeeeeee11222eeeeeeeee7bbb44b4ee9eeeeeeee0000eeeeee
eee222bb2299eeeeeee9beee28beeeeee08888888888beeeeeeee9e9beeeeeeeeeeee00e00ee888eeeee11122277eeeeeeee7444b44eeeeeeeeeee0000eeeeee
eee28b9bbbbb8eeeeee9eeee9beeeeeee088bee8888888eeeeeeeee9eeeeeeeeeeeee0eee0eeeeeeeeee1122eee7eeeeeeee711144beeeeeeeeeee000eeeeeee
ee2288b88b8b88eeeeeeeeee9eeeeeeee08b0eee00e88beeeeeeeeeeeeeeeeeeeeeee0eee0eeeeeeeeeeee7eee7eeeeeeeee1111bbeeeeeeeeeeeee00eeeeeee
ee2e8ee8ee8ee8eeeeeeeeeeeeeeeeeee088b0ee000e88beeeeeeeeeeeeeeeeeeeee777ee777eeeeeeeee777eee7eeeeeeee11117777eeeeeeeeee7777eeeeee
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeee77761333
d77777777777777dd77777777777777dd77777777777777dd77777777777777dd77777777777777dd77677767777677deee55555555555feeeeeeeee77761333
d76667777776667dd77777777777777dd77677666677677dd76667666676667dd77767777776777dd76767677676767dee5555555555551eeeeeeeee77661133
d76767777776767dd77667777776677dd76767777776767dd76767677676767dd77767777776777dd67776777767776de57777777777511eeeeeeeee67661113
d77677777777677dd77666777766677dd76767666676767dd76667666676667dd76776777767767dd76777776777767de77777777777711eeeeeeeeee6651111
d77777766777777dd77777777777777dd77677677777677dd76767677676767dd77666677666677dd77676767777677de77777777777711eeeeeeeeee6661113
d77777677677777dd77777777777777dd77777777677777dd77677766777677dd77766666666777dd77767677676777de77777777777711eeeeeeeeee7661133
d77777766777777dd77777777777777dd77677666677677dd76767677676767dd77666677666677dd77677776767677de77777777777711eeeeeeeee77761133
d77677777777677dd77666777766677dd76767777776767dd76667666676667dd76776777767767dd76777767777767de77777777777711eeeeeeeeeeeeeeeee
d76767777776767dd77667777776677dd76767666676767dd76767677676767dd77767777776777dd67776777767776de77777777777711eeeeeeeeeeeeeeeee
d76667777776667dd77777777777777dd77677777777677dd76667666676667dd77767777776777dd76767677676767de77777777777711eeeeeeeeeeeee6eee
d77777777777777dd77777777777777dd77777777777777dd77777777777777dd77777777777777dd77677776777677de77777777777711eeeeeeeeeeee6eeee
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddde777777777777115555555eeee65e6ee
111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111e7777777777771555555555eeeeeeeee
111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111e577777777775555555555eeeeeeeeee
111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee111eeeeee11e111111eee111eeeeeee11eeeeeee111e11111eeeeeee1eeeeeeeeeeeeeeeeeeee11eeeeeeee111eeeeeeeeee11111eeeeee111eee1eeeee
eeeeee11eeeee11111111111e11111eeeeeeee1eeeeeee111eeee11eeeeee11eee1e1eeeeeeeeeeee1ee1eeeeee1eee1ee1eeeee111e1e11eeeee11eeee1ee1e
eeeeeee1eeee111e1111111111ee11eeee1eee11eeeee1e1eeeeee1111111111ee1e1e1eeeeee111ee1e1eeeee1111eee11e1eee1111e111eeeee11eeee11ee1
ee11eeee1ee111eee111111e11eeeeeeeee11e11eeee1eeeeeeeee11eeeeeeeeee1e1e1eeeeeee11eeee1eeee111111e11e1eeeee11e1e1eeeeee11eee111e11
e1eeeeee11111eeee111111e11eeeeeeeeee1111eee1eeeeeeeee11eeeeee1eeee11111eeeeee1e1eeee1eeee111e11e111e1eeee1e1111eeeeee11ee111ee11
1eeeeeeeee11eeeeee1111eee11eeeeeee1e1111e11eeeeeeeee11eeeeeee11e1e11111e1eee1eeeeeee1eeee11e111e11e1eeeeee1111eeeeeee11e111ee111
1e111111e1e1eeeeee1111eee111eeee1ee11111e11eeeeeeee11eee11111111e111111ee1e1eeeeeee11eeee111111ee11e1eeeee1111eeeeeee11eeeee1111
e11111111ee11eeeeee11eeeee111eeee111111e1eeeeeeeee11eeeeeeeeeeeeeee111eeee1eeeeeee11eeeeee1111eeee1eeeeeeee11eeeeeee111eee11111e
e1e1eeeeeeeeeeeeeeeeeeeeee1111eeeeeee111ee111eeeee111eeeeeeeeeeeeecceeeee0eeeeee1111eeee9e9eeeeeee88eeeecccceeeeeceeeeeee5ceeeee
eeeee1eeeee1eeeeee1111eee111111e1e1eee11e11111eee11111eeeeeeeeeeec1cceee990eeeee1771eeee9e9eeeeee88eeeeec77ceeeec7ceeeee5ee5eeee
1eeeeeeeee11111e11eeee11111ee111e11eee1111ee11ee11ee11e1ee0000eee1cceeeee0eeeeee1111eeee9e9eeeee88eeeeeecccceeeeccceeeeeec5eeeee
eeeeee1eeee1eee11ee11ee111ee1e11e11eee1111eeeeee11eeeee1e0ee000eceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeee111eeee1111eeee1ee11eee1111eee11111ee1ee10ee000e0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee1111111111ee1111ee111eeeeee11eee11e11eeeeee11ee11ee000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee111111111eeeeeeeee11111ee1e11ee1e1e111ee11e111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeee1111111e111eeeeeee111eeeee111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
ccccccce8888888ee111111eeeeeeeeeeeeeeeeee77ee77eeeeecceeeeeeeeeeeeeeeeeeee1777eeeeee11eeeeeeeeeeeeeeeeeeeeeeeeeeccccceeeee77ccee
c77777ce8ddddd8ee1f1f11ee111111eeeeeeeee7cc77cc7eeeecceeeeeeeeeeeeeeeeeee1eeeeeeeeeeee1eeeeeeeeee7eeeeeeeeeeeeeeceeeceeecc77eecc
c7ccc7ce8eeeee8e111f115ee191911eeeeeeeee7cc77cc7eeecceeeeeeeeeeeeeeeeeee1eeeeeeeeeeeeee1eeeeeeee7eeeeeeeeeeeeeeeececeeeeceeeeeec
c7ccc7ce8eeeee8e11f1f15e111911eeeeeeeeee7cc77cc7eeecceeeeeeeeeeeeeeeeeee1ee11eeeeee11ee7eee11ee17ee11eeeeeeeeeeeeeceeeeeccee77cc
c7ccc7ce8eeeee8e111111ee119191eeeeeeeeee7cc77cc7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeeee11eeeeeee8eeeeeeeeeceeeeeeecc77ee
c77777ce8eeeee8e555555ee111111eeeeeeeeee7cc77cc7eecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeeee1ee1eeeeee8eeeeeeeeeceeeeeeeeeeeee
ccccccce8888888eeeeeeeeeeeeeeeeeeeeeeeee7cc77cc7eecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7771eeee111eee88eeeeeeeeeeeeeeeeeeeeee
dddddddedddddddeeeeeeeeeeeeeeeeeeeeeeeeee77ee77eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888eeeeeeeeeeeeeeeeeeee
eeccccee0000000eeeeeeeeeeeeeeeeeeeeeeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeeeeeeeeee77eeeee8eeeeeeeeeeeee1eeeeeeee
cceeee770077700eeeeeeeeeeeeeeeeeeeeeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeee0000000eee77eeee88eeeeeeeeeeeee1e11eeeee
77eeee770007000eeeee66eeeeeeeeeeeeeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeee0eee0eeeee77eee88eeeeeeeeeeee1ee11eeeee
77eeeecc0007000eee66eeeeeeeeeeeeeeeeeeee0ee000ee2eee2eee4ee444ee6eee55ee9ee9e9eeceeccceeee0e0eee77777eeeeeeeeeeeeeeeee1eeeee11ee
eecccceed07770dee6eeeeeeeeeeeeeeeeeeeeeeeee0e0eeeee22eeeeeeee4eeeeeee5eeeee999eeeeecceeeeee0eeee77777eeeeeeeeeeeeeeee1eeeeee11ee
eeeeeeeee00700eeeeeeee6ee3eeee3eeeeeeeeeeee0e0eeeeee2eeeeee44eeeeeee55eeeeeee9eeeeeeeceeee000eeeeeeeeeeeeeeeeeeee1ee1eeeeeeeeeee
eeeeeeeeed000deeeeee6eee3e3ee3e3eeeeeeeeeee000eeeee222eeeee444eeeee555eeeeeee9eeeeeccceee00000eeeeeeeeeeeeeeeeeee111eeeeeeeeee11
eeeeeeeeeedddeeeee66eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000eeeeeeeeeeeeeeeee111eeeeeeeeeee11
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee71eeeeeeeeee77eeeeeeeeeeeeeeeee666eeeeee
eeee5555577eeeeeeeeeeeee555eeeeeeeeeeee55eeeeeeeeee55555555eeeeeeeeeeeeeeeeeeeeeeeeeee77711eeeeeeeee7777eeeeeeeeeeeee6666666eeee
eeee555557777eeeeeee555555577eeeeeeee5555555eeeeee75555555555eeeeeeeeee77777777eeeee77777711eeeeeee77777777eeeeeeee66666666666ee
eee55555777777eee555555777777eeeeee55555555557eeee7775555555555eee7777777777777eee7777777711eeeeeee7777777777eeee66666666666777e
ee5555577777777ee557777777777eeee5555555555777eeee77775555555555ee7777777777777e7777777777711eeeeee777777777777e666666666677777e
ee55557777777777e7777777777777ee555555555577777ee777777755555551ee7777777777777e7777777777711eeeee7777777777777e566666677777777e
e555557777777777e7777777777777eee55555557777777ee77777777555551eee7777777777777e77777777777711eeee7777777777777ee56667777777777e
e555577777777777e7777777777777eee555555777777777777777777775511eee7777777777777e77777777777711eeee777777777777eee55777777777777e
5555777777777777ee777777777777eeee5555777777777777777777777771eeee7777777777777ee77777777777711ee7777777777777eeee55777777777777
e55577777777777eee7777777777777eee5577777777777777777777777711eeee7777777777777ee77777777775511ee7777777777777eeee55777777777777
ee5777777777777eee7777777777777eeee77777777777777777777777771eeeee7777777777777ee777777775555511e7777777777777eeeee5577777777777
eeee7777777777eeeee777777777777eeeee777777777777e777777777711eeeee7777777777777ee777775555555555e557777777777eeeeee5577777777777
eeeeee77777777eeeee7777777777eeeeeeee7777777777eeee777777771eeeeee7777777777777ee77755555555555ee555555777777eeeeeee5577777777ee
eeeeeeee77777eeeeee77777777eeeeeeeeee777777777eeeeee77777711eeeeee7777777777777eee55555555555eeeeeee555555577eeeeeee55777777eeee
eeeeeeeee7777eeeeeee7777eeeeeeeeeeeeee777777eeeeeeeee777771eeeeeee77777777eeeeeeeeee5555555eeeeeeeeeeeee555eeeeeeeeee55777eeeeee
eeeeeeeeeeeeeeeeeeee77eeeeeeeeeeeeeeeee777eeeeeeeeeeeee771eeeeeeeeeeeeeeeeeeeeeeeeeeee555eeeeeeeeeeeeeeeeeeeeeeeeeeeee57eeeeeeee
eeeeeeeeeeeeeeeeeeeeeeef50eeeeeeeeeeeeef755eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffeeeee60000006eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee77f50eeeeeeeeee77ff5500eeeeeeeeee7fee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffeeeee00000000eeee6666666eeeeeeeeeeeeeeeeeeeee
f7f7ffff550eeeeee7fffffff55550eeee7fffeeeeee55555eeeeeeeeeeeeeeeeeeeeeeeeeeee333333eeeee00600060eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
fffffffff5555f5ffffffffff55555f5eeeeeeeeeeeeee5555555e5eeeeeeeeeeeeeeeee3ffff3fffffeeeee00006000eeee6666666eeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555eeeeeeeeeeeeeeeeeeeeeeeeeeeee3ffff3fffffeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
e7fff55eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5555eeeeeeeeeeffffffffffffeeee333333fff33eeeee6600000666666666666eeeeeeeeeeeeeeeeeeeee
ffffff55555f5feee77f7ff5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffeeeeffffffff3eeeeeee66060606eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
fffffffffffffffffffffffffffff55eeeeeeeeeeeeeeeeeeeeeeeee333333333333eeeefffffff3eeeeeeee660606066e6e6e6e6e6eeeeeeeeeeeeeeeeeeeee
eeeeeeeeee6666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555555555553eeeeff5555f3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee333333333333eeeeff5ff5f3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeecec6666ecceceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffff5eeeeff5cf5f3ee6eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeeee
eee6cc655665566556cc66eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffff5eeeeff5cf5f3666eeeeeeeeeeeeeeeeeeeeeeeeeeeeee6eee6eececceeee
eee6c55666655666655cc6eeeeeeeeeeeeeeeeeeceeeeeeeeeeeeeeefffffffffff5eeeeff5cf5c3666eeeeeeeeeeeeeeeeeeeeeeeeeeeeee666e666cecccece
ece55666cc65566cc66556ceeeeeeeeeeeeeceeecceeeeeeeeeeeeeefffffffffff5eeeeff5cf5c3666eeeeeeeeeeeee666ee666eeeeeeeeeeeeeeeeeeeeeeee
e5566666c66556666666655eeeeeeeceeeeecceccceeeeeeceeeeeeefffffffffff5eeeefcccf5c3666eeeeeeeeeeeee666666666666666666eeeeee66eeeeee
566666666665566666666665ceeccecccecccccccccceccececeeeeefffffffffff5eeeefcccf5c366ceeeeeeeeeeeee666666666666666666666eee66666eee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccceeeeeeeeeeeeecceeeeeeee7888ee55555555eeeeeeeeeeeeeeeeeeeffffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeee66666666666666eeeeeeeeeecccceeceeeeecceecceeeceee788877e57577775eeeeeeeeeeeeeeeeeeeffffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccecceecceeeeeceeee7888777757575575eeeeeeeeeeeeeeeeeee33333333eeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee66e66666666666666e66eeeeeeeeeeeeceeceeeeeeeeeeeeeee7888777757575575eeeeeeeeeeeeeeeeeeefffffff35fff5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeee7888777757577575eeeeeeeecceeeeeeeeefffffff355ff3eeeeeeeeeeeeeeeeeeeeeeee
66666666666666666666666666666eeeeeeeeceeceeeeeeeeeeeeeee7888777757555575ffffffffccffeeeeeee3333fff333333eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeee788877e57777775fcfffcffffffeeeeeeeee553fffffff5eeeeeeeeeeeeeeeeeeeeeeee
6e6e6e6e6e6e6e6e6e6e6e6e6e6e6eeeeeeeeceeceeeeeeeeeeeeeeeee7888ee555555553c333cc33333eeeeeeeeee553ffffff5eeeeeeeeeeeeeeeeeeeeeeee
eee50ee00ee5000e00eeee00eee0005eeeeeeceeceeeeeeeeee888eee600e00005eeeeee5c5555c55553eeeeeeeeeee53f5555f5eeeeeeeeeeeeeeee88eeeeee
eee00ee00ee0000e00eeee00eee00005eeeeeceeceeeeeeeee88888eee00e00000eeeeee3c3333c33333eeeeeeeeeee53f5ff5f5eeeeeeeeeeeeeeee8eeeeeee
ee506e00ee50eeeeee8ee8eeeee00e00eeeecceeceeeeeeeee8ee88eee00e500eeeeeeeefcffffcffff5eeeeeeeeeee53f5ff5f5eeeeeeeeeeeeeeee8eeeeeee
ee000000ee000eeeeee00eeeeee00ee0eeeeecceceeeeeeeeeeee88e5e506e000eeeeeeefcffffcffff5eeeeeeeee6e53f5ff5f5eeeeeeeeeeeeeeee88eeeeee
ee000005ee000eeeeee00eeeeee00ee0eeeeeeeeeeeeeeeeeee888ee0e605e0005eeeeeefcfffccffff5eeeeeeee66e53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeee
e506e00ee50eeeeeee8ee8eeeee006e0eeeeeeeeeeeeeeeeeee88eee0ee00ee0eeeeeeeefcfffcfffff5eeeeeeee66ec3fcff5f5eeeeeeeeeeeeeeeeeeeeeeee
e00ee00ee00000ee00eeee00eee00000eeeeeeeeeeeeeeeeeeeeeeee0ee00ee00000eeeefffffcfffff5eeeeeeeec6eccfcfc5f5eeeeeeeeeeeeeeeeeeeeeeee
500e500ee00000ee00eeee00eee50000eeeeeeeeeeeeeeeeeee88eee0ee006e000005eeefffffcfffff5eeeeeeee6ceccfccccc5eeeeeeeeeeeeeeeeeeeeeeee
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000
__sfx__
090e00200c0000c6000c0001000013600000000c0000000004300043000c00000000043000000013600000000c000000000c00000000136000000000000000000c000000000c0000000013600000000c00000000
550e00201c3000c600283002630028300243002630004300000000430024300000000430000000233002330023300233000c00000000136000000000000000000c000000000c0000000013600000000c00000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010300001c12000200001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000000000000
010300001d22000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000000000000
011100001862300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400001e24018240186401864018640186430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010a00002462618626186161861600100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000001e24318243186431864318643186430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010a00001f11500700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
0110000021010260101a0130070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000000000000
011100002861300000000000c6130c614000000000100001000010000100001000010000100001000010000100001000010000100001000010000000000000000000000000000000000000000000000000000000
010400001c41024411007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
010400001c41037321007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
011200001611112111111130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011100000000000001000010000100001000010000100001000010000100001000010000100001000010000100000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
151600200412504115001050411504125041150010504115041250411500105041150010504115001050010504125041150010504115041250411500105041150412504115001050411500105041150010000100
d10c0000301412d4422d4322d4222d4122d4122d4122d4122d4452e4452d4452b4352944528435264452543523445214351f4451d4351c4421c4321c4221c4121c4172f4171c4172f417284173b417284173b417
d10c0000351413444234432344223441234412344123441234445354453444532435304452f4352d4452c4352a445284352644524435234422343223422234120214202122021420212200142001220014200122
1118000002162021320000002165091620913200000091650a1620a1320c1620d1620e162101621116213162151621516200100151650e1620e162001000e1650a1620a162001050a16504162041620a16204162
2918000002142021220000002125091420912200000091250a1000a1000c1000212509142091221110002125041420412200100041250b1420b122001000b1250014200122001050012507142071220a10001142
051800000e0430e02313635000000e0430e00013635136150e0430e02307635076000c0000e043076350e0230e0430e02313635000000e0430e00013635136000e0430e000076350e0430c0000e0230763507625
8d1800002d7422e2252d7422d7223273532215307212e7122d7422d7322d7222d2152d1152d3152d5151d6002c742215252c7422c7222c712215252f7422f722307413073230722307122b717307172b51730517
8d1800002d7422e2252d7422d72232735322153472535712377413773237722372153711537315375151d600387453872537745375223771237512307413072532722327123271239712345173b5173251739517
291800000a1420a122000000a125051420512200000051250a1450a1250c1000a1250514205122111000a125091420912200100091250414204122001000012502142041220573507125091420a1220c1350e145
051800000e0430e02313635000000e0430e00013635136150e0430e02307635076000c0000e043076350e0230e0430e02313635000000e0430e000136350e0430764613626076161361607617136170032100341
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
891800000e0400e0300e0200e010150401503015720157100070000700007000e741170401703017720177160c0400c0300c7200c710130401303013720137100070000700007000070000700007001572015710
c11800001c0000e0000e7000e700210402103224720247122604026032260212872726040260321a726267160c0000c0000c7000c7001f0001f0001f0001f0001f0401f0301f7222b5122304023030237222f512
891800001a0401a0301a0201a01018040180301872018710170501705017050177411704017030177201771617000100001770010700130001300013700137000070000700007000070000700007001570015700
891800001a0400e0301a0271a0161c040100301c7271c7161e050120501e0501e7411e120121202a5172a516367002a700367002a700130001300013700137000070000700007000070000700007001570015700
891800000205002030210000203004050040302370004030060500603024000060300604006020060160601717000100001770010700130001300013700137000070000700007000070000700007001570015700
__music__
01 61622122
01 69642924
01 66252624
00 64652524
00 68252827
02 69646129
03 72427273
03 72427273
00 41424344
00 41424344
04 41423444
04 41423536
01 41423233
02 41423273
__label__
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5mm5mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmfooooofmmmmmmmmmmmmmmmmmmmmmmmmffff
fffmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5mmm5mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmfooooooooofofmmmmmmmmmmmmmmmmmmmmfff
ffmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm555mmmm55mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmfooooooooooofofmmmmmmmmmmmmmmmmmmmmff
fmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55555mmmm55mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmf7797999999ooofofmmmmmmmmmmmmmmmmmmmmf
fmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5555555mmmm55mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmfoooooooooo999o2fmmmmmmmmmmmmmmmmmmmmmf
fmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5555555555mmmm55m55mmmmmmmmmmmmmmmmmmmmmmmmmmfooooooooooooo99222fmmmmmmmmmmmmmmmmmmmf
fmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm555555555555mmmm55m55mmmmmmmmmmmmmmmmmmmmmmmmmmfoooooooooooooo29222fmmmmmmmmmmmmmmmmmmf
fmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5555555m5555555555555mmmm55555m55mmmmmmmmmmmmmmmmmmmmmmf77797799oooooo222222fmmmmmmmmmmmmmmmmmmf
fmmmmmmmmmmmmmm555555555555555555555555m5555555555555mmmm55555m55mmmmmmmmmmmmmmmmmmmmmmfooooooo999999o2222222fmmmmmmmmmmmmmmmmmf
f55555555555555555555555555555555555555m5555555555555mmmm55555555m55mmmmmmmmmmmmmmmmmmfooooooooooooo992222222fmmmmmmmmmmmmmmmmmf
f5555555555555555555555555555555555555545555555555555mmmm5m555555m55mmmmmmmmmmmmmmmmmmfo77777oooooooo99922222fmmmmmmmmmmmmmmmmmf
f555555555555555555555555555555555555fff5545555555555mmmm5mm55555m55mmmmmmmmmmmmmmmmmfo7999997ooooooo2299222fmmmmmmmmmmmmmmmmmmf
f55555555555555555555555555555555555f444ff55555555555mmmm5m5m5555555m55mmmmmmmmmmmmmmf799d99999oooooo22299222fmmmmmmmmmmmmmmmmmf
f5555555555555555555555555555555555f444444f5f55455555mmmm5m55m555555m55mmmmmmmmmmmmmf79sd99sd99oo9oo222229922fmmmmmmmmmmmmmmmmmf
f5555555555555555555555555555555555f444444444f5555555mmmm5m5555m5555m55m555mmmmmmmmf779dd99dd99o999o222222922fmmmmmmmmmmmmmmmmmf
f5555555555555555555555555555555555f44944444444f55555mmmm5m55555m555555m55m5mmmmmmmf97d99sd99d999999222222992fmmmmmmmmmmmmmmmmmf
f555555555555555555555555555555555554f44444444424f555mmmm5m555555m55555m55mm5mmmmmmf97999dd999999999922222299ofmmmmmmmmmmmmmmmmf
f55555555555555555555555555555545454554f4444444244f45mmmm5m55555555m555555mm5mmmmmf7979sd99sd9999999999222229ofmmmmmmmmmmmmmmmmf
f555555555555555554545545455555555459454f4444442444f5mmmm5m555555555m55555mm5mmmmmf9979dd99dd99999999999222299fmmmmmmmmmmmmmmmmf
f555555555555555545f5f5f45f555554559555m544444424444fmmmm5m5555555555m5555mm5mmmmmf997999d99992111999999922229fmmmmmmmmmmmmmmmmf
f5555555555555554544444444445f95f555555m9544442444444fmmm5m555555555555m55mm5mmmmmf911799999921111119999992222fmmmmmmmmmmmmmmmmf
f555555555555555f4444444444494444ff5555m555f2244444449fmm5m5555555555555m5mm5mmmmmf911179999221111111999999222fmmmmmmmmmmmmmmmmf
f555555555555555f444444444444444444ffffm555f44444444449f45m555555555555555mm5mmmmmf1222222222422222111299999222fmmmmmmmmmmmmmmmf
f55555555555555554544444944444444444544fff55f44444444494m4mm55555555555555mm5mmmmmf2211244444421112221129999222fmmmmmmmmmmmmmmmf
f55555555555555545454545444444444454544444f55f4444444494f54mmm555555555555mm5mmmmmf2111124444411111122122999222fmmmmmmmmmmmmmmmf
f55555555555555595f454545444444444455444444f55f4444449944fm4m4mm5555555555mm5mmmmmf1111f124441f111f112242299222fmmmmmmmmmmmmmmmf
f5555555555555554555444545444444454454444444f4f94444994444mm4mmmm555555555mm5mmmmf11f111f44444f1111f1144429922fmmmmmmmmmmmmmmmmf
f5555555555555545454444444424244544544444444424499999444444fmmmmmmm5555555mm5mmmmmf2f111f44444f1111f44144422211fmmmmmmmmmmmmmmmf
f55555555555545555f44444544444244454444444444244444444444444mmmm4mm5555555mm5mmmmmf4211f4444444f11f24444422222211fmmmmmmmmmmmmmf
f555555555555555555f4445444444454942444444444244444444444444m4mmmmm5555555mm5mmmmmf442244422444444444444222111212fmmmmmmmmmmmmmf
f555555555555945555454444444444544442444444424444444444444444f4mm4m5555555mm5mmmmmf4444442222444444442422212229911fmmmmmmmmmmmmf
f5555555555454554545454444444445444444444422444444444444444444m4mm45555555mm555mmmf44444222224442424242222112221122fmmmmmmmmmmmf
f5555555555545455454554f444444549444442444444444444444444444444f4mm5555555mm555f111424241111114442424222211112991211fmmmmmmmmmmf
f555555555955555454554545f59454444444442444444444444444444444444fm45555555mf44444411424444444444442422222111121111121fmmmmmmmmmf
f55555555455555554595455545595f4444444424444444444444444444444444fm5555555f777774441144444444444444242222111221121111fmmmmmmmmmf
f554554955555455455545455555555fff44442444444444444444444444444444ffff44444444449444144442111124444442222219211211121fmmmmmmmmmf
f5555555555555555545555595555555f544444444444444444444444444444444411444444444444744444421ffff12444422222111112111211fmmmmmmmmmf
f55555555455555555554555555559944994444444444444454444444444444444441144444444444944444411111111144422221129221111111fmmmmmmmmmf
f5555555555555545555545555f444494499454444444444445444m4444444444444414444444444447441444111111111442222129s922121111fmmmmmmmmmf
f55555555555555559454545f4444494949944444444224424444444444442222244441444444444449444444411111444422221229992d21111fmmmmmmmmmmf
f55555555555554554555f44444544449499424444544444454444444442244444244414444444444494441444222224444222122292922dd11fmmmmmmmmmmmf
f5555555555555555554f454545444444495544m45545454544444444424444444442441444444444449441s44444444442212222222o22d11fmmmmmmmmmmmmf
f5555555555454955555f495444477777776544m54454545454444444244444244442441444444444449444s214444444221222222222222dd1fmmmmmmmmmmmf
fmm555555555555554554544447767776666665m5f5454555454444424444442244442414444444444494441ss444444211222222229o222sddfmmmmmmmmmmmf
f55mmmm455955555594555f47776677666666666555f4545444444442444442224444241444444444494441ssss222111222222222222222sddfmmmmmmmmmmmf
f555555mmmm455555549555777767776666dd6666655ff44m45544442494442244444241444444444494441sssm42222222222222229o222sdd1fmmmmmmmmmmf
f95459554554mm94555557777766776666d66dd66666m5f5f5545f44244m442244444241444444444494411ssss44222222222222229o222sdd1fmmmmmmmmmmf
f555544555555545mmmm7767776777666666666dd6666655554545f442m4m2444444244144444444994441ssssm44422222222222929o222sdd1fmmmmmmmmmmf
f5555555455455555577767776777766666666666dd666665555554f444544444442441444444444944411ssssss4444222222242s42o222sdd1fmmmmmmmmmmf
f555455555555555577677776777776666dddddd666dd66666555454m9m422222224414444444994444111sssssm444444224444944mo222sddfmmmmmmmmmmmf
f5555555555555557777777767777666dd66666dd6666dd666665595mmfm444444f4f1f5fff9444411111ssssssss4444444444444do2222sd1fmmmmmmmmmmmf
f55555555555555576777776777776666d666666d666666dd66666555mmffffffff5555555mfs11111111ssssssssm44444444444m9o22221dfmmmmmmmmmmmmf
f55555555555555776777667777776666dd666666d666666ddd666665mmmmm5mmmm5555555mfs1111111sssssssssss444444444mddo2222d1fmmmmmmmmmmmmf
f55555555555555776677766777766666d6dd6666d666666d66dd66666mmmmm5mmm5555555mfs111111ssssssssssssms444444md9o2222dddfmmmmmmmmmmmmf
f5555555555555776776677777776666666d6ddd6d66666d66666dd66666mmm5mmm5555555mmfs1111sssssssssssssssmsmsmssd9o22222dfmmmmmmmmmmmmmf
f555555555555577767777677777666d66666d6ddd66666d6666666dd66666mm5mm5555555mm5fssssssssssssssssssssssssssd9o2222ddfmmmmmmmmmmmmmf
f555555555555577676667777777666d6666666d6d6666d6666666666dd6666mm5m5555555mm55fddsssssssssssssssssssssssdo2222dddfmmmmmmmmmmmmmf
f55555555555577676666676777666d66d66666666666ddd666dddddd66dd66mm555555555mm5mf9dssssssssssssssssssssssd9o222ddd2fmmmmmmmmmmmmmf
f55555555555577676666676777666d6666666666666dddd6dd666dddd66666mmm5555555mmmfoo9ddsssssssssssssssssssssd9o222dd2f55mmmmmmmmmmmmf
f55555555555576766666676777666d666d666666666666d66d66ddddd66666mmm55555555foooo99ddsssssssssssssssssssd9o2222222f555mmmmmmmmmmmf
f55555555555767766666767777666d666d666666666666666666dddddd66666mmm55555foooooo999ddsssssssssssssssssd9o224242224f555mmmmmmmmmmf
f5555555555577676666676777666d6666d66666666d6d6d666d6dddddd66666mmmm555foooooooo99dddsssssssssssssssd9o22222222224f5555mmmmmmmmf
f5555555555577766666676777666d666d6666666dddddd6d66666ddd6d66666mmmmm5foooo9oooo999ddddssssssssssssd9o222424222224f55555mmmmmmmf
f5555555555776766666676777666d66d666666dd666dddd6d66d6666dd66665mmmmmfoo9ooooo9oo999ddddddssssssssd9o222222f222222f555555mmmmmmf
f555555555577766666677777766d6d66666666d666dddddd66666d6d66666655mmmmfooooooooooo49999ddddddddddddoo222424f5f2222f22f555555mmmmf
f555555555576766666676777666d66666666666d66dddd6dd6666666666666555mmmfoooo999999oo499999dddddd9ooo2222222f55f222f222f5555555mmmf
f5555555557767666667677776666666666666666dddddd6d666666666d6666555mmfooo9944444499o4499999999oo222222424f555555f22222f55555555mf
f555555555776676667777777666666d6dd66666666ddd66dd66666d66d66655555mfoo4444444444499444oooooo2422222222f5555555f22222f555555555f
f5555555557776667777767766666d66666dd6666666ddddd6666d666d666655555f9oo4444444444449994422222224422224f555555555f2422f555555555f
f5555555577777777766677766666dddddd66d666666666666666d666d666655555foo444444444444449999444444422222f55555555555f4422f555555555f
f55555555776777776767777666dd666dddd6d666ddd666666666d666d66665555foo444444444444444999992222222422f555555555555f244f5555555555f
f5555555577766677776777766666dd6dddd666666dddd6666666d666d6665555foo42444444444444444994444444442222f555555555555f44f5555555555f
f555555577767777777677766666666dddddd66666ddd666666666d6d66665555fo422444444444444444922244444442222f555555555555f444f555555555f
f555555577767777777767766666666666d6d66666d6666666666666d66665555f4422444444444444444922222444222222fm55555555555f444f555555555f
f55mmmm5776777777777677666d66666666dd66666d6666666666666d66665555f4222444444444444444222222222222222fmm55555555555f44f555555555f
f555555577677777777767766666d6666666d66666d66666666dd66666665555f422224444444444444442222222222222222fm55555555555f444f55555555f
f5555557767777777766677666dd66d66666666666d666666d6666d666665555f422222444444444444449222222222222222fmm5555555555f944f55555555f
f555555776777776667777776666dd66d66666666d66666d6666666d66665555f4222224444444444444422222222222222222fmm5555555555f94f55555555f
f5555557677776677777ddd7666666dd66d666666d6666dddddd6666d6665555f4222224444444444444122222222222222222fmmm5m5555555f944f5555555f
f55555577776677777ddddddd6666666dd66d6666d66666d6ddddd66d66555555f4222244444444444441122222222222222222fmmm55m555555f94444f5555f
f55555577667777dddddddddddd6666666dd66d6d6666666d6ddddd666655555555f222244444444444411424242222222222222fmm5555m5555f9444444f55f
f555555777777dddddddddddddddd6666666dd66d66666666dddddddd66555555555f22244444242444411122222222222222222fmmm55555m55fl9944444f5f
f5555555777dddddddddddddddddddd6666666dd66d66666666dd66d666555555555555f244424242441111424222222222222222fmmm555555m5flf94444f5f
f5555555dddddddddddddddddddddddddd666666dd66d66666666ddd66mmm55555555555f44242424211111142222222222222222f5mmm5555555m55f9444f5f
f5555555dddddddddddddddddddddddddddd666666dd66d6666666666655555mmmmm55555f24242421f1111114224242222222242f55mmm55555555mf9444f5f
f555555555dddddddddddddddddddddddddddd666666dd66d66666666655555555555mmmf12222221ff1111111222222222222224f55mmmm55555555f9444f5f
f555555555555ddddddddddddddddddddddddddd666666dd66d666666655555555555555f4211112fmf1111111114224242222222f555mmm55555555f9444f5f
f55555555555555ddddddddddddddddddddddddddd666666dd66d666655555555555555fo4222222fmf11111111ff422222222424f5555mmmf9f555f94444f5f
f55555555555555555dddddddddddddddddddddddddd666666dd6666655555555555555fo4422224fmf12111112ff244422242222f55555mmf99ff994444f55f
f5555555555555555555ddddddddddddddddddddddddddd666666666555555555555555fo4442244ff2112221f555f24224222422f555555mmf9999444f5555f
f5555555555555555555555dddddddddddddddddddddddddd6666655555555555555555fo4444444ff2111111f5555f222422422f55555555mmm55555555555f
f555555555555555555555555dddddddddddddddddddddddddddd555555555555555555fo9444449ff211121f555555m55f42222f55555555mmm55555555555f
f55555555555555555555555555dddddddddddddddddddddddd55555555555555555555fo4944449ff2212fm55555555m55f444f5555555555mmm5555555555f
f55555555555555555555555555555ddddddddddddddddddd55555555555555555555555fo499494ff2222fmm55555555m55555555555555555mmm555555555f
f55555555555555555555555555555555dddddddddddd555555555555555555555555555fo444944ff222fmmmm5555555m555555555555555555mmm55555555f
f5555555555555577777777777777777777777777777771111111111111111111oooooooooooooooooooooooooooooooooooooooooooooooo5555mmm5555555f
f5555555555555777ooooooooooooooooooooooooooooo17777777777777777717777777777777777777777777777777777777777777777ooo555mmmm555555f
f555555555555777o77777oo777777o7777777777777o177oooo777777ooo77717oooooooooo77777oooooooooooooooo7ooooooooooooo7ooo555mmm555555f
f55555555555777o77777oo7777777o7777777777777o17ooooo777777oooo7717oooooooooooo777oooooooooooooooo7oooooooooooooo7ooo555mmm55555f
f5555555555777o77777ooo777777o7777777777777o177oooo9777779oooo7717ooooooooooooo777oooooooooooooooo7oooooo777777777ooo555mmm5555f
f555555555777o77777777777777o77777oooooooooo1777799997799997777717oooo777ooooooo7777777ooooooo777777oooooooooooooo7ooo555mmm555f
f55555555777o777777777777777o7777777777ooooo17777799oooo9977777717ooooo7777oooooo777777oooooooo77777ooooooooooooooo7ooo55mmmm55f
f5555555777o777777777777777o7777777777ooooo17777777ooooo7777777717ooooo77777oooooo777777oooooooo77777ooooooooooooooo7ooo55mmmm5f
f555555777o777777777777777o77777ooooooooooo17777779ooooo9777777717ooooo77777oooooo7777777oooooooo77777oooooo7777777777ooo55mmm5f
f55555777o77777oooo777777o77777ooooooooooo177777999977999997777717ooooooooooooooooo7ooooooooooooooooo7oooooooooooooooo7ooo55mmmf
f5555777o77777oooo7777777o777777777777777o17ooooo99777799ooooo7717ooooooooooooooooo7oooooooooooooooooo7oooooooooooooooo7ooo55mmf
f555777o77777oooo7777777o777777777777777717oooooo77777779ooooo7717oooooooooooooooooo7oooooooooooooooooo7oooooooooooooooo7ooo5mmf
f55777o77777ooooo777777o7777777777777777o17oooooo77777777ooooo7717oooooooooooooooooo7ooooooooooooooooooo7oooooooooooooooo7ooo5mf
f5777o77777ooooo7777777o7777777777777777o177oooo777777777oooo77717oooooooooooooooooo7oooooooooooooooooooo7oooooooooooooooo7ooo5f
f777o77777ooooo7777777o7777777777777777o17777777777777777777777717ooooooooooooooooo777ooooooooooooooooooo7ooooooooooooooooo7ooof
f77ooooooooooooooooooooooooooooooooooooo1777777777777777777777771777777777777777777777777777777777777777777777777777777777777oof
f7777777777777777777777777777777777777717766666666666666666666771oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooof
f7777777777777777777777777777777777777717666666666666666666666671oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooof
f222222222222222222222222222222222222221666666666666666666666666122222222222222222222222222222222222222222222222222222222222222f
f222222222222222222222222222222222222221666666666666666666666666122222222222222222222222222222222222222222222222222222222222222f
f222222222222222222222222222222222222221666666666666666666666666122222222222222222222222222222222222222222222222222222222222222f
f522222222222222222222222222222222222222166661111666666666666666122222222222222222222222222222222222222222222222222222222222225f
f52222222222222222222222222222222222222216661111166666666666666612222222222222222222222222222222222222222222222222222222222222ff
fff22222222222222222222222222222222222221666111166666666666666661222222222222222222222222222222222222222222222222222222222222fff
fff22222222222222222222222222222222222221666666666666666666666661222222222222222222222222222222222222222222222222222222222222fff
ffff222222222222222222222222222222222222166666666666666666666666122222222222222222222222222222222222222222222222222222222222ffff
ffff22222222222222222222222222222222222216666666666666666111166612222222222222222222222222222222222222222222222222222222ff22ffff
fffff22222222222222222222222222222222222f16666666666666611111666122222222222222222222222222222222222222222222222222222ffffffffff
fffff2222ffffff2222222222222222222222ffff1666666666666661111666612222222222222222222222222222222222222222222222222222fffffffffff
fffffffffffffffff222222222222f222222fffff166666666666666666666661ffff22222222222222f22222222222222222222222222222222ffffffffffff
fffffffffffffffffff222222222fffff2fffffff16666666666666666666666ffffffffff22222ffffffffff22222222222222222222ff2ffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
__meta:title__
bn2
by morganquirk
