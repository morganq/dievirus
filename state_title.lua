titlef = 0
function update_title()
    titlef += 1
    if true or btnp(5) then
        player_abilities = {}
        state = "newgame"
    end
end


function draw_title()
    cls()
    print("die virus", 46, 32, 7)
    spr(13, 55 + rnd() * sin(titlef / 100) * 2, 56 + rnd() * sin(titlef / 100) * 2, 2, 2)
    print("❎ to start", 42, 88)
end