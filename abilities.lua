function has_mod(abil, name)
    return count(abil.mods, name) > 0
end

function make_ability(base, pips, mods)
    local a = {
        base = base,
        image = base[1],
        type = base[2],
        def = base[3],
        name = base[4],
        level = base[5],
        rarity = base[6],
        pips = pips,
    }
    a.mods = {}
    for m in all(mods) do add(a.mods, m) end
    a.copy = function()
        return make_ability(a.base, a.pips, a.mods)
    end
    a.draw_face = function(x,y)
        rectfill(x, y-1, x + 9, y + 10, 7)
        rectfill(x-1, y, x + 10, y + 9, 7)
        spr(a.image, x + 1, y + 1, 1, 1)
        modspots = { {0,0}, {0, 6} }
        for i = 1, #a.mods do
            spr(mod_defs[a.mods[i]], modspots[i][1] + x, modspots[i][2] + y)
        end

        local fives = a.pips \ 5
        local ones = a.pips - (fives * 5)
        local iy = 0
        for i = 1,fives do
            rectfill(x + 7, y + 9 - iy - 2, x + 9, y + 9 - iy, 12)
            iy += 4
        end
        for i = 1, ones do
            rectfill(x + 7, y + 9 - iy, x + 9, y + 9 - iy, 12)
            iy += 2
        end
    end    
    a.use = function(user, gx, gy, side)
        if a.base == "none" then return end
        printh(a.type)
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

function abil_shield(user, a, x, y, side)
    local shield = a.pips
    user.shield = max(user.shield, shield)
    user.shield_timer = shield_time
    local pp = tp(x,y)
    make_effect_simple(pp[1] + 4, pp[2] - 14, 0, 123)
end

function abil_attack(user, a, x, y, side)
    add(attack_runners, make_attack_runner(a.def, a, x, y, side))
end

function make_turret(x, y, a, side)
    local spri = 2
    if side == -1 then spri = 2 end
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
    local dir = side
    local turret_abil = make_ability(lookup_ability("Wave"), a.pips, a.mods)
    local p = find_open_square_for(side, x, y, {{dir,0}, {-dir,0}, {0,-1}, {0,1}, {dir,-1}, {dir,1}, {-dir,-1}, {-dir,1}})
    if p then
        local t = make_turret(p[1], p[2], turret_abil, side)
    end
end

function make_attack_runner(def, a, x, y, side)
    local steps_s = split(def, ";")
    local steps = {}
    for step in all(steps_s) do
        local step_def = split(step, "/")
        add(steps, {
            delay=step_def[1],
            grid=step_def[2],
            xv=step_def[3] * side,
            yv=step_def[4],
            collides=step_def[5] == 1,
            telegraph=step_def[6],
            max_tiles=step_def[7] or 8,
            bounces_x=step_def[8] == 1,
            bounces_y=step_def[9] == 1,
            alive=true,
        })
    end
    local t = 0
    function update(self)

        local any_alive = false
        for step in all(steps) do
            function damage_and_stop(x,y)
                make_damage_spot(x,y,a.pips,side,step.telegraph,a)
                if step.collides then
                    local c = grid[y][x].creature 
                    if c and c.side != side then
                        step.alive = false
                    end
                end
            end

            local non_moving = step.xv == 0 and step.yv == 0
            if step.virtual_objs and step.alive then
                for vo in all(step.virtual_objs) do
                    if step.xv != 0 or step.yv != 0 then
                        vo.timers = {vo.timers[1] - 1, vo.timers[2] - 1}

                        local moved = false
                        local off_grid = false
                        if vo.xv != 0 and vo.timers[1] <= 0 then
                            if (vo.pos[1] == 1 and vo.xv < 0) or (vo.pos[1] == 8 and vo.xv > 0) then
                                if step.bounces_x then
                                    vo.xv = -vo.xv
                                else
                                    off_grid = true
                                end
                            end
                            vo.pos[1] += sgn(vo.xv)
                            moved = true
                            vo.timers[1] = 30 / abs(vo.xv)
                        end
                        if vo.yv != 0 and vo.timers[2] <= 0 then
                            if (vo.pos[2] == 1 and vo.yv < 0) or (vo.pos[2] == 4 and vo.yv > 0) then
                                if step.bounces_y then
                                    vo.yv = -vo.yv
                                else
                                    off_grid = true
                                end
                            end
                            vo.pos[2] += sgn(vo.yv)
                            moved = true
                            vo.timers[2] = 30 / abs(vo.yv)
                        end                        
                        if moved and not off_grid then
                            printh(vo.pos[1] .. "," .. vo.pos[2])
                            damage_and_stop(vo.pos[1],vo.pos[2])
                            vo.max_tiles -= 1
                        end
                        if not off_grid and vo.max_tiles > 0 then
                            any_alive = true
                        end
                    end
                end
            end
            if not step.virtual_objs and t >= step.delay then
                
                step.virtual_objs = {}
                for space in all(abil_grid_spaces(step.grid, x, y, side)) do
                    if not non_moving then
                        local timers = {
                            (step.xv == 0) and 0 or (30 / step.xv),
                            (step.yv == 0) and 0 or (30 / step.yv),
                        }
                        add(step.virtual_objs, {pos = space, timers = timers, max_tiles=step.max_tiles, xv = step.xv, yv = step.yv}) -- no need to copy space because generated each time
                        any_alive = true
                    end
                    damage_and_stop(space[1],space[2])
                end
            end
        end
        if not any_alive then self.alive = false end
        t += 1
    end
    s = {
        update = update,
        alive = true,
        --[[debug_draw = function(self)
            for step in all(steps) do
                if step.virtual_objs then
                    for vo in all(step.virtual_objs) do
                        local pp = tp(vo.pos[1], vo.pos[2])
                        circfill(pp[1], pp[2], 3, 0)
                    end
                end
            end
        end,]]
    }    
    s:update()
    return s
end