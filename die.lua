function draw_die2d(die,x,y, die2, upgrade)
    local d1 = true
    if die2 and upgrade.kind != "hp" then
        d1 = (tf \ 14) % 2 == 0
    end
    local locs = split"0,15,15,15,30,15,45,15,15,0,15,30"
    for i = 1, 6 do
        temp_camera(-locs[i * 2 - 1] - x, -locs[i * 2] - y, function()
            if upgrade and not d1 and upgrade.faces[i] then
sfn([[
rectfill,-2,-1,11,10,12
rectfill,-1,-2,10,11,12
]])
                die2[i].draw_face(0,0,i)
            else
                die[i].draw_face(0,0,i)
            end
        end)
    end
end