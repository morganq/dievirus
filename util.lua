function tp(gx,gy)
    return {gx * 16 - 16, gy * 13 + 19}
end

function gp(x, y)
    return {mid(x \ 16 + 1,1,8), mid((y - 27) \ 13 + 1,1,4)}
end

function addfields(tbl,add)
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
--[[
function populate_table(o, s)
	for kv in all(split(s)) do
		local k,v = unpack(split(kv, "="))
		if v == "false" then o[k] = false
		elseif v == "true" then o[k] = true
		else
			o[k] = v
		end
	end
end

function string_table(s)
    local z = {}
    populate_table(z, s)
    return z
end

function string_multitable(s)
    local mt = {}
    for line in all(split(s,"\n")) do
        if #line > 3 then
            add(mt, string_table(line))
        end
    end
    return mt
end
]]

function string_multilookup(s)
    local mt = {}
    for line in all(split(s,"\n")) do
        if #line > 3 then
            local vals = split(line, ",")
            mt[vals[1]] = vals
        end
    end
    return mt
end

function center_print(s, x, y, color, bgcolor, outlinecolor, rounded)
	for s in all(split(s,"%")) do
		local w = print(s,0,-600) 
		local xo = (w - 0.5) \ 2
		if bgcolor then
			rectfill(x - xo - 1, y - 1, x + xo + 1, y + 5, bgcolor)
            if rounded then
                rectfill(x - xo - 2, y, x + xo + 2, y + 4, bgcolor)
            end
		end
		--[[if outlinecolor then
			rect(x - xo - 2, y - 2, x + xo + 2, y + 6, outlinecolor)
		end]]
		print(s, x - xo, y, color)
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