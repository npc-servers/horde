PERK.PrintName = "Taboo Breaker"
PERK.Description = "{1} increased Ballistic headshot damage. \nBallistic headshot damage increases Bleed buildup. \nBallistic damage removes Decay and Regenerator mutations."
PERK.Icon = "materials/perks/reverend/taboo_breaker2.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true}
}

PERK.Hooks = {}


PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("taboo_breaker") then return end
	
	if HORDE:IsBallisticDamage(dmginfo) and hitgroup == HITGROUP_HEAD then
            bonus.increase = bonus.increase + 0.25
			npc:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.3, ply, dmginfo:GetDamagePosition())
        end
       
	   if npc:Horde_HasMutation("decay") and HORDE:IsBallisticDamage(dmginfo) then
            npc.Horde_Mutation["decay"] = nil
            npc.Horde_Mutation_Decay = nil
        end
		
		if npc:Horde_HasMutation("regenerator") and HORDE:IsBallisticDamage(dmginfo) then
            npc.Horde_Mutation["regenerator"] = nil
            npc.Horde_Mutation_Regenerator = nil
        end
		
end
