PERK.PrintName = "Pack-a-Punch"
PERK.Description = "{1} increased Ballistic damage. \nBallistic damage deals {3} to {4} of an enemy's current health as bonus damage. \nPercent damage does not apply against bosses."
PERK.Icon = "materials/perks/headhunter.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
	[2] = {value = 0.35, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.08, percent = true},
	[5] = {value = 0.25, percent = true},
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("juggernaut_percent") then return end
    if HORDE:IsBallisticDamage(dmginfo) then
            bonus.increase = bonus.increase + 0.15
        
		
		if not npc:GetVar("is_boss") then
        bonus.post_add = npc:Health() * math.min(0.08, dmginfo:GetDamage() / 2000)
		end
    end
end
