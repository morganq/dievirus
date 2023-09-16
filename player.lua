pl = nil

function make_player()
    local pl = make_creature(1,2, 'red', max_hp, 37, 2, 2)
    addfields(pl, {
        max_health = pl.health,
        die = {},
        die_speed = 1,
        current_ability = nil,
    })
    return pl
end