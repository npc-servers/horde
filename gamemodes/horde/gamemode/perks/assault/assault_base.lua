PERK.PrintName = "Assault Base"
PERK.Description = [[
The Assault class is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.
Complexity: EASY

{1} more movement speed and jump height ({2} per level, up to {3}).
{5} increased Ballistic damage. ({6} per level, up to {7}).
{8} Increased Ballistic damage resistance. ({9} + {10} per level, up to {11}).

Gain Adrenaline when you kill an enemy.
Adrenaline increases damage and speed by {4}.]]
PERK.Params = {
    [1] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Assault},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {value = 0.10, percent = true},
    [5] = {percent = true, level = 0.008, max = 0.2, classname = HORDE.Class_Assault},
    [6] = {value = 0.008, percent = true},
    [7] = {value = 0.2, percent = true},
    [8] = {percent = true, base = 0.25, level = 0.01, max = 0.5, classname = HORDE.Class_Assault},
    [9] = {value = 0.25, percent = true},
    [10] = {value = 0.01, percent = true},
    [11] = {value = 0.5, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_base" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_base" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 1)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("assault_base", 1 + math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Assault)))
        ply:Horde_SetPerkLevelBonus("assault_base2", math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Assault)))
        ply:Horde_SetPerkLevelBonus("assault_base3", math.min(0.50, 0.25 + 0.01 * ply:Horde_GetLevel(HORDE.Class_Assault)))
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run, bonus_jump)
    if not ply:Horde_GetPerk("assault_base") then return end
    bonus_walk.more = bonus_walk.more * ply:Horde_GetPerkLevelBonus("assault_base")
    bonus_run.more = bonus_run.more * ply:Horde_GetPerkLevelBonus("assault_base")
    bonus_jump.more = bonus_jump.more * ply:Horde_GetPerkLevelBonus("assault_base")
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("assault_base") then return end
    if HORDE:IsBallisticDamage(dmginfo) then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("assault_base2")
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("assault_base")  then return end
    if HORDE:IsBallisticDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("assault_base3")
    end
end
