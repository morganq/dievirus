state = "title"
states = {
    title = {update=update_title, draw=draw_title},
    newgame = {update=update_newgame, draw=draw_newgame},
    gameplay = {update=update_gameplay, draw=draw_gameplay},
    upgrade = {update=update_upgrade, draw=draw_upgrade},
    win = {update=update_win, draw=draw_win}
}

function _draw()
    states[state].draw()
end
function _update()
    states[state].update()
end