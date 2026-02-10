PERK.PrintName = "Rallying Presence"
PERK.Icon = "materials/perks/paladin/rallying_presence.png"
PERK.Description = [[
All players inside Sacred Aura deal 25% more damage when their health is full.
All players inside Sacred Aura regenerate 2% health if their health is lower than full.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_rallying_presence" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_rallying_presence" then return end
end