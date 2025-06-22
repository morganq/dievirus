function make_effect_simple(x, y, num, spri, xv, yv, lifetime)
    if xv == nil then xv = 0 end
    if yv == nil then yv = -0.2 end
    lifetime = lifetime or 30
    local ng = make_nongrid(x,y)
    ng.time = 0
    ng.draw = function()
        if spri != nil then
            spr(spri, ng.pos[1], ng.pos[2])
        else
            print("-"..num, x, y, 7)
        end
    end
    ng.update = function()
        ng.pos[1] += xv
        ng.pos[2] += yv
        ng.time += 1
        if ng.time > lifetime then del(nongrid, ng) end
    end
    return ng
end
--[[
function make_effect_laser(x1, y1, x2, y2, side)
    local ng = make_nongrid(x1,y1)
    ng.time = 0
    ng.draw = function()
        local color = 8
        if side != 1 then color = 12 end
        
        rectfill(x1,y1 -1 ,x2,y2 + 1, color)
        line(x1,y1,x2,y2,7)
    end
    ng.update = function()
        ng.time += 1
        if ng.time > 10 then del(nongrid, ng) end
    end
    return ng
end
]]
function make_creature_particle(x, y, color, xv, floor)
    local ng = make_nongrid(x,y)
    local freezetime = -50 + rnd(2)
    local syv = (rnd() - 0.5) * 1.8
    addfields(ng, {
        color = color,
        yv = syv,
        xv = xv + (0.5 - rnd()) * 0.25,
        time = -rnd(100),
    })
    ng.draw = function()
        pset(ng.pos[1], ng.pos[2], color)
        --if freezetime > 8 and rnd() < 0.125 then
        --    line(ng.pos[1], 0, ng.pos[1], ng.pos[2], ng.color)
        --end        
    end
    ng.update = function()
        freezetime += 1
        if rnd() < 0.04 or freezetime >= 0 then color = rnd({15,15,5}) end
        --if freezetime >= 3 and rnd() < 0.25 then ng.color = 14 end
        ng.time += 1
        
        if freezetime < syv * 10 - 30 then
            ng.yv += 0.1
        else
            ng.yv += 0.02
            ng.yv *= 0.5
            if ng.xv > -3 then
                ng.xv += -rnd() * 0.25
            end
        end

        if ng.pos[2] > floor then
            ng.yv = ng.yv * -.15
            if ng.yv > -0.1 then
                ng.yv = 0
                --ng.xv = ng.xv * 0.9
                ng.y = floor
            end
        end

        ng.pos = {ng.pos[1] + ng.xv, ng.pos[2] + ng.yv}
        if freezetime > 32 and rnd() < 0.1 then
            del(nongrid, ng)
        end
    end
    return ng
end

function make_effect_ghost(x, y, spri, sprw, sprh)
    local ng = make_nongrid(x,y)
    ng.time = 0
    ng.draw = function()
        fillp(0b0101010101010101.11)
        spr(spri, ng.pos[1], ng.pos[2], sprw, sprh)
        fillp()
    end
    ng.update = function()
        ng.time += 1
        ng.pos = {ng.pos[1], ng.pos[2] - ng.time}
        if ng.time > 3 then del(nongrid, ng) end
    end
    return ng
end