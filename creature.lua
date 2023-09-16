creature_index = 1
function make_creature(x, y, side, health, spri, sprw, sprh)
    local go = make_gridobj(x, y, 10, spri, sprw, sprh)
    addfields(go, {
        movetime = 0,
        lastpos = {0,0},
        animate_time = 0,
        yo = -7,
        side = side,
        dir = side == 'red' and 1 or -1,
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
        local pp = tp(go.pos[1], go.pos[2])
        local spri = go.spri
        if go.movetime > 0 then
            fillp(0b0101010101010101.11)
        end
        local hit = 0
        if go.damage_time > 0 then
            pal({7,7,7,7,7,7,7,7,7,7,7,7,7,7,7})
            hit = -go.damage_time * go.dir
        end
        if go.animate_time > 0 then
            spri = go.spri + go.sprw
        end
        
        spr(spri, pp[1] - 1 + hit, pp[2] + go.yo, go.sprw, go.sprh)
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
