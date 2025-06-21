tf = 0
draw_time = 0
victory = false
victory_time = 0
defeat = false
defeat_time = 0

time_scale = 1
move_target = nil

function draw_debug()
    for i = 1,4 do
        for j = 1,8 do
            local gs = grid[i][j]
            if gs.creature then
                
                local pp1 = tp(j, i)
                circ(pp1[1], pp1[2], 2, 10)
                local pp2 = tp(gs.creature.pos[1], gs.creature.pos[2])
                line(pp1[1], pp1[2], pp2[1] + 8, pp2[2] + 8, 7)
            end
        end
    end
end

function draw_gameplay()
    draw_time = (draw_time + 1) % 1024
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

    --draw_debug()

    if time_scale < 1 and not victory then
        poke(0X5F54, 0x60)
        for i = 0, 63 do
            local x = sin(i / 21 + draw_time / 90)
            sspr(0,i,128,1,x * 1.25, i)
        end
        poke(0X5F54, 0x00)        
        if draw_time % 20 > 10 then
            spr(45, 60, 40)
        end
    end
end

function gameplay_tick()
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

    if pl.health <= 0 and not defeat then 
        defeat = true
        defeat_time = 0
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
                time_scale = 0
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

    make_effect_simple(rnd(128) + 30, rnd(64) - 64, 0, 46, -0.5, 2, 33)
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
        time_scale = 0
    end
    if defeat then
        defeat_time += 1
        if defeat_time > 120 then
            --
        end
        time_scale = 1
    end

    if pl.stun_time <= 0 and not victory and not defeat then
        move_target = nil    
        if btnp(0) and pl.pos[1] > 1 then
            move_target = {pl.pos[1] - 1, pl.pos[2]}
        end
        if btnp(1) and pl.pos[1] < 8 then
            move_target = {pl.pos[1] + 1, pl.pos[2]}
        end
        if btnp(2) and pl.pos[2] > 1 then
            move_target = {pl.pos[1], pl.pos[2] - 1}
        end        
        if btnp(3) and pl.pos[2] < 4 then
            move_target = {pl.pos[1], pl.pos[2] + 1}
        end
        if move_target then
            if valid_move_target(move_target[1], move_target[2], pl.side) then
                pl.move(move_target[1], move_target[2])
                time_scale = 1
            end
        end    
            
        
        if btnp(5) and pl.current_ability != nil then
            pl.die[pl.current_ability].use(pl, pl.pos[1], pl.pos[2], 'red')
            pl.current_ability = nil
            pl.animate_time = 5
            throw()
            time_scale = 1
        end
        if btnp(2,1) then
            victory = true
            victory_time = 90
        end
    end

    if time_scale > 0 then
        gameplay_tick()
    end
end

level = 0
function start_level()
    level += 1
    time_scale = 1
    nongrid = {}
    grid = { }
    for i = 1,4 do
        grid[i] = {}
        for j = 1, 8 do
            grid[i][j] = {}
        end
    end    
    for j = 1,4 do
        for i = 1, 8 do
            make_gridspace(i,j)
        end
    end    
    victory = false
    defeat = false
    die3d = {
        pts = {},
        faces = {
            {1,2,3,4}, -- front
            {2,1,5,6}, -- top
            {3,4,8,7}, -- bottom
            {1,4,8,5}, -- left
            {2,3,7,6}, -- right
            {5,6,7,8} -- back
        },
        x = 10, 
        y = 84,
        xv = 0,
        yv = 0,
        visible = false,
    }
    gen_die(die3d, 0, 0, 0)
    pl = make_player()
    for i = 1,6 do
        pl.die[i] = player_abilities[i].copy()
    end
    function place_monster(name, x, y, favor_row)
        x = x or flr(rnd(4)) + 5
        y = y or flr(rnd(4)) + 1
        local mon = parse_monster(monster_defs[name], x, y)
        mon.move(x,y)
        mon.favor_row = favor_row
        return mon
    end  
    if level == 1 then
        place_monster("mage1", 6, 1, 2)
        place_monster("mage1", 6, 4, 3)
    elseif level == 2 then
        place_monster("mage1")
        place_monster("fighter1")
    elseif level == 3 then
        place_monster("duelist1")
        place_monster("duelist1")
    elseif level == 4 then
        place_monster("engineer1")
    elseif level == 5 then
        place_monster("boss1")
    elseif level == 6 then
        place_monster("mage2")
        place_monster("mage2").abil_pattern_i = 2
    elseif level == 7 then
        place_monster("fighter2")
        place_monster("fighter1")
        place_monster("fighter1")
    elseif level == 8 then
        place_monster("engineer1")
        place_monster("engineer1")
        place_monster("fighter1")
    elseif level == 9 then -- too easy
        place_monster("bomber1")
        place_monster("bomber1").time = 33
        place_monster("bomber1").time = 66
    elseif level == 10 then
        place_monster("boss2")
    elseif level == 11 then
        place_monster("bomber2")
        place_monster("engineer2")
    elseif level == 12 then
        place_monster("duelist2")
    elseif level == 13 then
        place_monster("mage1")
        local m2 = place_monster("mage2")
        m2.abil_pattern_i = 2
        m2.move_pattern_i = 2
        local m3 = place_monster("mage3")
        m3.abil_pattern_i = 3
        m3.move_pattern_i = 3        
    elseif level == 14 then
        place_monster("fighter2")
        local m2 = place_monster("fighter2")
        m2.abil_pattern_i = 2
        m2.move_pattern_i = 2    
        place_monster("boss2")
    elseif level == 15 then
        place_monster("boss3")
        place_monster("engineer1")
        place_monster("fighter1")
    end

    throw()
end

dra, drb, drc, dvra, dvrb, dvrc = 0,0,0,0,0,0

function throw()
    die3d.visible = true
    die3d.x = 20
    die3d.y = 84
    die3d.xv = 1.5
    die3d.yv = 0
    dvra = (0.5 - rnd())
    dvrb = (0.5 - rnd())
    dvrc = (0.5 - rnd())  
end