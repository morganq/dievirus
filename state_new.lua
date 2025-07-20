tf = 0

function make_die(as)
    local die = {}
    local sas = split(as,"/")
    for i = 1,6 do
        die[i] = parse_ability(sas[i])
    end    
    return die
end

selected_class_index = 1
function update_newgame()
    if btnp(2) then
        selected_class_index = (selected_class_index - 2) % #classes + 1
        ssfx(14)
    end
    if btnp(3) then
        selected_class_index = selected_class_index % #classes + 1
        ssfx(14)
    end    
    local cl = classes[selected_class_index]
    if btnp(5) and dget(0) >= cl[4] then
        ssfx(12)
        scrnt(draw_newgame, cl[3] \ 8, 0, 16, 16, 92, 60)
        
        player_abilities = make_die(cl[5])
        -- DEBUG:
        debug_start_level = 1
        for j = 1, debug_start_level - 1 do
            level = j
            for i = 1, 6 do
                player_abilities[i] = player_abilities[i].copy()
            end
            current_upgrades = nil
            tf = 0
            update_upgrade()
            draw_upgrade()
            player_abilities = applied
            if current_upgrades[selected_upgrade_index].kind == "hp" then
                max_hp += 1
            end
        end
        reset()
        state = "gameplay"
        player_sprite = cl[3]
        tf = 0
        start_level()
    end
end

function draw_newgame(skip_player)
    cls(5)

sfn([[
rectfill,0,0,128,128,7
spr,146,27,7

rectfill,0,30,128,96,5
line,0,29,128,29,3
line,0,96,128,96,3
spr,147,03,21
spr,147,13,21
spr,147,23,21
spr,147,33,21
spr,147,43,21
spr,147,53,21
spr,147,63,21
spr,147,73,21
spr,147,83,21
spr,147,93,21
spr,147,103,21
spr,147,113,21
spr,147,118,21
spr,147,03,97,1,1,1,1
spr,147,13,97,1,1,1,1
spr,147,23,97,1,1,1,1
spr,147,33,97,1,1,1,1
spr,147,43,97,1,1,1,1
spr,147,53,97,1,1,1,1
spr,147,63,97,1,1,1,1
spr,147,73,97,1,1,1,1
spr,147,83,97,1,1,1,1
spr,147,93,97,1,1,1,1
spr,147,103,97,1,1,1,1
spr,147,113,97,1,1,1,1
spr,147,118,97,1,1,1,1

spr,79,124,-4
spr,79,124,123
spr,79,-4,-4,1,1,1,1
spr,79,-4,123,1,1,1,1
rect,0,0,127,127,6

spr,95,105,20
spr,95,55,-3
spr,95,123,40
spr,95,42,123
spr,95,82,124
spr,146,36,102

rectfill,85,30,114,95,15
line,83,30,83,95,15
line,116,30,116,95,15
rectfill,78,40,121,48,7
spr,64,92,66,2,2
rectfill,92,82,107,95,1

rectfill,0,-4,128,-1,1

print,⬆️,96,17,0
print,⬇️,96,104,0
print,choose your character,4,4,3
]])

    local cl = classes[selected_class_index]
    local color = 1
    if dget(0) < cl[4] then
        color = 8
        print("unlocked after " .. cl[4] .. " wins", 22, 116, color)
        pal(split"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1")
    else
        local s = "❎ to begin"
        print(s, 44, 116, 1)
    end
    
    if not skip_player then
        spr(cl[3], 92, 60, 2, 2)
    end    
    local d = make_die(cl[5])
    draw_die2d(d, 12, 42)
    
    if tf % 60 > 45 then
        parse_ability("curse;0").draw_face(57,57,-1)
    end
    palreset()
    print(cl[2], 100 - #cl[2] * 2, 42, color)
    tf += 1
end

--music(0)