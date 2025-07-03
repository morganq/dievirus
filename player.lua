pl = nil

function make_player()
    local pl = make_creature(1,2, 1, max_hp, player_sprite, 2, 2)
    addfields(pl, {
        max_health = pl.health,
        die = {},
        die_speed = 1,
        current_ability = nil,
    })
    return pl
end