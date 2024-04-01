PERK.PrintName = "Drain"
PERK.Description = "{1} increase to headshot damage proportional to how full your health is.\nRecover {2} health for each enemy you killed.\n when above max health, increases headshot damage by {3}."
PERK.Icon = "materials/perks/drain.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.05, percent = true},
    [3] = {value = 0.25, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("assault_drain")  then return end
    HORDE:SelfHeal(killer, killer:GetMaxHealth() * 0.05)
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if hitgroup ~= HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_drain")  then return end
    -- local soup = ply:Health() / ply:GetMaxHealth()
    local soup = ply:Health() * 0.1
    --if ply:Health() <= ply:GetMaxHealth() then
    if ply:Health() <= ply:GetMaxHealth() then
        bonus.increase = bonus.increase + 0.02 * math.Round(soup)
    end
    if ply:Health() > ply:GetMaxHealth() then
       bonus.increase = bonus.increase + 0.25
    end
end
