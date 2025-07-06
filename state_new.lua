    --parse_class("test", 0, 0, "pinch,2/mortar,2/pinch,2/bouncer,1,stun/sling,1,stun/sword,1,stun"),
    --parse_class("test", 0, "wall,1/wall,1/wall,1/wall,1/wall,1/wall,1"),
    --parse_class("vanguard", 0, "sword,1/sword,2/spear,2/spear,1/shield,2/bomb,1"),
    --parse_class("druid", 3, "gun,1/sword,1/shield,1/none,1/shield,1/bomb,1"),

function make_die(as)
    local die = {}
    local sas = split(as,"/")
    for i = 1,6 do
        die[i] = parse_ability(sas[i])
    end    
    return die
end

--1,test,0,0,shield;1/shield;1/shield;1/shield;1/shield;1/shield;1
classes = string_multilookup([[
1,commander,0,0,sling;1/sling;1/sword;2/shield;1/spear;1/bomb;1
2,fencer,2,0,sword;1/shield;1/spear;1/slap;1/scythe;1;claim/scythe;2
3,wizard,4,0,wave;1/wave;1/wall;1/sword;1/bomb;2/shield;1
4,engineer,6,0,turret;1/bomb;1/bomb;1/turret;1/sling;1/shield;1
]])
selected_class_index = 1
function update_newgame()
    if btnp(0) then
        selected_class_index = (selected_class_index - 2) % #classes + 1
        ssfx(14)
    end
    if btnp(1) then
        selected_class_index = selected_class_index % #classes + 1
        ssfx(14)
    end    
    local cl = classes[selected_class_index]
    if btnp(5) and dget(0) >= cl[4] then
        state = "gameplay"
        player_abilities = make_die(cl[5])
        --level = 4
        player_sprite = cl[3]
        start_level()
    end
end

function draw_newgame()
    cls(15)
sfn([[
rectfill,56,100,71,128,6
rectfill,56,100,71,122,5
rectfill,56,100,71,114,3
pal,6,7
spr,64,56,92,2,2
palreset
]])

    print("⬅️", 4, 20, 0)
    print("➡️", 120, 20, 0)
    local cl = classes[selected_class_index]
    local color = 1
    if dget(0) < cl[4] then
        color = 8
        print("unlocked after " .. cl[4] .. " wins", 22, 28, color)
    else
        local s = "❎ to choose "..cl[2]
        print(s, 64 - #s * 2, 116, 0)
        spr(cl[3], 56, 86, 2, 2)
    end
    print(cl[2], 64 - #cl[2] * 2, 20, color)
    draw_die2d(make_die(cl[5]), 37, 36)
    
end

--music(0)