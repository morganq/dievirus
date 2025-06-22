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
]]
abilities_str = split([[
104,attack,0/0b0000010000000000.0000000000000000/0/0/0/0,Slap,0
97,attack, 0/0b1010010000000000.0000000000000000/0/0/0/0,Sword,1
101,attack,0/0b0000010000000000.0000000000000000/6/0/0/0/8,Lance,1
100,attack,0/0b0000010000000000.0000000000000000/4/0/0/15/8/0/0,Wave,1
106,attack, 0/0b0000010011100100.0000000000000000/0/0/0/30,NBomb,1
107,attack, 0/0b0000000001001110.0100000000000000/0/0/0/35,Bomb,1
108,attack, 0/0b0000000000000100.11100100000000000000/0/0/0/40,FBomb,1
96,attack, 0/0b0100000000000000.0000000000000000/30/0/1/5/8,Sling,1
105,attack, 0/0b0100000000000000.0000000000000000/5/5/1/15/10/1/1,BounceWave,2
101,attack,0/0b0000010001000100.0000000000000000/0/0/0/0,Spear,2
102,attack,0/0b1010111000000000.0000000000000000/0/0/0/0,Scythe,2
103,attack,0/0b1010000000000000.0000000000000000/3/0/0/15,Split,2
105,attack,0/0b0000000000000000.1000000000000000/0/30/0/0,Wall,2
98,shield,,Shield,1
99,turret,,Turret,2
]],"\n")

mod_defs = {Growth = 120, Fast = 121, Claim = 122}

abilities = {}
for i = 1, #abilities_str-1 do
    local abil_def = split(abilities_str[i])
    abil_def.mods = {}
    add(abilities, abil_def)
end

local monster_defs = {
    mage1 =     "12|0|Wave,1|3|60|move_pattern=xx_|abil_pattern=__x",
    fighter1 =  "8|0|Sword,1,Claim/Sword,1|5|28|move_pattern=xx_|abil_pattern=__x",
    duelist1 =  "14|0|Wave,1/Sword,2|7|25|move_pattern=xxx_|abil_pattern=___x",
    engineer1 = "6|0|Turret,2/Sling,1|8|65|flies=1|abil_pattern=_x",
    boss1 =     "10|0|Bomb,2/Wave,1/Shield,1/Sword,3|20|15|flies=1|abil_pattern=____x_x_|move_pattern=xxxx____",
    bomber1 =   "4|0|Bomb,2|10|99",
    mage2 =     "12|1|Wave,2|8|40|move_pattern=xx_|abil_pattern=__x",
    fighter2 =  "8|1|Sword,3/Spear,3|10|30|abil_pattern=_x",
    boss2 =     "10|1|Sling,3/Turret,3/Shield,3/Wave,3|30|20|flies=1|abil_pattern=______x_x_x_|move_pattern=xxxx___x_x_x",
    bomber2 =   "4|2|Bomb,2|15|39|abil_pattern=_x_",
    engineer2 = "6|2|Turret,4/Sling,2/Shield,2|10|45|flies=1|abil_pattern=_x",
    duelist2 =  "14|2|Wave,3/Sword,4/Spear,4/Shield,2|14|21|move_pattern=xxx_|abil_pattern=___x",
    mage3 =     "12|2|Wave,4/Wave,4|15|40|move_pattern=xx_|abil_pattern=__x",
    boss3 =     "10|2|Wave,3/Wave,1/Shield,1/Spear,1|40|21|move_pattern=xxx_|abil_pattern=___x",
}