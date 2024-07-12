PERK.PrintName = "Charge"
PERK.Description = "Adds {1} maximum Adrenaline stacks.\nAdds {3} maximum Endorphins."
PERK.Icon = "materials/perks/charge.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 0.06, percent = true},
    [3] = {value = 3},
    [4] = {value = 0.1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "survivor_assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 1)
        ply:Horde_SetMaxEndorphins(ply:Horde_GetMaxEndorphins() + 3)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "survivor_assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 1)
        ply:Horde_SetMaxEndorphins(ply:Horde_GetMaxEndorphins() - 3)
    end
end