PERK.PrintName = "Quality Rounds"
PERK.Description = "{2} increased Ballistic damage. \n{1} increased Stun buildup."
PERK.Icon = "materials/perks/headhunter.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
	[2] = {value = 0.2, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.08, percent = true},
	[5] = {value = 0.25, percent = true},
}
PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("juggernaut_quality_rounds") then return end
    if HORDE:IsBallisticDamage(dmginfo) then 
	bonus.increase = bonus.increase + 0.2					
    end
end

PERK.Hooks.Horde_OnEnemyDebuffApply = function (npc, debuff, bonus, inflictor)
    if debuff == HORDE.Status_Stun and inflictor:Horde_GetPerk("juggernaut_quality_rounds") then
        bonus.increase = bonus.increase + 0.2
    end
end
