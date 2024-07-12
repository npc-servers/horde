PERK.PrintName = "Cardiac Resonance"
PERK.Description = "Every time you kill an enemy, Players near you also gain {1} Adrenaline and {4} Barrier, up to {2} Adrenaline stacks.\nKills add {3} barrier for each Adrenaline Stack you have."
PERK.Icon = "materials/perks/cardiac_resonance.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 2},
    [3] = {value = 2},
    [4] = {value = 10}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_resonance" then
        ply:Horde_SetCardiacResonanceEnabled(true)
    end
end
PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("assault_cardiac_resonance")  then return end
        killer:Horde_AddBarrierStack(0 + killer:Horde_GetAdrenalineStack() * 2)
end
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_resonance" then
        ply:Horde_SetCardiacResonanceEnabled(nil)
    end
end