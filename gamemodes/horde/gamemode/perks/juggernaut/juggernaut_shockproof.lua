PERK.PrintName = "Shockproof"
PERK.Description = "Gain {1} damage resist to non-physical damage and immunity to poison damage. \n{4} less debuff buildup."
PERK.Icon = "materials/perks/ballistic_shock.png"
PERK.Hooks = {}
PERK.Params = {
    [1] = {value = 0.25, percent = true},
	[2] = {value = 2},
	[3] = {value = 50},
	[4] = {value = 0.5, percent = true},
}


PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("juggernaut_shockproof")  then return end
    if HORDE:IsFireDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.25
    end
	if HORDE:IsBlastDamage(dmginfo) then
       bonus.resistance = bonus.resistance + 0.25
    end
	if HORDE:IsColdDamage(dmginfo) then
       bonus.resistance = bonus.resistance + 0.25
    end
	if HORDE:IsLightningDamage(dmginfo) then
       bonus.resistance = bonus.resistance + 0.25
    end
	if HORDE:IsPoisonDamage(dmginfo) then
       bonus.resistance = bonus.resistance + 1
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
	if not ply:Horde_GetPerk("juggernaut_shockproof") then return end
		bonus.less = bonus.less * 0.5
		if debuff == HORDE.Status_Break then
			bonus.apply = 0
			return true
		end
    end

--hook.Add("PlayerTick", "Horde_JuggernautBarrierRegen", function(ply, mv)
  -- if SERVER then
  -- if not ply:Alive() then return end
	--if not ply:Horde_GetPerk("juggernaut_shockproof") then return end
	
    
   -- if CurTime() >= ply.Horde_JuggernautBarrierRegenCurTime + 1 then
     --   ply:Horde_AddBarrierStack(math.min(3, ply:Horde_GetBarrierStack() + 3 ))
     --   ply.Horde_JuggernautBarrierRegenCurTime = CurTime()
   -- end
	--end
--end)

--hook.Add("Horde_ResetStatus", "Horde_JuggernautBarrierRegenReset", function(ply)
 --   ply.Horde_JuggernautBarrierRegen = 0
 --   ply.Horde_JuggernautBarrierRegenPercentage = 0
   --ply.Horde_JuggernautBarrierRegenCurTime = CurTime()
--end)