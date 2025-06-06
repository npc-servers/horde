PERK.PrintName = "Juggernaut Base"
PERK.Description = [[

The Juggernaut is a sub-class of the Heavy that focuses on improving its guns and being tankier than Heavy in exchange for being slower.
Complexity: EASY

{6} reduced walking and running speed.

{5} of Ballistic damage is converted into Stun. ({7} base, {8} per level, up to {9})
{1} additional max health. ({2} base, {3} per level, up to {4})

]]

--40% less walking and running speed.
--{1} increased Global damage resistance.
--{2} decreased walking and running speed.

PERK.Params = {
    [1] = {base = 25, level = 1, max = 50, classname = "Juggernaut"},
	[2] = {value = 25},
	[3] = {value = 1},
	[4] = {value = 50},
	[5] = {percent = true, base = 0.2, level = 0.008, max = 0.4, classname = "Juggernaut"},
	[6] = {value = 0.4, percent = true},
	[7] = {value = 0.2, percent = true},
	[8] = {value = 0.008, percent = true},
	[9] = {value = 0.4, percent = true},
}

PERK.Icon = "materials/subclasses/juggernaut.png"
	
PERK.Hooks = {}


-- This is a required function if you are planning to use bonuses based on levels.
PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("juggernaut_base", math.min(0.25, 0.01 * ply:Horde_GetLevel("Juggernaut")))
    end
end

PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("juggernaut_base") and HORDE:IsBallisticDamage(dmginfo) then
        ent:Horde_AddDebuffBuildup(HORDE.Status_Stun, dmginfo:GetDamage() / (5 - (attacker:Horde_GetPerkLevelBonus("juggernaut_base") * 0.1)), attacker, ent:GetPos())
    end
end

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("juggernaut_base") then
        bonus.increase = bonus.increase + (0.25 + ply:Horde_GetPerkLevelBonus("juggernaut_base") )
    end
end


PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("juggernaut_base") then return end
	local j = ply:Horde_GetPerkLevelBonus("juggernaut_base")
    bonus_walk.increase = bonus_walk.increase + (-0.4)
    bonus_run.increase = bonus_run.increase + (-0.4)
end

