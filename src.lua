state = "title"
states = {
    title = {update=update_title, draw=draw_title},
    newgame = {update=update_newgame, draw=draw_newgame},
    gameplay = {update=update_gameplay, draw=draw_gameplay},
    upgrade = {update=update_upgrade, draw=draw_upgrade},
    win = {update=update_win, draw=draw_win}
}

function _init()
    state = "title"
    cartdata("dievirus")
    menuitem(1, "clear wins", function()
        dset(0,0)
    end)
end

function _draw()
    palreset()
    states[state].draw()
    pal(split"129,2,141,4,134,6,7,136,9,10,142,139,13,14,15,0",1)
end
function _update()
    states[state].update()
end