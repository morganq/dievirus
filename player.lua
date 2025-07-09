pl = nil

function make_player()
    local pl = make_creature(1,2, 1, max_hp, player_sprite)
    addfields(pl, "die_speed=1", {
        max_health = pl.health,
        die = {},
    })
    return pl
end