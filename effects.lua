function make_effect_simple(x, y, num, spri)
    local ng = make_nongrid(x,y)
    ng.time = 0
    ng.draw = function()
        if spri != nil then
            spr(spri, x, y - ng.time \ 5)
        else
            print("-"..num, x, y - ng.time \ 5, 7)
        end
    end
    ng.update = function()
        ng.time += 1
        if ng.time > 30 then del(nongrid, ng) end
    end
    return ng
end

function make_creature_particle(x, y, color, xv, floor)
    local ng = make_nongrid(x,y)
    local freezetime = -50 + rnd(2)
    addfields(ng, {
        color = color,
        yv = -1 + (0.5 - rnd()) * 0.8,
        xv = xv + (0.5 - rnd()) * 0.25,
        time = -rnd(100),
    })
    ng.draw = function()
        pset(ng.pos[1], ng.pos[2], ng.color)
        if freezetime > 8 and rnd() < 0.125 then
            line(ng.pos[1], 0, ng.pos[1], ng.pos[2], ng.color)
        end        
    end
    ng.update = function()
        freezetime += 1
        if freezetime >= 0 then ng.color = 7 end
        if freezetime >= 3 and rnd() < 0.25 then ng.color = 11 end
        ng.time += 1
        
        if freezetime < 0 then
            ng.yv += 0.1
            if ng.pos[2] > floor then
                ng.yv = ng.yv * -.5
                if ng.yv > -0.1 then
                    ng.yv = 0
                    ng.xv = ng.xv * 0.9
                    ng.y = floor
                end
            end
            ng.pos = {ng.pos[1] + ng.xv, ng.pos[2] + ng.yv}
        end
        if freezetime > 12 then
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