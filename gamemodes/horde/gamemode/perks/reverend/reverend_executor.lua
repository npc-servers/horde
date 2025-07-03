PERK.PrintName = "Executor"
PERK.Description = [[Deal {1} more ballistic damage against targets with less than {3} health.
Deal {2} more ballistic damage against Elites.]]
PERK.Icon = "materials/perks/reverend/executor.png"
PERK.Params = {
    [1] = { value = 0.15, percent = true },
    [2] = { value = 0.1, percent = true },
    [3] = { value = 0.5, percent = true },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, bonus, _, dmg )
    if not ply:Horde_GetPerk( "reverend_executor" ) then return end
    if not HORDE:IsBallisticDamage( dmg ) then return end

    local half = npc:GetMaxHealth() * 0.5
    if npc:Health() <= half then
        bonus.more = bonus.more * 1.15
    end

    if npc:Horde_IsElite() then
        bonus.more = bonus.more * 1.1
    end
end
