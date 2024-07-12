PERK.PrintName = "Charge"
PERK.Description = "When below max health,\nincrease movespeed proportional to how low your health is, \nup to {3}x movespeed when at 1 hp."
PERK.Icon = "materials/perks/charge.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.06, percent = true},
    [3] = {value = 2},
}

PERK.Hooks = {}

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("assault_charge") then return end
    local pain = ply:GetMaxHealth() - ply:Health() + 1
    if ply:Health() < ply:GetMaxHealth() then
        bonus_walk.increase = bonus_walk.increase + 0.01 * math.Round(pain)
        bonus_run.increase = bonus_run.increase + 0.01 * math.Round(pain)
    end
end
