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

function string_multilookup(s, no_key)
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
                --make_creature_particle(dx + x, dy + y, c, xv / 2, dy + y + rnd(4))
            end
        end
    end 
end

FADE_PALS = string_multilookup([[
1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,11,12,13,14,15,0 
0 ,1 ,1 ,2 ,3 ,5 ,6 ,2 ,2 ,9 ,9 ,3 ,5 ,0 ,15 ,0
0 ,0 ,1 ,1 ,3 ,5 ,6 ,2 ,2 ,9 ,9 ,3 ,5 ,0 ,5 ,0
0 ,0 ,0 ,0 ,0 ,3 ,5 ,2 ,0 ,0 ,0 ,3 ,0 ,0 ,0 ,0
0 ,0 ,0 ,0 ,0 ,0 ,3 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0
]],true)

function screen_transition(sand)
    -- change to make sand a rect.
    nongrid = {}
    for i = sand and 0 or 200, 300, 4 do
        poke(0X5f54, 0x60)
        if i < 127 and sand then
            sandify(0, i, 127, rnd(3)+1, 0, i, 5)
        end
        
        pal(FADE_PALS[mid(i \ 5 - 40,1,6)])
        if sand then
            rectfill(0,0,127,i - 16, 5)
        else
            sspr(0,0,128,128)
        end
        poke(0X5f54, 0x00)
        local ng = {}
        for i = max(#nongrid - 1000,1), #nongrid do
            local n = nongrid[i]
            n.update()
            n.draw()
            add(ng, n)
        end        
        nongrid = ng
        flip()
    end
end