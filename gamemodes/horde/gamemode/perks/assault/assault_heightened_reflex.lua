PERK.PrintName = "Heightened Reflex"
PERK.Description = "{1} increased headshot damage.\n{2} Chance to add 2 Endorphin stacks upon taking damage"
PERK.Icon = "materials/perks/heightened_reflex.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.50, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if hitgroup ~= HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
    bonus.increase = bonus.increase + 0.25
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if not ply:Horde_GetPerk("assault_heightened_reflex")  then return end
        if dmg:GetAttacker():IsValid() then
        local p = math.random()
        if p <= 0.50 then
            ply:Horde_AddEndorphins()
            ply:Horde_AddEndorphins()
        end
    end
end
