current_upgrades = nil
selected_upgrade_index = 1
applied = {}
faces_options1 = split("xx____,xx____,xx____,____xx,____xx,__x___,__x___,___x__,___x__")
faces_options2 = split("x_____,_x____,__x___,___x__,____x_,_____x")
function update_upgrade()
    tf += 1
    if current_upgrades == nil then
        current_upgrades = {}
        local options = {"+1", "hp", rnd(enabled_animals), rnd(bases)}
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
        abilities = applied
        if current_upgrades[selected_upgrade_index].animal == "hp" then
            max_hp += 1
        end
        current_upgrades = nil
        selected_upgrade_index = 1
        state = "gameplay"
        start_level()
    end
end

function draw_upgrade()
    cls()
    local ls = "level "..(level + 1).."/15"
    print(ls, 64 - #ls * 2, 2, 6)
    print("⬅️", 4, 30, 7)    
    print("➡️", 120, 30, 7)    
    print("- choose upgrade -", 28, 12, 7)
    if current_upgrades != nil then
        local upgrade = current_upgrades[selected_upgrade_index]
        applied = {}
        for i = 1, 6 do
            applied[i] = abilities[i].copy()
            if upgrade.faces[i] then
                if upgrade.animal == "hp" then
                    --
                elseif sub(upgrade.animal,1,1) == "+" then
                    applied[i].pips += sub(upgrade.animal,2,2)
                elseif count(bases, upgrade.animal) > 0 then
                    applied[i].base = upgrade.animal
                else
                    applied[i].animal1 = upgrade.animal
                    local animal_descriptions = {
                        leaf="leaf: growth",
                        fox="fox: fire or speed",
                        elephant="elephant: drop tiles or stun",
                        rabbit="rabbit: quick roll or angular"
                    }
                    local desc = animal_descriptions[upgrade.animal]
                    print(desc, 64 - #desc * 2, 112, 6)
                end
            end
        end
        for i = 1, #current_upgrades do
            current_upgrades[i].draw(i * 30 - 4, 27)
            local color = 5
            if i == selected_upgrade_index then
                color = 7
            end
            rect(i * 30 - 10, 22, i * 30 - 6 + 24, 45, color)
        end
        draw_die2d(abilities,30,56,applied,upgrade)
    end
end