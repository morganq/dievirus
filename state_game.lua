function draw_gameplay()
    draw_time = (draw_time + 1) % 1024
    cls(inmediasres and 7 or 15)
    if not inmediasres then
        sfn([[
rectfill,0,0,128,32,7
spr,222,64,9
spr,208,24,13,3,1
spr,204,8,13,2,1
spr,205,1,13,1,1
spr,224,81,8,4,1
spr,220,84,13
spr,220,94,13
spr,221,107,13
spr,221,116,13
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

        for wall in all(walls) do
            spr(wall[1], wall[2], wall[3], 2, 2)
        end
        fillp(0b0111110110100000.1)
        rectfill(0,28,128,31,7)
        fillp()
    end

    local bins = {{},{},{},{}}

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

    if not inmediasres then
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
    else
        rectfill(imrtimer * 4 - 200,0,128,96,7)
    end
    if not pl then return end


    if not imr_pressed and not ended then
        if die3d.visible then
            local f, x, y = die_frames[(die_time \ die_spin) % 8 + 1], die3d.x - 8, die3d.y - 8
            temp_camera_sfn(die3d.x,0,[[
rectfill,0, 105, 14, 107, 5
rectfill,-1, 106, 15, 106, 5     
]])
            
            function sprf(...)
                spr(f,...)
            end
            pal(split"0,0,0,0,0,0,0")
            temp_camera_sfn(-x,-y,[[
sprf,1,0, 2, 2
sprf,-1,0, 2, 2
sprf,0,1, 2, 2
sprf,0,-1, 2, 2
palreset
sprf,0,0, 2, 2
]])
            
            die_time += 1
        elseif pl.current_ability != nil and not ended then
            local abil = pl.die[pl.current_ability]
            spr(76, die3d.x - 7, die3d.y - 7, 3, 2)
            abil.draw_face(die3d.x - 5, die3d.y - 3)

            local line1 = abil.name
            local lx = print(line1,0,-100)
            print(line1, 64 - lx / 2 + 5, 114, 1)
            spr(130 + (draw_time \ 10) % 2, 64 - lx / 2 - 5, 114)
        end
    end
    
    if not inmediasres then
        local game_seconds = (game_frames_frac / 30) / 0x0.0001 
        if game_seconds < night_time then
            spr(155, 110, 1)
            print(night_time - game_seconds, 119, 3, 0)
        else
            spr(231, 115, 1)
            night_palette_imm = not ended
            is_night = true
        end

        local hpx = 2
        for i = 1, pl.max_health + 1 do
            local bounce = 0
            if bounce_hp[i] > 0 then
                bounce_hp[i] -= 1
                bounce = sin(bounce_hp[i] / 25) * 4
            end
            if i == pl.max_health + 1 and pl.shield_timer > 0 then
                if pl.shield_timer > 30 or pl.shield_timer \ 2 % 3 == 0 then
                    spr(145, hpx, 2 + bounce)
                end
            elseif i <= pl.health then
                spr(128, hpx, 2 + bounce)
            elseif i <= pl.max_health then
                spr(129, hpx, 2 + bounce)
            end
            hpx += 9
        end

        if victory then
            local mvt = -coslerp(victory_time,60,-46,28)
            temp_camera_sfn(0, mvt,
[[
rectfill,0,-5,128,46,7
rect,-1,-5,128,46,1
fillp,0b0101101001011010.1
rectfill,-1,47,127,48,1
fillp
print,victory!,48,0,1
print,the die         with energy,8,13,2
print,from your defeated foes...,8,21,2
spr,97,26,-2
spr,97,94,-2,1,1,1
print,upgrade,14,36,12
]])

            print("rattles", 40 + sin(6699.39 % (victory_time \ 3) / 20) * 1.25, -mvt + sin(9437.9 % (victory_time \ 3) / 20) * 0.75 + 13,1)
            spr(130 + (tf \ 10) % 2, 4, -mvt + 35)
        end
        if defeat then
--spr,203,26,-2
--spr,203,94,-2,1,1,1            
            temp_camera_sfn(0, -coslerp(defeat_time,80,-46,38),
[[
rectfill,0,-5,128,46,6
rect,-1,-5,128,46,1
fillp,0b0101101001011010.1
rectfill,-1,47,127,48,1
fillp
print,you are slain,38,0,0
spr,203,4,-2
spr,203,117,-2,1,1,1
spr,203,4,35
spr,203,117,35,1,1,1
print,the die seeks out,30,18,8
print,a new champion...,30,26,8
]])
        end
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

    if show_title then
sfn([[
clip,0,0,127,9
print,the relic of power & ruin,14,6,8
clip,0,9,127,16
print,the relic of power & ruin,13,6,8
clip
]])
        
        if victory_time > 90 then
sfn([[
rect,54,14,65,25,8
spr,240,40,16,3,1
spr,243,64,16
spr,247,72,16,2,1
]])                 
            
        end
    end
end

function gameplay_tick()
    game_frames_frac += ended and 0 or 0x0.0001
    
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

    for runner in all(attack_runners) do
        runner:update()
        if not runner.alive then del(attack_runners, runner) end
    end

    if living_monsters == 0 and not victory then
        victory = true
        music(11)
        victory_time = 0
    end

    if pl.health <= 0 and not defeat then 
        defeat = true
        music(10)
        defeat_time = 0
    end    

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
        music(11)
    elseif side_total == -32 then
        defeat = true
        music(10)
    end
end

function update_gameplay()
    ended = victory or defeat
    if victory then
        victory_time = min(victory_time + 1, 10000)
        if inmediasres then
            if victory_time > 65 then
                show_title = true
            end
            if victory_time > 180 then
                set_state("newgame")
            end
        elseif victory_time > 60 and btnp(5) then
            dset(1, dget(1) + 1)
            if level == 20 then
                dset(0, dget(0) + 1)
                set_state("win")
            else
                for i = 1, 6 do
                    player_abilities[i] = player_abilities[i].copy()
                end
                set_state("upgrade")
                music(12)
            end
        end
        time_scale = 1
    end
    if defeat then
        defeat_time += 1
        if defeat_time % 5 == 0 then
            defeat_wall = rnd(#walls)\1 + 1
            walls[defeat_wall][3] += 2
        end
        for wall in all(walls) do
            if wall[3] != 16 and rnd() < 0.5 then
                wall[3] += 0.25
            end
        end
        time_scale = 1
        if defeat_time > 240 then
            set_state("newgame")
            music(12)
        end
    end

    temp_runner = nil
    if pl.stun_time <= 0 and not ended then
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
        if move_target and not inmediasres then
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
            if inmediasres then imr_pressed = true end
            abil.use(pl, pl.pos[1], pl.pos[2], 1)
            pl.die[pl.current_ability] = abil.copy()
            pl.current_ability = nil
            pl.animate_time = 5
            throw()
            time_scale = 1
        end
        --if btnp(4) then
        --    defeat = true
        --end
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

    if die3d.visible and not ended then
        die3d.yv += 0.3 * pl.die_speed
        if die3d.y > 100 then
            if die3d.yv > 4 then sfx(16,1) end
            if die3d.yv > 1 then
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
    imrtimer = min(imrtimer + 1, 1000)
end

function spawn()
    pl = make_player()
    for i = 1,6 do
        pl.die[i] = player_abilities[i].copy()
    end
    pl.die[-1] = make_ability(all_abilities["curse"], 0, {}).copy()          
end

function do_level_intro()
    for i = 1, 60 do
        if i == 30 then
            spawn()
        end

        _draw()
        palreset()
        pal(FADE_PALS_1[max((30 - i) \ 5,1)],1)
        flip()
    end
end

level = 0
function start_level()
    music(0)
    victory = false
    defeat = false
    draw_time = 0
    victory_time = 0
    defeat_time = 0
    is_night = false

    time_scale = 1

    level += 1
    attack_runners = {}
    nongrid = {}
    grid = {}
    game_frames_frac = 0
    pause_extend = 0
    bounce_hp = {}
    for i = 1, max_hp + 1 do
        bounce_hp[i] = 0
    end

    night_time = max(65 - level * 5, 45)
    if level == 15 then night_time = 0 end
    if level >= 18 then night_time = 9999 end

    --victory = true
    --victory_time = 90
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

walls = smlu([[
199,-8,16
233,4,16
199,16,16
199,28,16
199,40,16
201,52,16
235,60,16
199,76,16
199,88,16
199,100,16
199,112,16
199,124,16
]],true)
    defeat_wall = 0

    local ld = all_levels[level]
    for enemy in all(ld) do
        local name, favor_col, time, api, mpi = unpack(split(enemy,"/"))
        x = flr(rnd(4)) + 5
        y = flr(rnd(4)) + 1
        if inmediasres then
            x = 6
            y = 2
            name = "dog1"
        end
        local mon = parse_monster(monster_defs[name], x, y)
        mon.move(x,y)
        mon.favor_col = favor_col
        mon.time = time or 0
        mon.abil_pattern_i = api or 0
        mon.move_pattern_i = mpi or 0
    end    

    if inmediasres then
        spawn()
        imrtimer = 0
    else
        do_level_intro()
        imrtimer = 1000
    end
    throw()
end

function throw()
    local all_frames = split"160,162,164,166,168,170,172,174"
    die_frames = {}
    for i = 1, 8 do
        local j = rnd(#all_frames)\1 + 1
        add(die_frames, all_frames[j])
        deli(all_frames,j)
    end
    die_time = 0
    die_spin = 2
    die3d.visible = true
    die3d.x = 20
    die3d.y = 64
    die3d.xv = 2.5
    die3d.yv = 0
end