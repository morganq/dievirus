
function draw_gameplay()
    draw_time = (draw_time + 1) % 1024
    cls(15)
    sfn([[
rectfill,0,0,128,32,7
spr,222,64,9
spr,199,-8,16,2,2
spr,199,4,16,2,2
spr,199,16,16,2,2
spr,199,28,16,2,2
spr,199,40,16,2,2
spr,201,52,16,3,2
spr,199,76,16,2,2
spr,199,88,16,2,2
spr,199,100,16,2,2
spr,199,112,16,2,2
spr,199,124,16,2,2
spr,208,24,13,3,1
spr,204,8,13,2,1
spr,205,1,13,1,1
spr,224,81,8,4,1
spr,220,84,13
spr,220,94,13
spr,221,107,13
spr,221,116,13
spr,228,2,20,2,2
spr,211,37,24,2,1
spr,213,76,24,2,1
spr,214,108,24,1,1
spr,222,72,9
spr,223,113,9
spr,222,121,9
rectfill,61,12,62,13,12
fillp,0b1100110011001100.1
line,110,10,124,10,6
line,70,10,82,10,6
fillp,0b1101110111011101.1
line,34,9,82,9,6
fillp,0
]])
    local game_seconds = (game_frames_frac / 30) / 0x0.0001 
    if game_seconds < night_time then
        print(night_time - game_seconds, 64, 1, 0)
    else
        spr(231, 60, 1)
        night_palette_imm = true
        is_night = true
    end
    local bins = {{},{},{},{}}
    --[=[for i = 1, #nongrid do
        local ng = nongrid[i]
        local gpp = gp(ng.pos[1],ng.pos[2])
        add(bins[gpp[2]],ng)
    end]=]
    for i = 1,4 do
        for j = 1, 8 do
            local gridspace = grid[i][j]
            for k = 1, #gridspace do
                gridspace[k].draw()
            end
            local pp =tp(j, i)
        end
        for o in all(bins[i]) do o.draw() end
    end
    for ng in all(nongrid) do
        ng.draw()
    end
    palreset()

    if temp_runner then
        for fh in all(temp_runner.fake_hit) do
            local pxy = tp(fh[1], fh[2])
            spr(137 + (draw_time \ 2) % 4, pxy[1] + 4, pxy[2] + 2)
        end
    end

    sfn([[
rectfill,0,86,128,96,15
line,5,86,29,86,15
line,49,86,79,86,15
line,90,86,128,86,15
sspr,0,96,16,4,3,84
sspr,16,96,16,4,70,84
sspr,16,100,16,4,104,83
sspr,0,100,16,4,44,84
sspr,32,96,24,4,0,108
sspr,32,96,24,4,100,95
sspr,32,96,24,4,42,120
sspr,32,100,24,4,74,111
sspr,32,100,24,4,25,91
]])
    if not pl then return end

    if die3d.visible then
        rectfill(die3d.x, 105, die3d.x + 14, 107, 5)
        rectfill(die3d.x-1, 106, die3d.x + 15, 106, 5)
        local f, x, y = die_frames[(die_time \ die_spin) % 8 + 1], die3d.x - 8, die3d.y - 8
        pal(split"0,0,0,0,0,0,0")
        spr(f, x + 1, y, 2, 2)
        spr(f, x - 1, y, 2, 2)
        spr(f, x, y + 1, 2, 2)
        spr(f, x, y - 1, 2, 2)
        palreset()
        spr(f, x, y, 2, 2)
        
        die_time += 1
    elseif pl.current_ability != nil then
        local abil = pl.die[pl.current_ability]
        spr(76, die3d.x - 7, die3d.y - 7, 3, 2)
        abil.draw_face(die3d.x - 5, die3d.y - 3)

        local line1 = abil.name
        local lx = print(line1,0,-100)
        print(line1, 64 - lx / 2 + 5, 114, 1)
        spr(130, 64 - lx / 2 - 5, 114)
    end
    
    local hpx = 6
    spr(132,3,1,1,2)
    local hw = (pl.max_health + pl.shield) * 7
    line(6,1,hw+3,1,1)
    line(6,10,hw+3,10,1)
    spr(132,hw,1,1,2,true)
    for i = 1, pl.max_health do
        
        if i <= pl.health then
            spr(128, hpx, 3)
        else
            spr(129, hpx, 3)
        end
        hpx += 7
    end
    if pl.shield_timer > 0 then
        local fx = 1 - (pl.shield_timer / shield_time)
        for i = 1, pl.shield do
            spr(145, hpx, 3)
            local yo = fx * 6
            sspr(64, 64 + yo, 8, 6 - yo, hpx, 3 + yo)
            hpx += 7
        end
        
        
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

    if (time_scale < 1 or pause_extend > 0) and not victory then
        
        poke(0X5F54, 0x60)
        for i = 11, 90 do
            local mul = mid(i / 16 - 0.5,0,1)
            local x = sin(i / 26 + draw_time / 128) * mul
            sspr(0,i,128,1,x * 1.25, i)
        end
        poke(0X5F54, 0x00)        
        if draw_time % 20 > 10 then
            spr(133, 59, 54)
        end
    end
end

function gameplay_tick()
    game_frames_frac += 0x0.0001
    
    local living_monsters = 0
    local need_update = {}
    for i = 1, 8 do
        for j = 1, 4 do
            local gridspace = grid[j][i]
            if gridspace.creature and gridspace.creature.health > 0 and gridspace.creature.side != 1 then
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

    if not victory and not defeat then
        for runner in all(attack_runners) do
            runner:update()
            if not runner.alive then del(attack_runners, runner) end
        end
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

    if rnd() < 0.5 then
        make_creature_particle(128, rnd(60) + 20, 15, -3, rnd(52) + 28)
    end

    local side_total = 0
    for y = 1, 4 do
        for x = 1, 8 do
            side_total += grid[y][x].space.side
        end
    end
    if side_total == 32 then
        victory = true
    elseif side_total == -32 then
        defeat = true
    end
end

function update_gameplay()
    if btnp(4) then victory = true end

    if victory then
        victory_time += 1
        if victory_time > 90 then
            if level == 15 then
                dset(0, dget(0) + 1)
                state = "win"
            else
                for i = 1, 6 do
                    player_abilities[i] = player_abilities[i].copy()
                end
                state = "upgrade"
                tf = 0
            end
        end
        time_scale = 1
    end
    if defeat then
        defeat_time += 1
        time_scale = 1
    end

    temp_runner = nil
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
            if pl.overextended_timer == 0 then
                if valid_move_target(move_target[1], move_target[2], pl.side) then
                    pl.move(move_target[1], move_target[2])
                    time_scale = 1
                end
            else
                -- If overextended, any attempted motion will unpause
                time_scale = 1
            end
        end    
        
        local abil = pl.die[pl.current_ability]
        if abil != nil then
            if abil.type == "attack" then
                temp_runner = make_attack_runner(abil.def, 1, abil, pl.pos[1], pl.pos[2], 1, true)
            end
        end
        if btnp(5) and pl.current_ability != nil then
            abil.use(pl, pl.pos[1], pl.pos[2], 1)
            pl.die[pl.current_ability] = abil.copy()
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
        if pause_extend > 0 then
            pause_extend -= 1
        else
            gameplay_tick()
        end
    else   
        -- enable/disable a music track
    end

    if die3d.visible then
        die3d.yv += 0.3 * pl.die_speed
        if die3d.y > 100 then
            if die3d.yv > 0.5 then
                for i = 1, die3d.yv * 10 do 
                    local p = make_creature_particle(die3d.x + rnd(10) - 5, 106, 5, rnd(1)-0.5, 106 + rnd(3))
                    p.yv = rnd(2) * -0.5
                end            
            end
            die3d.yv = die3d.yv * -0.35
            die3d.y = 100
            die3d.xv *= 0.5
            die_spin *= 2
        end
        if die_time > 45 then
            pl.die_speed = 1
            
            die3d.xv = 0
            die3d.yv = 0
            if pl.stun_time <= 0 then
                die3d.visible = false
                
                pl.current_ability = flr(rnd(6)) + 1

                if is_night and pl.current_ability == 4 then
                    pl.current_ability = -1
                end
                time_scale = 0
                if has_mod(pl.die[pl.current_ability], "pause") then
                    pause_extend += 30
                end                    
            end
        end        
        die3d.xv *= 0.975
        die3d.x += die3d.xv
        die3d.y += die3d.yv
    end    
end

function do_level_intro()
    for i = 1, 60 do
        if i == 30 then
            pl = make_player()
            for i = 1,6 do
                pl.die[i] = player_abilities[i].copy()
            end
            pl.die[-1] = make_ability(all_abilities["curse"], 1, {}).copy()            
        end


        if i == 1 then
            function place_monster(name, x, y, favor_row)
                x = x or flr(rnd(4)) + 5
                y = y or flr(rnd(4)) + 1
                local mon = parse_monster(monster_defs[name], x, y)
                mon.move(x,y)
                mon.favor_row = favor_row
                return mon
            end  
            if level == 1 then
                place_monster("mage1", 6, 2, 2)
                --place_monster("mage1", 6, 4, 3)
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
            elseif level == 9 then
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
                --place_monster("fighter1")
            end            
        end

        _draw()
        pal(FADE_PALS[max((30 - i) \ 5,1)])
        poke(0X5f54, 0x60)
        sspr(0, 0, 128, 128, 0, 0)
        poke(0X5f54, 0x00)
        palreset()
        pal(split"129,2,141,4,134,6,7,136,9,10,142,139,13,14,15,0",1)
        flip()
    end
end

level = 0
function start_level()
    tf = 0
    victory = false
    defeat = false
    draw_time = 0
    victory_time = 0
    defeat_time = 0

    time_scale = 1

    level += 1
    attack_runners = {}
    nongrid = {}
    grid = { }
    game_frames_frac = 0
    pause_extend = 0

    night_time = max(65 - level * 5, 25)

    victory = true
    victory_time = 90
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
    die3d = {}

    do_level_intro()
    throw()
end

function throw()
    sfx(16,1)
    local all_frames = {160,162,164,166,168,170,172,174}
    die_frames = {}
    for i = 1, 8 do
        local j = rnd(#all_frames)\1 + 1
        add(die_frames, all_frames[j])
        deli(all_frames,j)
    end
    --die_frames = {34,36,42,44,40,32,38,46}
    die_time = 0
    die_spin = 2
    die3d.visible = true
    die3d.x = 20
    die3d.y = 64
    die3d.xv = 2.5
    die3d.yv = 0
end