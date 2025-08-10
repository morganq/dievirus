function update_win()
    if tf == 20 then
        music(-1)
        sfx(20)
    end
    if tf > 60 and btnp(5) then
        set_state("newgame")
    end
end

function draw_win()
    cls(1)
sfn([[
print,- you win -,42,8,7
print,with die in hand you mount,8,28,6
print,the steps of the ziggurat.,8,36,6
print,here the curse can be,8,52,6
print,lifted and with it the,8,60,6
print,wretched power of the die.,8,68,6
print,lift the curse... or maybe,8,84,6
print,just one last roll?,8,92,6
print,roll,102,116,12
spr,132,92,116
]])
    print("wins: " .. dget(0), 8, 116, 7)
    
end

--[[
|          you win             |
| with die in hand you mount   |
| the steps of the ziggurat.   |
| 
| here, the curse can be       |
| lifted and with it, the      |
| wretched power of the die.   |
| 
| destroy the curse... or maybe
| just one last roll?
|
| wins: 3                      | 
]]