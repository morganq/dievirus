function make_nongrid(x,y)
    local ng = {
        pos = {x,y},
    }
    add(nongrid, ng)
    return ng
end


function valid_move_target(x,y,side)
    if x < 1 or x > 8 or y < 1 or y > 4 then return false end
    local spot = grid[y][x]
    if spot.creature then
        return false
    end
    if spot.space.side != side then
        if x - side < 1 or x - side > 8 then return false end
        local spot2 = grid[y][x - side]
        if spot2.space.side != side then
            return false
        end
    end
    return true
end

function add_go_to_grid(go)
    local newgrid = grid[go.pos[2]][go.pos[1]]
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

function make_gridobj(x,y,layer,spri) 
    local go = {
        pos = {x,y},
        layer = layer or 10,
        spri = spri,
    }
    add_go_to_grid(go)
    go.move = function(x,y)
        del(grid[go.pos[2]][go.pos[1]], go)
        go.pos = {x,y}
        add_go_to_grid(go)
    end
    go.draw = function()
        local pp = tp(go.pos[1], go.pos[2])
        spr(go.spri, pp[1], pp[2], 2, 2)
    end
    return go
end

function find_open_square_for(side, gx, gy, attempt_squares)
    local spot = grid[gy][gx]
    local dir = 1
    if side != 1 then dir = -1 end
    local attempts = attempt_squares or {
        {0,0}, {-dir, 0}, {-dir,-1}, {-dir,1}, {0,-1}, {0,1}, {dir, 0}, {dir,-1}, {dir,1}, 
    }
    for offset in all(attempts) do
        local tx, ty = gx + offset[1], gy + offset[2]
        if tx >= 1 and tx <= 8 and ty >= 1 and ty <= 4 then
            local new_spot = grid[ty][tx]
            if new_spot.space.side == side and new_spot.creature == nil then
                return {tx, ty}
            end
        end
    end
    return nil
end

function push_to_open_square(c)
    local pos = find_open_square_for(c.side, c.pos[1], c.pos[2])
    if pos then
        c.move(pos[1],pos[2])
    end
end

function make_damage_spot(x,y,damage,side,warning,abil)
    local go = make_gridobj(x,y,1)
    addfields(go,"decay=0", {
        side=side,
        damage=damage,
        countdown_max = warning or 0,
        countdown = warning or 0,
        abil = abil
    })
    go.update = function()
        local spot = grid[go.pos[2]][go.pos[1]]
        if go.countdown > 0 then
            go.countdown -= 1
        elseif go.countdown == 0 then
            if spot.creature and spot.creature.side != go.side then
                if has_mod(go.abil, "stun") then
                    spot.creature.stun_time = 90
                end                
                if has_mod(go.abil, "poison") then
                    spot.creature.poison_timer = 120 * go.damage
                else
                    spot.creature.take_damage(go.damage)
                end
            end
            local claims = count(abil.mods, "claim") * 2
            if spot.space.side != go.side and abil.tiles_claimed < claims then
                spot.space.flip(go.side, 30 * 8)
                abil.tiles_claimed += 1
            end            
            spot.space.bounce_timer = 13
            go.countdown -= 1               
            ssfx((go.side == 1) and 8 or 9)
        else
            go.decay += 1
            if go.decay > 4 then
                del(spot, go)
            end
        end
    end
    go.draw = function()
        local pp = tp(go.pos[1], go.pos[2])
        local spot = grid[go.pos[2]][go.pos[1]]
        pp[2] += spot.space.offset_y
        local color = 9
        if go.side != 1 then color = 8 end
        if go.countdown > 0 then
            local t = 1 - (go.countdown / go.countdown_max)
            local hw = 6 * t + 2
            local hh = 4 * t + 2
            local x1,y1,x2,y2 = pp[1] + 1, pp[2] + 1, pp[1] + 14, pp[2] + 11
            
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
    local side = 1
    if x > 4 then
        side = -1
    end
    local go = make_gridobj(x,y,0,spri)
    go.side = side
    go.main_side = side
    go.fire_time = 0
    go.bounce_timer = 15 + x + y
    go.offset_y = 0
    go.update = function()
        if go.fire_time > 0 then
            go.fire_time -= 1
        end
    end
    go.draw = function()
        go.offset_y = -(cos(go.bounce_timer / 10) - 0.5) * (go.bounce_timer / 5)
        go.bounce_timer = max(go.bounce_timer - 1, 0)
        local pp = tp(go.pos[1], go.pos[2])
        pp[2] += go.offset_y
        local spri = 64
        if go.side == -1 then
            pal(split"0,2,3,4,5,3,13,8,9,10,11,12,1,14,15,0")
        else
            palreset()
        end
        spr(spri, pp[1], pp[2], 2, 2)
        if go.fire_time > 0 and go.fire_time % 5 == 0 then
            make_effect_fire(pp[1] + rnd() * 12, pp[2] + rnd() * 8 - 2)
        end
    end
    grid[go.pos[2]][go.pos[1]].space = go
    go.flip = function(side, time)
        if side == go.side then return end
        if side == go.main_side then
            go.side = go.main_side
            return
        end
        go.main_side = go.side
        go.side = side
    end
    return go
end