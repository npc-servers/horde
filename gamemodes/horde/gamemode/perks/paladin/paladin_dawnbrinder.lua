PERK.PrintName = "Dawnbrinder"
PERK.Icon = "materials/perks/paladin/dawnbrinder.png"
PERK.Description = [[
Reduce Smite's cooldown by 50%
Increase Smite's damage by 100%
Sacred Aura deals Lightning damage per second to every enemy inside it.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_dawnbrinder" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_dawnbrinder" then return end
end