SPELL.PrintName       = "Raise Weeper Spectre"
SPELL.Weapon          = { "horde_void_projector" }
SPELL.Mind            = { 75 }
SPELL.ChargeTime      = { 3 }
SPELL.ChargeRelease   = nil
SPELL.Cooldown        = 10
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = { HORDE.DMG_PHYSICAL, HORDE.DMG_COLD }
SPELL.Type            = { HORDE.Spell_Type_Minion }
SPELL.Icon            = "spells/raise_shadow_hulk.png"
SPELL.Description     = [[Raises a Weeper Spectre created using dark matter. Weeper Spectre will attack nearby enemies with a frost nova, inflicting Cold damage and inflicting Frostbite. You can create at most 1 Weeper Spectre.]]
SPELL.Fire            = function( ply )
    return HORDE:RaiseSpectre( ply, {
        weeper_spectre = true
    } )
end
SPELL.Price                 = 2000
SPELL.Upgrades              = 3
SPELL.Upgrade_Description   = "Increases minion health and frost nova / melee damage."
SPELL.Upgrade_Prices        = function( upgrade_level )
    return 1000 + 100 * upgrade_level
end