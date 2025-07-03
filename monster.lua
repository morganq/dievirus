
-- supported special properties:
-- flies (can teleport when moving)
-- move_pattern (table of bools, move on index or not)
-- abil_pattern (table of bools, use abil on index or not)

function make_monster(spri, palette_index, x, y, abilities, health, speed, special_properties)
    local needs_push = false
    if grid[y][x].creature then needs_push = true end
    local c = make_creature(x,y,-1, health, spri, 2, 2)
    c.palette = monster_palettes[palette_index]
    c.abilities = abilities
    c.speed = speed
    c.time = 0
    c.abil_timer = speed \ 2
    c.move_timer = speed
    c.next_ability = rnd(c.abilities)
    addfields(c, special_properties or {})
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

    local baseupdate = c.update
    c.update = function()
        baseupdate()
        if c.stun_time > 0 then return end
        c.time += 1
        if c.overextended_timer <= 0 then
            c.move_timer -= 1
        end
        if c.move_timer <= 0 then
            local will_move = true
            if c.move_pattern then
                if not c.move_pattern[c.move_pattern_i] then will_move = false end
                c.move_pattern_i = c.move_pattern_i % #c.move_pattern + 1
            end
            if will_move then -- Move pattern allows move
                local abiltx = {sword=0, sling=8, bomb=6}
                local tx = nil
                local ty = nil
                if rnd() < 0.4 then tx = abiltx[c.next_ability.base] end
                if c.favor_row and rnd() < 0.25 then ty = c.favor_row end
                if c.flies then
                    local rx = tx or flr(rnd(4)) + 5
                    local ry = ty or flr(rnd(4)) + 1            
                    if valid_move_target(rx, ry, c.side) then
                        c.move(rx, ry)
                    end
                else
                    local spots = {}
                    for i = -1,1 do for j = -1,1 do add(spots, {i,j}) end end
                    for i = 1,9 do
                        local spot = rnd(spots)
                        del(spots, spot)
                        local dx,dy = nil,nil
                        if tx then dx = mid(tx - c.pos[1], -1, 1) end
                        if ty then dy = mid(ty - c.pos[2], -1, 1) end
                        local rx = (dx or spot[1]) + c.pos[1]
                        local ry = (dy or spot[2]) + c.pos[2]
                        if valid_move_target(rx, ry, c.side) then
                            c.move(rx, ry)
                            break
                        end
                    end
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
    end
    local basedraw = c.draw
    c.draw = function()
        palreset()
        if c.palette != nil then
            --pal(c.palette)
            basedraw()
        else
            basedraw()
        end
        local pp = tp(c.pos[1], c.pos[2])
        local hpx = pp[1] + 3
        local hpy = pp[2] + 10
        
        line(hpx, hpy, hpx + 9, hpy, 6)
        line(hpx, hpy, hpx + 9 * (c.health / c.max_health), hpy, 15)

        palreset()
        if c.abil_pattern and c.abil_timer < 9 and c.abil_pattern[c.abil_pattern_i] then
            spr(134, hpx + 2, hpy - 21) 
        end
        if c.move_pattern and c.move_timer < 9 and c.move_pattern[c.move_pattern_i] then
            spr(135, hpx + 2, hpy - 21) 
        end        
    end
    if needs_push then
        push_to_open_square(c)
    end
    return c
end

function parse_monster(s, x, y)
    local parts = split(s, "|")
    local abils_s = split(parts[3],"/")
    local abilities = {}
    for abil_s in all(abils_s) do add(abilities, parse_ability(abil_s)) end
    local special_properties = {}
    for i = 6, #parts do
        local kv = split(parts[i],"=")
        special_properties[kv[1]] = kv[2]
    end
    return make_monster(parts[1], parts[2], x, y, abilities, parts[4], parts[5], special_properties)
end