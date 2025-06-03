PERK.PrintName = "Static Discharge"
PERK.Description = "Receiving damage from enemies releases a pulse that deals {1} Electric damage."
-- Gain immunity to Lightning damage. 
PERK.Icon = "materials/perks/artificer/purge.png"
PERK.Params = {
    [1] = {value = 150},
	[2] = {value = 5, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.PlayerHurt = function(victim, attacker, healthRemaining, damageTaken)
    if not (victim:Horde_GetPerk("totikfr_21") and victim:Alive())  then return end
	if victim.DischargeActive then return end
    if attacker:IsValid() and attacker:IsNPC() then
		local dmg = DamageInfo()
            dmg:SetAttacker(victim)
            dmg:SetInflictor(victim)
            dmg:SetDamageType(DMG_SHOCK)
            dmg:SetDamage(150)
            local e = EffectData()
           e:SetOrigin(victim:GetPos())
            util.Effect("explosion_shock", e, true, true)
		 victim.DischargeActive = true
            util.BlastDamageInfo(dmg, victim:GetPos(), 160)
			victim.DischargeActive = nil
    end
end

--PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
  --  if not ply:Horde_GetPerk("totikfr_21") then return end
  --  if HORDE:IsLightningDamage(dmginfo) then
  --      bonus.resistance = bonus.resistance + 1.0
  --  end
--end

--PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
  --  if ply:Horde_GetPerk("totikfr_21") and debuff == HORDE.Status_Shock then
   --     bonus.apply = 0
    --    return true
   -- end
--end
