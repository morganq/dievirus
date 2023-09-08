local nongrid = {}
function make_nongrid(x,y)
    local ng = {
        pos = {x,y},
        draw = function() end,
        update = function() end,
    }
    add(nongrid, ng)
    return ng
end

function make_effect_simple(x, y, num, spri)
    local ng = make_nongrid(x,y)
    ng.time = 0
    ng.draw = function()
        if spri != nil then
            spr(spri, x, y - ng.time \ 5)
        else
            print("-"..num, x, y - ng.time \ 5, 7)
        end
    end
    ng.update = function()
        ng.time += 1
        if ng.time > 30 then del(nongrid, ng) end
    end
    return ng
end

function make_effect_laser(x1, y1, x2, y2, side)
    local ng = make_nongrid(x1,y1)
    ng.time = 0
    ng.draw = function()
        local color = 8
        if side != 'red' then color = 12 end
        
        rectfill(x1,y1 -1 ,x2,y2 + 1, color)
        line(x1,y1,x2,y2,7)
    end
    ng.update = function()
        ng.time += 1
        if ng.time > 10 then del(nongrid, ng) end
    end
    return ng
end

function make_creature_particle(x, y, color, xv, floor)
    local ng = make_nongrid(x,y)
    local freezetime = -50 + rnd(2)
    addfields(ng, {
        color = color,
        yv = -1 + (0.5 - rnd()) * 0.8,
        xv = xv + (0.5 - rnd()) * 0.25,
        time = -rnd(100),
    })
    ng.draw = function()
        pset(ng.pos[1], ng.pos[2], ng.color)
        if freezetime > 8 and rnd() < 0.125 then
            line(ng.pos[1], 0, ng.pos[1], ng.pos[2], ng.color)
        end        
    end
    ng.update = function()
        freezetime += 1
        if freezetime >= 0 then ng.color = 7 end
        if freezetime >= 3 and rnd() < 0.25 then ng.color = 11 end
        ng.time += 1
        
        if freezetime < 0 then
            ng.yv += 0.1
            if ng.pos[2] > floor then
                ng.yv = ng.yv * -.5
                if ng.yv > -0.1 then
                    ng.yv = 0
                    ng.xv = ng.xv * 0.9
                    ng.y = floor
                end
            end
            ng.pos = {ng.pos[1] + ng.xv, ng.pos[2] + ng.yv}
        end
        if freezetime > 12 then
            del(nongrid, ng)
        end
    end
    return ng
end

function make_effect_ghost(x, y, spri, sprw, sprh)
    local ng = make_nongrid(x,y)
    ng.time = 0
    ng.draw = function()
        fillp(0b0101010101010101.11)
        spr(spri, ng.pos[1], ng.pos[2], sprw, sprh)
        fillp()
    end
    ng.update = function()
        ng.time += 1
        ng.pos = {ng.pos[1], ng.pos[2] - ng.time}
        if ng.time > 3 then del(nongrid, ng) end
    end
    return ng
end

function make_effect_fire(x, y)
    local ng = make_nongrid(x,y)
    ng.time = rnd() * 10
    ng.draw = function()
        pal({[9]=(8 + ng.time \ 20)})
        spr(116 + (ng.time \ 5) % 5, x, y)
        pal()
    end
    ng.update = function()
        ng.time += 1
        y -= 0.1
        if ng.time > 50 then
            del(nongrid, ng)
        end
    end
end

function make_bullet(x, y, side, speed, abil, spri, sprw, sprh)
    local ng = make_nongrid(x,y)
    ng.last_x = gp(x,y)[1]
    ng.side = side
    local dir = 1
    if ng.side != 'red' then dir = -1 end
    ng.yv = count_animal(abil, "rabbit")
    if rnd() < 0.5 then ng.yv = -ng.yv end
    ng.draw = function()
        spr(spri, ng.pos[1], ng.pos[2], sprw or 1, sprh or 1)
    end
    ng.update = function()        
        gpp = gp(ng.pos[1] + 4 + 8 * speed * dir, ng.pos[2] + 8 * speed * ng.yv * 1)
        if gpp[1] != ng.last_x then
            ng.last_x = gpp[1]
            make_damage_spot(gpp[1], gpp[2], abil.pips + flr(ng.yv), ng.side, 10, {hit_drop=count_animal(abil, "elephant") * 300})
            --if count_animal(abil, "elephant") > 0 and grid[gpp[2]][gpp[1]].space.side != ng.side then 
            --    grid[gpp[2]][gpp[1]].space.drop(30 * 10)
            --end
        end

        ng.pos = {ng.pos[1] + dir * speed, ng.pos[2] + ng.yv * speed * 13/16}
        if ng.pos[1] < 0 or ng.pos[1] > 128 then
            del(nongrid, ng)
        end
        if ng.pos[2] > 58 then
            ng.yv = -abs(ng.yv)
        elseif ng.pos[2] < 12 then
            ng.yv = abs(ng.yv)
        end        
    end
    return ng
end

function make_bomb(x1, x2, y1, y2, side, abil, total_time)
    local ng = make_nongrid(x1,y1)
    ng.side = side
    ng.time = 0
    ng.total_time = total_time or 60
    ng.draw = function()
        if ng.side == 'red' then
            spr(131, ng.pos[1] - 4, ng.pos[2] - 4)
        else
            spr(130, ng.pos[1] - 4, ng.pos[2] - 4)
        end
        --circfill(ng.pos[1], ng.pos[2], 3, 6) --improve
    end
    ng.update = function()
        ng.time += 1
        local t = ng.time / ng.total_time
        ng.pos = {t * (x2 - x1) + x1 + 8, t * (y2 - y1) + y1 + ((t * 2 - 1) ^ 2) * 20 - 16}
        if ng.time > ng.total_time then
            del(nongrid, ng)
        end
    end
    return ng
end

function make_melee(x, y, user, dist, side, abil, onhit)
    local dir = 1
    if side != 'red' then dir = -1 end
    local np = gp(x + 8 + dir * 16, y)
    onhit(np[1],np[2])    
end

function addfields(tbl,add)
    for k,v in pairs(add) do
        tbl[k] = v
    end
end

function abil_sword(user, a, x, y, side)
    local pp = tp(x,y)
    local props = {hit_drop = count_animal(a, "elephant") * 600, hit_fire_enemy = count_animal(a, "fox") * 180}
    local onhit = function(gx,gy)
        local lim = 1 + count_animal(a, "rabbit")
        for gyy = max(gy-lim,1), min(gy+lim,4) do
            local gxx = gx
            if count_animal(a, "rabbit") > 0 then
                gxx += abs(gyy - gy)
            end
            make_damage_spot(gxx, gyy, a.pips, side, 0, props)
        end
    end
    if side == 'red' and x <= 7 then 
        grid[y][x+1].space.flip('red', 30 * 13)
    end
    if side == 'blue' and x >= 2 then 
        grid[y][x-1].space.flip('blue', 30 * 13)
    end    
    make_melee(pp[1], pp[2], user, 0 + 16 * count_animal(a, "tiger"), side, a, onhit)
end

function abil_spear(user, a, x, y, side)
    local pp = tp(x,y)
    local dir = 1
    if side != 'red' then dir = -1 end
    local props = {hit_drop = count_animal(a, "elephant") * 300, hit_fire_enemy = count_animal(a, "fox") * 180}
    local onhit = function(gx,gy)
        if count_animal(a, "rabbit") > 0 then
            for gyy = 1, 4 do
                if gyy != gy then
                    make_damage_spot(gx - dir, gyy, a.pips + 1, side, 0, props)
                end
            end        
        else
            for gxx = gx, clamp(gx + dir * (count_animal(a, "tiger") + 1),1,8), dir do
                make_damage_spot(gxx, gy, a.pips, side, 0, props)
            end
        end
    end    
    make_melee(pp[1], pp[2], user, 0, side, a, onhit)
end

function abil_gun(user, a, x, y, side)
    local dir = 1
    if side != 'red' then dir = -1 end
    
    local lstart = tp(x,y)
    local x2 = 0
    local damage = a.pips
    
    for i = x, 4.5 + 3.5 * dir, dir do
        x2 = i
        local creature = grid[y][i].creature
        if creature and creature.side != side then
            creature.stun_time = count_animal(a, "elephant") * 90 * creature.stun_co
            make_damage_spot(i, y, damage, side, 0, {hit_fire = count_animal(a, "fox") * 120})
            break
        end
    end
    local lend = tp(x2, y)
    make_effect_laser(lstart[1] + 8, lstart[2] + 3, lend[1] + 8, lend[2] + 3, side)
    if count_animal(a, "rabbit") > 0 then pl.die_speed = 3.0 end
end

function abil_wave(user, a, x, y, side)
    local pp = tp(x, y)
    make_bullet(pp[1], pp[2], side, 2 + count_animal(a, "fox") * 2, a, 128)
end

function abil_bomb(user, a, x, y, side)
    local time = 40
    local dist = 4
    local x2 = x
    local pp1 = tp(x, y)
    if side == 'red' then
        x2 = min(x + dist, 8)
    else
        x2 = max(x - dist, 1)
    end
    local props = {hit_drop=count_animal(a,"elephant") * 300, hit_fire=count_animal(a,"fox") * 90}
    if count_animal(a, "monster") > 0 then
        for y2 = 1, 4 do
            local pp2 = tp(x2, y2)
            make_bomb(pp1[1], pp2[1], pp1[2], pp2[2], side, a, y2 * 15 + 15)
            make_damage_spot(x2, y2, a.pips, side, y2 * 15 + 15, props)
        end
    elseif count_animal(a, "rabbit") > 0 then
        local pp2 = tp(x2, y)
        make_bomb(pp1[1], pp2[1], pp1[2], pp2[2], side, a, time)    
        for i = 1, 8 do
            for j = 1, 4 do
                local dx, dy = abs(x2 - i), abs(y - j)
                if dx == dy then
                    make_damage_spot(i, j, a.pips, side, time, props)
                end
            end
        end
    else
        local pp2 = tp(x2, y)
        make_bomb(pp1[1], pp2[1], pp1[2], pp2[2], side, a, time)
        for i = x2-1, x2+1 do
            if i >= 1 and i <= 8 then
                make_damage_spot(i, y, a.pips, side, time, props)
            end
        end
        if y > 1 then make_damage_spot(x2, y-1, a.pips, side, time, props) end
        if y < 4 then make_damage_spot(x2, y+1, a.pips, side, time, props) end
    end
    
end

function abil_shield(user, a, x, y, side)
    local shield = a.pips
    shield += count_animal(a, "elephant") * 2
    user.shield = max(user.shield, shield)
    if count_animal(a, "elephant") > 0 then
        grid[y][x].space.drop(600)
    end
    dir = 1
    if side != 'red' then dir = -1 end
    if count_animal(a, "fox") > 0 and x + dir > 0 and x + dir < 9 then
        grid[y][x + dir].space.fire_time = 300
    end    
    if count_animal(a, "rabbit") > 0 then
        pl.die_speed = 3.0
        make_effect_simple(28, 80, nil, 102)
    end
    user.shield_timer = shield_time
    local pp = tp(x,y)
    make_effect_simple(pp[1] + 4, pp[2] - 14, 0, 114)
end

function abil_turret(user, a, x, y, side)
    local dir = 1
    if side != 'red' then dir = -1 end
    local x1 = x
    if valid_move_target(x + dir, y, side) then
        x1 = x + dir
    elseif valid_move_target(x - dir, y, side) then
        x1 = x - dir  
    else
        return
    end
    local t = make_turret(x1, y, a, side)
    t.health += count_animal(a, "elephant") * 2
    user.stun_time = count_animal(a, "elephant") * 40
end

local fns_base = {sword=abil_sword, gun=abil_gun, bomb=abil_bomb, none=abil_none, shield=abil_shield, wave=abil_wave, turret=abil_turret, spear=abil_spear}

function valid_move_target(x,y,side)
    if x < 1 or x > 8 or y < 1 or y > 4 then return false end
    local spot = grid[y][x]
    return spot.space.side == side and not spot.space.dropped and not spot.creature
end

function add_go_to_grid(go)
    local newgrid = grid[go.pos[2]][go.pos[1]]
    -- Add the obj to the grid location. But add based on layer.
    if #newgrid == 0 then
        add(newgrid, go)
    else
        local i = 1
        while true do
            if i > #newgrid then
                add(newgrid, go)
                break 
            elseif go.layer <= newgrid[i].layer then
                add(newgrid, go, i)
                break
            end
            i += 1
        end
    end
end

function make_gridobj(x,y,layer,spri,sprw,sprh) 
    local go = {
        pos = {x,y},
        layer = layer or 10,
        spri = spri,
        sprw = sprw,
        sprh = sprh,
        draw = function() end,
        update = function() end,
    }
    add_go_to_grid(go)
    go.move = function(x,y)
        del(grid[go.pos[2]][go.pos[1]], go)
        go.pos = {x,y}
        add_go_to_grid(go)
    end
    if spri != nil then
        go.draw = function()
            local pp = tp(go.pos[1], go.pos[2])
            spr(go.spri, pp[1], pp[2], go.sprw, go.sprh)
        end
    end
    return go
end

function push_to_open_square(c)
    local gx, gy = c.pos[1], c.pos[2]
    local spot = grid[gy][gx]
    local dir = 1
    if c.side != 'red' then dir = -1 end
    local attempts = {
        {0,0}, {-dir,-1}, {-dir,1}, {dir,-1}, {dir,1}, {-dir, 0}, {dir, 0}, {0,-1}, {0,1}
    }
    for offset in all(attempts) do
        local tx, ty = gx + offset[1], gy + offset[2]
        if tx >= 1 and tx <= 8 and ty >= 1 and ty <= 4 then
            local new_spot = grid[ty][tx]
            if new_spot.space.side == c.side and new_spot.creature == nil and not new_spot.space.dropped then
                c.move(tx,ty)
                return
            end
        end
    end
end

creature_index = 1
function make_creature(x, y, side, health, spri, sprw, sprh)
    local go = make_gridobj(x, y, 10, spri, sprw, sprh)
    addfields(go, {
        movetime = 0,
        lastpos = {0,0},
        animate_time = 0,
        yo = -7,
        side = side,
        damage_time = 0,
        health = health,
        max_health = health,
        shield = 0,
        shield_timer = 0,
        stun_time = 0,
        stun_co = 1,
        alive=true,
        index=creature_index
    })
    creature_index += 1
    go.draw = function()
        local spri = go.spri
        if go.movetime > 0 then
            fillp(0b0101010101010101.11)
        end
        if go.damage_time > 0 then
            pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7})
        end
        if go.animate_time > 0 then
            spri = go.spri + go.sprw
        end
        local pp = tp(go.pos[1], go.pos[2])
        spr(spri, pp[1] - 1, pp[2] + go.yo, go.sprw, go.sprh)
        fillp()
        pal()
        if go.stun_time > 0 then
            spr(144 + (tf \ 10) % 2, pp[1] + 3, pp[2] - 6)
            print(go.stun_time, 100, go.index * 5 + 64, 7 + go.index)
        end
    end

    local baseupdate = go.update
    go.update = function()
        local space = grid[go.pos[2]][go.pos[1]].space
        if space.dropped or space.side != go.side then
            push_to_open_square(go)
        end
        if space.fire_time > 0 and space.fire_time % 20 == 0 then
            go.take_damage(1)
        end
        go.damage_time -= 1
        go.movetime -= 1
        go.animate_time -= 1
        go.shield_timer -= 1
        if go.shield_timer <= 0 then
            go.shield = 0
        end
        go.stun_time -= 1
        baseupdate()
    end

    local basemove = go.move
    go.move = function(x,y)
        if not go.alive then return end
        local pp = tp(go.pos[1],go.pos[2])
        make_effect_ghost(pp[1], pp[2] + go.yo, go.spri, go.sprw, go.sprh)
        grid[go.pos[2]][go.pos[1]].creature = nil
        go.lastpos = {go.pos[1], go.pos[2]}
        go.movetime = 3
        basemove(x,y)
        grid[y][x].creature = go
    end

    go.take_damage = function(damage)
        if damage >= go.shield then
            local damage_after = damage - go.shield
            go.shield = 0
            go.shield_timer = 0
            go.health -= damage_after
        else
            go.shield -= damage
        end
        go.damage_time = 5
        local pp = tp(go.pos[1],go.pos[2])
        make_effect_simple(pp[1] + 10, pp[2] - 4, damage)
        if go.health <= 0 then
            go.kill()
        end
    end

    go.kill = function()
        go.alive = false
        local sx = go.spri % 16 * 8
        local sy = go.spri \ 16 * 8
        for x = 0, go.sprw * 8 - 1 do
            local xv = (x / (go.sprw * 8 - 1)) - 0.5
            for y = 0, go.sprh * 8 - 1 do 
                local c = sget(sx + x, sy + y)
                local pp = tp(go.pos[1], go.pos[2])
                if c > 0 then
                    make_creature_particle(pp[1] + x, pp[2] + y + go.yo, c, xv / 2, pp[2] + 6 + rnd(4))
                end
            end
        end
        grid[go.pos[2]][go.pos[1]].creature = nil
        del(grid[go.pos[2]][go.pos[1]], go)
    end

    grid[go.pos[2]][go.pos[1]].creature = go
    return go
end

-- supported special properties:
-- flies (can teleport when moving)
-- move_pattern (table of bools, move on index or not)
-- abil_pattern (table of bools, use abil on index or not)

function make_monster(spri, palette_index, x, y, abilities, health, speed, special_properties)
    local needs_push = false
    if grid[y][x].creature then needs_push = true end
    local c = make_creature(x,y,"blue", health, spri, 2, 2)
    c.palette = monster_palettes[palette_index]
    --printh(pal, "test.txt")
    c.abilities = abilities
    c.speed = speed
    c.time = 0
    c.next_ability = rnd(c.abilities)
    addfields(c, special_properties or {})
    if special_properties.move_pattern then
        c.move_pattern = {}
        for i = 1, #special_properties.move_pattern do
            add(c.move_pattern, sub(special_properties.move_pattern, i, 'x') == 'x')
        end
        c.move_pattern_i = 1
    end
    if special_properties.abil_pattern then
        c.abil_pattern = {}
        for i = 1, #special_properties.abil_pattern do
            add(c.abil_pattern, sub(special_properties.abil_pattern, i, 'x') == 'x')
        end    
        c.abil_pattern_i = 1
    end

    local baseupdate = c.update
    c.update = function()
        baseupdate()
        if c.stun_time > 0 then return end
        c.time += 1
        if c.time % c.speed == 0 then
            local will_move = true
            if c.move_pattern then
                if not c.move_pattern[c.move_pattern_i] then will_move = false end
                c.move_pattern_i = c.move_pattern_i % #c.move_pattern + 1
            end
            if will_move then -- Move pattern allows move
                local abiltx = {sword=0, gun=8, bomb=6}
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
                        if tx then dx = clamp(tx - c.pos[1], -1, 1) end
                        if ty then dy = clamp(ty - c.pos[2], -1, 1) end
                        local rx = (dx or spot[1]) + c.pos[1]
                        local ry = (dy or spot[2]) + c.pos[2]
                        if valid_move_target(rx, ry, c.side) then
                            c.move(rx, ry)
                            break
                        end
                    end
                end
            end
        end
        if c.time % c.speed == (c.speed \ 2) then
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
        end
    end
    local basedraw = c.draw
    c.draw = function()
        if c.palette != nil then
            pal(c.palette)
            basedraw()
            pal()
        else
            basedraw()
        end
        local pp = tp(c.pos[1], c.pos[2])
        local hpx = pp[1] + 3
        local hpy = pp[2] + 10
        
        line(hpx, hpy, hpx + 9, hpy, 6)
        line(hpx, hpy, hpx + 9 * (c.health / c.max_health), hpy, 8)
    end
    if needs_push then
        push_to_open_square(c)
    end
    return c
end

function parse_monster(s)
    local parts = split(s, "|")
    local abils_s = split(parts[5],"/")
    local abilities = {}
    for abil_s in all(abils_s) do add(abilities, parse_ability(abil_s)) end
    local special_properties = {}
    for i = 8, #parts do
        local kv = split(parts[i],"=")
        special_properties[kv[1]] = kv[2]
    end
    return make_monster(parts[1], parts[2], parts[3], parts[4], abilities, parts[6], parts[7], special_properties)
end

function make_damage_spot(x,y,damage,side,warning,special_properties)
    local go = make_gridobj(x,y,1)
    addfields(go, {
        side=side,
        damage=damage,
        countdown_max = warning or 0,
        countdown = warning or 0,
        decay = 0,
    })
    addfields(go, special_properties or {})
    go.update = function()
        local spot = grid[go.pos[2]][go.pos[1]]
        if go.countdown > 0 then
            go.countdown -= 1
        elseif go.countdown == 0 then
            
            if spot.creature and spot.creature.side != go.side then
                spot.creature.take_damage(go.damage)
            end
            go.countdown -= 1             
            if go.hit_drop and go.hit_drop > 0 then
                spot.space.drop(go.hit_drop)
            end
            if go.hit_fire and go.hit_fire > 0 then
                spot.space.fire_time = go.hit_fire
            end           
            if go.hit_fire_enemy and go.side != spot.space.side and go.hit_fire_enemy > 0 then
                spot.space.fire_time = go.hit_fire_enemy
            end            
        else
            go.decay += 1
            if go.decay > 4 then
                del(spot, go)
            end
        end
    end
    go.draw = function()
        local pp = tp(go.pos[1], go.pos[2])
        local color = 7
        if go.side != 'red' then color = 10 end
        if go.countdown > 0 then
            local t = 1 - (go.countdown / go.countdown_max)
            local hw = 6 * t + 2
            local hh = 4 * t + 2
            local x1,y1,x2,y2 = pp[1] + 1, pp[2] + 1, pp[1] + 14, pp[2] + 11
            
            --[[if go.countdown < 5 then
                fillp(0b0101101001011010.1)
                rectfill(pp[1] + 1, pp[2] + 1, pp[1] + 14, pp[2] + 11, color)
                fillp()
            end]]
            line(x1, y1, x1 + hw, y1, color)
            line(x1, y1, x1, y1 + hh, color)
            line(x1, y2, x1 + hw, y2, color)
            line(x1, y2, x1, y2 - hh, color)
            line(x2, y1, x2 - hw, y1, color)
            line(x2, y1, x2, y1 + hh, color)
            line(x2, y2, x2 - hw, y2, color)
            line(x2, y2, x2, y2 - hh, color)            
        else
            rectfill(pp[1] + 1, pp[2] + 1, pp[1] + 14, pp[2] + 11, color)
        end
    end
end

function make_gridspace(x,y)
    local spri = 1
    local side = 'red'
    if x > 4 then
        spri = 3
        side = 'blue'
    end
    local go = make_gridobj(x,y,0,spri,2,2)
    go.side = side
    go.dropped = false
    go.drop_time = 0
    go.main_side = side
    go.flip_time = 0
    go.drop_finish_time = 0
    go.fire_time = 0
    local baseupdate = go.update
    go.update = function()
        if go.dropped then
            go.drop_time += 1
            if go.drop_time >= go.drop_finish_time then
                go.dropped = false
                go.drop_time = 0
            end
        end
        if go.flip_time > 0 then
            local dir = 1
            if go.main_side != 'red' then dir = -1 end
            local can_revert = false
            if go.pos[1] == 8 or go.side == 'red' and grid[go.pos[2]][go.pos[1] + 1].space.side == 'blue' then
                can_revert = true
            end
            if go.pos[1] == 1 or go.side == 'blue' and grid[go.pos[2]][go.pos[1] - 1].space.side == 'red' then
                can_revert = true
            end
            if can_revert then            
                go.flip_time -= 1
                if go.flip_time <= 0 then
                    go.side = go.main_side
                end
            end
        end
        if go.fire_time > 0 then
            go.fire_time -= 1
        end
    end
    local basedraw = go.draw
    go.draw = function()
        local pp = tp(go.pos[1], go.pos[2])
        local spri = 1
        if go.side == 'blue' then spri = 3 end
        spr(spri, pp[1], pp[2] + (go.drop_time / 2.5) ^ 2, go.sprw, go.sprh)
        if go.dropped and go.drop_time > go.drop_finish_time - 4 then
            pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7})
            spr(go.spri, pp[1], pp[2], go.sprw, go.sprh)
            pal()
        end
        if go.fire_time > 0 and go.fire_time % 5 == 0 then
            make_effect_fire(pp[1] + rnd() * 12, pp[2] + rnd() * 8 - 2)
        end
    end
    go.drop = function(time)
        if go.dropped then return end
        go.drop_time = 0
        go.drop_finish_time = time
        go.dropped = true
    end
    grid[go.pos[2]][go.pos[1]].space = go
    go.flip = function(side, time)
        if side == go.side then return end
        if side == go.main_side then
            go.side = go.main_side
            go.flip_time = 0
            return
        end
        go.main_side = go.side
        go.side = side
        go.flip_time = time
    end
    return go
end

pl = nil

function make_ability(base, pips, animal1, animal2)
    local a = {
        base = base,
        pips = pips,
        animal1 = animal1,
        animal2 = animal2,
        num_growth = 0,
    }
    a.copy = function()
        return make_ability(a.base, a.pips, a.animal1, a.animal2)
    end
    a.draw_face = function(x,y)
        spr(imgs_base[a.base], x, y, 2, 2)
        rect(x, y, x + 15, y + 15, 12)
        if a.animal1 then
            pal(split("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"))
            spr(spranimals[a.animal1], x + 1, y + 2)
            spr(spranimals[a.animal1], x + 3, y + 2)
            spr(spranimals[a.animal1], x + 2, y + 1)
            spr(spranimals[a.animal1], x + 2, y + 3)
            pal()
            spr(spranimals[a.animal1], x + 2, y + 2)
        end
        --if a.animal2 then
            --spr(spranimals[a.animal2], x + 2, y + 8)
        --end        
        
        local fives = a.pips \ 5
        local ones = a.pips - (fives * 5)
        local iy = 0
        for i = 1,fives do
            rectfill(x + 11, y + 13 - iy - 2, x + 13, y + 13 - iy, 10)
            iy += 4
        end
        for i = 1, ones do
            rectfill(x + 11, y + 13 - iy, x + 13, y + 13 - iy, 10)
            iy += 2
        end
    end    
    a.use = function(user, gx, gy, side)
        if a.base == "none" then return end
        fns_base[a.base](user, a, gx, gy, side)
        if a.num_growth < 3 and count_animal(a, "leaf") > 0 then
            a.pips += count_animal(a, "leaf")
            local pp = tp(gx,gy)
            make_effect_simple(pp[1] + 4, pp[2] - 14, nil, 108)
            a.num_growth += 1
        end
    end
    return a
end

function parse_ability(s)
    return make_ability(unpack(split(s)))
end

function make_player()
    local pl = make_creature(1,2, 'red', max_hp, 37, 2, 2)
    addfields(pl, {
        max_health = pl.health,
        die = {},
        die_speed = 1,
        current_ability = nil,
    })
    return pl
end

function make_turret(x, y, a, side)
    local spri = 33
    if side == 'blue' then spri = 136 end
    local t = make_creature(x, y, side, a.pips, spri, 2, 2)
    local baseupdate = t.update
    local abil = make_ability("wave", a.pips)
    t.rate = 80 - count_animal(a, "fox") * 25
    t.time = 0
    t.update = function()
        baseupdate()
        t.time += 1
        if t.time % t.rate == t.rate \ 2 then    
            if count_animal(a, "fox") > 0 then
                local rx = flr(rnd(4)) + 1
                if t.side == 'red' then rx += 4 end
                local ry = flr(rnd(4)) + 1
                grid[ry][rx].space.fire_time = 120
                t.animate_time = 5
            else
                abil.use(t, x, y, t.side)
            end
            if count_animal(a, "rabbit") > 0 then
                local rx = flr(rnd(4)) + 1
                if t.side == 'blue' then rx += 4 end
                local ry = flr(rnd(4)) + 1
                if valid_move_target(rx, ry, t.side) then
                    t.move(rx, ry)
                end
            end
        end
        if t.time >= 750 then
            t.kill()
        end
    end
    return t
end

function make_upgrade(faces, animal)
    local up = {
        faces = {},
        animal = animal
    }
    for i = 1,6 do up.faces[i] = sub(faces,i,"x") == 'x' end
    local positions = {
        {0,3},{3,3},{6,3},{9,3},{3,0},{3,6}
    }
    up.draw = function(x,y)
        --print(up.animal, x,y,6)
        if up.animal == "hp" then
            spr(122, x + 5, y)
            print("+1 hp", x-1, y + 9, 7)
        else
            for i = 1, 6 do
                local px, py = positions[i][1] + x, positions[i][2] + y + 6
                local color = 5
                if up.faces[i] then color = 11 end
                rectfill(px,py,px+1,py+1,color)
            end        
            if sub(up.animal,1,1) == "+" then
                print(up.animal, x + 8, y, 10)
            elseif count(bases, up.animal) > 0 then
                spr(imgs_base[up.animal], x + 6, y - 5,2,2)
            else
                spr(spranimals[up.animal], x+8, y)
            end        
        end
    end
    return up
end



function draw_die2d(die,x,y, die2, upgrade)
    local d1 = true
    if die2 and upgrade.animal != "hp" then
        d1 = (tf \ 14) % 2 == 0
    end
    if d1 then
        die[1].draw_face(x,y + 18)
        die[2].draw_face(x + 18,y + 18)
        die[3].draw_face(x + 36,y + 18)
        die[4].draw_face(x + 54,y + 18)
        die[5].draw_face(x + 18,y)
        die[6].draw_face(x + 18,y + 36)
    else
        die2[1].draw_face(x,y + 18)
        if upgrade.faces[1] then rect(x-1,y+17,x+16,y+34,7) end
        die2[2].draw_face(x + 18,y + 18)
        if upgrade.faces[2] then rect(x+17,y+17,x+34,y+34,7) end
        die2[3].draw_face(x + 36,y + 18)
        if upgrade.faces[3] then rect(x+35,y+17,x+52,y+34,7) end
        die2[4].draw_face(x + 54,y + 18)
        if upgrade.faces[4] then rect(x+53,y+17,x+70,y+34,7) end
        die2[5].draw_face(x + 18,y)
        if upgrade.faces[5] then rect(x+17,y-1,x+34,y+16,7) end
        die2[6].draw_face(x + 18,y + 36)        
        if upgrade.faces[6] then rect(x+17,y+35,x+34,y+52,7) end
    end
end

function _init()
    state = "title"
    cartdata("dievirus")
    menuitem(1, "clear wins", function()
        dset(0,0)
    end)
end

level = 0
function start_level()
    level += 1
    nongrid = {}
    grid = { }
    for i = 1,4 do
        grid[i] = {}
        for j = 1, 8 do
            grid[i][j] = {}
        end
    end    
    for j = 1,4 do
        for i = 1, 8 do
            make_gridspace(i,j)
        end
    end    
    victory = false
    defeat = false
    die3d = {
        pts = {},
        faces = {
            {1,2,3,4}, -- front
            {2,1,5,6}, -- top
            {3,4,8,7}, -- bottom
            {1,4,8,5}, -- left
            {2,3,7,6}, -- right
            {5,6,7,8} -- back
        },
        x = 10, 
        y = 84,
        xv = 0,
        yv = 0,
        visible = false,
    }
    gen_die(die3d, 0, 0, 0)
    pl = make_player()
    for i = 1,6 do
        pl.die[i] = abilities[i]
        --pl.die[i] = make_ability("turret", 1, "elephant")
    end

    local monsters = {
        mage1 = "164|0|6|1|wave,1|3|40|move_pattern=xx_|abil_pattern=__x",
        fighter1 = "41|0|6|1|sword,1|3|25|move_pattern=xx_|abil_pattern=__x",
        duelist1 = "168|0|6|1|wave,1,fox/sword,2|5|25|move_pattern=xxx_|abil_pattern=___x",
        engineer1 = "9|0|6|1|turret,2/gun,1|8|55|flies=1|abil_pattern=_x",
        boss1 = "132|0|6|1|bomb,2,monster/wave,1,elephant/shield,1/sword,3|20|15|flies=1|abil_pattern=____x_x_|move_pattern=xxxx____",
        bomber1 = "5|0|6|1|bomb,2|10|99",
        mage2 = "164|1|6|1|wave,2,rabbit|8|40|move_pattern=xx_|abil_pattern=__x",
        fighter2 = "41|1|6|1|sword,3,fox/spear,3,fox|10|30|abil_pattern=_x",
        boss2 = "132|1|6|1|gun,3,monster/turret,3,tiger/shield,3/wave,3,rabbit|30|20|flies=1|abil_pattern=______x_x_x_|move_pattern=xxxx___x_x_x",
        bomber2 = "5|2|6|1|bomb,2,fox|15|39|abil_pattern=_x_",
        engineer2 = "9|2|6|1|turret,4,rabbit/gun,2/shield,2|10|45|flies=1|abil_pattern=_x",
        duelist2 = "168|2|6|1|wave,3,elephant,rabbit/sword,4/spear,4/shield,2|14|21|move_pattern=xxx_|abil_pattern=___x",
        mage3 = "164|2|6|1|wave,4,rabbit/wave,4|15|40|move_pattern=xx_|abil_pattern=__x",
        boss3 = "168|2|6|1|wave,3,rabbit/wave,1,fox,leaf/shield,1,leaf/spear,1,tiger,leaf|40|21|move_pattern=xxx_|abil_pattern=___x",
    }
    function place_monster(name, x, y, favor_row)
        local mon = parse_monster(monsters[name])
        mon.move(x or flr(rnd(4)) + 5,y or flr(rnd(4)) + 1)
        mon.favor_row = favor_row
        return mon
    end  
    if level == 1 then
        place_monster("mage1", 6, 1, 2)
        place_monster("mage1", 6, 4, 3)
    elseif level == 2 then
        place_monster("mage1")
        place_monster("fighter1")
    elseif level == 3 then
        place_monster("duelist1")
        place_monster("duelist1")
    elseif level == 4 then
        place_monster("engineer1")
    elseif level == 5 then
        place_monster("boss1")
    elseif level == 6 then
        place_monster("mage2")
        place_monster("mage2").abil_pattern_i = 2
    elseif level == 7 then
        place_monster("fighter2")
        place_monster("fighter1")
        place_monster("fighter1")
    elseif level == 8 then
        place_monster("engineer1")
        place_monster("engineer1")
        place_monster("fighter1")
    elseif level == 9 then -- too easy
        place_monster("bomber1")
        place_monster("bomber1").time = 33
        place_monster("bomber1").time = 66
    elseif level == 10 then
        place_monster("boss2")
    elseif level == 11 then
        place_monster("bomber2")
        place_monster("engineer2")
    elseif level == 12 then
        place_monster("duelist2")
    elseif level == 13 then
        place_monster("mage1")
        local m2 = place_monster("mage2")
        m2.abil_pattern_i = 2
        m2.move_pattern_i = 2
        local m3 = place_monster("mage3")
        m3.abil_pattern_i = 3
        m3.move_pattern_i = 3        
    elseif level == 14 then
        place_monster("fighter2")
        local m2 = place_monster("fighter2")
        m2.abil_pattern_i = 2
        m2.move_pattern_i = 2    
        place_monster("boss2")
    elseif level == 15 then
        place_monster("boss3")
        place_monster("engineer1")
        place_monster("fighter1")
    end

    throw()
end

dra, drb, drc, dvra, dvrb, dvrc = 0,0,0,0,0,0

function throw()
    die3d.visible = true
    die3d.x = 20
    die3d.y = 84
    die3d.xv = 1.5
    die3d.yv = 0
    dvra = (0.5 - rnd())
    dvrb = (0.5 - rnd())
    dvrc = (0.5 - rnd())  
end