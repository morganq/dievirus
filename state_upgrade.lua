current_upgrades = nil
selected_upgrade_index = 1
applied = {}

--faces_options1 = split("x_____,_x____,__x___,___x__,____x_,_____x")
faces_options2 = split("x_____,_x____,__x___,___x__,____x_,_____x")
upgrade_mods_names = split"growth,claim,pause,stun,poison,rage,invasion"
upgrade_mods = {}
for mn in all(upgrade_mods_names) do
    for i = 1, all_mods[mn][3] do
        add(upgrade_mods, mn)
    end
end

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
            elseif all_abilities[up.kind] != nil then
                local abil = all_abilities[up.kind]
                spr(abil[2], x + 8, y - 3)
                spr(abil[5] + 149, x - 4, y - 4)
            else
                spr(all_mods[up.kind][2], x+8, y)
            end        
        end
    end
    return up
end

function draw_random_abil()
    local level_rarity = min(level \ 4 + 1, 3)
    local abils_by_rarity = {}
    for i = -1, 5 do
        abils_by_rarity[i] = {}
    end
    for k,v in pairs(all_abilities) do
        add(abils_by_rarity[v[5]], k)
    end
    if rnd() > 0.35 or level_rarity == 5 then
        return rnd(abils_by_rarity[level_rarity])
    else
        if rnd() > 0.5 then
            return rnd(abils_by_rarity[level_rarity + 1])
        else
            return rnd(abils_by_rarity[level_rarity - 1])
        end
    end
end

function update_upgrade()
    pl = nil
    tf += 1
    if current_upgrades == nil then
        current_upgrades = {}
        local options = {"hp", rnd(upgrade_mods), rnd(upgrade_mods), rnd(upgrade_mods), draw_random_abil(), draw_random_abil(), draw_random_abil()}
        if level % 3 == 0 then
            options = {"+1", "+1", "+1", "+1"}
        end
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
                rndfc = rnd(faces_options2)
                current_upgrades[i] = make_upgrade(rndfc, v)
            end
            
        end
    end
    if btnp(2) then
        selected_upgrade_index = (selected_upgrade_index - 2) % #current_upgrades + 1
        ssfx(14)
    end
    if btnp(3) then
        selected_upgrade_index = selected_upgrade_index % #current_upgrades + 1
        ssfx(14)
    end    
    if btnp(5) and tf > 32 then
        screen_transition(false)
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
    camera(0,cos(min(tf / 64, 0.5)) * -64 - 64)
sfn([[
rectfill,30,0,128,128,7
line,31,0,128,0,6
line,127,0,127,127,6
line,31,127,127,127,6
spr,146,27,7

rectfill,0,0,30,128,3
line,0,0,30,0,1
line,0,0,0,127,1
line,0,127,30,127,1

rectfill,31,60,128,109,5
line,31,60,128,60,3
line,31,109,128,109,3
spr,78,33,52
spr,78,43,52
spr,78,53,52
spr,78,63,52
spr,78,73,52
spr,78,83,52
spr,78,93,52
spr,78,103,52
spr,78,113,52
spr,78,33,110,1,1,1,1
spr,78,43,110,1,1,1,1
spr,78,53,110,1,1,1,1
spr,78,63,110,1,1,1,1
spr,78,73,110,1,1,1,1
spr,78,83,110,1,1,1,1
spr,78,93,110,1,1,1,1
spr,78,103,110,1,1,1,1
spr,78,113,110,1,1,1,1

spr,79,124,-4
spr,79,124,123
spr,79,-4,-4
spr,79,-4,123

spr,95,105,20
spr,95,55,-3
spr,95,123,40
spr,95,42,123
spr,95,82,124
spr,146,56,46

line,38,30,38,53,3

rectfill,0,-4,128,-1,1

print,⬆️,12,4,7
print,⬇️,12,119,7
print,choose upgrade,38,22,3
]])
    local ls = "level "..(level + 1).."/15"
    print(ls, 82, 5, 5)
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
                    applied[i].original_pips = applied[i].pips
                    nl_print("+1 health", 42, 34, 1)        
                elseif all_abilities[upgrade.kind] != nil then
                    --applied[i].base = upgrade.kind
                    local abil = all_abilities[upgrade.kind]
                    applied[i] = make_ability(abil, applied[i].pips, applied[i].mods)
                    nl_print(applied[i].name, 42, 34, 1)                    
                else
                    applied[i].mods[#player_abilities[i].mods + 1] = upgrade.kind
                    --add(applied[i].mods, upgrade.kind)
                    local desc = all_mods[upgrade.kind][4]
                    nl_print(desc, 42, 34, 1)
                end
            end
        end
        for i = 1, #current_upgrades do
            temp_camera(-4, -(i * 27 - 16), function()
                rectfill(0, 0, 22, 23, 7)
                current_upgrades[i].draw(5, 5)
                local color = 3
                if i == selected_upgrade_index then
                    color = 12
                end
                
                rect(0, 0, 22, 23, color)
            end)
        end
        draw_die2d(player_abilities,50,65,applied,upgrade)
    end
end