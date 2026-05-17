SUBCLASS.PrintName = "Spellsword" -- Required
SUBCLASS.UnlockCost = 0
SUBCLASS.ParentClass = HORDE.Class_Berserker -- Required for any new classes
SUBCLASS.Icon = "subclasses/warlock.png" -- Required
SUBCLASS.Description = [[
Berserker subclass.
A slow caster that uses destructive spells.]] -- Required
SUBCLASS.BasePerk = "spellsword_base"
SUBCLASS.Perks = {
    [1] = { title = "Research", choices = { "spellsword_sorcery", "spellsword_warfare" } },
    [2] = { title = "Strategy", choices = { "spellsword_sigil_inscription", "spellsword_runic_inscription" } },
    [3] = { title = "Scholarship", choices = { "spellsword_arcane_recovery", "spellsword_arcane_deflection" } },
    [4] = { title = "Enlightenment", choices = { "spellsword_mystic_arcanum", "spellsword_combat_mastery" } },
} -- Required