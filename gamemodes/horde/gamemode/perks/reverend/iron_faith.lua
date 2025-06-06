PERK.PrintName = "Iron Faith"
PERK.Description = "Kills grant yourself and nearby players {4} of their max armor. \nPlayers with Mind will be restored {1} of their max Mind instead."
PERK.Icon = "materials/perks/reverend/iron_faith.png"
PERK.Params = {
    [1] = {value = 0.1, percent = true},
    [2] = {value = 0.20, percent = true},
	[3] = {value = 2},
	[4] = {value = 0.02, percent = true},
	[5] = {value = 0.2, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
 if not killer:Horde_GetPerk("iron_faith") then return end
-- if killer:Armor() >= 10 then return end
--	killer:SetArmor(math.min(10,killer:Armor()+2))
	
	for _, ent in pairs(ents.FindInSphere(killer:GetPos(), 250)) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() and (ent:Armor() < ent:GetMaxArmor()) and (ent:GetMaxArmor() > 0) then
			ent:SetArmor(math.min((ent:GetMaxArmor()), ent:Armor() + (ent:GetMaxArmor() * 0.02) ))
		end
		if ent:IsValid() and ent:IsPlayer() and ent:Alive() and (ent:Horde_GetMaxMind() > 0) then
		ent:Horde_SetMind(math.min(ent:Horde_GetMaxMind(), ent:Horde_GetMind() + (ent:Horde_GetMaxMind() * 0.1)))
		--ent:ChatPrint( "Mind Activated" )
		end
	end
end

--PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
  --  if not ply:Horde_GetPerk("iron_faith") then return end
	
--	if ply:Armor() >= 5 then
   --     bonus.block = bonus.block + 2
   -- end
	
  --  if ply:Armor() >= 5 and (HORDE:IsFireDamage(dmginfo) or HORDE:IsBlastDamage(dmginfo)) then
     --   bonus.resistance = bonus.resistance + 1.0
    --end
--end

--PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
   -- if ply:Horde_GetPerk("iron_faith") and ply:Armor() >= 5 and debuff == HORDE.Status_Ignite then
    --    bonus.apply = 0
   --     return true
  --  end
--end
