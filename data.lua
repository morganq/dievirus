shield_time = 30 * 15
max_hp = 4
monster_palettes = {
    split("1,2,5,4,5,6,7,9,10,7,11,12,13,14,15"),
    split("1,2,5,4,5,6,7,4,6,7,11,12,13,14,15")
}

-- image, grid image, type, speed, name, description,
abilities_str = split([[
96,240,instant,0,Slap,
64,240,instant,0,Sword,
98,241,instant,0,Poke,
76,242,wave,4,Wave,
78,243,instant,0,Spear,
100,244,instant,0,Scythe,
68,245,bomb,1,Bomb,
102,246,wave,4,Split,
66,247,bullet,8,Gun,
104,248,bomb,1,Wall,
72,0,shield,0,Shield,
]],"\n")

mods = {Growth = 208, Fast = 209, Claim = 210}

abilities = {}
for i = 2, #abilities_str-1 do
    local abil_def = split(abilities_str[i])
    abil_def.mods = {}
    add(abilities, abil_def)
end