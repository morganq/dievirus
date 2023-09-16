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

function make_damage_spot(x,y,damage,side,warning,abil)
    local go = make_gridobj(x,y,1)
    addfields(go, {
        side=side,
        damage=damage,
        countdown_max = warning or 0,
        countdown = warning or 0,
        decay = 0,
        abil = abil
    })
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

function draw_die2d(die,x,y, die2, upgrade)
    local d1 = true
    if die2 and upgrade.mod != "hp" then
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