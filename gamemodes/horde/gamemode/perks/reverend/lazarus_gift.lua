PERK.PrintName = "Lazarus Gift"
PERK.Description = "Ballistic damage headshots leech {2} max health for yourself and nearby players. \nIncrease speed by {1} while at full health."
PERK.Icon = "materials/perks/reverend/lazarus_gift.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.02, percent = true},
	[3] = {value = 0.01, percent = true},
	[4] = {value = 5},
}

PERK.Hooks = {}

--PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
   -- if SERVER and perk == "lazarus_gift" then
    --    ply:Horde_SetArmorRegenEnabled(true)
	--	ply:Horde_SetArmorRegenMax(10)
   -- end
--end

--PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
   -- if SERVER and perk == "lazarus_gift" then
   --     ply:Horde_SetArmorRegenEnabled(nil)
	--	ply:Horde_SetArmorRegenMax(0)
  --  end
--end


PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("lazarus_gift") and HORDE:IsBallisticDamage(dmginfo) and hitgroup == HITGROUP_HEAD then
		for _, ent in pairs(ents.FindInSphere(ply:GetPos(), 250)) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() and ent == ply then
		HORDE:SelfHeal(ply, ply:GetMaxHealth() * 0.02)
			elseif ent:IsPlayer() and ent:Alive() and ent ~= ply then
			local healinfo = HealInfo:New({amount=ent:GetMaxHealth() * 0.02, healer=ply})
            HORDE:OnPlayerHeal(ent, healinfo)
		end
	end
		end
    end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("lazarus_gift") then return end
	if ply:Health() >= ply:GetMaxHealth() then
    bonus_walk.increase = bonus_walk.increase + 0.25
    bonus_run.increase = bonus_run.increase + 0.25
	end
end
	
