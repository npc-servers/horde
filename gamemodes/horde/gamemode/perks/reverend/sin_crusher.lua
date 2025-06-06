PERK.PrintName = "Sin Crusher"
PERK.Description = "{2} of your healing directly reduces debuff buildup. \nKills restore an additional {3} health. \nKilling Elites heals an additional {1} and cleanses all debuffs."
PERK.Icon = "materials/perks/reverend/sin_crusher.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
	[2] = {value = 1, percent = true},
	[3] = {value = 0.05, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_PostOnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("sin_crusher") then
        for debuff, buildup in pairs(ply.Horde_Debuff_Buildup) do
            if debuff == HORDE.Status_Bleeding or debuff == HORDE.Status_Break or debuff == HORDE.Status_Necrosis or debuff == HORDE.Status_Ignite or debuff == HORDE.Status_Frostbite or debuff == HORDE.Status_Shock then
                ply:Horde_ReduceDebuffBuildup(debuff, healinfo:GetHealAmount())
            end
        end
    end
end

--PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
 --   if not ply:Horde_GetPerk("sin_crusher") then return end
   -- if HORDE:IsPoisonDamage(dmginfo) then
   --     bonus.resistance = bonus.resistance + 1.0
   -- end
--end

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("sin_crusher") then return end

	if victim:Horde_IsElite() then
	for _, ent in pairs(ents.FindInSphere(killer:GetPos(), 250)) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
			for debuff, buildup in pairs(ent.Horde_Debuff_Buildup) do
				ent:Horde_RemoveDebuff(debuff)
				ent:Horde_ReduceDebuffBuildup(debuff, buildup)
			end
            HORDE:OnPlayerHeal(ent, HealInfo:New({amount=ent:GetMaxHealth() * 0.2, healer=killer}))
			end
        end
		end

    for _, ent in pairs(ents.FindInSphere(killer:GetPos(), 250)) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
			local healinfo = HealInfo:New({amount=ent:GetMaxHealth() * 0.05, healer=killer})
            HORDE:OnPlayerHeal(ent, healinfo)		
        end
    end
	
    end



--PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
   -- if ply:Horde_GetPerk("sin_crusher") and debuff == HORDE.Status_Break then
   --     bonus.apply = 0
    --    return true
   -- end
	
	--if ply:Horde_GetPerk("sin_crusher") and debuff == HORDE.Status_Bleeding then
  --      bonus.apply = 0
  --      return true
  --  end
--end

