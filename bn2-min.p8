pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function tp(n,e)return{n*16-16,e*13+19}end function gp(n,e)return{mid(n\16+1,1,8),mid((e-27)\13+1,1,4)}end function addfields(n,e)for e,t in pairs(e)do n[e]=t end end function sfn(n)for n in all(split(n,"\n"))do if(#n>3)local n=split(n)local e=n[1]deli(n,1)_ENV[e](unpack(n))
end end function string_multilookup(e)local n={}for e in all(split(e,"\n"))do if(#e>3)local e=split(e,",")n[e[1]]=e
end return n end function center_print(t,e,n,d,l,o,i)for o in all(split(t,"%"))do local t=print(o,0,-600)local t=(t-.5)\2if l then rectfill(e-t-1,n-1,e+t+1,n+5,l)if(i)rectfill(e-t-2,n,e+t+2,n+4,l)
end print(o,e-t,n,d)n+=8end end function temp_camera(t,l,o)local n,e=peek2(24360),peek2(24362)camera(n+t,e+l)o()camera(n,e)end function palreset()pal()palt(2)end function get_bit(n,e)return n&32768>>>e~=0end function ssfx(n)sfx(n,0)end shield_time=300max_hp=4monster_palettes={split"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15",split"1,2,5,4,5,6,7,4,6,7,11,12,13,14,15"}all_abilities=string_multilookup[[slap,104,attack,    0/0b0000010000000000.0000000000000000/0/0/0/0,0
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
turret,99,turret,wave,2
s.turret,117,turret,split,3
curse,119,curse,,-1
]]all_mods=string_multilookup[[growth,120,3,gets stronger each use%in battle
fast,121,0,roll the next die faster
claim,122,8,claim up to 2 of the tiles hit
pause,123,4,time stands still for%a moment longer
invasion,124,2,+1 pip if standing%in enemy territory
rage,125,2,+2 pips if less than%half health
poison,126,2,deals poison damage instead
stun,127,2,stuns the enemy for%a moment
]]local t=string_multilookup[[mage1,38,0,wave;1,4,60,move_pattern=xx_,abil_pattern=__x
fighter1,36,0,sword;1;claim/sword;1,5,28,move_pattern=xx_,abil_pattern=__x
duelist1,14,0,wave;1/sword;2/sword;1;claim,7,32,move_pattern=xxx_,abil_pattern=___x
engineer1,34,0,turret;2/sling;1,8,65,flies=1,abil_pattern=_x
boss1,40,0,bomb;2/wave;1/shield;1/sword;3,20,15,flies=1,abil_pattern=____x_x__,move_pattern=xxxx_____
bomber1,32,0,bomb;2,10,99
mage2,38,1,wave;2,8,40,move_pattern=xx_,abil_pattern=__x
fighter2,36,1,sword;3/spear;3,10,30,abil_pattern=_x
boss2,42,1,sling;3/turret;3/shield;3/wave;3,30,20,flies=1,abil_pattern=______x_x_x_,move_pattern=xxxx___x_x_x
bomber2,32,2,bomb;2,15,39,abil_pattern=_x_
engineer2,34,2,turret;4/sling;2/shield;2,10,45,flies=1,abil_pattern=_x
duelist2,14,2,wave;3/sword;4/spear;4/shield;2,14,21,move_pattern=xxx_,abil_pattern=___x
mage3,38,2,wave;4/wave;4,15,40,move_pattern=xx_,abil_pattern=__x
boss3,44,2,wave;3/wave;1/shield;1/spear;1,40,21,move_pattern=xxx_,abil_pattern=___x
boss4,48,2,wave;3/wave;1/shield;1/spear;1,40,21,move_pattern=xxx_,abil_pattern=___x
]]function draw_die2d(d,i,f,t,e)local l=true if(t and e.kind~="hp")l=tf\14%2==0
local o={{0,15},{15,15},{30,15},{45,15},{15,0},{15,30}}for n=1,6do temp_camera(-o[n][1]-i,-o[n][2]-f,function()if(e and not l and e.faces[n])rectfill(-2,-1,11,10,12)rectfill(-1,-2,10,11,12)t[n].draw_face(0,0,n)else d[n].draw_face(0,0,n)
end)end end die3d={}local e={}function make_nongrid(n,t)local n={pos={n,t},draw=function()end,update=function()end}add(e,n)return n end function valid_move_target(n,t,e)if(n<1or n>8or t<1or t>4)return false
local l=grid[t][n]if(l.space.dropped or l.creature)return false
if l.space.side~=e then if(n-e<1or n-e>8)return false
local n=grid[t][n-e]if(n.space.side~=e)return false
end return true end function add_go_to_grid(n)local e=grid[n.pos[2]][n.pos[1]]if#e==0then add(e,n)else local t=1while(true)if t>#e then add(e,n)break elseif n.layer<=e[t].layer then add(e,n,t)break end t+=1
end end function make_gridobj(n,t,l,e,o,d)local n={pos={n,t},layer=l or 10,spri=e,sprw=o,sprh=d,draw=function()end,update=function()end}add_go_to_grid(n)n.move=function(e,t)del(grid[n.pos[2]][n.pos[1]],n)n.pos={e,t}add_go_to_grid(n)end if(e~=nil)n.draw=function()local e=tp(n.pos[1],n.pos[2])spr(n.spri,e[1],e[2],n.sprw,n.sprh)end
return n end function find_open_square_for(l,e,t,o)local n,n=grid[t][e],1if(l~=1)n=-1
local n=o or{{0,0},{-n,0},{-n,-1},{-n,1},{0,-1},{0,1},{n,0},{n,-1},{n,1}}for n in all(n)do local n,e=e+n[1],t+n[2]if n>=1and n<=8and e>=1and e<=4then local t=grid[e][n]if(t.space.side==l and t.creature==nil and not t.space.dropped)return{n,e}
end end return nil end function push_to_open_square(n)local e=find_open_square_for(n.side,n.pos[1],n.pos[2])if(e)n.move(e[1],e[2])
end function make_damage_spot(n,l,o,d,e,t)local n=make_gridobj(n,l,1)addfields(n,{side=d,damage=o,countdown_max=e or 0,countdown=e or 0,decay=0,abil=t})n.update=function()local e=grid[n.pos[2]][n.pos[1]]if n.countdown>0then n.countdown-=1elseif n.countdown==0then if e.creature and e.creature.side~=n.side then if(has_mod(n.abil,"stun"))e.creature.stun_time=90
if(has_mod(n.abil,"poison"))e.creature.poison_timer=120*n.damage else e.creature.take_damage(n.damage)
end local l=count(t.mods,"claim")*2if(e.space.side~=n.side and t.tiles_claimed<l)e.space.flip(n.side,240)t.tiles_claimed+=1
e.space.bounce_timer=13n.countdown-=1ssfx(n.side==1and 8or 9)else n.decay+=1if(n.decay>4)del(e,n)
end end n.draw=function()local t,e=tp(n.pos[1],n.pos[2]),grid[n.pos[2]][n.pos[1]]t[2]+=e.space.offset_y local e=9if(n.side~=1)e=8
if(n.countdown>0)local n=1-n.countdown/n.countdown_max local d,i,n,t,l,o=6*n+2,4*n+2,t[1]+1,t[2]+1,t[1]+14,t[2]+11line(n,t,n+d,t,e)line(n,t,n,t+i,e)line(n,o,n+d,o,e)line(n,o,n,o-i,e)line(l,t,l-d,t,e)line(l,t,l,t+i,e)line(l,o,l-d,o,e)line(l,o,l,o-i,e)else rectfill(t[1]+1,t[2]+1,t[1]+14,t[2]+11,e)
end end function make_gridspace(e,l)local t=1if(e>4)t=-1
local n=make_gridobj(e,l,0,spri,2,2)n.side=t n.dropped=false n.drop_time=0n.main_side=t n.flip_time=0n.drop_finish_time=0n.fire_time=0n.bounce_timer=15+e+l n.offset_y=0local e=n.update n.update=function()if n.dropped then n.drop_time+=1if(n.drop_time>=n.drop_finish_time)n.dropped=false n.drop_time=0
end if(n.fire_time>0)n.fire_time-=1
end local e=n.draw n.draw=function()n.offset_y=-(cos(n.bounce_timer/10)-.5)*(n.bounce_timer/5)n.bounce_timer=max(n.bounce_timer-1,0)local e=tp(n.pos[1],n.pos[2])e[2]+=n.offset_y if(n.side==-1)pal(split"0,2,3,4,5,3,13,8,9,10,11,12,1,14,15,0")else palreset()
spr(64,e[1],e[2]+(n.drop_time/2.5)^2,n.sprw,n.sprh)if(n.dropped and n.drop_time>n.drop_finish_time-4)pal{7,7,7,7,7,7,7,7,7,7,7,7,7,7,7}spr(n.spri,e[1],e[2],n.sprw,n.sprh)
if(n.fire_time>0and n.fire_time%5==0)make_effect_fire(e[1]+rnd()*12,e[2]+rnd()*8-2)
end n.drop=function(e)if(n.dropped)return
n.drop_time=0n.drop_finish_time=e n.dropped=true end grid[n.pos[2]][n.pos[1]].space=n n.flip=function(e,t)if(e==n.side)return
if(e==n.main_side)n.side=n.main_side n.flip_time=0return
n.main_side=n.side n.side=e n.flip_time=t end return n end function parse_ability(n)local n=split(n,";")local e=all_abilities[n[1]]return make_ability(e,n[2],{n[3]})end function has_mod(n,e)return count(n.mods,e)>0end function make_ability(n,e,t)local n={base=n,name=n[1],image=n[2],type=n[3],def=n[4],rarity=n[6],pips=e}n.mods={}n.original_pips=e for e in all(t)do add(n.mods,e)end n.copy=function()return make_ability(n.base,n.original_pips,n.mods)end n.get_pips=function()if(pl and has_mod(n,"invasion")and grid[pl.pos[2]][pl.pos[1]].space.side==-1)return n.pips+1
if(pl and has_mod(n,"rage")and pl.health<=pl.max_health/2)return n.pips+1
return n.pips end n.draw_face=function(e,t,o)local l=n.name=="curse"and 8or 7rectfill(e,t-1,e+9,t+10,l)rectfill(e-1,t,e+10,t+9,l)spr(n.image,e+1,t+1,1,1)modspots={{0,0},{0,6}}for l=1,#n.mods do spr(all_mods[n.mods[l]][2],modspots[l][1]+e,modspots[l][2]+t)end local n=n.get_pips()local l=n\5local d,n=n-l*5,0for l=1,l do rectfill(e+7,t+9-n-2,e+9,t+9-n,12)n+=4end for l=1,d do rectfill(e+7,t+9-n,e+9,t+9-n,12)n+=2end if(o==4)spr(141,e-2,t+4)
end n.use=function(e,t,l,o)if(n.base=="none")return
n.tiles_claimed=0_ENV["abil_"..n.type](e,n.get_pips(),n,t,l,o)if(has_mod(n,"growth"))n.pips+=1n.original_pips+=1
if(has_mod(n,"fast"))pl.die_speed=3
end return n end function abil_grid_spaces(l,o,d,i)local t={}for n=0,7do for e=0,3do if get_bit(l,n*4+e%4)then local n,e=o+n*i,d+e-1if(n>=1and n<=8and e>=1and e<=4)add(t,{n,e})
end end end return t end function abil_shield(n,e,o,t,l,d)local e=e n.shield=max(n.shield,e)n.shield_timer=shield_time local e=tp(t,l)if(n==pl)ssfx(15)
make_effect_simple(e[1]+4,e[2]-14,0,136)end function abil_attack(d,e,n,t,l,o)add(attack_runners,make_attack_runner(n.def,e,n,t,l,o))end function abil_curse()local n=0for e=1,50do local e=grid[rnd(4)\1+1][rnd(4)\1+1]if e.space.side==1then e.space.side=-1n+=1if(n>=2)return
end end ssfx(19)end function make_turret(o,e,t,d,n)local l=12if(n==-1)l=2
local n=make_creature(e,t,n,o,l,2,2)local l=n.update n.rate=80n.time=0n.update=function()l()n.time+=1if(n.time%n.rate==n.rate\2)d.use(n,e,t,n.side)
if(n.time>=450)n.kill()
end return n end function abil_turret(n,t,l,o,d,e)local n,l=e,make_ability(all_abilities[l.def],t,l.mods)local n=find_open_square_for(e,o,d,{{n,0},{-n,0},{0,-1},{0,1},{n,-1},{n,1},{-n,-1},{-n,1}})if(n)local n=make_turret(t,n[1],n[2],l,e)
end function make_attack_runner(n,d,i,f,a,t,o)local n,e=split(n,";"),{}for n in all(n)do local n=split(n,"/")add(e,{delay=n[1],grid=n[2],xv=n[3]*t,yv=n[4],collides=n[5]==1,telegraph=n[6],max_tiles=n[7]or 8,bounces_x=n[8]==1,bounces_y=n[9]==1,absolute_x=n[10]==1,absolute_y=n[11]==1,alive=true})end local n=0function update(r)local l=false function damage_and_stop(n,e,l)if(o)add(s.fake_hit,{e,l})else make_damage_spot(e,l,d,t,n.telegraph,i)
if n.collides then local e=grid[l][e].creature if(e and e.side~=t)n.alive=false
end end for e in all(e)do local o=e.xv==0and e.yv==0if e.virtual_objs and e.alive then for n in all(e.virtual_objs)do if e.xv~=0or e.yv~=0then n.timers={n.timers[1]-1,n.timers[2]-1}local t=false if n.xv~=0and n.timers[1]<=0then if n.pos[1]<=1and n.xv<0or n.pos[1]>=8and n.xv>0then if(e.bounces_x)n.xv=-n.xv else n.off_grid=true
end n.pos[1]+=sgn(n.xv)t=true n.timers[1]=30/abs(n.xv)-1end if n.yv~=0and n.timers[2]<=0then if n.pos[2]<=1and n.yv<0or n.pos[2]>=4and n.yv>0then if(e.bounces_y)n.yv=-n.yv else n.off_grid=true
end n.pos[2]+=sgn(n.yv)t=true n.timers[2]=30/abs(n.yv)-1end if(t and not n.off_grid)damage_and_stop(e,n.pos[1],n.pos[2])n.max_tiles-=1
if(not n.off_grid and n.max_tiles>0)l=true
end end end if not e.virtual_objs then if n>=e.delay then e.virtual_objs={}for n in all(abil_grid_spaces(e.grid,e.absolute_x and 1or f,e.absolute_y and 2or a,t))do if(not o)local t={e.xv==0and 0or 30/e.xv,e.yv==0and 0or 30/e.yv}add(e.virtual_objs,{pos=n,timers=t,max_tiles=e.max_tiles,xv=e.xv,yv=e.yv,off_grid=false})l=true
damage_and_stop(e,n[1],n[2])end else l=true end end end if(not l)r.alive=false
n+=1end s={update=update,alive=true,fake_hit={}}if o then local n=0while(s.alive)n+=1s:update()
else s:update()end return s end function make_effect_simple(n,i,f,d,t,l,o)if(t==nil)t=0
if(l==nil)l=-.2
o=o or 30local n=make_nongrid(n,i)n.time=0n.draw=function()if(d~=nil)spr(d,n.pos[1],n.pos[2])else pset(n.pos[1],n.pos[2],f)
end n.update=function()n.pos[1]+=t n.pos[2]+=l n.time+=1if(n.time>o)del(e,n)
end return n end function make_creature_particle(n,t,l,i,o)local n,t,d=make_nongrid(n,t),-50+rnd(2),(rnd()-.5)*1.8addfields(n,{color=l,yv=d,xv=i+(.5-rnd())*.25,time=-rnd(100)})n.draw=function()pset(n.pos[1],n.pos[2],l)end n.update=function()t+=1if(rnd()<.04or t>=0)l=rnd{15,15,5}
n.time+=1if t<d*10-30then n.yv+=.1else n.yv+=.02n.yv*=.5if(n.xv>-3)n.xv+=-rnd()*.25
end if n.pos[2]>o then n.yv=n.yv*-.15if(n.yv>-.1)n.yv=0n.y=o
end n.pos={n.pos[1]+n.xv,n.pos[2]+n.yv}if(t>32and rnd()<.1)del(e,n)
end return n end function make_effect_ghost(n,t,l,o,d)local n=make_nongrid(n,t)n.time=0n.draw=function()fillp(21845.75)spr(l,n.pos[1],n.pos[2],o,d)fillp()end n.update=function()n.time+=1n.pos={n.pos[1],n.pos[2]-n.time}if(n.time>3)del(e,n)
end return n end creature_index=1function make_creature(n,l,e,t,o,d,i)local n=make_gridobj(n,l,10,o,d,i)addfields(n,{movetime=0,lastpos={0,0},yo=-7,side=e,dir=e,damage_time=0,health=t,max_health=t,shield=0,shield_timer=0,stun_time=0,stun_co=1,alive=true,overextended_timer=0,index=creature_index,poison_timer=0})n.clay_time=15creature_index+=1n.draw=function()local e,t,l,o=tp(n.pos[1],n.pos[2]),n.spri,0,grid[n.pos[2]][n.pos[1]].space function ds(d,i)spr(t,e[1]+l+d,e[2]+n.yo+i+o.offset_y,2,2,n.side==-1)end if(n.clay_time>0)if t<12then pal(split"2,2,2,2,2,2,1,1,1,1,1,1,1,1,15,1")clip(0,e[2]+n.yo+max((n.clay_time-10)*4,-4),128,22)ds(n.clay_time\5,0)ds(-n.clay_time\6,0)ds(0,n.clay_time\7)ds(0,-n.clay_time\8)ds(0,0)clip()palreset()elseif t<40then ds(0,0)else ds(n.clay_time*n.clay_time*.125,n.clay_time*n.clay_time*-.25)end n.clay_time-=1return
if(n.movetime>0)fillp(21845.75)
if(n.damage_time>0)pal{7,7,7,7,7,7,7,7,7,7,7,7,7,7,7}l=-n.damage_time*n.dir
if(n.poison_timer>0)pal(split"1,2,3,4,5,6,7,8,9,10,12,12,13,14,15,0")
ds(0,0)fillp()palreset()if(n.stun_time>0)spr(143+tf\10%2,e[1]+3,e[2]-6)
end local t=n.update n.update=function()local e=grid[n.pos[2]][n.pos[1]].space if(e.dropped)push_to_open_square(n)
if e.side~=n.side then n.overextended_timer+=1if(n.overextended_timer>=30)n.overextended_timer=0push_to_open_square(n)
else n.overextended_timer=0end if(e.fire_time>0and e.fire_time%20==0)n.take_damage(1)
n.poison_timer=max(n.poison_timer-1,0)n.damage_time-=1n.movetime-=1n.shield_timer-=1if(n.shield_timer<=0)n.shield=0
n.stun_time-=1t()end local o=n.move n.move=function(e,t)if(not n.alive)return
local l=tp(n.pos[1],n.pos[2])if(n.clay_time<=0)make_effect_ghost(l[1],l[2]+n.yo,n.spri,n.sprw,n.sprh)ssfx(n==pl and 14or-1)n.movetime=3
grid[n.pos[2]][n.pos[1]].creature=nil n.lastpos={n.pos[1],n.pos[2]}o(e,t)grid[t][e].creature=n if(n.poison_timer>0)n.take_damage(1)local n=tp(e,t)
end n.take_damage=function(e)if(e>=n.shield)local e=e-n.shield n.shield=0n.shield_timer=0n.health-=e else n.shield-=e
n.damage_time=5local e=tp(n.pos[1],n.pos[2])sfx(n==pl and 11or 10,1)if(n.health<=0)n.kill()sfx(n==pl and 13or 12,1)
end n.kill=function()n.alive=false local t,o=n.spri%16*8,n.spri\16*8for e=0,n.sprw*8-1do local d=e/(n.sprw*8-1)-.5for l=0,n.sprh*8-1do local o,t=sget(t+e,o+l),tp(n.pos[1],n.pos[2])if(o~=14)make_creature_particle(t[1]+e,t[2]+l+n.yo,o,d/2,t[2]+6+rnd(4))
end end grid[n.pos[2]][n.pos[1]].creature=nil del(grid[n.pos[2]][n.pos[1]],n)end grid[n.pos[2]][n.pos[1]].creature=n return n end pl=nil function make_player()local n=make_creature(1,2,1,max_hp,player_sprite,2,2)addfields(n,{max_health=n.health,die={},die_speed=1,current_ability=nil})return n end function make_monster(d,i,n,l,f,a,t,e)local o=false if(grid[l][n].creature)o=true
local n=make_creature(n,l,-1,a,d,2,2)n.palette=monster_palettes[i]n.abilities=f n.speed=t n.time=0n.abil_timer=t\2n.move_timer=t n.next_ability=rnd(n.abilities)addfields(n,e or{})if(e.move_pattern)n.move_pattern={}for t=1,#e.move_pattern do add(n.move_pattern,e.move_pattern[t]=="x")end n.move_pattern_i=1
if(e.abil_pattern)n.abil_pattern={}for t=1,#e.abil_pattern do add(n.abil_pattern,e.abil_pattern[t]=="x")end n.abil_pattern_i=1
local e=n.update n.update=function()e()if(n.stun_time>0)return
n.time+=1if(n.overextended_timer<=0)n.move_timer-=1
if n.move_timer<=0then local e=true if n.move_pattern then if(not n.move_pattern[n.move_pattern_i])e=false
n.move_pattern_i=n.move_pattern_i%#n.move_pattern+1end if e then local l,e,t={sword=0,sling=8,bomb=6},nil,nil if(rnd()<.4)e=l[n.next_ability.base]
if(n.favor_row and rnd()<.25)t=n.favor_row
if n.flies then local e,t=e or flr(rnd(4))+5,t or flr(rnd(4))+1if(valid_move_target(e,t,n.side))n.move(e,t)
else local l={}for n=-1,1do for e=-1,1do add(l,{n,e})end end for o=1,9do local o=rnd(l)del(l,o)local l,d=nil,nil if(e)l=mid(e-n.pos[1],-1,1)
if(t)d=mid(t-n.pos[2],-1,1)
local e,t=(l or o[1])+n.pos[1],(d or o[2])+n.pos[2]if(valid_move_target(e,t,n.side))n.move(e,t)break
end end end n.move_timer=n.speed end n.abil_timer-=1if n.abil_timer<=0then local e=true if n.abil_pattern then if(not n.abil_pattern[n.abil_pattern_i])e=false
n.abil_pattern_i=n.abil_pattern_i%#n.abil_pattern+1end if(e)n.next_ability.use(n,n.pos[1],n.pos[2],n.side)n.animate_time=5n.next_ability=rnd(n.abilities)
n.abil_timer=n.speed end if(n.abil_pattern and n.abil_timer==8and n.abil_pattern[n.abil_pattern_i])ssfx(18)
if(n.move_pattern and n.move_pattern==8and n.move_pattern[n.move_pattern_i])ssfx(17)
end local e=n.draw n.draw=function()palreset()if(n.palette~=nil)e()else e()
if(n.clay_time>0)return
local t=tp(n.pos[1],n.pos[2])local e,t=t[1]+3,t[2]+10line(e,t,e+9,t,6)line(e,t,e+9*(n.health/n.max_health),t,15)palreset()if(n.abil_pattern and n.abil_timer<9and n.abil_pattern[n.abil_pattern_i])spr(134,e+2,t-21)
if(n.move_pattern and n.move_timer<9and n.move_pattern[n.move_pattern_i])spr(135,e+2,t-21)
end if(o)push_to_open_square(n)
return n end function parse_monster(n,l,o)local t,e=split(n[4],"/"),{}for n in all(t)do add(e,parse_ability(n))end local t={}for e=7,#n do local n=split(n[e],"=")t[n[1]]=n[2]end return make_monster(n[2],n[3],l,o,e,n[5],n[6],t)end titlef=0function update_title()titlef+=1player_abilities={}state="newgame"end function draw_title()cls()print("die virus",46,32,7)spr(13,55+rnd()*sin(titlef/100)*2,56+rnd()*sin(titlef/100)*2,2,2)print("❎ to start",42,88)end function make_die(e)local n,t={},split(e,"/")for e=1,6do n[e]=parse_ability(t[e])end return n end classes=string_multilookup[[1,commander,0,0,sling;1/sling;1/sword;2/shield;1/spear;1/bomb;1
2,fencer,2,0,sword;1/shield;1/spear;1/slap;1/scythe;1;claim/scythe;2
3,wizard,4,0,wave;1/wave;1/wall;1/sword;1/bomb;2/shield;1
4,engineer,6,0,turret;1/bomb;1/bomb;1/turret;1/sling;1/shield;1
]]selected_class_index=1function update_newgame()if(btnp(0))selected_class_index=(selected_class_index-2)%#classes+1ssfx(14)
if(btnp(1))selected_class_index=selected_class_index%#classes+1ssfx(14)
local n=classes[selected_class_index]if(btnp(5)and dget(0)>=n[4])state="gameplay"player_abilities=make_die(n[5])player_sprite=n[3]start_level()
end function draw_newgame()cls(15)sfn[[rectfill,56,100,71,128,6
rectfill,56,100,71,122,5
rectfill,56,100,71,114,3
pal,6,7
spr,64,56,92,2,2
palreset
]]print("⬅️",4,20,0)print("➡️",120,20,0)local n,e=classes[selected_class_index],1if(dget(0)<n[4])e=8print("unlocked after "..n[4].." wins",22,28,e)else local e="❎ to choose "..n[2]print(e,64-#e*2,116,0)spr(n[3],56,86,2,2)
print(n[2],64-#n[2]*2,20,e)draw_die2d(make_die(n[5]),37,36)end function draw_gameplay()draw_time=(draw_time+1)%1024cls(15)sfn[[rectfill,0,0,128,32,7
spr,222,64,9
spr,199,-8,16,2,2
spr,199,4,16,2,2
spr,199,16,16,2,2
spr,199,28,16,2,2
spr,199,40,16,2,2
spr,201,52,16,3,2
spr,199,76,16,2,2
spr,199,88,16,2,2
spr,199,100,16,2,2
spr,199,112,16,2,2
spr,199,124,16,2,2
spr,208,24,13,3,1
spr,204,8,13,2,1
spr,205,1,13,1,1
spr,224,81,8,4,1
spr,220,84,13
spr,220,94,13
spr,221,107,13
spr,221,116,13
spr,228,2,20,2,2
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
]]local n=game_frames_frac/30/.00002if(n<night_time)center_print(night_time-n,64,1,0)else spr(231,60,1)night_palette_imm=true is_night=true
local t={{},{},{},{}}for n=1,#e do local n=e[n]local e=gp(n.pos[1],n.pos[2])add(t[e[2]],n)end for n=1,4do for e=1,8do local t=grid[n][e]for n=1,#t do t[n].draw()end local n=tp(e,n)end for n in all(t[n])do n.draw()end end palreset()if(temp_runner)for n in all(temp_runner.fake_hit)do local n=tp(n[1],n[2])spr(137+draw_time\2%4,n[1]+4,n[2]+2)end
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
if die3d.visible then rectfill(die3d.x,105,die3d.x+14,107,5)rectfill(die3d.x-1,106,die3d.x+15,106,5)local n,e,t=die_frames[die_time\die_spin%8+1],die3d.x-8,die3d.y-8pal(split"0,0,0,0,0,0,0")spr(n,e+1,t,2,2)spr(n,e-1,t,2,2)spr(n,e,t+1,2,2)spr(n,e,t-1,2,2)palreset()spr(n,e,t,2,2)die_time+=1elseif pl.current_ability~=nil then local n=pl.die[pl.current_ability]spr(76,die3d.x-7,die3d.y-7,3,2)n.draw_face(die3d.x-5,die3d.y-3)local e=n.name local t=print(e,0,-100)print(e,64-t/2+5,114,1)spr(130,64-t/2-5,114)if n.animal1~=nil then end end local n=6spr(132,3,1,1,2)local e=(pl.max_health+pl.shield)*7line(6,1,e+3,1,1)line(6,10,e+3,10,1)spr(132,e,1,1,2,true)for e=1,pl.max_health do if(e<=pl.health)spr(128,n,3)else spr(129,n,3)
n+=7end if(pl.shield_timer>0)local e=1-pl.shield_timer/shield_time for t=1,pl.shield do spr(145,n,3)local e=e*6sspr(64,64+e,8,6-e,n,3+e)n+=7end
if(victory)local n=min(victory_time,40)rectfill(34,n-5,94,n+8,0)rect(34,n-5,94,n+9,9)print("victory",50,n,10)
if(defeat)local n=min(defeat_time,40)rectfill(34,n-5,94,n+8,0)rect(34,n-5,94,n+9,2)print("defeat",52,n,8)
for n in all(attack_runners)do end if(time_scale<1or pause_extend>0)and not victory then poke(24404,96)for n=11,90do local e=mid(n/16-.5,0,1)local e=sin(n/26+draw_time/128)*e sspr(0,n,128,1,e*1.25,n)end poke(24404,0)if(draw_time%20>10)spr(133,59,54)
end end function gameplay_tick()game_frames_frac+=.00002local t,l=0,{}for n=1,8do for e=1,4do local n=grid[e][n]if(n.creature and n.creature.health>0and n.creature.side~=1)t+=1
for n in all(n)do add(l,n)end end end for n in all(l)do n.update()end for n in all(e)do n.update()end if not victory and not defeat then for n in all(attack_runners)do n:update()if(not n.alive)del(attack_runners,n)
end end if(t==0and not victory)victory=true victory_time=0
if(pl.health<=0and not defeat)defeat=true defeat_time=0
tf+=1if(rnd()<.5)make_creature_particle(128,rnd(60)+20,15,-3,rnd(52)+28)
local n=0for e=1,4do for t=1,8do n+=grid[e][t].space.side end end if n==32then victory=true elseif n==-32then defeat=true end end function update_gameplay()if(btnp(4))victory=true
if victory then victory_time+=1if victory_time>90then if(level==15)dset(0,dget(0)+1)state="win"else for n=1,6do player_abilities[n]=player_abilities[n].copy()end state="upgrade"
end time_scale=1end if(defeat)defeat_time+=1if defeat_time>120then end time_scale=1
temp_runner=nil if pl.stun_time<=0and not victory and not defeat then move_target=nil if(btnp(0)and pl.pos[1]>1)move_target={pl.pos[1]-1,pl.pos[2]}
if(btnp(1)and pl.pos[1]<8)move_target={pl.pos[1]+1,pl.pos[2]}
if(btnp(2)and pl.pos[2]>1)move_target={pl.pos[1],pl.pos[2]-1}
if(btnp(3)and pl.pos[2]<4)move_target={pl.pos[1],pl.pos[2]+1}
if move_target then if pl.overextended_timer==0then if(valid_move_target(move_target[1],move_target[2],pl.side))pl.move(move_target[1],move_target[2])time_scale=1
else time_scale=1end end local n=pl.die[pl.current_ability]if n~=nil then if(n.type=="attack")temp_runner=make_attack_runner(n.def,1,n,pl.pos[1],pl.pos[2],1,true)
end if(btnp(5)and pl.current_ability~=nil)n.use(pl,pl.pos[1],pl.pos[2],1)pl.die[pl.current_ability]=n.copy()pl.current_ability=nil pl.animate_time=5throw()time_scale=1
if(btnp(2,1))victory=true victory_time=90
end if time_scale>0then if(pause_extend>0)pause_extend-=1else gameplay_tick()
else end if die3d.visible then die3d.yv+=.3*pl.die_speed if die3d.y>100then if(die3d.yv>.5)for n=1,die3d.yv*10do local n=make_creature_particle(die3d.x+rnd(10)-5,106,5,rnd(1)-.5,106+rnd(3))n.yv=rnd(2)*-.5end
die3d.yv=die3d.yv*-.35die3d.y=100die3d.xv*=.5die_spin*=2end if die_time>45then pl.die_speed=1die3d.xv=0die3d.yv=0if pl.stun_time<=0then die3d.visible=false pl.current_ability=flr(rnd(6))+1if(is_night and pl.current_ability==4)pl.current_ability=-1
time_scale=0if(has_mod(pl.die[pl.current_ability],"pause"))pause_extend+=30
end end die3d.xv*=.975die3d.x+=die3d.xv die3d.y+=die3d.yv end end function do_level_intro()for n=1,60do if(n==30)pl=make_player()for n=1,6do pl.die[n]=player_abilities[n].copy()end pl.die[-1]=make_ability(all_abilities["curse"],1,{}).copy()
if(n==1)function place_monster(l,n,e,o)n=n or flr(rnd(4))+5e=e or flr(rnd(4))+1local t=parse_monster(t[l],n,e)t.move(n,e)t.favor_row=o return t end if level==1then place_monster("mage1",6,2,2)elseif level==2then place_monster"mage1"place_monster"fighter1"elseif level==3then place_monster"duelist1"place_monster"duelist1"elseif level==4then place_monster"engineer1"elseif level==5then place_monster"boss1"elseif level==6then place_monster"mage2"place_monster"mage2".abil_pattern_i=2elseif level==7then place_monster"fighter2"place_monster"fighter1"place_monster"fighter1"elseif level==8then place_monster"engineer1"place_monster"engineer1"place_monster"fighter1"elseif level==9then place_monster"bomber1"place_monster"bomber1".time=33place_monster"bomber1".time=66elseif level==10then place_monster"boss2"elseif level==11then place_monster"bomber2"place_monster"engineer2"elseif level==12then place_monster"duelist2"elseif level==13then place_monster"mage1"local n=place_monster"mage2"n.abil_pattern_i=2n.move_pattern_i=2local n=place_monster"mage3"n.abil_pattern_i=3n.move_pattern_i=3elseif level==14then place_monster"fighter2"local n=place_monster"fighter2"n.abil_pattern_i=2n.move_pattern_i=2place_monster"boss2"elseif level==15then place_monster"boss3"place_monster"engineer1"place_monster"fighter1"end
_draw()flip()end end level=0function start_level()is_night=false tf=0draw_time=0victory=false victory_time=0defeat=false defeat_time=0time_scale=1move_target=nil level+=1attack_runners={}e={}grid={}game_frames_frac=0pause_extend=0night_time=max(65-level*5,25)for n=1,4do grid[n]={}for e=1,8do grid[n][e]={}end end for n=1,4do for e=1,8do make_gridspace(e,n)end end die3d={x=10,y=84,xv=0,yv=0,visible=false}do_level_intro()throw()end function throw()sfx(16,1)local n={160,162,164,166,168,170,172,174}die_frames={}for e=1,8do local e=rnd(#n)\1+1add(die_frames,n[e])deli(n,e)end die_time=0die_spin=2die3d.visible=true die3d.x=20die3d.y=64die3d.xv=2.5die3d.yv=0dvra=.5-rnd()dvrb=.5-rnd()dvrc=.5-rnd()end current_upgrades=nil selected_upgrade_index=1applied={}faces_options2=split"x_____,_x____,__x___,___x__,____x_,_____x"upgrade_mods_names=split"growth,claim,pause,stun,poison,rage,invasion"upgrade_mods={}for n in all(upgrade_mods_names)do for e=1,all_mods[n][3]do add(upgrade_mods,n)end end function make_upgrade(t,n)local n={faces={},kind=n}for e=1,6do n.faces[e]=t[e]~="_"and t[e]or false end local o={{0,3},{3,3},{6,3},{9,3},{3,0},{3,6}}n.draw=function(e,t)if(n.kind=="hp")spr(142,e+4,t-2)print("+1 hp",e-3,t+7,0)else for l=1,6do local e,t,n=o[l][1]+e,o[l][2]+t+6,({["3"]=14,["2"]=14,["-"]=8,["1"]=12,x=12,[false]=5})[n.faces[l]]rectfill(e,t,e+1,t+1,n)end if sub(n.kind,1,1)=="+"then print("up",e+8,t-1,12)elseif all_abilities[n.kind]~=nil then local n=all_abilities[n.kind]spr(n[2],e+8,t-3)spr(n[5]+149,e-4,t-4)else spr(all_mods[n.kind][2],e+8,t)end
end return n end function draw_random_abil()local e,n=min(level\4+1,3),{}for e=-1,5do n[e]={}end for e,t in pairs(all_abilities)do add(n[t[5]],e)end if rnd()>.35or e==5then return rnd(n[e])else if(rnd()>.5)return rnd(n[e+1])else return rnd(n[e-1])
end end function update_upgrade()pl=nil tf+=1if current_upgrades==nil then current_upgrades={}local n={"hp",rnd(upgrade_mods),rnd(upgrade_mods),rnd(upgrade_mods),draw_random_abil(),draw_random_abil(),draw_random_abil()}if(level%3==0)n={"+1","+1","+1","+1"}
local t=split"11____,____11,__11__,1__1__,_2____,2_____,___2__,3-____"for o=1,4do local l=flr(rnd(#n)+1)local e=n[l]deli(n,l)local n="______"if(e=="+1")local n=rnd(#t)\1+1current_upgrades[o]=make_upgrade(t[n],e)deli(t,n)else printh(l)printh("here: "..e)n=rnd(faces_options2)current_upgrades[o]=make_upgrade(n,e)
end end if(btnp(0))selected_upgrade_index=(selected_upgrade_index-2)%#current_upgrades+1ssfx(14)
if(btnp(1))selected_upgrade_index=selected_upgrade_index%#current_upgrades+1ssfx(14)
if btnp(5)then player_abilities=applied if(current_upgrades[selected_upgrade_index].kind=="hp")max_hp+=1
current_upgrades=nil selected_upgrade_index=1state="gameplay"start_level()end end function draw_upgrade()cls(15)local n="level "..level+1 .."/15"print(n,64-#n*2,2,2)print("⬅️",1,30,1)print("➡️",120,30,1)print("- choose upgrade -",28,12,1)if current_upgrades~=nil then local e=current_upgrades[selected_upgrade_index]applied={}for n=1,6do applied[n]=player_abilities[n].copy()if(e.faces[n])if e.kind=="hp"then elseif sub(e.kind,1,1)=="+"then local e=({["3"]=3,["2"]=2,["-"]=-1,["1"]=1,[false]=0})[e.faces[n]]applied[n].pips=max(applied[n].pips+e,0)applied[n].original_pips=applied[n].pips elseif all_abilities[e.kind]~=nil then local e=all_abilities[e.kind]applied[n]=make_ability(e,applied[n].pips,applied[n].mods)center_print(applied[n].name,64,112,1)else applied[n].mods[#player_abilities[n].mods+1]=e.kind local n=all_mods[e.kind][4]center_print(n,64,112,1)end
end for n=1,#current_upgrades do temp_camera(-(n*26-12),-22,function()rectfill(0,0,22,23,7)current_upgrades[n].draw(5,5)local e=15if(n==selected_upgrade_index)e=12
rect(0,0,22,23,e)end)end draw_die2d(player_abilities,37,56,applied,e)end end function update_win()end function draw_win()cls()print("you win!!!",44,50,7)print("wins: "..dget(0),50,60,7)end state="title"states={title={update=update_title,draw=draw_title},newgame={update=update_newgame,draw=draw_newgame},gameplay={update=update_gameplay,draw=draw_gameplay},upgrade={update=update_upgrade,draw=draw_upgrade},win={update=update_win,draw=draw_win}}player_sprite=0function _init()state="title"night_palette_imm=false cartdata"dievirus"menuitem(1,"clear wins",function()dset(0,0)end)end function _draw()palreset()states[state].draw()pal(split"129,2,141,4,134,6,7,136,9,10,142,139,13,14,15,0",1)if(night_palette_imm)pal(split"129,2,141,4,134,5,6,136,9,10,142,3,13,14,15,0",1)night_palette_imm=false
end function _update()states[state].update()end
__gfx__
eeeeeee0099eeeeeeee0e000000eeeeeeeeee00000eeeeee22eeeeeee22eeeeeeeeeeee0099eeeeeeeeeeee0099eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee999999eeeeeee000044040eeeeeeee00aaaa0eeeee2eee4444ee2e0eeeeeeeee999999eeeeeeeeee999999eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee0404404eeeeeee00404404eeeeeeee0909909eeeeee222556652ee0ee0eeeeee0404404eeeeeeeee0404404eeeeeeeeeeeeeeeeeeeeee22eeeee00eeee
eeeeee004424eeeeeee0e044414eeeeeeee0099949eeeeeeee22505605e0eee0eeeeee004424eeeeeeeeee004424eeeeeeeeee000eeeeeeeeee200000020eeee
909eee000440eeeeeeeeee04444eeeeeeee00499990eeeeeeee445525ee0ee0e909eee000440eeee909eee000440eeeeeeeeeee0eeeeeeeeeee20bb272b0eeee
909eeee00000eeeeeeeeeee444eeeeeeeee00099700eeeeeeee444554eee00ee909eeee00000eeee909eeee00000eeeeeeeeee080eeeeeeeeee200000000eeee
e0eee422000eeeeeeeeee991449eeee0e9e00747770eeeeeee99244449ee0eeee0eee422000eeeeee0eee422000eeeeeeeeee0b8b0eeeeeeeee2e2b2eeeeeeee
ee0e44422992eeee0eee99114419eee0e96607777cc6eeeee559422229e0eeeeee0e44422992eeeeee0e44422992eeeeeeeee0888020eeeeeeeee2000eeeeeee
ee0422449924eeeee0ee11111111ee0ee6999677cc96eeeee544944445e0eeeeee0422449924eeeeee0422449924eeeeeeeee0b0b020eeeeeeeee2bbb0eeeeee
ee42ee4994e444eeee091e1111e1190ee66ee06444096eee54ee4999e50eeeeeee42ee4994e444eeee42ee4994e444eeeeeee08880eeeeeeeeeee22000eeeeee
ee40ee9924ee44eeee94e656565e149ee6666e77990699ee55ee4556e55eeeeeee40ee9924ee44eeee40ee9924ee44eeeeeee0b8b0eeeeeeeeeee2bbb0eeeeee
eeeee090000eeeeeeeee05656565e0eee6666ccc776666eeeeee2224e0eeeeeeeeeee090000eeeeeeeeee090000eeeeeeeeee00000eeeeeeeeeeee00002eeeee
eeee000e000deeeeeeee5656e65eeeeeee66cccccc6666eeeee2224220eeeeeeeeee000e000deeeeeeee000e000deeeeeeee2ee22e2eeeeeeeeeee0eee0eeeee
eeee00ddd0dddeeeeeee65eeee6eeeeeeee6ccccccc66eeeee2224e222eeeeeeeeee00ddd0dddeeeeeee00ddd0dddeeeeee0ee808ee0eeeeeeeeee0eeee0eeee
eee0ddddd444deeeeeee5ddddd444deeeeeccdddd449deeeeed5ddd5dddeeeeeeee0ddddd444deeeeee0ddddd444deeeee22888088822eeeeeeee2eeeee0eeee
ee444dddddeeeeeeeee444ddddddeeeeee994dddddeeeeeeed555dd555dddeeeee444dddddeeeeeeee444dddddeeeeeeee88e82228e88eeeeeee2eeeeee0eeee
eeeeeeeeeeeeeeeeeeeeeeee0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9999eeeeeeeeeeee9999eeeeeeeeeeee9999eeeeeeeeeeee9999eeeee
eeeeeeeeeeeeeeeeeeeeeeee0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8e998888e8eeeeee8e998888e8eeeeee8e998888e8eeeeee8e998888e8ee
eeeeeeeeeeeeeeeeeeeeee0000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88867768eeeeeeee88867768eeeeeeee88867768eeeeeeee88867768eee
eeeeeeeeeeeeeeeeeeeee0b8bb0eeeeeeeeeeeeeeeeeeeeeeee20000eeeeeeeee888ee770660eeeee888ee770660eeeee888ee770660eeeee888ee770660eeee
eeeeeeeeeeeeeeeeeeee0bb8b090eeeeeeeeeee0000eeeeeeee22bbb0eeeeeeeeee8ee776776eeeeeee8ee776776eeeeeee8ee776776eeeeeee8ee776776eeee
eeeeeeeeeeeeeeeeeee2200020a02eeeeeeeeeee0bbbb99aeee2b0b0eeeeeeeeeee888e077775eeeeee888e077775eeeeee888e077775eeeeee888e077775eee
eeeeee99aeeeeeeeeee0bbb8b0a02eeeeeee000b888b9aeeeee2bb0b0eeeeeeeeeeee770077066eeeeeee770077066eeeeeee770077066eeeeeee770077066ee
eeeee0009eeeeeeeeee0bbb8b0902eeeeeeee08bb78bbeeeeee2b08780eeeeeeeeee7770000067eeeeee7770000067eeeeee7770000067eeeeee7770000067ee
eee000809eeeeeeeeee08bb8bb080eeee0eee8bbbbbbeeeeeeee2bbbb0eeeeeeeeee6660067067eeeeee6660067067eeeeee6660067067eeeeee6660067067ee
ee0b08b0eeeeeeeeeee2b888888b2eeee00e8bbbbbbbaaeeeeeee2000eeeeeeeeeeee666667677eeeeeee666667677eeeeeee666667677eeeeeee666667677ee
e0888000eeeeeeeeeeee0bb8bbb0eeeeee00b8bbb8bbbeaeeeee00b8b00eeeeeeeeeeee5555e88eeeeeeeee5555e88eeeeeeeee5555e88eeeeeeeee5555e88ee
e02bb8bb0e00000eeeeee0b8bb0eeeeeee08888b888beeeeeeeee2b8b0eeeeeeeeeeee00000ee8eeeeeeee00000ee8eeeeeeee00000ee8eeeeeeee00000ee8ee
e0b2b8bbb20b8b0eeeeeee2222eeeeeee08888888888beeeeeeeee080eeeeeeeeeeeee00e00ee888eeeeee00e00ee888eeeeee00e00ee888eeeeee00e00ee888
e0b80022202b870eeeeee0bb8b0eeeeee088bee8888888eeeeeeee2b0eeeeeeeeeeeee0eee0eeeeeeeeeee0eee0eeeeeeeeeee0eee0eeeeeeeeeee0eee0eeeee
e08b2e0bb00b8b0eeeeeee0000eeeeeee08b0eee00e88beeeeeeeee2eeeeeeeeeeeeee0eee0eeeeeeeeeee0eee0eeeeeeeeeee0eee0eeeeeeeeeee0eee0eeeee
ee2222e22e22222eeeeeeeeeeeeeeeeee088b0ee000e88beeeeeeeeeeeeeeeeeeeeee777ee777eeeeeeee777ee777eeeeeeee777ee777eeeeeeee777ee777eee
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
d77777777777777dd77777777777777dd77777777777777dd77777777777777dd77777777777777dd77677767777677deee55555555555feeeeeeeeeeeeeeeee
d76667777776667dd77777777777777dd77677666677677dd76667666676667dd77767777776777dd76767677676767dee5555555555551eeeeeeeeeeeeeeeee
d76767777776767dd77667777776677dd76767777776767dd76767677676767dd77767777776777dd67776777767776de57777777777511eeeeeeeeeeeeeeeee
d77677777777677dd77666777766677dd76767666676767dd76667666676667dd76776777767767dd76777776777767de77777777777711eeeeeeeeeeeeeeeee
d77777766777777dd77777777777777dd77677677777677dd76767677676767dd77666677666677dd77676767777677de77777777777711eeeeeeeeeeeeeeeee
d77777677677777dd77777777777777dd77777777677777dd77677766777677dd77766666666777dd77767677676777de77777777777711eeeeeeeeeeeeeeeee
d77777766777777dd77777777777777dd77677666677677dd76767677676767dd77666677666677dd77677776767677de77777777777711eeeeeeeeeeeeeeeee
d77677777777677dd77666777766677dd76767777776767dd76667666676667dd76776777767767dd76777767777767de77777777777711eeeeeeeeeeeeeeeee
d76767777776767dd77667777776677dd76767666676767dd76767677676767dd77767777776777dd67776777767776de77777777777711eeeeeeeeeeeeeeeee
d76667777776667dd77777777777777dd77677777777677dd76667666676667dd77767777776777dd76767677676767de77777777777711eeeeeeeeeeeeeeeee
d77777777777777dd77777777777777dd77777777777777dd77777777777777dd77777777777777dd77677776777677de77777777777711eeeeeeeeeeeeeeeee
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddde777777777777115555555eeeeeeeeee
111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111e7777777777771555555555eeeeeeeee
111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111e577777777775555555555eeeeeeeeee
111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee111eeeeeee1e111111eeee11eeeeeee11eeeeeee111e11111eeeeeee1eeeeeeeeeeeeeeeeeeeeee111eeeee111eeeee111eeeee1111eeee111eee1eeeee
eeeeee11eeeeee1111111111eee11eeeeeeeee1eeeeeee111eeee11eeeeee11eee1e1eeeeeeeeeeeeee1eee1eee1eee1eee1eee1eee1ee11eeeee11eeee1ee1e
eeeeeee1eeeee11e11111111ee1111eeee1eee11eeeee1e1eeeeee1111111111ee1e1e1eeeeee111ee1111eeee1111eeee1111eeeeeee1e1eeeee11eeee11ee1
ee11eeee1eee11eee111111eee1111eeeee11e11eeee1eeeeeeeee11eeeeeeeeee1e1e1eeeeeee11e111111ee111111ee111111eeeee1ee1eeeee11eee111e11
e1eeeeee11e11eeee111111eee1111eeeeee1111eee1eeeeeeeee11eeeeee1eeee11111eeeeee1e1e1e1111ee111e11ee1111e1eeee1ee1eeeeee11ee111ee11
1eeeeeeee111eeeeee1111eeee1111eeee1e1111e11eeeeeeeee11eeeeeee11e1e11111e1eee1eeee1e1111ee11e111ee1111e1ee11eeeeeeeeee11e111ee111
1e111111e111eeeeee1111eeee1111ee1ee11111e11eeeeeeee11eee11111111e111111ee1e1eeeee111111ee111111ee111111e1e1eeeeeeeeee11eeeee1111
e11111111ee11eeeeee11eeee111111ee111111e1eeeeeeeee11eeeeeeeeeeeeeee111eeee1eeeeeee1111eeee1111eeee1111ee11eeeeeeeeee111eee11111e
e1e1eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee111eee11eeeeeeeeeeeeeeeeeeeeecceeee9ee9eeee5555eeee9e9eeeeee88eeeeee8eeeeeeeceeeeeee95eeeee
eeeee1eeeee1eeeeee1111eeeeeee1ee1e1eee11eee11ee1eeeeeeeeeeeeeeeeecccceeee9ee9eee5665eeee9e9eeeeeee88eeee8eeeeeeec7ceeeee5ee5eeee
1eeeeeeeee11111e11eeee11eeeeeeeee11eee11ee1111e1eeeeeeeeee0000eeeccceeee9ee9eeee5555eeee9e9eeeee88888eeee8eeeeeeccceeeeee59eeeee
eeeeee1eeee1eee11ee11ee1eee11eeee11eee11ee1111eeeeeeeeeee0ee000eceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88eeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeee111eeee11eee11eeee11eee11ee1111e1eeeeeeee0ee000e0eeeeeeeeeee88eeeeeeeeeeeeeeeeeeee88eeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee1111111111ee1111eeeeeeeeeee11eee11ee1111e1eeeeeeeee000000eeeeeeeeeeee88eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeee111111111eeeeeeeee1111eeeee11ee1e1ee1111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeee1111eeee111eeeeee111111eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
ee1eeeeeeeeeeeeee11111eee11111eeeee1eeeee77ee77eeeecceeeeee77eeee1111eeeee9a7eeeeeee99eeeeeeeeeeeeeeeeeeeeeeeeeeccccceeeee7799ee
ee1eeeeeeeeeeeee11f1f11e11ccc11eee1eeeee7cc77cc7eeecceeeeee77eee1cccc1eee9eeeeeeeeeeee9eeeeeeeeeeeeeeeeeeeeeeeeeceeeceee9977ee99
e111eeeee888eeee111f111e11c1c11ee1eeeeee7cc77cc7eeecceeeeee77eee1cccc1ee9eeeeeeeeeeeeee9eeeeeeee7eeeeeeeeeeeeeeeececeeee9eeeeee9
e111eeeeeeeeeeee11f1f11e11ccc11ee1eeeeee7cc77cc7eeecceeeeee77eeee1cc1eee9ee99eeeeee99eeaeee99ee9aee99eeeeeeeeeeeeeceeeee99ee7799
11111eeeeeeeeeee5111115e5111115ee1eeeeee7cc77cc7eeecceeeeee77eeee1cc1eeeeeeeeeeeeeeeeee7eeeeeee99eeeeeee8eeeeeeeeeceeeeeee9977ee
11111eeeeeeeeeeee55555eee55555eee1eeeeee7cc77cc7eeeeeeeeeeeeeeeeee11eeeeeeeeeeeeeeeeeeeeeeeeee9ee9eeeeee8eeeeeeeeeceeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1eeeeee7cc77cc7eeecceeeeee77eeeeeeeeeeeeeeeeeeeeeeeeeeeeee7a9eeee999eee88eeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1eeeeeee77ee77eeeecceeeeee77eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888eeeeeeeeeeeeeeeeeeee
ee9999eee1111eeeeeeeeeeeeeeeeeeeee1eeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
99eeee771eeee1eeeeeeeeeeeeeeeeeeeee1eeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
77eeee771eeee1eeeeeeeeeeeeeeeeeeeeeeeeee00eeeeee22eeeeee44eeeeee66eeeeeea9eeeeeecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
77eeee99e1ee1eeeeeeeeeeeeeeeeeeeeeeeeeee0ee000ee2eee2eee4ee444ee6eee55ee9eeaeaeeceeccceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
ee9999eee1ee1eeeeeeeeeeeeeeeeeeeeeeeeeeeeee0e0eeeee22eeeeeeee4eeeeeee5eeeeeaaaeeeeecceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee11eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0e0eeeeee2eeeeee44eeeeeee55eeeeeeeaeeeeeeeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000eeeee222eeeee444eeeee555eeeeeeeaeeeeeccceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
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
eeeeeeeeeeeeeeeeeeeeeeef50eeeeeeeeeeeeef755eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee77f50eeeeeeeeee77ff5500eeeeeeeeee7fee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffeeeeeeeee6666666eeeeeeeeeeeeeeeeeeeee
f7f7ffff550eeeeee7fffffff55550eeee7fffeeeeee55555eeeeeeeeeeeeeeeeeeeeeeeeeeee33333333333333eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
fffffffff5555f5ffffffffff55555f5eeeeeeeeeeeeee5555555e5eeeeeeeeeeeeeeeee3ffff3ffffffffffff35fff5eeee6666666eeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555eeeeeeeeeeeeeeeeeeeeeeeeeeeee3ffff3ffffffffffff355ff3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
e7fff55eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5555eeeeeeeeeeffffffffffffeeee333333fff333333fff33333366666666666eeeeeeeeeeeeeeeeeeeee
ffffff55555f5feee77f7ff5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffeeeeffffffff3eeee553fffffff5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
fffffffffffffffffffffffffffff55eeeeeeeeeeeeeeeeeeeeeeeee333333333333eeeefffffff3eeeeee553ffffff56e6e6e6e6e6eeeeeeeeeeeeeeeeeeeee
eeeeeeeeee6666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee555555555553eeeeff5555f3eeeeeee53f5555f5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee5555eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee333333333333eeeeff5ff5f3eeeeeee53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeecec6666ecceceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffff5eeeeff5cf5f3ee6eeee53f5ff5f5eeeeeeeeeeeeeeeeeeeeeeeeeeceeeee
eee6cc655665566556cc66eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffff5eeeeff5cf5f3666ee6e53f5ff5f5eeeeeeeeeeeeeeeee6eee6eececceeee
eee6c55666655666655cc6eeeeeeeeeeeeeeeeeeceeeeeeeeeeeeeeefffffffffff5eeeeff5cf5c3666e66e53f5ff5f5eeeeeeeeeeeeeeeee666e666cecccece
ece55666cc65566cc66556ceeeeeeeeeeeeeceeecceeeeeeeeeeeeeefffffffffff5eeeeff5cf5c3666e66ec3fcff5f5666ee666eeeeeeeeeeeeeeeeeeeeeeee
e5566666c66556666666655eeeeeeeceeeeecceccceeeeeeceeeeeeefffffffffff5eeeefcccf5c3666ec6eccfcfc5f5666666666666666666eeeeee66eeeeee
566666666665566666666665ceeccecccecccccccccceccececeeeeefffffffffff5eeeefcccf5c366ce6ceccfccccc5666666666666666666666eee66666eee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccceeeeeeeeeeeeecceeeeeeee7000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeee66666666666666eeeeeeeeeecccceeceeeeecceecceeeceee700077eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccecceecceeeeeceeee70007777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeee66e66666666666666e66eeeeeeeeeeeeceeceeeeeeeeeeeeeee70007777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeee70007777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
66666666666666666666666666666eeeeeeeeceeceeeeeeeeeeeeeee70007777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeee700077eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
6e6e6e6e6e6e6e6e6e6e6e6e6e6e6eeeeeeeeceeceeeeeeeeeeeeeeeee7000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeceeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecceeceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecceceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
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
00088880088880088880088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088880088880088880088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088880088880088880088880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888800888800888800888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888800888800888800888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00888800888800888800888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888008888008888008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08888008888008888008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8888888888888888888888888888888888888888888888888888888888888888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
8228228222228888822822822222888882282282222288888228228222228888c11c11c11111ccccc11c11c11111ccccc11c11c11111ccccc11c11c11111cccc
8888888282822888888888828282288888888882828228888888888282822888ccccccc1c1c11cccccccccc1c1c11cccccccccc1c1c11cccccccccc1c1c11ccc
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111888821111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11118555221111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111858521111cc11111111111111c
8888888888888888888888888888888888888888888888888888888888888888ccccccccccccccccccccccccccccccccccccc858552ccccccccccccccccccccc
88888888888888888888888888888888888888888888888888888888888888888888a88888888888cccccccccccccccccccc8171852ccccccccccccccccccccc
8228228222228888822822822222888882282282222288888aaaaa822aaaaaa88a85558aaaaaaaa8caaaaaaaaaaaaaacc11c85555211ccccc11c11c11111cccc
8888888282822888888888828282288888888882828228888a888882828228a88aa222aaaaaaaaa8caaaaaaaaaaaaaacccccc88821c11cccccccccc1c1c11ccc
8222222222222228822222222222222882222222222222288a222222222222a88a85558aaaaaaaa8caaaaaaaaaaaaaacc11885158811111cc11111111111111c
8222222222222228822222222222222882222222222222288a222222222222a88aa8a8aaaaaaaaa8caaaaaaaaaaaaaacc11185152111111cc11111111111111c
82222222222222288222222222222228822222222222222882222222222222288aaaaaaaaaaaaaa8caaaaaaaaaaaaaacc11118181111111cc11111111111111c
82222222222222288222222bbbb22228822222222222222882222222222222288aaaaaaaaaaaaaa8caaaaaaaaaaaaaacc11118521111111cc11111111111111c
8222222222222228822222b5155b222882222222222222288a222222222222a88a11111aaaaaaaa8caaaaaaaaaaaaaacc11111211111111cc11111111111111c
8222222222222228822222bb7bb7b22882222222222222288a222222222222a88aaaaaaaaaaaaaa8caaaaaaaaaaaaaacc11111111111111cc11111111111111c
8222222222222228822222b5155b222882222222222222288a222222222222a88aaaaaaaaaaaaaa8caaaaaaaaaaaaaacc11111111111111cc11111888821111c
8222222222222228822222b5155b222882222222222222288a222222222222a88aaaaaaaaaaaaaa8caaaaaaaaaaaaaacc11888888888811cc11118555221111c
82222222222222288222222b15b2222882222222222222288aaaaa222aaaaaa88aaaaaaaaaaaaaa8caaaaaaaaaaaaaacc11111111111111cc11111858521111c
888888888888888888888bb515b88888888888888888888888888888888888888888888888888888ccccccccccccccccccccccccccccccccccccc858552ccccc
88888888888888888888b55bbb38888888888888888888888888888888888888ccccccccccccccccccc8a8cccccccccccccccccccccccccccccc8171852ccccc
8228228222228888822b1b111133888882282282222288888228228222228888caaaaac11aaaaaacca85558aaaaaaaaccaaaaaaaaaaaaaacc11c85555211cccc
888888828282288888b5b8b51383538888888882828228888888888282822888caccccc1c1c11caccaa222aaaaaaaaaccaaaaaaaaaaaaaacccccc88821c11ccc
822222222222222882bbb2b51322332882222222222222288222222222222228ca111111111111acca85558aaaaaaaaccaaaaaaaaaaaaaacc11885158811111c
82222222222222288222233515b2222882222222222222288222222222222228ca111111111111accaa8a8aaaaaaaaaccaaaaaaaaaaaaaacc11185152111111c
822222222222222882223532bbb2222882222222222222288222222222222228c11111111111111ccaaaaaaaaaaaaaaccaaaaaaaaaaaaaacc11118181111111c
8222222222222228822233111b12222882222222222222288222222222222228c11111111111111ccaaaaaaaaaaaaaaccaaaaaaaaaaaaaacc11118521111111c
8222222222222228821b11111bbb122882222222222222288222222222222228ca111111111111acca11111aaaaaaaaccaaaaaaaaaaaaaacc11111211111111c
822222222222222882bbb1111112222882222222222222288222222222222228ca111111111111accaaaaaaaaaaaaaaccaaaaaaaaaaaaaacc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228ca111111111111accaaaaaaaaaaaaaaccaaaaaaaaaaaaaacc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228ca111111111111accaaaaaaaaaaaaaaccaaaaaaaaaaaaaacc11888888888811c
8222222222222228822222222222222882222222222222288222222222222228caaaaa111aaaaaaccaaaaaaaaaaaaaaccaaaaaaaaaaaaaacc11111111111111c
8888888888888888888888888888888888888888888888888888888888888888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
8888888888888888888888888888888888888888888888888888888888888888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
8228228222228888822822822222888882282282222288888228228222228888c11c11c11111ccccc11c11c11111ccccc11c11c11111ccccc11c11c11111cccc
8888888282822888888888828282288888888882828228888888888282822888ccccccc1c1c11cccccccccc1c1c11cccccccccc1c1c11cccccccccc1c1c11ccc
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8222222222222228822222222222222882222222222222288222222222222228c11111111111111cc11111111111111cc11111111111111cc11111111111111c
8888888888888888888888888888888888888888888888888888888888888888cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
15555555555555551555555555555555155555555555555515555555555555551555555555555555155555555555555515555555555555551555555555555555
15656565656565651565656565656565156565656565656515656565656565651565656565656565156565656565656515656565656565651565656565656565
16565656565656551656565656565655165656565656565516565656565656551656565656565655165656565656565516565656565656551656565656565655
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000cccccccccccccccc0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00000000000000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00000000000000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00008882880000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00088882888000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00888882888800c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00222222222200c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00088882888000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00088882888000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00008882880000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00008882880000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c0000088280aaa0c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00000082000000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c0000000000aaa0c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c00000000000000c0000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000cccccccccccccccc0000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000bb0bbb0bbb0bb0000000bb0b0b0bbb0bbb0b000bb00000000000000000000000000000000000000000000
000000000000000000000000000000000000000000b000b0b00b00b0b00000b000b0b00b00b000b000b0b0000000000000000000000000000000000000000000
000000000000000000000000000000000000000000b000bbb00b00b0b00000bbb0bbb00b00bb00b000b0b0000000000000000000000000000000000000000000
000000000000000000000000000000000000000000b0b0b0b00b00b0b0000000b0b0b00b00b000b000b0b0000000000000000000000000000000000000000000
000000000000000000000000000000000000000000bbb0b0b0bbb0b0b00000bb00b0b0bbb0bbb0bbb0bbb0000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__meta:title__
bn2
by morganquirk
