PERK.PrintName = "Bionic Legs"
PERK.Description = "Increase your speed by {1}."
PERK.Icon = "materials/perks/phase_walk.png"
PERK.Params = {
    [1] = { value = 0.4, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_PlayerMoveBonus = function( ply, bonus_walk, bonus_run )
    if not ply:Horde_GetPerk( "juggernaut_bionic_legs" ) then return end

    local speedIncrease = 0.4

    bonus_walk.increase = bonus_walk.increase + speedIncrease
    bonus_run.increase = bonus_run.increase + speedIncrease
end