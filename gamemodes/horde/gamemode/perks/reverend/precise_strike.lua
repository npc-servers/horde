PERK.PrintName = "Precise Strike"
PERK.Description = "Increases Ballistic damage based on distance, \nincreasing by {1} damage for each {2} units. Increase caps at {3}. \nBallistic damage headshots build up Stun."
PERK.Icon = "materials/perks/reverend/precise_strike.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 100},
    [3] = {value = 0.25, percent = true},
	[4] = {value = 3},
	[5] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("precise_strike") then return end
    local dmgtype = dmginfo:GetDamageType()
    if HORDE:IsBallisticDamage(dmginfo) then
        local hitPos = dmginfo:GetDamagePosition()
        local selfPos = ply:GetPos()
        local sqrDist = hitPos:DistToSqr(selfPos)
		if hitgroup == HITGROUP_HEAD then
			npc:Horde_AddDebuffBuildup(HORDE.Status_Stun, dmginfo:GetDamage() / 3, ply, dmginfo:GetDamagePosition())
		end
        if sqrDist < 10000 then
            return
        elseif sqrDist < 40000 then
            bonus.increase = bonus.increase + 0.05
        elseif sqrDist < 90000 then
            bonus.increase = bonus.increase + 0.10
        elseif sqrDist < 160000 then
            bonus.increase = bonus.increase + 0.15
        elseif sqrDist < 250000 then
            bonus.increase = bonus.increase + 0.20
        else
            bonus.increase = bonus.increase + 0.25
        end
    end
end