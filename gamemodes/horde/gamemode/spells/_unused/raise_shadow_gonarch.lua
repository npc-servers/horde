SPELL.PrintName       = "Raise Gonarch Spectre"
SPELL.Weapon          = {"horde_void_projector"}
SPELL.Mind            = {100}
SPELL.ChargeTime      = {3}
SPELL.ChargeRelease   = true
SPELL.Cooldown        = 20
SPELL.Slot            = HORDE.Spell_Slot_Reload
SPELL.DamageType      = {HORDE.DMG_PHYSICAL, HORDE.DMG_COLD}
SPELL.Type            = {HORDE.Spell_Type_Minion}
SPELL.Icon            = "spells/raise_shadow_hulk.png"
SPELL.Description    = [[Raises a Gonarch Spectre created using dark matter. Gonarch Spectre has high health and melee damage, and also has access to a ranged attack that deals Cold damage. You can create at most 1 Gonarch Spectre.]]
SPELL.Fire            = function (ply, wpn, charge_stage)
    return HORDE:RaiseCustomSpectre(ply, {gonarch_spectre=true})
end
SPELL.Price                      = 2500
SPELL.Upgrades                   = 3
SPELL.Upgrade_Description        = "Increases minion health and melee damage."
SPELL.Upgrade_Prices             = function (upgrade_level)
    return 1250 + 250 * upgrade_level
end