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
    printh("bullet " .. side)
    --make_effect_laser(lstart[1] + 8, lstart[2] + 3, lend[1] + 8, lend[2] + 3, side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips

    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        local creature = grid[space[2]][space[1]].creature
        printh(space[1] .. "," .. space[2] .. " - " .. (creature != nil and 1 or 0))
        if creature and creature.side != side then
            make_damage_spot(space[1], space[2], damage, side, 0, a)
            break
        end
    end    
end

function abil_wave(user, a, x, y, side)
    printh("wave " .. side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips

    local time = 0
    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        make_damage_spot(space[1], space[2], damage, side, time, a)
        time += 30 \ a.speed
    end
end

function abil_bomb(user, a, x, y, side)
    printh("bomb " .. side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips

    local time = 30 \ a.speed
    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        make_damage_spot(space[1], space[2], damage, side, time, a)
    end
end

function abil_instant(user, a, x, y, side)
    printh("instant " .. side)
    local dir = (side == 'red' and 1 or -1)
    
    local damage = a.pips

    for space in all(abil_grid_spaces(a.grid_image, x, y, dir)) do
        make_damage_spot(space[1], space[2], damage, side, 0, a)
    end
end