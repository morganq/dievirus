current_upgrades = nil
selected_upgrade_index = 1
applied = {}
faces_options1 = split("xx____,xx____,xx____,____xx,____xx,__x___,__x___,___x__,___x__")
faces_options2 = split("x_____,_x____,__x___,___x__,____x_,_____x")
upgrade_bases = {}--split"Wave,Sling,Shield,Spear,BounceWave,Scythe,Slap,Poke,Split,Sword,Wall"
for a in all(abilities) do
    add(upgrade_bases,a.name)
end
upgrade_mods = split"Growth,Fast,Claim"

function make_upgrade(faces, kind)
    local up = {
        faces = {},
        kind = kind
    }
    printh(kind)
    for i = 1,6 do up.faces[i] = faces[i] == 'x' end
    local positions = {
        {0,3},{3,3},{6,3},{9,3},{3,0},{3,6}
    }
    up.draw = function(x,y)
        if up.kind == "hp" then
            spr(122, x + 5, y)
            print("+1 hp", x-1, y + 9, 0)
        else
            for i = 1, 6 do
                local px, py = positions[i][1] + x, positions[i][2] + y + 6
                local color = 5
                if up.faces[i] then color = 12 end
                rectfill(px,py,px+1,py+1,color)
            end        
            if sub(up.kind,1,1) == "+" then
                print(up.kind, x + 12, y-1, 12)
            elseif count(upgrade_bases, up.kind) > 0 then
                spr(lookup_ability(up.kind)[1], x + 13, y - 3)
            else
                spr(mod_defs[up.kind], x+8, y)
            end        
        end
    end
    return up
end

function update_upgrade()
    tf += 1
    if current_upgrades == nil then
        current_upgrades = {}
        local options = {"+1", "hp", rnd(upgrade_mods), rnd(upgrade_bases)}
        --local options = {"+1", "hp", rnd(upgrade_bases)}
        for i = 1, 3 do
            local ind = flr(rnd(#options) + 1)
            local v = options[ind]
            deli(options, ind)
            local rndfc = '______'
            if v == '+1' then
                rndfc = rnd(faces_options1)
            else
                rndfc = rnd(faces_options2)
            end
            current_upgrades[i] = make_upgrade(rndfc, v)
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
    print("⬅️", 4, 30, 1)
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
                    applied[i].pips += sub(upgrade.kind,2,2)
                elseif count(upgrade_bases, upgrade.kind) > 0 then
                    --applied[i].base = upgrade.kind
                    applied[i] = make_ability(lookup_ability(upgrade.kind), applied[i].pips, applied[i].mods)
                else
                    applied[i].mods[#player_abilities[i].mods + 1] = upgrade.kind
                    --add(applied[i].mods, upgrade.kind)
                    local mod_descriptions = {
                    }
                    --local desc = mod_descriptions[upgrade.animal]
                    --print(desc, 64 - #desc * 2, 112, 6)
                end
            end
        end
        for i = 1, #current_upgrades do
            current_upgrades[i].draw(i * 30 - 4, 27)
            local color = 5
            if i == selected_upgrade_index then
                color = 0
            end
            rect(i * 30 - 10, 22, i * 30 - 6 + 24, 45, color)
        end
        draw_die2d(player_abilities,37,56,applied,upgrade)
    end
end