tf = 0
victory = false
victory_time = 0
defeat = false
defeat_time = 0



function draw_gameplay()
    cls()
    fillp(0b0)
    -- Sort by binning grid objs and non-grid objs by y grid space
    -- then draw them top to bottom. ez.
    local bins = {{},{},{},{}}
    for i = 1, #nongrid do
        local ng = nongrid[i]
        local gpp = gp(ng.pos[1],ng.pos[2])
        add(bins[gpp[2]],ng)
    end
    for i = 1,4 do
        for j = 1, 8 do
            local gridspace = grid[i][j]
            for k = 1, #gridspace do
                gridspace[k].draw()
            end
            local pp =tp(j, i)
            --print(#gridspace, pp[1], pp[2], 7)
        end
        for o in all(bins[i]) do o.draw() end
    end
    if die3d.visible then
        draw_die3d(die3d)
    elseif pl.current_ability != nil then
        local abil = pl.die[pl.current_ability]
        abil.draw_face(die3d.x - 8, die3d.y - 8)

        local line1 = abil.description
        print(line1, 64 - #line1 * 2, 114, 11)
        if abil.animal1 != nil then
            local line2 = descriptions[abil.base .. "/" .. abil.animal1]
            print(line2, 64 - #line2 * 2, 122, 10)
        end
    end

    local hpx = 1
    for i = 1, pl.max_health do
        if i <= pl.health then
            spr(192, hpx, 0)
        else
            spr(193, hpx, 0)
        end
        hpx += 6
    end
    if pl.shield_timer > 0 then
        for i = 1, pl.shield do
            spr(194, hpx, 0)
            hpx += 6
        end
        local frame = flr((pl.shield_timer / shield_time) * 9) + 195
        spr(frame, hpx - 1, -2)
    end   

    if victory then
        local y = min(victory_time, 40)
        rectfill(34, y - 5, 94, y + 8, 0)
        rect(34, y - 5, 94, y + 9, 9)
        print("victory", 50, y, 10)
    end
    if defeat then
        local y = min(defeat_time, 40)
        rectfill(34, y - 5, 94, y + 8, 0)
        rect(34, y - 5, 94, y + 9, 2)
        print("defeat", 52, y, 8)
    end
end

function update_gameplay()
    if victory then
        victory_time += 1
        if victory_time > 90 then
            if level == 15 then
                dset(0, dget(0) + 1)
                state = "win"
            else
                state = "upgrade"
            end
        end
    end
    if defeat then
        defeat_time += 1
        if defeat_time > 120 then
            --
        end
    end

    if pl.health <= 0 and not defeat then 
        defeat = true
        defeat_time = 0
    end
    local living_monsters = 0

    local need_update = {}
    for i = 1, 8 do
        for j = 1, 4 do
            local gridspace = grid[j][i]
            if gridspace.creature and gridspace.creature.health > 0 and gridspace.creature.side != 'red' then
                living_monsters += 1
            end
            for o in all(gridspace) do
                add(need_update, o)
            end
        end
    end
    for o in all(need_update) do o.update() end

    for ng in all(nongrid) do
        ng.update()
    end

    if living_monsters == 0 and not victory then
        victory = true
        victory_time = 0
    end

    if pl.stun_time <= 0 and not victory and not defeat then
        local target = nil
        if btnp(0) and pl.pos[1] > 1 then
            target = {pl.pos[1] - 1, pl.pos[2]}
        end
        if btnp(1) and pl.pos[1] < 8 then
            target = {pl.pos[1] + 1, pl.pos[2]}
        end
        if btnp(2) and pl.pos[2] > 1 then
            target = {pl.pos[1], pl.pos[2] - 1}
        end        
        if btnp(3) and pl.pos[2] < 4 then
            target = {pl.pos[1], pl.pos[2] + 1}
        end        
        if target then
            if valid_move_target(target[1], target[2], pl.side) then
                pl.move(target[1], target[2])
            end
        end
        if btnp(5) and pl.current_ability != nil then
            pl.die[pl.current_ability].use(pl, pl.pos[1], pl.pos[2], 'red')
            pl.current_ability = nil
            pl.animate_time = 5
            throw()
        end
        if btnp(2,1) then
            victory = true
            victory_time = 90
        end
    end
    tf += 1
    if die3d.visible then
        die3d.yv += 0.1 * pl.die_speed
        if die3d.y > 100 then
            die3d.yv = die3d.yv * -0.5
            die3d.y = 100
            dvra = (0.5 - rnd()) * die3d.yv * die3d.xv
            dvrb = (0.5 - rnd()) * die3d.yv * die3d.xv
            dvrc = (0.5 - rnd()) * die3d.yv * die3d.xv
            if die3d.xv < 0.4 + pl.die_speed * 0.1 then
                pl.die_speed = 1
                die3d.visible = false
                die3d.xv = 0
                die3d.yv = 0
                pl.current_ability = flr(rnd(6)) + 1
            end
        end
        die3d.xv *= 0.975
        die3d.x += die3d.xv
        die3d.y += die3d.yv
        dra += dvra / 10
        drb += dvrb / 10
        drc += dvrc / 10
        gen_die(die3d, dra,drb,drc)
    end
end