PERK.PrintName = "Engineer Base"
PERK.Description = [[
The Engineer class is a minion-centered class that deals damage through minions.
Complexity: MEDIUM

{1} increased minion damage. ({2} per level, up to {3}).

Turrets have {4} base health and deals {5} base damage.]]
PERK.Params = {
    [1] = {percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Engineer},
    [2] = {value = 0.008, percent = true},
    [3] = {value = 0.20, percent = true},
    [4] = {value = 400},
    [5] = {value = 15},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerMinionDamage = function (ply, npc, bonus, dmginfo)
    if ply:Horde_GetPerk("engineer_base") then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("engineer_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("engineer_base", math.min(0.20, 0.008 * ply:Horde_GetLevel(HORDE.Class_Engineer)))
    end
end