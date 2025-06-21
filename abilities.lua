function has_mod(abil, name)
    return count(abil.mods, name) > 0
end

function make_ability(base, pips, mods)
    local a = {
        base = base,
        image = base[1],
        grid_image = base[2],
        type = base[3],
        speed = base[4],
        name = base[5],
        description = base[6],
        pips = pips,
    }
    a.mods = {}
    for m in all(mods) do add(a.mods, m) end
    a.copy = function()
        return make_ability(a.base, a.pips, a.mods)
    end
    a.draw_face = function(x,y)
        spr(a.image, x, y, 2, 2)
        modspots = { {1,1}, {1, 8} }
        for i = 1, #a.mods do
            spr(mod_defs[a.mods[i]], modspots[i][1] + x, modspots[i][2] + y)
        end

        rect(x, y, x + 15, y + 15, 12)

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
        _ENV["abil_" .. a.type](user, a, gx, gy, side)
        if has_mod(a, "Growth") then
            a.pips += 1
        end
        if has_mod(a, "Fast") then
            pl.die_speed = 3
        end
    end
    return a
end

function abil_grid_spaces(img, x, y, dir)
    local spaces = {}
    local imgx, imgy = img % 16 * 8, img \ 16 * 8
    for ix = 0, 7 do
        for iy = 0, 7 do
            if sget(imgx + ix, imgy + iy) == 7 then
                local tx = x + ix * dir
                local ty = iy + y - 3
                if tx >= 1 and tx <= 8 and ty >= 1 and ty <= 4 then
                    add(spaces, {tx, ty})
                end
            end
        end
    end
    return spaces
end

function abil_shield(user, a, x, y, side)
    local shield = a.pips
    user.shield = max(user.shield, shield)
    user.shield_timer = shield_time
    local pp = tp(x,y)
    make_effect_simple(pp[1] + 4, pp[2] - 14, 0, 123)
end

function abil_bullet(user, a, x, y, side)
    
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips
    local lstart = tp(x, y)
    local lend = tp(x + dir * 10,y)

    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        local creature = grid[space[2]][space[1]].creature
        if creature and creature.side != side then
            make_damage_spot(space[1], space[2], damage, side, 0, a)
            lend = tp(space[1], space[2])
            break
        end
    end    
    make_effect_laser(lstart[1] + 8, lstart[2] + 3, lend[1] + 8, lend[2] + 3, side)
end

function abil_wave(user, a, x, y, side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips

    local time = 0
    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        make_damage_spot(space[1], space[2], damage, side, time, a)
        time += 30 \ a.speed
    end
    local pp = tp(x,y)
    make_effect_simple(pp[1] + 4 + dir * 8, pp[2] - 1, nil, 160, a.speed * 16 / 30 * dir, 0, 60)
end

function abil_bomb(user, a, x, y, side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips

    local time = 30 \ a.speed
    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        make_damage_spot(space[1], space[2], damage, side, time, a)
    end
end

function abil_instant(user, a, x, y, side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips
    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        make_damage_spot(space[1], space[2], damage, side, 0, a)
    end
end

function make_turret(x, y, a, side)
    local spri = 33
    if side == 'blue' then spri = 136 end
    local t = make_creature(x, y, side, a.pips, spri, 2, 2)
    local baseupdate = t.update
    t.rate = 80
    t.time = 0
    t.update = function()
        baseupdate()
        t.time += 1
        if t.time % t.rate == t.rate \ 2 then    
            a.use(t, x, y, t.side)
        end
        if t.time >= (30 * 15) then
            t.kill()
        end
    end
    return t
end

function abil_turret(user, a, x, y, side)
    local dir = (side == 'red' and 1 or -1)
    local turret_abil = make_ability(lookup_ability("Wave"), a.pips, a.mods)
    local p = find_open_square_for(side, x, y, {{dir,0}, {-dir,0}, {0,-1}, {0,1}, {dir,-1}, {dir,1}, {-dir,-1}, {-dir,1}})
    if p then
        local t = make_turret(p[1], p[2], turret_abil, side)
    end
end