PERK.PrintName = "Providence"
PERK.Icon = "materials/perks/paladin/providence.png"
PERK.Description = [[
Your Divine Shield also protects everyone inside your Sacred Aura in the same way as you.
Additionally if enemies hit allies protected by your Divine Shield, they take Blunt damage.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_providence" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_providence" then return end
end