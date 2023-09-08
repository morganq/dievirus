abilities = {}
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
    parse_class("commander", 0, "gun,1/gun,1/sword,2/shield,1/bomb,1/bomb,1"),
    parse_class("vanguard", 0, "sword,1/sword,2/spear,2/spear,1/shield,2/bomb,1"),
    parse_class("wizard", 0, "wave,1/wave,2/wave,1/sword,1/bomb,2/shield,1"),
    parse_class("engineer", 0, "turret,1/turret,2/bomb,2/bomb,1/gun,1/shield,1"),
    parse_class("druid", 3, "gun,1/sword,1,leaf/shield,1/none,1/shield,1,leaf/bomb,1,leaf"),
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
        for i = 1,6 do
            abilities[i] = classes[selected_class_index].abilities[i]
        end
        start_level(1)
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