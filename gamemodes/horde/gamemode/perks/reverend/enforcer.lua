PERK.PrintName = "Enforcer"
PERK.Description = "{1} increased headshot damage. \n{1} increased Ballistic damage."
PERK.Icon = "materials/perks/reverend/enforcer.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("enforcer") then return end
	
if HORDE:IsBallisticDamage(dmginfo) then
bonus.increase = bonus.increase + 0.1
end


   if not hitgroup == HITGROUP_HEAD then return end
     bonus.increase = bonus.increase + 0.1
end

--PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
  --  if not hitgroup == HITGROUP_HEAD then return end
  --  if not ply:Horde_GetPerk("enforcer")  then return end
  --  if ply:Health() >= ply:GetMaxHealth() then
   --     bonus.increase = bonus.increase + 0.1
  --  end
--end