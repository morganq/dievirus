states = {
    newgame = {update=update_newgame, draw=draw_newgame},
    gameplay = {update=update_gameplay, draw=draw_gameplay},
    upgrade = {update=update_upgrade, draw=draw_upgrade},
    win = {update=update_win, draw=draw_win}
}

player_sprite = 0

function begin_game(spr, def)
    player_abilities = make_die(def)
    level = 0
    -- DEBUG:
    --[[
    debug_start_level = 0
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
    end]]
    
    reset()
    set_state("gameplay")
    player_sprite = spr
    start_level()    
end

function _init()
    night_palette_imm = false
    cartdata("dievirus")
    menuitem(1, "clear wins", function()
        dset(0,0)
    end)

    --for i = 1, 20 do
    --    cls(7)
    --    flip()
    --end    

    inmediasres = true
    begin_game(0, "start;5/start;5/start;5/start;5/start;5/start;5")
    --begin_game(0, "sling;1/sling;1/spear;1/spear;1/shield;1/sword;2")
    --set_state("win")
end

function _draw()
    palreset()
    states[state].draw()
    pal(split"129,2,141,4,134,6,7,136,9,10,142,139,13,14,15,0",1)
    if night_palette_imm then
        pal(split"129,2,141,4,134,5,6,136,9,10,142,3,13,14,15,0",1)
        night_palette_imm = false 
    end
    if pal_override_imm then
        pal(pal_override_imm)
        pal_override_imm = nil
    end
end
function _update()
    states[state].update()
    tf += 1
end

function set_state(name)
    state = name
    if name == "newgame" then music(12) end
    tf = 0
end

-- enemies can still spawn on top of eachother