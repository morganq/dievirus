
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