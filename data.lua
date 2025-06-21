shield_time = 30 * 15
max_hp = 4
monster_palettes = {
    split("1,2,5,4,5,6,7,9,10,7,11,12,13,14,15"),
    split("1,2,5,4,5,6,7,4,6,7,11,12,13,14,15")
}

-- image, grid image, type, speed, name, description,
abilities_str = split([[
96,240,instant,0,Slap,
64,249,instant,0,Sword,
98,241,instant,0,Poke,
76,242,wave,4,Wave,
78,243,instant,0,Spear,
100,244,instant,0,Scythe,
68,245,bomb,1,Bomb,
102,246,wave,4,Split,
66,247,bullet,8,Gun,
104,248,bomb,1,Wall,
72,0,shield,0,Shield,
74,0,turret,0,Turret,
]],"\n")

mod_defs = {Growth = 208, Fast = 209, Claim = 210}

abilities = {}
for i = 1, #abilities_str-1 do
    local abil_def = split(abilities_str[i])
    abil_def.mods = {}
    add(abilities, abil_def)
end

local monster_defs = {
    mage1 =     "164|0|Wave,1|3|60|move_pattern=xx_|abil_pattern=__x",
    fighter1 =  "41|0|Sword,1,Claim|5|25|move_pattern=xx_|abil_pattern=__x",
    duelist1 =  "168|0|Wave,1/Sword,2|7|25|move_pattern=xxx_|abil_pattern=___x",
    engineer1 = "9|0|Turret,2/Gun,1|8|65|flies=1|abil_pattern=_x",
    boss1 =     "132|0|Bomb,2/Wave,1/Shield,1/Sword,3|20|15|flies=1|abil_pattern=____x_x_|move_pattern=xxxx____",
    bomber1 =   "5|0|Bomb,2|10|99",
    mage2 =     "164|1|Wave,2|8|40|move_pattern=xx_|abil_pattern=__x",
    fighter2 =  "41|1|Sword,3/Spear,3|10|30|abil_pattern=_x",
    boss2 =     "132|1|Gun,3/Turret,3/Shield,3/Wave,3|30|20|flies=1|abil_pattern=______x_x_x_|move_pattern=xxxx___x_x_x",
    bomber2 =   "5|2|Bomb,2|15|39|abil_pattern=_x_",
    engineer2 = "9|2|Turret,4/Gun,2/Shield,2|10|45|flies=1|abil_pattern=_x",
    duelist2 =  "168|2|Wave,3/Sword,4/Spear,4/Shield,2|14|21|move_pattern=xxx_|abil_pattern=___x",
    mage3 =     "164|2|Wave,4/Wave,4|15|40|move_pattern=xx_|abil_pattern=__x",
    boss3 =     "168|2|Wave,3/Wave,1/Shield,1/Spear,1|40|21|move_pattern=xxx_|abil_pattern=___x",
}