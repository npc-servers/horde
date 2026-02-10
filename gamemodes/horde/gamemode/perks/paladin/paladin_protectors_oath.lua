PERK.PrintName = "Protector's Oath"
PERK.Icon = "materials/perks/paladin/protectors_oath.png"
PERK.Description = [[
Losing a stack of Faith makes you heal all allies inside your Sacred Aura for 2% health.
Divine Shield provides additional 3% to all elemental resistances per Faith stack.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_protectors_oath" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_protectors_oath" then return end
end