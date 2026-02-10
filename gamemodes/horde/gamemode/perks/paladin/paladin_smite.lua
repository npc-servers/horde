PERK.PrintName = "Smite"
PERK.Icon = "materials/perks/paladin/smite.png"
PERK.Description = [[
Press Shift + E to empower your next attack.
Empowered attack deals additional 200 Lightning damage to every enemy inside your Sacred Aura, healing allies inside for 20% health and clearing all player debuffs.
Cooldown: 10 seconds.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_smite" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_smite" then return end
end