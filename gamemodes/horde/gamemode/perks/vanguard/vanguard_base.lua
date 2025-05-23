PERK.PrintName = "Vanguard Base"
PERK.Description = [[
Warden subclass.
A powerful combatant capable of controlling individual threats using biotic powers.
Complexity: MEDIUM

{1} increased Shotgun damage. ({2} per level, up to {3}).
Allows you to use Biotic abilites.
Biotic abilities have a cooldown of {4} seconds.
]]
PERK.Icon = "materials/subclasses/vanguard.png"

PERK.Params = {
    [1] = { percent = true, level = 0.008, max = 0.20, classname = "Vanguard" },
    [2] = { value = 0.008, percent = true },
    [3] = { value = 0.20, percent = true },
    [4] = { value = 8 },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("vanguard_base") then return end
    if HORDE:IsCurrentWeapon(dmginfo, "Shotgun") == true then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("vanguard_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("vanguard_base", math.min(0.20, 0.008 * ply:Horde_GetLevel("Vanguard")))
    end
end