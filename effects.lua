function make_effect_simple(x, y, color, spri, xv, yv, lifetime, fill, sprw, sprh, flip)
    xv = xv or 0
    yv = yv or -0.2
    lifetime = lifetime or 30
    local ng = make_nongrid(x,y)
    local time = 0
    ng.draw = function()
        fillp(fill)
        spr(spri, ng.pos[1], ng.pos[2], sprw or 1, sprh or 1, flip)
        fillp()
    end
    ng.update = function()
        ng.pos[1] += xv
        ng.pos[2] += yv
        time += 1
        if time > lifetime then del(nongrid, ng) end
    end
    return ng
end

function make_creature_particle(x, y, color, xv, floor)
    local ng = make_nongrid(x,y)
    local freezetime = -50 + rnd(2)
    local syv = (rnd() - 0.5) * 1.8
    addfields(ng,"", {
        color = color,
        yv = syv,
        xv = xv + (0.5 - rnd()) * 0.25,
    })
    ng.draw = function()
        pset(ng.pos[1], ng.pos[2], color)   
    end
    ng.update = function()
        freezetime += 1
        if rnd() < 0.04 or freezetime >= 0 then color = rnd({15,15,5}) end
        
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