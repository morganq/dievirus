titlef = 0
function update_title()
    titlef += 1
    if btnp(5) then
        state = "newgame"
    end
end


function draw_title()
    cls()
    --[[for i = 1, 45 do
        local x1 = rnd() * 128
        line(x1, 0, x1, 128, 0)
    end
    ]]
    --[[
    for i = 0, 10 do
        for j = -1, 10 do
            local x1 = (i * 20) + (((titlef % 100) * (sin(j / 2.3 + titlef + 0.25) * 2.5) + j * 4) / 5) % 20 - 20
            local y1 = j * 16
            local color = 1
            local val = sin((x1 - 24) / 128)
            if val > 0.75 then
                color = 8
            elseif val > 0.4 then
                color = 2
            end
            rect(x1, y1, x1 + 16, y1 + 13, color)
        end
    end
    ]]--
    print("die virus", 46, 32, 7)
    spr(13, 55 + rnd() * sin(titlef / 100) * 2, 56 + rnd() * sin(titlef / 100) * 2, 2, 2)
    print("❎ to start", 42, 88)
end