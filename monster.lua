
-- supported special properties:
-- flies (can teleport when moving)
-- move_pattern (table of bools, move on index or not)
-- abil_pattern (table of bools, use abil on index or not)

function make_monster(spri, palette_index, x, y, abilities, health, speed, special_properties)
    local needs_push = false
    if grid[y][x].creature then needs_push = true end
    local c = make_creature(x,y,-1, health, spri)
    c.palette = monster_palettes[palette_index]
    c.abilities = abilities
    c.speed = speed
    c.abil_timer = speed \ 2
    c.move_timer = speed
    c.next_ability = rnd(c.abilities)
    addfields(c, "time=0", special_properties or {})
    if special_properties.move_pattern then
        c.move_pattern = {}
        for i = 1, #special_properties.move_pattern do
            add(c.move_pattern, special_properties.move_pattern[i] == 'x')
        end
        c.move_pattern_i = 1
    end
    if special_properties.abil_pattern then
        c.abil_pattern = {}
        for i = 1, #special_properties.abil_pattern do
            add(c.abil_pattern, special_properties.abil_pattern[i] == 'x')
        end    
        c.abil_pattern_i = 1
    end

    c.pick_next_move_target = function()
        c.move_target = nil
        local tx = nil
        local ty = nil
        if c.flies then
            for i = 1, 10 do
                if c.favor_col and rnd() < 0.45 then tx = c.favor_col end
                local rx = tx or flr(rnd(4)) + 5
                local ry = ty or flr(rnd(4)) + 1            
                if valid_move_target(rx, ry, c.side, true) then
                    c.move_target = {rx,ry}
                    break
                end
            end
        else
            if c.favor_col and rnd() < 0.45 then tx = c.favor_col end
            local spots = {{-1,0},{1,0},{0,-1},{0,1}}
            for i = 1,4 do
                local spot = rnd(spots)
                del(spots, spot)
                local dx,dy = nil,nil
                if tx then dx = mid(tx - c.pos[1], -1, 1) end
                if ty then dy = mid(ty - c.pos[2], -1, 1) end
                local rx = (dx or spot[1]) + c.pos[1]
                local ry = (dy or spot[2]) + c.pos[2]
                if valid_move_target(rx, ry, c.side, false) then
                    c.move_target = {rx,ry}
                    break
                end
            end
        end
    end

    local baseupdate = c.update
    c.update = function()
        baseupdate()
        if ended then return end
        if c.stun_time > 0 then return end
        c.time += 1
        c.move_timer -= 1
        if c.overextended_timer <= 0 and not c.move_target then
            c.pick_next_move_target()
        end

        if c.move_timer <= 0 then
            local will_move = c.overextended_timer <= 0
            if c.move_pattern then
                if not c.move_pattern[c.move_pattern_i] then will_move = false end
                c.move_pattern_i = c.move_pattern_i % #c.move_pattern + 1
            end
            if will_move then
                if c.move_target then
                    if valid_move_target(c.move_target[1], c.move_target[2], c.side, c.flies) then
                        c.move(c.move_target[1], c.move_target[2])
                    end
                    c.move_target = nil
                end
            end
            c.move_timer = c.speed
        end

        c.abil_timer -= 1
        if c.abil_timer <= 0 then
            local will_abil = true
            if c.abil_pattern then
                if not c.abil_pattern[c.abil_pattern_i] then will_abil = false end
                c.abil_pattern_i = c.abil_pattern_i % #c.abil_pattern + 1
            end        
            if will_abil then
                c.next_ability.use(c, c.pos[1], c.pos[2], c.side)        
                c.animate_time = 5
                c.next_ability = rnd(c.abilities)
                
            end
            c.abil_timer = c.speed
        end

        if c.abil_pattern and c.abil_timer == 8 and c.abil_pattern[c.abil_pattern_i] then
            ssfx(18)
        end
        --[[if c.move_pattern and c.move_pattern == 8 and c.move_pattern[c.move_pattern_i] then
            ssfx(17)
        end ]]       
    end
    local basedraw = c.draw
    c.draw = function()

        if c.move_target then
            local xo, yo = mid(c.move_target[1] - c.pos[1], -1, 1), mid(c.move_target[2] - c.pos[2], -1, 1)
            if not c.move_pattern or (c.move_pattern and c.move_pattern[c.move_pattern_i]) then
                local t = 1 - (c.move_timer / c.speed)
                local val = 0
                if t > 0.85 then
                    val = 3                    
                elseif t > 0.65 then
                    val = 2
                elseif t > 0.25 then
                    val = 1                    
                end
                c.telegraph_x = val * xo
                c.telegraph_y = val * yo
            end
        end
        if c.move_timer == c.speed then 
            c.telegraph_x = 0
            c.telegraph_y = 0
        end        

        palreset()
        if c.palette != nil then
            pal(c.palette)
            basedraw()
            palreset()
        else
            basedraw()
        end
        if c.clay_time > 0 then return end
        local pp = tp(c.pos[1], c.pos[2])
        local hpx = pp[1] + 3
        local hpy = pp[2] + 10
        
        line(hpx, hpy, hpx + 9, hpy, 1)
        line(hpx, hpy, hpx + 9 * (c.health / c.max_health), hpy, 9)
        if c.shield_timer > 0 then
            line(hpx, hpy, hpx + 9, hpy, 7)
        end

        palreset()
        if c.abil_pattern and c.abil_timer == 9 and c.abil_pattern[c.abil_pattern_i] then
            make_effect_simple(hpx + 2, hpy - 18, nil, 134, 0, -0.25, 14)
        end
    end
    if needs_push then
        push_to_open_square(c)
    end
    c.pick_next_move_target()
    return c
end

function parse_monster(parts, x, y)
    local abils_s = split(parts[4],"/")
    local abilities = {}
    for abil_s in all(abils_s) do add(abilities, parse_ability(abil_s)) end
    local special_properties = {}
    for i = 7, #parts do
        local kv = split(parts[i],"=")
        special_properties[kv[1]] = kv[2]
    end
    return make_monster(parts[2], parts[3], x, y, abilities, parts[5], parts[6], special_properties)
end