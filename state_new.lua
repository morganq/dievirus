function parse_class(name,spri, wins, s)
    local class = {
        name=name,
        spri=spri,
        wins_needed=wins,
        abilities = {},
    }
    for abil_s in all(split(s,"/")) do
        add(class.abilities, parse_ability(abil_s))
    end
    return class
end
classes = {
    --parse_class("test", 0, 0, "pinch,2/mortar,2/pinch,2/bouncer,1,stun/sling,1,stun/sword,1,stun"),
    --parse_class("test", 0, "wall,1/wall,1/wall,1/wall,1/wall,1/wall,1"),
    parse_class("commander",0, 0, "sling;1;stun/sling;1/sword;2/shield;1/spear;1/bomb;1"),
    parse_class("fencer",36, 0, "sword;1/shield;1/spear;1/slap;1/scythe;1;claim/scythe;2"),
    parse_class("wizard",34, 0, "wave;1/wave;1/wall;1;stun/sword;1/bomb;2/shield;1"),
    --parse_class("vanguard", 0, "sword,1/sword,2/spear,2/spear,1/shield,2/bomb,1"),
    parse_class("engineer",32, 0, "turret;1/turret;1/bomb;1/bomb;1/sling;1/shield;1"),
    --parse_class("druid", 3, "gun,1/sword,1/shield,1/none,1/shield,1/bomb,1"),
}
selected_class_index = 1
function update_newgame()
    if btnp(0) then
        selected_class_index = (selected_class_index - 2) % #classes + 1
    end
    if btnp(1) then
        selected_class_index = selected_class_index % #classes + 1
    end    
    if btnp(5) and dget(0) >= classes[selected_class_index].wins_needed then
        state = "gameplay"
        local abilities = {}
        for i = 1,6 do
            player_abilities[i] = classes[selected_class_index].abilities[i]
            --player_abilities[i].mods = {"claim"}
        end
        --level = 4
        player_sprite = classes[selected_class_index].spri
        start_level()
    end
end

function draw_newgame()
    cls(15)
    print("⬅️", 4, 20, 0)
    print("➡️", 120, 20, 0)
    local cl = classes[selected_class_index]
    local color = 1
    if dget(0) < cl.wins_needed then
        color = 8
        print("unlocked after " .. cl.wins_needed .. " wins", 22, 28, color)
    else
        local s = "❎ to choose "..cl.name
        print(s, 64 - #s * 2, 116, 0)
        spr(cl.spri, 56, 86, 2, 2)
    end
    print(cl.name, 64 - #cl.name * 2, 20, color)
    draw_die2d(cl.abilities, 37, 36)
    
    
end