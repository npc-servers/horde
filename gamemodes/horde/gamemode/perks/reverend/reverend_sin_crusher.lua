PERK.PrintName = "Sin Crusher"
PERK.Description = [[{2} of your healing directly reduces debuff buildup.
Kills restore an additional {3} health.
Killing Elites heals an additional {1} and cleanses all debuffs.]]
PERK.Icon = "materials/perks/reverend/sin_crusher.png"
PERK.Params = {
    [1] = { value = 0.2, percent = true },
    [2] = { value = 1, percent = true },
    [3] = { value = 0.05, percent = true },
}
PERK.Hooks = {}

PERK.Hooks.Horde_PostOnPlayerHeal = function( ply, healinfo )
    local healer = healinfo:GetHealer()
    if not healer:IsPlayer() or not healer:Horde_GetPerk( "reverend_sin_crusher" ) then return end

    local reduceDebuff = {
        [HORDE.Status_Bleeding] = true,
        [HORDE.Status_Break] = true,
        [HORDE.Status_Necrosis] = true,
        [HORDE.Status_Ignite] = true,
        [HORDE.Status_Frostbite] = true,
        [HORDE.Status_Shock] = true
    }

    for debuff, _ in pairs( ply.Horde_Debuff_Buildup ) do
        if reduceDebuff[debuff] then
            ply:Horde_ReduceDebuffBuildup( debuff, healinfo:GetHealAmount() )
        end
    end
end

PERK.Hooks.Horde_OnEnemyKilled = function( victim, killer )
    if not killer:Horde_GetPerk( "reverend_sin_crusher" ) then return end

    if victim:Horde_IsElite() then
        for _, ent in pairs( ents.FindInSphere( killer:GetPos(), 250 ) ) do
            if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
                for debuff, buildup in pairs( ent.Horde_Debuff_Buildup ) do
                    ent:Horde_RemoveDebuff( debuff )
                    ent:Horde_ReduceDebuffBuildup( debuff, buildup )
                end
                HORDE:OnPlayerHeal( ent, HealInfo:New( { amount = ent:GetMaxHealth() * 0.2, healer = killer } ) )
            end
        end
    end

    for _, ent in pairs( ents.FindInSphere( killer:GetPos(), 250 ) ) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
            local healinfo = HealInfo:New( { amount = ent:GetMaxHealth() * 0.05, healer = killer } )
            HORDE:OnPlayerHeal( ent, healinfo )
        end
    end
end