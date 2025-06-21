function count_animal(a, name)
    local num = 0
    if a.animal1 == name then num += 1 end
    if a.animal2 == name then num += 1 end
    return num
end

function tp(gx,gy)
    return {gx * 16 - 16, gy * 13 + 4}
end

function gp(x, y)
    return {clamp(x \ 16 + 1,1,8), clamp((y - 12) \ 13 + 1,1,4)}
end

function clamp(a,b,c)
    return min(max(a,b),c)
end

function addfields(tbl,add)
    for k,v in pairs(add) do
        tbl[k] = v
    end
end

function lookup_ability(name)
    for def in all(abilities) do
        if def[5] == name then
            return def
        end
    end
end

function parse_ability(s)
    local args = split(s)
    local abil_def = lookup_ability(args[1])
    return make_ability(abil_def, args[2], {args[3]})
end