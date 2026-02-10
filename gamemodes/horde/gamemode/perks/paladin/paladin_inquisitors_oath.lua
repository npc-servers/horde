PERK.PrintName = "Inquisitor's Oath"
PERK.Icon = "materials/perks/paladin/inquisitors_oath.png"
PERK.Description = [[
Increase damage dealt by 3% for every Faith stack you currently have. (max. 30%)
Killing an enemy gives you 1 stack of Faith.
Melee hits leech 5% health.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_inquisitors_oath" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_inquisitors_oath" then return end
end