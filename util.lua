function tp(gx,gy)
    return {gx * 16 - 16, gy * 13 + 19}
end

function gp(x, y)
    return {mid(x \ 16 + 1,1,8), mid((y - 27) \ 13 + 1,1,4)}
end

function addfields(tbl,sadd,add)
	for kv in all(split(sadd)) do
		local k,v = unpack(split(kv, "="))
		if v == "false" then tbl[k] = false
		elseif v == "true" then tbl[k] = true
		else
			tbl[k] = v
		end
	end
    for k,v in pairs(add) do
        tbl[k] = v
    end
end

function sfn(s)
    for line in all(split(s, "\n")) do
        if #line > 3 then
            local vars = split(line)
            local fnn = vars[1]
            deli(vars, 1)
            _ENV[fnn](unpack(vars))
        end
    end
end

function smlu(s, no_key)
    local mt = {}
    for line in all(split(s,"\n")) do
        if #line > 3 then
            local vals = split(line, ",")
            if no_key then
                add(mt, vals)
            else
                mt[vals[1]] = vals
            end
        end
    end
    return mt
end

function nl_print(s, x, y, color)
	for s in all(split(s,"%")) do
		print(s, x, y, color)
		y += 8
	end
end

function temp_camera(dx, dy, fn)
    local cx, cy = peek2(0x5f28), peek2(0x5f2a)
    camera(cx + dx, cy + dy)
    fn()
    camera(cx, cy)
end

function palreset()
    pal()
    palt(0b0000000000000010)
end

function get_bit(bs, n)
    return (bs & (0b1000000000000000 >>> n)) != 0
end

function ssfx(i)
    sfx(i,0)
end

function sandify(sx, sy, sw, sh, dx, dy, t)
    for x = 0, sw do
        local xv = (x / sw) - 0.5
        for y = 0, sh do 
            local c = sget(sx + x, sy + y)
            if c != (t or 14) then
                make_creature_particle(dx + x, dy + y, c, xv / 2, dy + 6 + rnd(4))
            end
        end
    end 
end

FADE_PALS_1 = smlu([[
129,2  ,141,4  ,134,6  ,7  ,136,9  ,10 ,142,139,13 ,14 ,15 ,0
0. ,129,129,2  ,141,134,6  ,2. ,2  ,9  ,9. ,141,134,0  ,15 ,0
0. ,0  ,129,129,141,134,6. ,2. ,2  ,9  ,9. ,141,134,0  ,134,0
0. ,0  ,0. ,0  ,0. ,141,134,2. ,0  ,0  ,0. ,141,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,141,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,0  ,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
0. ,0  ,0. ,0  ,0. ,0  ,0  ,0. ,0  ,0  ,0. ,0. ,0  ,0  ,0  ,0
]],true)


function scrnt(draw_fn, ...)
    nongrid = {}
    sandify(...)
    poke(0X5f54, 0x00)
    for i = 0, 170, 4 do
        draw_fn(true)
        local ng = {}
        for i = max(#nongrid - 1000,1), #nongrid do
            local n = nongrid[i]
            n.update()
            n.draw()
            add(ng, n)
        end        
        nongrid = ng

        pal(FADE_PALS_1[mid(i \ 5 - 25,1,6)], 1)
        flip()
    end
end

function draw_pips(pips, x, y, color)
    local fives = pips \ 5
    local ones = pips - (fives * 5)
    local iy = 0
    for i = 1,fives do
        rectfill(x, y - iy - 2, x + 2, y - iy, color)
        iy += 4
    end
    for i = 1, ones do
        rectfill(x, y - iy, x + 2, y - iy, color)
        iy += 2
    end    
end

function draw_mods(mods, x, y)
    for i = 1, #mods do
        spr(all_mods[mods[i]][2], x, y + i * 6 - 6)
    end    
end