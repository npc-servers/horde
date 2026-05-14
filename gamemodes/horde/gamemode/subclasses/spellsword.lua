SUBCLASS.PrintName = "Spellsword" -- Required
SUBCLASS.UnlockCost = 0
SUBCLASS.ParentClass = HORDE.Class_Berserker -- Required for any new classes
SUBCLASS.Icon = "subclasses/warlock.png" -- Required
SUBCLASS.Description = [[
Berserker subclass.
A slow caster that uses destructive spells.]] -- Required
SUBCLASS.BasePerk = "spellsword_base"
SUBCLASS.Perks = {
    [1] = {title = "Transfigure", choices = {"spellsword_l1p", "spellsword_r1p"}},
    [2] = {title = "Channelling", choices = {"spellsword_l2p", "spellsword_r2p"}},
    [3] = {title = "Vectorize", choices = {"spellsword_l3p", "spellsword_r3p"}},
    [4] = {title = "Annihilation", choices = {"spellsword_l4p", "spellsword_r4p"}},
} -- Required