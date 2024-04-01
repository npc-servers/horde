PERK.PrintName = "Cardiac Overload"
--PERK.Description = "Adrenaline duration increased by {1}.\nAdds {2} maximum Adrenaline stacks."
PERK.Description = "Adrenaline duration increased by {1}.\nAdds {2} maximum Endorphins"
PERK.Icon = "materials/perks/cardiac_overload.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 4},
    --[2] = {value = 0.1, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_overload" then
        --i literally had to make a new buff just to have incremental evasion be a thing, its not a status and is defined within sh_damage.lua and sv_damage
        ply:Horde_SetMaxEndorphins(ply:Horde_GetMaxEndorphins() + 4)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() * 1.5)
    end
end

--[[PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("assault_cardiac_overload")  then return end
        killer:Horde_AddSandcloak(killer:Horde_GetAdrenalineStack() * 2 )
end]]--

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_overload" then
        ply:Horde_SetMaxEndorphins(ply:Horde_GetMaxEndorphins() - 4)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() / 1.5)
    end
end