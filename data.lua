shield_time = 30 * 15
max_hp = 4
local monster_palettes = {
    split("1,2,5,4,5,6,7,9,10,7,11,12,13,14,15"),
    split("1,2,5,4,5,6,7,4,6,7,11,12,13,14,15")
}

imgs_base = {sword=64, gun=66, bomb=68, none=70, shield=72, turret=74, wave=76, spear=78}
bases = split("sword,gun,bomb,shield,turret,wave,spear")
animals = split("tiger,elephant,bat,frog,bee,snail,rabbit,snake,ox,monkey,fox,penguin,leaf,monster")
spranimals = {}
for k,v in pairs(animals) do
    spranimals[v] = k + 95
end
enabled_animals = split("elephant,rabbit,fox")

function parse_descriptions(s)
    local descs = {}
    for line in all(split(s,"\n")) do
        local parts = split(line,":")
        descs[parts[1]] = parts[2]
    end
    return descs
end
local descriptions = parse_descriptions([[
sword:slice ahead, claim 1 tile
spear:stab forward
gun:instant hit at range
bomb:throw explosive
shield:gain shield
turret:build turret
wave:cast damaging wave
sword/leaf:gain +1 pip on use
spear/leaf:gain +1 pip on use
gun/leaf:gain +1 pip on use
bomb/leaf:gain +1 pip on use
shield/leaf:gain +1 pip on use
turret/leaf:gain +1 pip on use
wave/leaf:gain +1 pip on use
sword/elephant:drop tiles
spear/elephant:drop tiles
gun/elephant:stun enemy
bomb/elephant:drop tiles
shield/elephant:+2 shield, drop tile below
turret/elephant:+2 turret health, stun self
wave/elephant:drop tiles
sword/rabbit:v shape
spear/rabbit:sideways, +1 damage
gun/rabbit:quick roll
bomb/rabbit:x shape
shield/rabbit:quick roll
turret/rabbit:jumps every shot
wave/rabbit:diagonal, +1 damage
sword/fox:burn tiles
spear/fox:burn tiles
gun/fox:burn tile
bomb/fox:burn tiles
shield/fox:burn tile ahead
turret/fox:random fires
wave/fox:fast wave
]])