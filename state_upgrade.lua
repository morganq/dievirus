current_upgrades = nil
selected_upgrade_index = 1
applied = {}

--faces_options1 = split("x_____,_x____,__x___,___x__,____x_,_____x")
faces_options2 = split("x_____,_x____,__x___,___x__,____x_,_____x")
upgrade_bases = {}
for a in all(abilities) do
    add(upgrade_bases,a[4])
end
upgrade_mods = split"growth,claim,pause,stun,poison,rage,invasion"

function make_upgrade(faces, kind)
    local up = {
        faces = {},
        kind = kind
    }
    for i = 1,6 do
        up.faces[i] = faces[i] != "_" and faces[i] or false
    end
    local positions = {
        {0,3},{3,3},{6,3},{9,3},{3,0},{3,6}
    }
    up.draw = function(x,y)
        if up.kind == "hp" then
            spr(142, x + 4, y - 2)
            print("+1 hp", x-3, y + 7, 0)
        else
            for i = 1, 6 do
                local px, py = positions[i][1] + x, positions[i][2] + y + 6
                local color = ({["3"]=14, ["2"]=14, ["-"]=8, ["1"]=12, x=12, [false]=5})[up.faces[i]]
                rectfill(px,py,px+1,py+1,color)
            end        
            if sub(up.kind,1,1) == "+" then
                print("up", x + 8, y-1, 12)
            elseif count(upgrade_bases, up.kind) > 0 then
                local abil = lookup_ability(up.kind)
                spr(abil[1], x + 8, y - 3)
                spr(abil[5] + 149, x - 4, y - 4)
                --print(abil[5], x - 2, y - 3, 0)
            else
                spr(mod_defs[up.kind], x+8, y)
            end        
        end
    end
    return up
end

function draw_random_abil()
    local level_rarity = level \ 4 + 1
    local abils_by_rarity = {}
    for i = -1, 5 do
        abils_by_rarity[i] = {}
    end
    for a in all(upgrade_bases) do
        --printh(a .. ", " .. lookup_ability(a)[5])
        add(abils_by_rarity[lookup_ability(a)[5]], a)
    end
    if rnd() > 0.35 or level_rarity == 5 then
        --printh("at level "..level_rarity)
        return rnd(abils_by_rarity[level_rarity])
    else
        if rnd() > 0.5 then
            --printh("up level "..level_rarity)
            return rnd(abils_by_rarity[level_rarity + 1])
        else
            --printh("down level "..level_rarity)
            return rnd(abils_by_rarity[level_rarity - 1])
        end
    end
end

function update_upgrade()
    pl = nil
    tf += 1
    if current_upgrades == nil then
        current_upgrades = {}
        local options = {"hp", rnd(upgrade_mods), draw_random_abil(), draw_random_abil()}
        if level % 3 == 0 then
            options = {"+1", "+1", "+1", "+1"}
        end
        --local options = {"+1", "hp", rnd(upgrade_bases)}
        local faces_options1 = split("11____,____11,__11__,1__1__,_2____,2_____,___2__,3-____")
        for i = 1, 4 do
            local ind = flr(rnd(#options) + 1)
            local v = options[ind]
            deli(options, ind)
            local rndfc = '______'
            if v == '+1' then
                local j = rnd(#faces_options1)\1+1
                --printh(j)
                current_upgrades[i] = make_upgrade(faces_options1[j], v)
                deli(faces_options1,j)
            else
                printh(v)
                rndfc = rnd(faces_options2)
                current_upgrades[i] = make_upgrade(rndfc, v)
            end
            
        end
    end
    if btnp(0) then
        selected_upgrade_index = (selected_upgrade_index - 2) % #current_upgrades + 1
    end
    if btnp(1) then
        selected_upgrade_index = selected_upgrade_index % #current_upgrades + 1
    end    
    if btnp(5) then
        player_abilities = applied
        if current_upgrades[selected_upgrade_index].kind == "hp" then
            max_hp += 1
        end
        current_upgrades = nil
        selected_upgrade_index = 1
        state = "gameplay"
        start_level()
    end
end

function draw_upgrade()
    cls(15)
    local ls = "level "..(level + 1).."/15"
    print(ls, 64 - #ls * 2, 2, 2)
    print("⬅️", 1, 30, 1)
    print("➡️", 120, 30, 1)    
    print("- choose upgrade -", 28, 12, 1)
    if current_upgrades != nil then
        local upgrade = current_upgrades[selected_upgrade_index]
        applied = {}
        for i = 1, 6 do
            applied[i] = player_abilities[i].copy()
            if upgrade.faces[i] then
                if upgrade.kind == "hp" then
                    --
                elseif sub(upgrade.kind,1,1) == "+" then
                    local delta = ({["3"]=3, ["2"]=2, ["-"]=-1, ["1"]=1, [false]=0})[upgrade.faces[i]]
                    applied[i].pips = max(applied[i].pips + delta, 0)
                elseif count(upgrade_bases, upgrade.kind) > 0 then
                    --applied[i].base = upgrade.kind
                    local abil = lookup_ability(upgrade.kind)
                    applied[i] = make_ability(abil, applied[i].pips, applied[i].mods)
                    center_print(applied[i].name, 64, 112, 1)                    
                else
                    applied[i].mods[#player_abilities[i].mods + 1] = upgrade.kind
                    --add(applied[i].mods, upgrade.kind)
                    local desc = mod_descriptions[upgrade.kind]
                    center_print(desc, 64, 112, 1)
                end
            end
        end
        for i = 1, #current_upgrades do
            temp_camera(-(i * 26 - 12), -22, function()
                rectfill(0, 0, 22, 23, 7)
                current_upgrades[i].draw(5, 5)
                local color = 15
                if i == selected_upgrade_index then
                    color = 12
                end
                
                rect(0, 0, 22, 23, color)
            end)
        end
        draw_die2d(player_abilities,37,56,applied,upgrade)
    end
end