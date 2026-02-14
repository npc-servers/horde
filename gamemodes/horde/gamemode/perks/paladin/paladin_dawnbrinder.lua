PERK.PrintName = "Dawnbrinder"
PERK.Icon = "materials/perks/paladin/dawnbrinder.png"
PERK.Description = [[
Reduce Smite's cooldown by 50%
Increase Smite's damage by 100%
Sacred Aura deals Lightning damage per second to every enemy inside it.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "paladin_dawnbrinder" then return end
    if not ply:Horde_GetPerk( "paladin_smite" ) then return end

    ply:Horde_SetPerkCooldown( 5 )
end

-- Aura lightning damage is handled in horde_paladin_aura/init