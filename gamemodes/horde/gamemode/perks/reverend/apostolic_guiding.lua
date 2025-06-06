PERK.PrintName = "Apostolic Guiding"
PERK.Description = "Healing players gives barrier equal to the amount healed. \nRegenerate {3} health per second."
PERK.Icon = "materials/perks/reverend/apostolic_guiding.png"
PERK.Params = {
[1] = {value = 0.5, percent = true},
[2] = {value = 1, percent = true},
[3] = {value = 0.02, percent = true},
[4] = {value = 10},
}

PERK.Hooks = {}
--PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
  --  if not ply:Horde_GetPerk("apostolic_guiding") then return end
  --  bonus.resistance = bonus.resistance + math.min(0.25, (1 * (math.max(0, 1 - ply:Health() / ply:GetMaxHealth()))))
--end


PERK.Hooks.Horde_OnPlayerHeal = function(ply, healinfo)
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk("apostolic_guiding") then
       if healer == ply then
	   ply:Horde_AddBarrierStack(healinfo:GetHealAmount()) 
	   else
	   ply:Horde_AddBarrierStack(healinfo:GetHealAmount()) 
	   end
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "apostolic_guiding" then
        ply:Horde_SetHealthRegenPercentage(0.02)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "apostolic_guiding" then
        ply:Horde_SetHealthRegenPercentage(0)
    end
end
