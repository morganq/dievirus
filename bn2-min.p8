pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function tp(n,e)return{n*16-16,e*13+19}end function gp(n,e)return{mid(n\16+1,1,8),mid((e-27)\13+1,1,4)}end function addfields(n,e,o)for e in all(split(e))do local e,o=unpack(split(e,"="))if o=="false"then n[e]=false elseif o=="true"then n[e]=true else n[e]=o end end for e,o in pairs(o)do n[e]=o end end function sfn(n)for n in all(split(n,"\n"))do if(#n>3)local n=split(n)local e=n[1]deli(n,1)_ENV[e](unpack(n))
end end function smlu(e,o)local n={}for e in all(split(e,"\n"))do if#e>3then local e=split(e,",")if(o)add(n,e)else n[e[1]]=e
end end return n end function nl_print(e,o,n,t)for e in all(split(e,"%"))do print(e,o,n,t)n+=8end end function temp_camera(o,t,l)local n,e=peek2(24360),peek2(24362)camera(n+o,e+t)l()camera(n,e)end function palreset()pal()palt(2)end function get_bit(n,e)return n&32768>>>e~=0end function ssfx(n)sfx(n,0)end function sandify(t,l,e,d,i,o,r)for n=0,e do local a=n/e-.5for e=0,d do local t=sget(t+n,l+e)if(t~=(r or 14))make_creature_particle(i+n,o+e,t,a/2,o+6+rnd(4))
end end end FADE_PALS_1=smlu([[129,2  ,141,4  ,134,6  ,7  ,136,9  ,10 ,142,139,13 ,14 ,15 ,0
0. ,129,129,2  ,141,134,6  ,2. ,2  ,9  ,9. ,141,134,0  ,15 ,0
0. ,0  ,129,129,141,134,6. ,2. ,2  ,9  ,9. ,141,134,0  ,134,0
0. ,0  ,0. ,0  ,0. ,141,134,2. ,0  ,0  ,0. ,141,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,141,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,0  ,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,0  ,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
]],true)function scrnt(n,...)nongrid={}sandify(...)poke(24404,0)for o=0,170,4do n(true)local e={}for n=max(#nongrid-1000,1),#nongrid do local n=nongrid[n]n.update()n.draw()add(e,n)end nongrid=e pal(FADE_PALS_1[mid(o\5-25,1,6)],1)flip()end end function draw_pips(n,e,o,t)local l=n\5local d,n=n-l*5,0for l=1,l do rectfill(e,o-n-2,e+2,o-n,t)n+=4end for l=1,d do rectfill(e,o-n,e+2,o-n,t)n+=2end end function draw_mods(n,o,t)for e=1,#n do spr(all_mods[n[e]][2],o,t+e*6-6)end end shield_time=300max_hp=4monster_palettes={split"1,2,3,1,5,6,7,3,5,6 ,14,12,13,14,15",split"1,2,3,0,5,6,7,9,1,5,10,12,13,14,15",split"1,2,3,4,5,6,7,8,12,10,11,12,13,14,15",split"1,2,3,4,5,6,7,8,8,10,11,12,13,14,15"}gridpatterns=split"64,66,68,64,64,66,68,64,70,72,66,74,70,72,66,74,74,66,72,70,74,66,72,70,64,72,66,64,64,72,66,64"all_abilities=smlu[[slap,104,attack,    0/0b0000010000000000.0000000000000000/0/0/0/0,0
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
]]all_mods=smlu[[growth,120,3,+1 each use in%battle (max = 5)
pierce,121,2,ignores shields
claim,122,8,claim up to 2%of the tiles hit
pause,123,4,time stands still%for a moment longer
invasion,124,2,+1 if standing%in enemy tile
rage,125,2,+2 if less than%half health
poison,126,2,deals poison damage%instead of normal
stun,127,2,stuns the enemy%for a moment
]]local e,o=smlu[[harpy1,38,0,wave;1,4,60,flies=1,move_pattern=xx_,abil_pattern=__x
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
]],smlu([[harpy1
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
]],true)function draw_die2d(d,i,r,o,e)local t=true if(o and e.kind~="hp")t=tf\14%2==0
local l=split"0,15,15,15,30,15,45,15,15,0,15,30"for n=1,6do temp_camera(-l[n*2-1]-i,-l[n*2]-r,function()if(e and not t and e.faces[n])sfn[[rectfill,-2,-1,11,10,12
rectfill,-1,-2,10,11,12
]]o[n].draw_face(0,0,n)else d[n].draw_face(0,0,n)
end)end end function make_nongrid(n,e)local n={pos={n,e}}add(nongrid,n)return n end function valid_move_target(n,e,o,t)if(n<1or n>8or e<1or e>4)return false
local n=grid[e][n]if(n.creature)return false
if(t and n.space.side~=o)return false
return true end function add_go_to_grid(n)local e=grid[n.pos[2]][n.pos[1]]if#e==0then add(e,n)else local o=1while(true)if o>#e then add(e,n)break elseif n.layer<=e[o].layer then add(e,n,o)break end o+=1
end end function make_gridobj(n,e,o,t)local n={pos={n,e},layer=o or 10,spri=t}add_go_to_grid(n)n.move=function(e,o)del(grid[n.pos[2]][n.pos[1]],n)n.pos={e,o}add_go_to_grid(n)end n.draw=function()local e=tp(n.pos[1],n.pos[2])spr(n.spri,e[1],e[2],2,2)end return n end function find_open_square_for(o,e,t,l)local n,n=grid[t][e],1if(o~=1)n=-1
local n=l or{{0,0},{-n,0},{-n,-1},{-n,1},{0,-1},{0,1},{n,0},{n,-1},{n,1}}for n in all(n)do local n,e=e+n[1],t+n[2]if n>=1and n<=8and e>=1and e<=4then local t=grid[e][n]if(t.space.side==o and t.creature==nil)return{n,e}
end end return nil end function push_to_open_square(n)local e=find_open_square_for(n.side,n.pos[1],n.pos[2])if e then n.move(e[1],e[2])else local e=n.pos[1]-n.side if(e>=1and e<=8)n.move(e,n.pos[2])
end end function make_damage_spot(n,l,t,d,e,o)local n=make_gridobj(n,l,1)addfields(n,"decay=0",{side=d,damage=t,countdown_max=e or 0,countdown=e or 0,abil=o})n.update=function()if(victory or defeat)return
local e=grid[n.pos[2]][n.pos[1]]if n.countdown>0then n.countdown-=1elseif n.countdown==0then if e.creature and e.creature.side~=n.side and e.creature.iframes<=0then if(has_mod(n.abil,"stun"))e.creature.stun_time=90
if(has_mod(n.abil,"poison"))e.creature.poison_timer=60*n.damage else e.creature.take_damage(n.damage,has_mod(n.abil,"pierce"))
if(e.creature==pl)pl.iframes=15
end local t=count(o.mods,"claim")*2if(e.space.side~=n.side and o.tiles_claimed<t)e.space.flip(n.side,240)o.tiles_claimed+=1
e.space.bounce_timer=13n.countdown-=1ssfx(n.side==1and 8or 9)else n.decay+=1if(n.decay>8)del(e,n)
end end n.draw=function()local e,o=tp(n.pos[1],n.pos[2]),grid[n.pos[2]][n.pos[1]]e[2]+=o.space.offset_y local o=9if(n.side~=1)o=8
if(has_mod(n.abil,"poison"))o=12
if n.countdown>0then local n=1-n.countdown/n.countdown_max local d,i,n,e,t,l=6*n+2,4*n+2,e[1]+1,e[2]+1,e[1]+14,e[2]+11line(n,e,n+d,e,o)line(n,e,n,e+i,o)line(n,l,n+d,l,o)line(n,l,n,l-i,o)line(t,e,t-d,e,o)line(t,e,t,e+i,o)line(t,l,t-d,l,o)line(t,l,t,l-i,o)else if(n.decay<5)rectfill(e[1]+1,e[2]+1,e[1]+14,e[2]+11,o)
end if t>2then fillp(56190.5)if(t>6)fillp(23130.5)
rectfill(e[1]+2,e[2]+2,e[1]+13,e[2]+10,0)fillp()end end end function make_gridspace(e,o)local t=1if(e>4)t=-1
local n=make_gridobj(e,o,0,spri)n.side=t n.main_side=t n.bounce_timer=15+e+o n.offset_y=0n.update=function()end n.draw=function()n.offset_y=-(cos(n.bounce_timer/10)-.5)*(n.bounce_timer/5)n.bounce_timer=max(n.bounce_timer-1,0)local t=tp(n.pos[1],n.pos[2])t[2]+=n.offset_y local e=gridpatterns[e-1+(o-1)*8+1]if(n.side==-1)pal(split"0,2,3,4,5,3,13,8,9,10,11,12,1,14,15,0")else palreset()
spr(e,t[1],t[2],2,2)end grid[n.pos[2]][n.pos[1]].space=n n.flip=function(e,o)if(e==n.side)return
if(e==n.main_side)n.side=n.main_side return
n.main_side=n.side n.side=e end return n end function parse_ability(n)local n=split(n,";")local e=all_abilities[n[1]]return make_ability(e,n[2],{n[3]})end function has_mod(n,e)return count(n.mods,e)>0end function make_ability(n,e,o)local n={base=n,name=n[1],image=n[2],type=n[3],def=n[4],rarity=n[6],pips=e}n.mods={}n.original_pips=e for e in all(o)do add(n.mods,e)end n.copy=function()return make_ability(n.base,n.original_pips,n.mods)end n.get_pips=function()if(pl and has_mod(n,"invasion")and grid[pl.pos[2]][pl.pos[1]].space.side==-1)return n.pips+1
if(pl and has_mod(n,"rage")and pl.health<=pl.max_health/2)return n.pips+1
return n.pips end n.draw_face=function(e,o,l)local t=n.name=="curse"and 8or 7rectfill(e,o-1,e+9,o+10,t)rectfill(e-1,o,e+10,o+9,t)spr(n.image,e+1,o+1,1,1)draw_mods(n.mods,e,o)draw_pips(n.get_pips(),e+7,o+9,12)if(l==4)spr(141,e-2,o+4)
end n.use=function(e,o,t,l)if(n.base=="none")return
n.tiles_claimed=0_ENV["abil_"..n.type](e,n.get_pips(),n,o,t,l)if(has_mod(n,"growth")and n.pips<5)n.pips+=1n.original_pips+=1
if(has_mod(n,"fast"))pl.die_speed=3
end return n end function abil_grid_spaces(t,l,d,i)local o={}for n=0,7do for e=0,3do if get_bit(t,n*4+e%4)then local n,e=l+n*i,d+e-1if(n>=1and n<=8and e>=1and e<=4)add(o,{n,e})
end end end return o end function abil_shield(n,e,o,t,l,i)local d=e n.shield=max(n.shield,d)n.shield_timer=shield_time local d=tp(t,l)if(n==pl)ssfx(15)
make_effect_simple(d[1]+4,d[2]-14,0,136)add(attack_runners,make_attack_runner(o.def,e,o,t,l,i))end function abil_attack(d,e,n,o,t,l)add(attack_runners,make_attack_runner(n.def,e,n,o,t,l))end function abil_curse()local n=0for e=1,50do local e=grid[rnd(4)\1+1][rnd(8)\1+1]if e.space.side==1then e.space.side=-1n+=1if(n>=1)return
end end ssfx(19)end function make_turret(n,e,o,t,l)local n=make_creature(e,o,l,n,12)local e=n.update n.rate=80n.time=0n.update=function()e()n.time+=1if(n.time%n.rate==n.rate\2)t.use(n,n.pos[1],n.pos[2],n.side)
if(n.time>=450)n.kill()
end return n end function abil_turret(n,o,t,l,d,e)local n,t=e,make_ability(all_abilities[t.def],o,t.mods)local n=find_open_square_for(e,l,d,{{n,0},{-n,0},{0,-1},{0,1},{n,-1},{n,1},{-n,-1},{-n,1}})if(n)local n=make_turret(o,n[1],n[2],t,e)
end function make_attack_runner(n,d,i,r,a,o,l)local n,e=split(n,";"),{}for n in all(n)do local n=split(n,"/")add(e,{delay=n[1],grid=n[2],xv=n[3]*o,yv=n[4],collides=n[5]==1,telegraph=n[6],max_tiles=n[7]or 8,bounces_x=n[8]==1,bounces_y=n[9]==1,absolute_x=n[10]==1,absolute_y=n[11]==1,alive=true})end local n=0function update(f)local t=false function damage_and_stop(n,e,t)if(l)add(s.fake_hit,{e,t})else make_damage_spot(e,t,d,o,n.telegraph,i)
if n.collides then local e=grid[t][e].creature if(e and e.side~=o)n.alive=false
end end for e in all(e)do local l=e.xv==0and e.yv==0if e.virtual_objs and e.alive then for n in all(e.virtual_objs)do if e.xv~=0or e.yv~=0then n.timers={n.timers[1]-1,n.timers[2]-1}local o=false if n.xv~=0and n.timers[1]<=0then if n.pos[1]<=1and n.xv<0or n.pos[1]>=8and n.xv>0then if(e.bounces_x)n.xv=-n.xv else n.off_grid=true
end n.pos[1]+=sgn(n.xv)o=true n.timers[1]=30/abs(n.xv)-1end if n.yv~=0and n.timers[2]<=0then if n.pos[2]<=1and n.yv<0or n.pos[2]>=4and n.yv>0then if(e.bounces_y)n.yv=-n.yv else n.off_grid=true
end n.pos[2]+=sgn(n.yv)o=true n.timers[2]=30/abs(n.yv)-1end if(o and not n.off_grid)damage_and_stop(e,n.pos[1],n.pos[2])n.max_tiles-=1
if(not n.off_grid and n.max_tiles>0)t=true
end end end if not e.virtual_objs then if n>=e.delay then e.virtual_objs={}local n=o*-3.5+4.5for n in all(abil_grid_spaces(e.grid,e.absolute_x and n or r,e.absolute_y and 2or a,o))do if(not l)local o={e.xv==0and 0or 30/abs(e.xv),e.yv==0and 0or 30/abs(e.yv)}add(e.virtual_objs,{pos=n,timers=o,max_tiles=e.max_tiles,xv=e.xv,yv=e.yv,off_grid=false})t=true
damage_and_stop(e,n[1],n[2])end else t=true end end end if(not t)f.alive=false
n+=1end s={update=update,alive=true,fake_hit={}}if l then local n=0while(s.alive)n+=1s:update()
else s:update()end return s end function make_effect_simple(n,l,c,d,e,o,t,i,r,a,f)e=e or 0o=o or-.2t=t or 30local n,l=make_nongrid(n,l),0n.draw=function()palreset()fillp(i)spr(d,n.pos[1],n.pos[2],r or 1,a or 1,f)fillp()end n.update=function()n.pos[1]+=e n.pos[2]+=o l+=1if(l>t)del(nongrid,n)
end return n end function make_creature_particle(n,e,o,d,t)local n,e,l=make_nongrid(n,e),-50+rnd(2),(rnd()-.5)*1.8addfields(n,"",{color=o,yv=l,xv=d+(.5-rnd())*.25})n.draw=function()pset(n.pos[1],n.pos[2],o)end n.update=function()e+=1if(rnd()<.04or e>=0)o=rnd{15,15,5}
if e<l*10-30then n.yv+=.1else n.yv+=.02n.yv*=.5if(n.xv>-3)n.xv+=-rnd()*.25
end if n.pos[2]>t then n.yv=n.yv*-.15if(n.yv>-.1)n.yv=0n.y=t
end n.pos={n.pos[1]+n.xv,n.pos[2]+n.yv}if(e>32and rnd()<.1)del(nongrid,n)
end return n end creature_index=1function make_creature(n,l,e,o,t)local n=make_gridobj(n,l,10,t)addfields(n,"movetime=0,yo=-7,damage_time=0,shield=0,shield_timer=0,stun_time=0,stun_co=1,alive=true,overextended_timer=0,poison_timer=0,iframes=0",{lastpos={0,0},side=e,dir=e,health=o,max_health=o,index=creature_index})n.clay_time=t>=40and 45or 15creature_index+=1n.draw=function()local e,o,t,l=tp(n.pos[1],n.pos[2]),n.spri,0,grid[n.pos[2]][n.pos[1]].space function ds(d,i)local r=n.side*-sin(n.overextended_timer/60)*3spr(o,e[1]+t+d+r,e[2]+n.yo+i+l.offset_y,2,2,n.side==-1)end if(n.clay_time>0)if o<12then pal(split"2,2,2,2,2,2,1,1,1,1,1,1,1,1,15,1")clip(0,e[2]+n.yo+max((n.clay_time-10)*4,-4),128,22)ds(n.clay_time\5,0)ds(-n.clay_time\6,0)ds(0,n.clay_time\7)ds(0,-n.clay_time\8)ds(0,0)clip()palreset()elseif o<40then ds(0,0)else ds(n.clay_time*n.clay_time*.125,n.clay_time*n.clay_time*-.25)end n.clay_time-=1return
if(n.movetime>0)fillp(21845.75)
if(n.damage_time>0)pal(split"7,7,7,7,7,7,7,7,7,7,7,7,7,7,7")t=-n.damage_time*n.dir
if(n.poison_timer>0)pal(split"1,2,3,12,12,6,7,12,9,10,12,12,13,14,15,0")
if(n.iframes%2==0)ds(0,0)
fillp()palreset()if(n.stun_time>0)spr(143+tf\10%2,e[1]+3,e[2]-6)
end n.update=function()local e=grid[n.pos[2]][n.pos[1]].space if(n.iframes>0)n.iframes-=1
if e.side~=n.side then n.overextended_timer+=1if(n.overextended_timer>=30)n.overextended_timer=0push_to_open_square(n)
else n.overextended_timer=0end n.poison_timer=max(n.poison_timer-1,0)n.damage_time-=1n.movetime-=1n.shield_timer-=1if(n.shield_timer<=0)n.shield=0
n.stun_time-=1end local l=n.move n.move=function(e,o)if(not n.alive)return
local t=tp(n.pos[1],n.pos[2])if(n.clay_time<=0)make_effect_simple(t[1],t[2]+n.yo,nil,n.spri,0,-1,3,43690.75,2,2,n.side==-1)ssfx(n==pl and 14or-1)n.movetime=3
grid[n.pos[2]][n.pos[1]].creature=nil n.lastpos={n.pos[1],n.pos[2]}l(e,o)grid[o][e].creature=n if(n.poison_timer>0)n.take_damage(1)local n=tp(e,o)
end n.take_damage=function(e,o)if o then n.health-=e else if(e>=n.shield)local e=e-n.shield n.shield=0n.shield_timer=0n.health-=e else n.shield-=e
end n.damage_time=5local e=tp(n.pos[1],n.pos[2])sfx(n==pl and 11or 10,1)if(n.health<=0)n.kill()sfx(n==pl and 13or 12,1)
end n.kill=function()n.alive=false local o,t,e=n.spri%16*8,n.spri\16*8,tp(n.pos[1],n.pos[2])sandify(o,t,15,15,e[1],e[2]+n.yo)grid[n.pos[2]][n.pos[1]].creature=nil del(grid[n.pos[2]][n.pos[1]],n)end grid[n.pos[2]][n.pos[1]].creature=n return n end pl=nil function make_player()local n=make_creature(1,2,1,max_hp,player_sprite)addfields(n,"die_speed=1",{max_health=n.health,die={}})return n end function make_monster(d,i,n,t,r,a,o,e)local l=false if(grid[t][n].creature)l=true
local n=make_creature(n,t,-1,a,d)n.palette=monster_palettes[i]n.abilities=r n.speed=o n.abil_timer=o\2n.move_timer=o n.next_ability=rnd(n.abilities)addfields(n,"time=0",e or{})if(e.move_pattern)n.move_pattern={}for o=1,#e.move_pattern do add(n.move_pattern,e.move_pattern[o]=="x")end n.move_pattern_i=1
if(e.abil_pattern)n.abil_pattern={}for o=1,#e.abil_pattern do add(n.abil_pattern,e.abil_pattern[o]=="x")end n.abil_pattern_i=1
local e=n.update n.update=function()e()if(n.stun_time>0)return
n.time+=1if(n.overextended_timer<=0)n.move_timer-=1
if n.move_timer<=0then local e=true if n.move_pattern then if(not n.move_pattern[n.move_pattern_i])e=false
n.move_pattern_i=n.move_pattern_i%#n.move_pattern+1end if e then local e=nil if(n.favor_col and rnd()<.45)e=n.favor_col
if n.flies then local e,o=e or flr(rnd(4))+5,flr(rnd(4))+1if(valid_move_target(e,o,n.side,true))n.move(e,o)
else local t={{-1,0},{1,0},{0,-1},{0,1}}for o=1,4do local o=rnd(t)del(t,o)local t,l=nil,nil if(e)t=mid(e-n.pos[1],-1,1)
local e,o=(t or o[1])+n.pos[1],(l or o[2])+n.pos[2]if(valid_move_target(e,o,n.side))n.move(e,o)break
end end end n.move_timer=n.speed end n.abil_timer-=1if n.abil_timer<=0then local e=true if n.abil_pattern then if(not n.abil_pattern[n.abil_pattern_i])e=false
n.abil_pattern_i=n.abil_pattern_i%#n.abil_pattern+1end if(e)n.next_ability.use(n,n.pos[1],n.pos[2],n.side)n.animate_time=5n.next_ability=rnd(n.abilities)
n.abil_timer=n.speed end if(n.abil_pattern and n.abil_timer==8and n.abil_pattern[n.abil_pattern_i])ssfx(18)
if(n.move_pattern and n.move_pattern==8and n.move_pattern[n.move_pattern_i])ssfx(17)
end local e=n.draw n.draw=function()palreset()if(n.palette~=nil)pal(n.palette)e()palreset()else e()
if(n.clay_time>0)return
local o=tp(n.pos[1],n.pos[2])local e,o=o[1]+3,o[2]+10line(e,o,e+9,o,1)line(e,o,e+9*(n.health/n.max_health),o,9)if(n.shield>0)line(e,o,e+9*min(n.shield/6,1),o,7)
palreset()if(n.abil_pattern and n.abil_timer==9and n.abil_pattern[n.abil_pattern_i])make_effect_simple(e+2,o-18,nil,134,0,-.25,12)
if(n.move_pattern and n.move_timer==9and n.move_pattern[n.move_pattern_i])make_effect_simple(e+2,o-18,nil,n.flies and 135or 156,0,-.25,12)
end if(l)push_to_open_square(n)
return n end function parse_monster(n,t,l)local o,e=split(n[4],"/"),{}for n in all(o)do add(e,parse_ability(n))end local o={}for e=7,#n do local n=split(n[e],"=")o[n[1]]=n[2]end return make_monster(n[2],n[3],t,l,e,n[5],n[6],o)end titlef=0function update_title()titlef+=1player_abilities={}state="newgame"end function draw_title()cls()print("die virus",46,32,7)spr(13,55+rnd()*sin(titlef/100)*2,56+rnd()*sin(titlef/100)*2,2,2)print("❎ to start",42,88)end tf=0function make_die(e)local n,o={},split(e,"/")for e=1,6do n[e]=parse_ability(o[e])end return n end classes=smlu[[1,king,0,0,sling;1/sling;1/spear;1/spear;1/shield;1/sword;2
2,queen,2,0,sword;2/shield;1/spear;1/slap;1/scythe;1;claim/scythe;2
3,priestess,4,0,wave;1/wave;1/wall;0;stun/sword;1/bomb;2/shield;1
4,engineer,6,1,turret;1/splash;1/cane;1/turret;1/rock;1/shield;1
5,farmer,8,1,slap;1/shield;1/rock;0;growth/scythe;1/spear;1/sy.turret;1;claim
6,apothecary,10,2,bomb;1;poison/slap;2;poison/sword;1/bomb;1/cane;1/sling;1
]]selected_class_index=1function update_newgame()if(btnp(2))selected_class_index=(selected_class_index-2)%#classes+1ssfx(14)
if(btnp(3))selected_class_index=selected_class_index%#classes+1ssfx(14)
local n=classes[selected_class_index]if btnp(5)and dget(0)>=n[4]then ssfx(12)scrnt(draw_newgame,n[3]\8,0,16,16,92,60)player_abilities=make_die(n[5])debug_start_level=1for n=1,debug_start_level-1do level=n for n=1,6do player_abilities[n]=player_abilities[n].copy()end current_upgrades=nil tf=0update_upgrade()draw_upgrade()player_abilities=applied if(current_upgrades[selected_upgrade_index].kind=="hp")max_hp+=1
end reset()state="gameplay"player_sprite=n[3]tf=0start_level()end end function draw_newgame(o)cls(5)sfn[[rectfill,0,0,128,128,7
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
]]local n,e=classes[selected_class_index],1if(dget(0)<n[4])e=8print("unlocked after "..n[4].." wins",22,116,e)pal(split"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1")else local n="❎ to begin"print(n,44,116,1)
if(not o)spr(n[3],92,60,2,2)
local o=make_die(n[5])draw_die2d(o,12,42)if(tf%60>45)parse_ability"curse;0".draw_face(57,57,-1)
palreset()print(n[2],100-#n[2]*2,42,e)tf+=1end function draw_gameplay()draw_time=(draw_time+1)%1024cls(15)sfn[[rectfill,0,0,128,32,7
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
]]for n in all(walls)do spr(n[1],n[2],n[3],2,2)end fillp(32160.5)rectfill(0,28,128,31,7)fillp()local n=game_frames_frac/30/.00002if(n<night_time)spr(155,111,0)print(night_time-n,120,2,0)else spr(231,113,1)night_palette_imm=true is_night=true
local e={{},{},{},{}}for n=1,4do for e=1,8do local o=grid[n][e]for n=1,#o do o[n].draw()end local n=tp(e,n)end for n in all(e[n])do n.draw()end end for n in all(nongrid)do n.draw()end palreset()if(temp_runner)for n in all(temp_runner.fake_hit)do local n=tp(n[1],n[2])spr(137+draw_time\2%4,n[1]+4,n[2]+2)end
sfn[[rectfill,0,86,128,96,15
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
]]if(not pl)return
if die3d.visible then rectfill(die3d.x,105,die3d.x+14,107,5)rectfill(die3d.x-1,106,die3d.x+15,106,5)local n,e,o=die_frames[die_time\die_spin%8+1],die3d.x-8,die3d.y-8pal(split"0,0,0,0,0,0,0")spr(n,e+1,o,2,2)spr(n,e-1,o,2,2)spr(n,e,o+1,2,2)spr(n,e,o-1,2,2)palreset()spr(n,e,o,2,2)die_time+=1elseif pl.current_ability~=nil then local n=pl.die[pl.current_ability]spr(76,die3d.x-7,die3d.y-7,3,2)n.draw_face(die3d.x-5,die3d.y-3)local n=n.name local e=print(n,0,-100)print(n,64-e/2+5,114,1)spr(130,64-e/2-5,114)end local n=6spr(132,3,1,1,2)local e=(pl.max_health+pl.shield)*7line(6,1,e+3,1,1)line(6,10,e+3,10,1)spr(132,e,1,1,2,true)for e=1,pl.max_health do if(e<=pl.health)spr(128,n,3)else spr(129,n,3)
n+=7end if(pl.shield_timer>0)local e=1-pl.shield_timer/shield_time for o=1,pl.shield do spr(145,n,3)local e=e*6sspr(64,64+e,8,6-e,n,3+e)n+=7end
if(victory)local n=min(victory_time,40)rectfill(34,n-5,94,n+8,0)rect(34,n-5,94,n+9,9)print("victory",50,n,10)
if(defeat)local n=min(defeat_time,40)rectfill(34,n-5,94,n+8,0)rect(34,n-5,94,n+9,2)print("defeat",52,n,8)
if(time_scale<1or pause_extend>0)and not victory then poke(24404,96)for n=11,90do local e=mid(n/16-.5,0,1)local e=sin(n/26+draw_time/128)*e sspr(0,n,128,1,e*1.25,n)end poke(24404,0)if(draw_time%20>10)spr(133,59,54)
end end function gameplay_tick()game_frames_frac+=.00002local e,o=0,{}for n=1,8do for t=1,4do local n=grid[t][n]if(n.creature and n.creature.health>0and n.creature.side~=1)e+=1
for n in all(n)do add(o,n)end end end for n in all(o)do n.update()end for n in all(nongrid)do n.update()end if not victory and not defeat then for n in all(attack_runners)do n:update()if(not n.alive)del(attack_runners,n)
end end if(e==0and not victory)victory=true victory_time=0
if(pl.health<=0and not defeat)defeat=true defeat_time=0
tf+=1if(rnd()<.5)make_creature_particle(128,rnd(60)+20,15,-3,rnd(52)+28)
local n=0for e=1,4do for o=1,8do n+=grid[e][o].space.side end end if n==32then victory=true elseif n==-32then defeat=true end end function update_gameplay()if victory then victory_time+=1if victory_time>90then if(level==20)dset(0,dget(0)+1)state="win"else for n=1,6do player_abilities[n]=player_abilities[n].copy()end state="upgrade"tf=0
end time_scale=1end if defeat then defeat_time+=1if(defeat_time%5==0)defeat_wall=rnd(#walls)\1+1walls[defeat_wall][3]+=2
for n in all(walls)do if(n[3]~=16and rnd()<.5)n[3]+=.25
end time_scale=1if(defeat_time>120)run()
end temp_runner=nil if pl.stun_time<=0and not victory and not defeat then move_target=nil if(btnp(0)and pl.pos[1]>1)move_target={pl.pos[1]-1,pl.pos[2]}
if(btnp(1)and pl.pos[1]<8)move_target={pl.pos[1]+1,pl.pos[2]}
if(btnp(2)and pl.pos[2]>1)move_target={pl.pos[1],pl.pos[2]-1}
if(btnp(3)and pl.pos[2]<4)move_target={pl.pos[1],pl.pos[2]+1}
if move_target then if pl.overextended_timer==0then if(valid_move_target(move_target[1],move_target[2],pl.side))pl.move(move_target[1],move_target[2])time_scale=1
else time_scale=1end end local n=pl.die[pl.current_ability]if n~=nil then if(n.type=="attack")temp_runner=make_attack_runner(n.def,1,n,pl.pos[1],pl.pos[2],1,true)
end if(btnp(5)and pl.current_ability~=nil)n.use(pl,pl.pos[1],pl.pos[2],1)pl.die[pl.current_ability]=n.copy()pl.current_ability=nil pl.animate_time=5throw()time_scale=1
end if time_scale>0then if(pause_extend>0)pause_extend-=1else gameplay_tick()
else end if die3d.visible then die3d.yv+=.3*pl.die_speed if die3d.y>100then if(die3d.yv>.5)for n=1,die3d.yv*10do local n=make_creature_particle(die3d.x+rnd(10)-5,106,5,rnd(1)-.5,106+rnd(3))n.yv=rnd(2)*-.5end
die3d.yv=die3d.yv*-.35die3d.y=100die3d.xv*=.5die_spin*=2end if die_time>45then pl.die_speed=1die3d.xv=0die3d.yv=0if pl.stun_time<=0then die3d.visible=false pl.current_ability=flr(rnd(6))+1if(is_night and pl.current_ability==4)pl.current_ability=-1
time_scale=0if(has_mod(pl.die[pl.current_ability],"pause"))pause_extend+=30
end end die3d.xv*=.975die3d.x+=die3d.xv die3d.y+=die3d.yv end end function do_level_intro()for n=1,60do if(n==30)pl=make_player()for n=1,6do pl.die[n]=player_abilities[n].copy()end pl.die[-1]=make_ability(all_abilities["curse"],0,{}).copy()
if(n==1)local n=o[level]for n in all(n)do local n,o,t,l,d=unpack(split(n,"/"))x=flr(rnd(4))+5y=flr(rnd(4))+1local n=parse_monster(e[n],x,y)n.move(x,y)n.favor_col=o n.time=t or 0n.abil_pattern_i=l or 0n.move_pattern_i=d or 0end
_draw()palreset()pal(FADE_PALS_1[max((30-n)\5,1)],1)flip()end end level=0function start_level()tf=0victory=false defeat=false draw_time=0victory_time=0defeat_time=0is_night=false time_scale=1level+=1attack_runners={}nongrid={}grid={}game_frames_frac=0pause_extend=0night_time=max(65-level*5,45)if(level==15)night_time=0
if(level>=18)night_time=9999
for n=1,4do grid[n]={}for e=1,8do grid[n][e]={}end end for n=1,4do for e=1,8do make_gridspace(e,n)end end die3d={}walls=smlu([[199,-8,16
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
]],true)defeat_wall=0do_level_intro()throw()end function throw()sfx(16,1)local n={160,162,164,166,168,170,172,174}die_frames={}for e=1,8do local e=rnd(#n)\1+1add(die_frames,n[e])deli(n,e)end die_time=0die_spin=2die3d.visible=true die3d.x=20die3d.y=64die3d.xv=2.5die3d.yv=0end current_upgrades=nil selected_upgrade_index=1applied={}faces_options2=split"x_____,_x____,__x___,___x__,____x_,_____x"upgrade_mods_names=split"growth,pierce,claim,pause,invasion,rage,poison,stun"upgrade_mods={}for n in all(upgrade_mods_names)do for e=1,all_mods[n][3]do add(upgrade_mods,n)end end function make_upgrade(o,n)local n={faces={},kind=n}for e=1,6do n.faces[e]=o[e]~="_"and o[e]or false end local l={{0,3},{3,3},{6,3},{9,3},{3,0},{3,6}}n.draw=function(e,o)if(n.kind=="hp")spr(142,e+4,o-2)print("+1 hp",e-3,o+7,0)else for t=1,6do local e,o,n=l[t][1]+e,l[t][2]+o+6,({["3"]=14,["2"]=14,["-"]=8,["1"]=12,x=12,[false]=5})[n.faces[t]]rectfill(e,o,e+1,o+1,n)end if sub(n.kind,1,1)=="+"then print("up",e+8,o-1,12)elseif all_abilities[n.kind]~=nil then local n=all_abilities[n.kind]spr(n[2],e+8,o-3)spr(n[5]+149,e-4,o-4)else spr(all_mods[n.kind][2],e+8,o)end
end return n end function draw_random_abil()local e,n=split"0,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,4"[level],{}for e=-1,5do n[e]={}end for e,o in pairs(all_abilities)do add(n[o[5]],e)end if(rnd()>.35)return rnd(n[e])else return rnd(n[e+1])
end function update_upgrade()pl=nil tf+=1if current_upgrades==nil then current_upgrades={}local n={"hp",rnd(upgrade_mods),rnd(upgrade_mods),rnd(upgrade_mods),draw_random_abil(),draw_random_abil(),draw_random_abil()}if(level%3==0)n={"+1","+1","+1","+1"}
local e=split"11____,____11,__11__,1__1__,_2____,2_____,___2__,3-____"for t=1,4do local l=flr(rnd(#n)+1)local o=n[l]deli(n,l)local n="______"if(o=="+1")local n=rnd(#e)\1+1current_upgrades[t]=make_upgrade(e[n],o)deli(e,n)else n=rnd(faces_options2)current_upgrades[t]=make_upgrade(n,o)
end end if(btnp(2))selected_upgrade_index=(selected_upgrade_index-2)%#current_upgrades+1ssfx(14)
if(btnp(3))selected_upgrade_index=selected_upgrade_index%#current_upgrades+1ssfx(14)
if btnp(5)and tf>32then ssfx(12)poke(24404,96)local n=selected_upgrade_index*27-16player_abilities=applied if(current_upgrades[selected_upgrade_index].kind=="hp")max_hp+=1
current_upgrades=nil selected_upgrade_index=1state="gameplay"scrnt(draw_upgrade,4,n,22,23,4,n,7)start_level()end end function draw_upgrade(o)camera(0,cos(min(tf/64,.5))*-64-64)sfn[[rectfill,30,0,128,128,7
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
]]local n="level "..level+1 .."/20"print(n,82,5,5)if current_upgrades~=nil then local e=current_upgrades[selected_upgrade_index]applied={}for n=1,6do applied[n]=player_abilities[n].copy()if(e.faces[n])local o=""if e.kind=="hp"then o="+1 health"elseif sub(e.kind,1,1)=="+"then local e=({["3"]=3,["2"]=2,["-"]=-1,["1"]=1,[false]=0})[e.faces[n]]applied[n].pips=max(applied[n].pips+e,0)applied[n].original_pips=applied[n].pips o="level up abilities"elseif all_abilities[e.kind]~=nil then local e=all_abilities[e.kind]applied[n]=make_ability(e,applied[n].pips,applied[n].mods)o=applied[n].name else applied[n].mods[min(#player_abilities[n].mods+1,2)]=e.kind o=all_mods[e.kind][4]end nl_print(o,42,34,1)
end for n=1,#current_upgrades do temp_camera(-4,-(n*27-16),function()if(n==selected_upgrade_index and o)return
rectfill(0,0,22,23,7)current_upgrades[n].draw(5,5)local e=3if(n==selected_upgrade_index)e=12
rect(0,0,22,23,e)end)end draw_die2d(player_abilities,50,65,state=="gameplay"and player_abilities or applied,e)end end function update_win()end function draw_win()cls()print("you win!!!",44,50,7)print("wins: "..dget(0),50,60,7)end state="title"states={title={update=update_title,draw=draw_title},newgame={update=update_newgame,draw=draw_newgame},gameplay={update=update_gameplay,draw=draw_gameplay},upgrade={update=update_upgrade,draw=draw_upgrade},win={update=update_win,draw=draw_win}}player_sprite=0function _init()state="title"night_palette_imm=false cartdata"dievirus"menuitem(1,"clear wins",function()dset(0,0)end)end function _draw()palreset()states[state].draw()pal(split"129,2,141,4,134,6,7,136,9,10,142,139,13,14,15,0",1)if(night_palette_imm)pal(split"129,2,141,4,134,5,6,136,9,10,142,3,13,14,15,0",1)night_palette_imm=false
if(pal_override_imm)pal(pal_override_imm)pal_override_imm=nil
end function _update()states[state].update()end
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
e1e1eeeeeeeeeeeeeeeeeeeeee1111eeeeeee111ee111eeeee111eeeeeeeeeeeeecceeeee0eeeeee1111eeee9e9eeeeeee88eeeee8eeeeeeeceeeeeee59eeeee
eeeee1eeeee1eeeeee1111eee111111e1e1eee11e11111eee11111eeeeeeeeeeec1cceee990eeeee1771eeee9e9eeeeee88eeeee88eeeeeec7ceeeee5ee5eeee
1eeeeeeeee11111e11eeee11111ee111e11eee1111ee11ee11ee11e1ee0000eee1cceeeee0eeeeee1111eeee9e9eeeee88eeeeee88eeeeeeccceeeeee95eeeee
eeeeee1eeee1eee11ee11ee111ee1e11e11eee1111eeeeee11eeeee1e0ee000eceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeee111eeee1111eeee1ee11eee1111eee11111ee1ee10ee000e0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee1111111111ee1111ee111eeeeee11eee11e11eeeeee11ee11ee000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee111111111eeeeeeeee11111ee1e11ee1e1e111ee11e111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeee1111111e111eeeeeee111eeeee111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
ee1eeeeeeeeeeeeee11111eee11111eeeee1eeeee77ee77eeeeecceeee777eeee1111eeeee1777eeeeee11eeeeeeeeeeeeeeeeeeeeeeeeeeccccceeeee7799ee
ee1eeeeeeeeeeeee11f1f11e11ccc11eee1eeeee7cc77cc7eeeecceee77eeeee1cccc1eee1eeeeeeeeeeee1eeeeeeeeee7eeeeeeeeeeeeeeceeeceee9977ee99
e111eeeee888eeee111f111e11c1c11ee1eeeeee7cc77cc7eeecceeee7e77eee1cccc1ee1eeeeeeeeeeeeee1eeeeeeee7eeeeeeeeeeeeeeeececeeee9eeeeee9
e111eeeeeeeeeeee11f1f11e11ccc11ee1eeeeee7cc77cc7eeecceee77eeeeeee1cc1eee1ee11eeeeee11ee7eee11ee17ee11eeeeeeeeeeeeeceeeee99ee7799
11111eeeeeeeeeee5111115e5111115ee1eeeeee7cc77cc7eeeeeeee7e777eeee1cc1eeeeeeeeeeeeeeeeee7eeeeeee11eeeeeee8eeeeeeeeeceeeeeee9977ee
11111eeeeeeeeeeee55555eee55555eee1eeeeee7cc77cc7eecceeeeeeeeeeeeee11eeeeeeeeeeeeeeeeee7eeeeeee1ee1eeeeee8eeeeeeeeeceeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1eeeeee7cc77cc7eecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7771eeee111eee88eeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1eeeeeee77ee77eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888eeeeeeeeeeeeeeeeeeee
ee9999eee1111eeeeeeeeeeeeeeeeeeeee1eeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeeeeeeeeee77eeeeeeeeeeeeeeeeeeeeeeeeeeee
99eeee771eeee1eeeeeeeeeeeeeeeeeeeee1eeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeee0000000eee77eeeeeeeeeeeeeeeeeeeeeeeeeeee
77eeee771eeee1eeeeee66eeeeeeeeeeeeeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeee0eee0eeeee77eeeeeeeeeeeeeeeeeeeeeeeeeee
77eeee99e1ee1eeeee66eeeeeeeeeeeeeeeeeeee0ee000ee2eee2eee4ee444ee6eee55ee9ee9e9eeceeccceeee0e0eee77777eeeeeeeeeeeeeeeeeeeeeeeeeee
ee9999eee1ee1eeee6eeeeeeeeeeeeeeeeeeeeeeeee0e0eeeee22eeeeeeee4eeeeeee5eeeee999eeeeecceeeeee0eeee77777eeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee11eeeeeeeeee6ee3eeee3eeeeeeeeeeee0e0eeeeee2eeeeee44eeeeeee55eeeeeee9eeeeeeeceeee000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeee6eee3e3ee3e3eeeeeeeeeee000eeeee222eeeee444eeeee555eeeeeee9eeeeeccceee00000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeee66eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
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
eeeeeeeeeeeeeeeeeeeeeeef50eeeeeeeeeeeeef755eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee77f50eeeeeeeeee77ff5500eeeeeeeeee7fee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffeeeeeeeeeeeeeeeee6666666eeeeeeeeeeeeeeeeeeeee
f7f7ffff550eeeeee7fffffff55550eeee7fffeeeeee55555eeeeeeeeeeeeeeeeeeeeeeeeeeee333333eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
fffffffff5555f5ffffffffff55555f5eeeeeeeeeeeeee5555555e5eeeeeeeeeeeeeeeee3ffff3fffffeeeeeeeeeeeeeeeee6666666eeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555eeeeeeeeeeeeeeeeeeeeeeeeeeeee3ffff3fffffeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
e7fff55eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5555eeeeeeeeeeffffffffffffeeee333333fff33eeeeeeeeeeeee66666666666eeeeeeeeeeeeeeeeeeeee
ffffff55555f5feee77f7ff5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffeeeeffffffff3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
fffffffffffffffffffffffffffff55eeeeeeeeeeeeeeeeeeeeeeeee333333333333eeeefffffff3eeeeeeeeeeeeeeee6e6e6e6e6e6eeeeeeeeeeeeeeeeeeeee
eeeeeeeeee6666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555555555553eeeeff5555f3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee333333333333eeeeff5ff5f3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeecec6666ecceceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffff5eeeeff5cf5f3ee6eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeeee
eee6cc655665566556cc66eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffff5eeeeff5cf5f3666eeeeeeeeeeeeeeeeeeeeeeeeeeeeee6eee6eececceeee
eee6c55666655666655cc6eeeeeeeeeeeeeeeeeeceeeeeeeeeeeeeeefffffffffff5eeeeff5cf5c3666eeeeeeeeeeeeeeeeeeeeeeeeeeeeee666e666cecccece
ece55666cc65566cc66556ceeeeeeeeeeeeeceeecceeeeeeeeeeeeeefffffffffff5eeeeff5cf5c3666eeeeeeeeeeeee666ee666eeeeeeeeeeeeeeeeeeeeeeee
e5566666c66556666666655eeeeeeeceeeeecceccceeeeeeceeeeeeefffffffffff5eeeefcccf5c3666eeeeeeeeeeeee666666666666666666eeeeee66eeeeee
566666666665566666666665ceeccecccecccccccccceccececeeeeefffffffffff5eeeefcccf5c366ceeeeeeeeeeeee666666666666666666666eee66666eee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccceeeeeeeeeeeeecceeeeeeee7000ee55555555eeeeeeeeeeeeeeeeeeeffffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeee66666666666666eeeeeeeeeecccceeceeeeecceecceeeceee700077e57577775eeeeeeeeeeeeeeeeeeeffffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccecceecceeeeeceeee7000777757575575eeeeeeeeeeeeeeeeeee33333333eeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee66e66666666666666e66eeeeeeeeeeeeceeceeeeeeeeeeeeeee7000777757575575eeeeeeeeeeeeeeeeeeefffffff35fff5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeee7000777757577575eeeeeeeecceeeeeeeeefffffff355ff3eeeeeeeeeeeeeeeeeeeeeeee
66666666666666666666666666666eeeeeeeeceeceeeeeeeeeeeeeee7000777757555575ffffffffccffeeeeeee3333fff333333eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeee700077e57777775fcfffcffffffeeeeeeeee553fffffff5eeeeeeeeeeeeeeeeeeeeeeee
6e6e6e6e6e6e6e6e6e6e6e6e6e6e6eeeeeeeeceeceeeeeeeeeeeeeeeee7000ee555555553c333cc33333eeeeeeeeee553ffffff5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5c5555c55553eeeeeeeeeee53f5555f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeee3c3333c33333eeeeeeeeeee53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecceeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefcffffcffff5eeeeeeeeeee53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecceceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefcffffcffff5eeeeeeeee6e53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefcfffccffff5eeeeeeee66e53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefcfffcfffff5eeeeeeee66ec3fcff5f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffcfffff5eeeeeeeec6eccfcfc5f5eeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffcfffff5eeeeeeee6ceccfccccc5eeeeeeeeeeeeeeeeeeeeeeee
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
01110000240001800118001000002861300000000000c6130c6140000000001000010000100001000010000100001000010000100001000010000100001000010000100000000000000000000000000000000000
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
__music__
03 40204344
__label__
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmhhhhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhmmhhmhhhmhhhmhhhmhhmmhhmmhhhmhhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhhhhmm
mmmmhhhmmhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhmmmhmhmhhhmhhhmhmhmhmhmhmhmhmmmhmhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhmmhhhm
mmmmhhmmmhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhmmmhmhmhmhmhmhmhhhmhmhmhmhmhhmmhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhmmmhhm
mmmmhhhmmhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhmmmhmhmhmhmhmhmhmhmhmhmhmhmhmmmhmhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhmmhhhm
mmmmmhhhhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhmhhmmhmhmhmhmhmhmhmhmhhhmhhhmhmhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhhhhmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777hhh77mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777777hh77mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777h7h77mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777777h77777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777h777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hh7777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hh7777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77h777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777777rrr7mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777777mmmmm7777777777mmmmm7777777777mmmmm7777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777777777777mmm777777777777mmm777777777777mmm777777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777hhh77mmm7777777hhh77mmm777777777h77mmm777hhhhhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777777hh77mmm77777777hh77mmm77777777hh77mmm77hhhhhhhh77mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777777777h77mmm777777777h77mmm7777777hh777mmm77hhhhhhhh77mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777hh777777mmm7777hh777777mmm77h777hh7777mmm777hhhhhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777h77777777mmm777h77777777mmm77hh7hh77777mmm777hhhhhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77h777777777mmm77h777777777mmm777hhh777777mmm7777hhhh7777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77h7hhhhhh77mmm77h7hhhhhh77mmm777hhh77rrr7mmm7777hhhh7777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hhhhhhh77mmm777hhhhhhh77mmm77h77hh77777mmo77777hh77777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777777rrr7mmm77777777rrr7mmm77777777rrr7mmo77777777rrr7mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777777mmmmm7777777777mmmmm7777777777mmmoo7777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmoooommmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777777hhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777h777h77mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777hhhh7777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hhhhhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hhh7hh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hh7hhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777hhhhhh777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777hhhh7777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm77777777rrr7mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm7777777777mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm0099mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm999999mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm0404404mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm004424mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm909mmm000440mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm909mmmm00000mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd0ddd422000dddddmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd70744422992777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd70422449924777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd74277499474447dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd74077992477447dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd77770900007777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd7770007000d777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd77700ddd0ddd77dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd770ddddd444d77dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd7444ddddd77777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd77777777777777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmd77777777777777dmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmddddddddddddddddmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhhhhhhhhhhhhhhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhhhhhhhhhhhhhhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmhhhhhhhhhhhhhhhhmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmhhhhhmmmmmmhhhmmhhmmmmmmhhmhmhmmhhmmhhmmhhmhhhmmmmmmhhmmhhmhhhmhhhmhhhmhhmmhhmmhhhmhhhmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmhhmhmhhmmmmmmhmmhmhmmmmmhmmmhmhmhmhmhmhmhmmmhmmmmmmmhmmmhmhmhhhmhhhmhmhmhmhmhmhmhmmmhmhmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmhhhmhhhmmmmmmhmmhmhmmmmmhmmmhhhmhmhmhmhmhhhmhhmmmmmmhmmmhmhmhmhmhmhmhhhmhmhmhmhmhhmmhhmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmhhmhmhhmmmmmmhmmhmhmmmmmhmmmhmhmhmhmhmhmmmhmhmmmmmmmhmmmhmhmhmhmhmhmhmhmhmhmhmhmhmmmhmhmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmhhhhhmmmmmmmhmmhhmmmmmmmhhmhmhmhhmmhhmmhhmmhhhmmmmmmhhmhhmmhmhmhmhmhmhmhmhmhhhmhhhmhmhmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
__meta:title__
bn2
by morganquirk
