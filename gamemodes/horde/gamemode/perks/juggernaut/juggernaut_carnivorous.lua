PERK.PrintName = "Carnivorous"
PERK.Description = "{1} of Ballistic damage builds up Bleeding. \nLeech {3} health when dealing Ballistic damage against bleeding targets."
--Kills restore {2} of your max health. \n
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 0.3, percent = true},
	[2] = {value = 0.05, percent = true},
	[3] = {value = 1},
}

PERK.Hooks = {}

--PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, inflictor)
   -- if not killer:Horde_GetPerk("juggernaut_carnivorous") then return end
   
   --     HORDE:SelfHeal(killer, killer:GetMaxHealth() * 0.05)
   
--end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("juggernaut_carnivorous") then return end
    if HORDE:IsBallisticDamage(dmginfo) then 	
		npc:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.3 , ply, dmginfo:GetDamagePosition())
		
	if npc:Horde_HasDebuff(HORDE.Status_Bleeding) then
		HORDE:SelfHeal(ply, 1)
		end
    end
end
