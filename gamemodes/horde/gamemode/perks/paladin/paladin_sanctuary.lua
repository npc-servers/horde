PERK.PrintName = "Sanctuary"
PERK.Icon = "materials/perks/paladin/sanctuary.png"
PERK.Description = [[
Immune to Necrosis
When you're using Divine Shield, every player inside your Sacred Aura cannot take more damage than 50% of their health in one instance. ]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_sanctuary" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_sanctuary" then return end
end