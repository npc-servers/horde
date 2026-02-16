PERK.PrintName = "Inquisitor's Oath"
PERK.Icon = "materials/perks/paladin/inquisitors_oath.png"
PERK.Description = [[
Increase damage dealt by 3% for every Faith stack you currently have. (max. 30%)
Killing an enemy gives you 1 stack of Faith.
Melee hits leech 5% health.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "paladin_inquisitors_oath" ) then return end
    local faithStacks = ply:Horde_GetPaladinFaithStack()
    if faithStacks == 0 then return end

    bonus.increase = bonus.increase + 0.03 * faithStacks
end

PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, _, _, _, dmginfo )
    if not ply:Horde_GetPerk( "paladin_inquisitors_oath" ) then return end
    if dmginfo:GetDamage() <= 0 then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    local leech = ply:GetMaxHealth() * 0.05
    HORDE:SelfHeal( ply, leech )
end

PERK.Hooks.Horde_OnEnemyKilled = function( _, killer )
    if not killer:Horde_GetPerk( "paladin_inquisitors_oath" ) then return end

    killer:Horde_AddPaladinFaithStack()
end