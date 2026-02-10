PERK.PrintName = "Shield Bash"
PERK.Icon = "materials/perks/paladin/shield_bash.png"
PERK.Description = [[
While shielding, reduce debuff buildups by 50%.
Press Shift + E to strike an enemy with your shield, dealing 200 Blunt damage, stunning him and pushing away from you.
Cooldown: 10 seconds.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_shield_bash" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_shield_bash" then return end
end