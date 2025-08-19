PERK.PrintName = "Taboo Breaker"
PERK.Description = [[{1} increased Ballistic headshot damage.
Ballistic headshot damage increases Bleed buildup.
Ballistic damage removes Decay and Regenerator mutations.]]
PERK.Icon = "materials/perks/reverend/taboo_breaker2.png"
PERK.Params = {
    [1] = { value = 0.25, percent = true }
}

PERK.Hooks = {}


PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "reverend_taboo_breaker" ) then return end
    if not HORDE:IsBallisticDamage( dmginfo ) then return end

    if hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.25
        npc:Horde_AddDebuffBuildup( HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.3, ply, dmginfo:GetDamagePosition() )
    end

    if npc:Horde_HasMutation( "decay" ) then
        npc.Horde_Mutation["decay"] = nil
        npc.Horde_Mutation_Decay = nil
    end
    if npc:Horde_HasMutation( "regenerator" ) then
        npc.Horde_Mutation["regenerator"] = nil
        npc.Horde_Mutation_Regenerator = nil
    end
end
