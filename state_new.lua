function parse_class(name, wins, s)
    local class = {
        name=name,
        wins_needed=wins,
        abilities = {},
    }
    for abil_s in all(split(s,"/")) do
        add(class.abilities, parse_ability(abil_s))
    end
    return class
end
classes = {
    parse_class("commander", 0, "Gun,1/Gun,1/Sword,2/Shield,1/Bomb,1/Bomb,1"),
    parse_class("fencer", 0, "Sword,1/Slap,1,Growth/Spear,1/Shield,1/Scythe,1,Claim/Scythe,2"),
    parse_class("wizard", 0, "Wave,1/Wave,2/Wall,1/Sword,1/Bomb,2/Shield,1"),
    --parse_class("vanguard", 0, "Sword,1/Sword,2/Spear,2/Spear,1/Shield,2/Bomb,1"),
    parse_class("engineer", 0, "Turret,1/Turret,2/Bomb,2/Bomb,1/Gun,1/Shield,1"),
    --parse_class("druid", 3, "Gun,1/Sword,1/Shield,1/None,1/Shield,1/Bomb,1"),
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
            --player_abilities[i].mods = {"Claim"}
        end
        start_level()
    end
end

function draw_newgame()
    cls()
    print("⬅️", 4, 20, 7)    
    print("➡️", 120, 20, 7)
    local cl = classes[selected_class_index]
    local color = 7
    if dget(0) < cl.wins_needed then
        color = 6
        print("unlocked after " .. cl.wins_needed .. " wins", 22, 28, 6)
    else
        local s = "❎ to choose "..cl.name
        print(s, 64 - #s * 2, 96, 7)
    end
    print(cl.name, 64 - #cl.name * 2, 20, color)
    draw_die2d(cl.abilities, 30, 36)
    
    
end