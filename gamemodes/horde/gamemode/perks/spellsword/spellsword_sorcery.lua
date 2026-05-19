PERK.PrintName = "Sorcery"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
Increase maximum mind by 50.
Increase mind regen by 1.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxMind = function( ply, bonus )
    if not ply:Horde_GetPerk( "spellsword_sorcery" ) then return end

    bonus.add = bonus.add + 50
end

PERK.Hooks.Horde_MindRegeneration = function( ply, bonus )
    if not ply:Horde_GetPerk( "spellsword_sorcery" ) then return end

    bonus.increase = bonus.increase + 1
end