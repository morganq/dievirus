function parse_ability(s)
    local args = split(s,";")
    local abil_def = all_abilities[args[1]]
    return make_ability(abil_def, args[2], {args[3]}, abil_def[6])
end

function has_mod(abil, name)
    return count(abil.mods, name) > 0
end

function make_ability(base, pips, mods, icon_color)
    local a = {
        base = base,
        name = base[1],
        image = base[2],
        type = base[3],
        def = base[4],
        rarity = base[6],
        pips = pips,
    }
    a.mods = {}
    a.original_pips = pips
    
    for m in all(mods) do add(a.mods, m) end
    a.copy = function()
        return make_ability(a.base, a.original_pips, a.mods)
    end

    a.get_pips = function()
        if pl then
            local gps = grid[pl.pos[2]][pl.pos[1]].space
            if has_mod(a, "invasion") and gps.side == -1 then
                return a.pips + 1
            end
            if has_mod(a, "snipe") and pl.pos[1] == 1 then
                return a.pips + 1
            end            
            if has_mod(a, "rage") and pl.health <= pl.max_health / 2 then
                return a.pips + 1
            end
        end
        return a.pips
    end

    a.draw_face = function(x,y,n)
        local color = a.name == "curse" and 8 or 7
        rectfill(x, y-1, x + 9, y + 10, color)
        rectfill(x-1, y, x + 10, y + 9, color)
        pal(1, icon_color or 1)
        spr(a.image, x + 1, y + 1, 1, 1)
        pal(1,1)
        draw_mods(a.mods, x, y)
        draw_pips(a.get_pips(), x + 7, y + 9, 12)
        
        if n == 4 then
            spr(141, x - 2, y + 4)
        end
    end    
    a.use = function(user, gx, gy, side)
        if a.base == "none" then return end
        a.tiles_claimed = 0
        _ENV["abil_" .. a.type](user, a.get_pips(), a, gx, gy, side)
        local max_growth_pips = 4 + side -- lol nice
        if has_mod(a, "growth") and a.pips < max_growth_pips then
            a.pips += 1
            a.original_pips += 1
        end
    end
    return a
end

function abil_grid_spaces(grid_def, x, y, dir)
    local spaces = {}
    for ix = 0, 7 do
        for iy = 0, 3 do
            if get_bit(grid_def, ix * 4 + iy % 4) then
                local tx = x + ix * dir
                local ty = y + iy - 1
                if tx >= 1 and tx <= 8 and ty >= 1 and ty <= 4 then
                    add(spaces, {tx, ty})
                end
            end
        end
    end
    return spaces
end

function abil_shield(user, pips, a, x, y, side)
    user.shield_timer = max(shield_time * pips, user.shield_timer)
    local pp = tp(x,y)
    if user == pl then ssfx(15) end
    --make_effect_simple(pp[1] + 4, pp[2] - 14, 0, 136)
    bounce_hp[#bounce_hp] = 10
    add(attack_runners, make_attack_runner(a.def, pips, a, x, y, side))
end

function abil_attack(user, pips, a, x, y, side)
    add(attack_runners, make_attack_runner(a.def, pips, a, x, y, side))
end

function abil_curse()
    local cursed = 0
    for i = 1, 50 do
        local s = grid[rnd(4)\1+1][rnd(8)\1+1]
        if s.space.side == 1 then
            s.space.side = -1
            cursed += 1
            if cursed >= 1 then return end
        end
    end
    ssfx(19)
end

function make_turret(pips, x, y, a, side)
    local spri = 12
    local t = make_creature(x, y, side, pips, spri)
    local baseupdate = t.update
    t.rate = 80
    t.time = 0
    t.update = function()
        baseupdate()
        t.time += 1
        if t.time % t.rate == t.rate \ 2 then
            a.use(t, t.pos[1], t.pos[2], t.side)
        end
        if t.time >= (30 * 15) then
            t.kill()
        end
    end
    return t
end

function abil_turret(user, pips, a, x, y, side)
    local dir = side
    local turret_abil = make_ability(all_abilities[a.def], pips, a.mods)
    local p = find_open_square_for(side, x, y, {{dir,0}, {-dir,0}, {0,-1}, {0,1}, {dir,-1}, {dir,1}, {-dir,-1}, {-dir,1}})
    if p then
        local t = make_turret(pips, p[1], p[2], turret_abil, side)
    end
end

function make_attack_runner(def, pips, a, x, y, side, fake)
    local steps_s = split(def, ";")
    local steps = {}
    for step in all(steps_s) do
        local sd = split(step, "/")
        add(steps, {
            delay=sd[1],
            grid=sd[2],
            xv=sd[3] * side,
            yv=sd[4],
            collides=sd[5] == 1,
            telegraph=sd[6],
            max_tiles=sd[7] or 8,
            bounces_x=sd[8] == 1,
            bounces_y=sd[9] == 1,
            absolute_x=sd[10] == 1,
            absolute_y=sd[11] == 1,
            alive=true,
        })
    end
    local t = 0
    function update(self)
        local any_alive = false
        function damage_and_stop(st, x,y)
            if fake then
                add(s.fake_hit, {x,y})
            else
                make_damage_spot(x,y,pips,side,st.telegraph,a)
            end
            if st.collides then
                local c = grid[y][x].creature 
                if c and c.side != side then
                    st.alive = false
                end
            end
        end        
        for step in all(steps) do

            local non_moving = step.xv == 0 and step.yv == 0
            if step.virtual_objs and step.alive then
                for vo in all(step.virtual_objs) do
                    if step.xv != 0 or step.yv != 0 then
                        vo.timers = {vo.timers[1] - 1, vo.timers[2] - 1}

                        local moved = false
                        if vo.xv != 0 and vo.timers[1] <= 0 then
                            if (vo.pos[1] <= 1 and vo.xv < 0) or (vo.pos[1] >= 8 and vo.xv > 0) then
                                if step.bounces_x then
                                    vo.xv = -vo.xv
                                else
                                    vo.off_grid = true
                                end
                            end
                            vo.pos[1] += sgn(vo.xv)
                            moved = true
                            vo.timers[1] = 30 / abs(vo.xv) - 1
                        end
                        if vo.yv != 0 and vo.timers[2] <= 0 then
                            if (vo.pos[2] <= 1 and vo.yv < 0) or (vo.pos[2] >= 4 and vo.yv > 0) then
                                if step.bounces_y then
                                    vo.yv = -vo.yv
                                else
                                    vo.off_grid = true
                                end
                            end
                            vo.pos[2] += sgn(vo.yv)
                            moved = true
                            vo.timers[2] = 30 / abs(vo.yv) - 1
                        end                        
                        if moved and not vo.off_grid then
                            damage_and_stop(step, vo.pos[1],vo.pos[2])
                            vo.max_tiles -= 1
                        end
                        if not vo.off_grid and vo.max_tiles > 0 then
                            any_alive = true
                        end
                    end
                end
            end
            if not step.virtual_objs then
                if t >= step.delay then
                    step.virtual_objs = {}
                    local abs_x = side * -3.5 + 4.5
                    for space in all(abil_grid_spaces(step.grid, step.absolute_x and abs_x or x, step.absolute_y and 2 or y, side)) do
                        if not non_moving then
                            local timers = {
                                (step.xv == 0) and 0 or (30 / abs(step.xv)),
                                (step.yv == 0) and 0 or (30 / abs(step.yv)),
                            }
                            add(step.virtual_objs, {pos = space, timers = timers, max_tiles=step.max_tiles, xv = step.xv, yv = step.yv, off_grid = false}) -- no need to copy space because generated each time
                            any_alive = true
                        end
                        damage_and_stop(step, space[1],space[2])
                    end
                else
                    any_alive = true
                end
            end
        end
        if not any_alive then self.alive = false end
        t += 1
    end
    s = {
        update = update,
        alive = true,
        fake_hit = {},
    }    
    if fake then
        local ticks = 0
        while s.alive do
            ticks += 1
            s:update()
        end
    else
        s:update()
    end
    return s
end