shield_time = 30 * 15
max_hp = 4
monster_palettes = {
    split("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"),
    split("1,2,5,4,5,6,7,4,6,7,11,12,13,14,15")
}

-- image, type, def, name, description,
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
abilities_str = split([[
104,attack, 0/0b0000010000000000.0000000000000000/0/0/0/0,slap,0
112,attack, 0/0b0000000000000100.0000000000000000/0/0/0/25,rock,0
97,attack,  0/0b1010010000000000.0000000000000000/0/0/0/0,sword,1
101,attack, 0/0b0000010000000000.0000000000000000/7/0/0/0/2,spear,1
100,attack, 0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,wave,1
107,attack, 0/0b0000000001001110.0100000000000000/0/0/0/35,bomb,1
96,attack,  0/0b0100000000000000.0000000000000000/30/0/1/5/8,sling,1
105,attack, 0/0b0100000000000000.0000000000000000/5/-5/1/15/10/1/1,rico,2
109,attack, 0/0b0000010001000100.0000000000000000/0/0/0/0,lance,2
102,attack, 0/0b1010111000000000.0000000000000000/0/0/0/0,scythe,2
103,attack, 0/0b1010000000000000.0000000000000000/3/0/0/15,split,2
113,attack, 0/0b0000010000000000.0000000000000000/6/0/0/15/6/1/0,bouncer,2
110,attack, 0/0b0000000000000000.1000000000000000/0/30/0/30/4/0/0/0/1,wall,2
114,attack, 0/0b0000000000000000.0000011001100000/0/0/0/35/4/0/0/1/1,mortar,2
111,attack, 0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0;15/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,double,3
116,attack, 0/0b0000000000000001.0000000000000000/0/-30/0/10/4/0/0/0/1;10/0b0000000000000000.1000000000000000/0/30/0/10/4/0/0/0/1,pinch,3
98,shield,,shield,1
99,turret,,turret,2
119,curse,,curse,-1
]],"\n")

mod_defs = {growth = 120, fast = 121, claim = 122, pause = 123, invasion = 124, rage = 125, poison = 126, stun = 127}
mod_descriptions = {
    growth="gets stronger each use\nin battle",
    fast="roll the next die faster",
    claim="claim up to 2 of\nthe tiles hit",
    pause="time stands still for\na moment longer",
    invasion="+1 pip if standing\nin enemy territory",
    rage="+1 pips if less than\nhalf health",
    poison="deals poison damage instead",
    stun="stuns the enemy for\na moment"
}

abilities = {}
for i = 1, #abilities_str-1 do
    local abil_def = split(abilities_str[i])
    abil_def.mods = {}
    add(abilities, abil_def)
end

local monster_defs = {
    mage1 =     "12|0|wave,1|3|60|move_pattern=xx_|abil_pattern=__x",
    fighter1 =  "8|0|sword,1,claim/sword,1|5|28|move_pattern=xx_|abil_pattern=__x",
    duelist1 =  "14|0|wave,1/sword,2/sword,1,claim|7|32|move_pattern=xxx_|abil_pattern=___x",
    engineer1 = "6|0|turret,2/sling,1|8|65|flies=1|abil_pattern=_x",
    boss1 =     "10|0|bomb,2/wave,1/shield,1/sword,3|20|15|flies=1|abil_pattern=____x_x__|move_pattern=xxxx_____",
    bomber1 =   "4|0|bomb,2|10|99",
    mage2 =     "12|1|wave,2|8|40|move_pattern=xx_|abil_pattern=__x",
    fighter2 =  "8|1|sword,3/spear,3|10|30|abil_pattern=_x",
    boss2 =     "10|1|sling,3/turret,3/shield,3/wave,3|30|20|flies=1|abil_pattern=______x_x_x_|move_pattern=xxxx___x_x_x",
    bomber2 =   "4|2|bomb,2|15|39|abil_pattern=_x_",
    engineer2 = "6|2|turret,4/sling,2/shield,2|10|45|flies=1|abil_pattern=_x",
    duelist2 =  "14|2|wave,3/sword,4/spear,4/shield,2|14|21|move_pattern=xxx_|abil_pattern=___x",
    mage3 =     "12|2|wave,4/wave,4|15|40|move_pattern=xx_|abil_pattern=__x",
    boss3 =     "10|2|wave,3/wave,1/shield,1/spear,1|40|21|move_pattern=xxx_|abil_pattern=___x",
}

-- third mod crash