creature_index = 1
function make_creature(x, y, side, health, spri)
    local go = make_gridobj(x, y, 10, spri)
    addfields(go,
        "movetime=0,yo=-7,damage_time=0,shield_timer=0,stun_time=0,stun_co=1,alive=true,overextended_timer=0,poison_timer=0,iframes=0,telegraph_x=0,telegraph_y=0",
        {
            lastpos = {0,0},
            side = side,
            dir = side,
            health = health,
            max_health = health,
            index=creature_index,
        })
    go.clay_time = spri >= 40 and 45 or 15
    creature_index += 1
    go.draw = function()
        local pp = tp(go.pos[1], go.pos[2])
        local spri = go.spri        
        local hit = 0
        local space = grid[go.pos[2]][go.pos[1]].space
        function ds(ox, oy)
            local ov = go.side * -sin(go.overextended_timer / 60) * 3
            spr(spri, pp[1] + hit + ox + ov + go.telegraph_x, pp[2] + go.yo + oy + space.offset_y + go.telegraph_y, 2,2, go.side == -1)
        end

        if go.clay_time > 0 then
            if spri < 12 then
                pal(split"2,2,2,2,2,2,1,1,1,1,1,1,1,1,15,1")
                clip(0, pp[2] + go.yo + max((go.clay_time - 10) * 4,-4), 128, 22)
                
                ds(go.clay_time \ 5,0)
                ds(-go.clay_time \ 6,0)
                ds(0,go.clay_time \ 7)
                ds(0,-go.clay_time \ 8)
                ds(0,0)
                clip()
                palreset()
            elseif spri < 40 then
                ds(0,0)
            else
                ds(go.clay_time * go.clay_time * 0.125, go.clay_time * go.clay_time * -0.25)
            end
            go.clay_time -= 1
            return
        end

        if go.movetime > 0 then
            fillp(0b0101010101010101.11)
        end
        
        if go.damage_time > 0 then
            pal(split"7,7,7,7,7,7,7,7,7,7,7,7,7,7,7")
            hit = -go.damage_time * go.dir
        end
        
        if go.poison_timer > 0 then
            pal(split"1,2,3,12,12,6,7,12,9,10,12,12,13,14,15,0")
        end
        if go.iframes % 2 == 0 then
            ds(0,0)
        end
        fillp()
        palreset()
        if go.stun_time > 0 then
            spr(143 + (tf \ 10) % 2, pp[1] + 3, pp[2] - 6)
        end
    end

    go.update = function()
        local space = grid[go.pos[2]][go.pos[1]].space
        if go.iframes > 0 then go.iframes -= 1 end
        if space.side != go.side then
            go.overextended_timer += 1
            if go.overextended_timer >= 30 then
                go.overextended_timer = 0
                push_to_open_square(go)
            end
        else
            go.overextended_timer = 0
        end
        for t in all(split"poison_timer,damage_time,movetime,shield_timer,stun_time") do
            go[t] = max(go[t] - 1, 0)
        end
    end

    local basemove = go.move
    go.move = function(x,y)
        if not go.alive then return end
        local pp = tp(go.pos[1],go.pos[2])     
        if go.clay_time <= 0 then
            make_effect_simple(pp[1], pp[2] + go.yo, nil, go.spri, 0, -1, 3, 0b1010101010101010.11, 2, 2, go.side == -1)
            ssfx(go == pl and 14 or -1)
            go.movetime = 3
        end
        grid[go.pos[2]][go.pos[1]].creature = nil
        go.lastpos = {go.pos[1], go.pos[2]}
        
        basemove(x,y)
        grid[y][x].creature = go
        if go.poison_timer > 0 then
            go.take_damage(1, true)
            local npp = tp(x,y)
            --make_effect_simple(npp[1] + 8, npp[2] - 9, 0, 126)
        end        
    end

    go.take_damage = function(damage, pierce)
        if victory or defeat then return end
        if not pierce then 
            if go.shield_timer > 0 then
                go.shield_timer = 0
                sfx(20, 1)
                return
            end
        end
        if go == pl then
            for i = max(go.health - damage + 1,1), go.health do
                bounce_hp[i] = 10
            end
        end
        go.health -= damage
        go.damage_time = 5
        local pp = tp(go.pos[1],go.pos[2])
        sfx(go == pl and 11 or 10, 1)
        if go.health <= 0 then
            go.kill()
            sfx(go == pl and 13 or 12, 1)
        end
    end

    go.kill = function()
        go.alive = false
        local sx = go.spri % 16 * 8
        local sy = go.spri \ 16 * 8
        local pp = tp(go.pos[1], go.pos[2])
        sandify(sx, sy, 15, 15, pp[1], pp[2] + go.yo)
        grid[go.pos[2]][go.pos[1]].creature = nil
        del(grid[go.pos[2]][go.pos[1]], go)
    end

    grid[go.pos[2]][go.pos[1]].creature = go
    
    return go
end
