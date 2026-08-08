SUBCLASS.PrintName = "Paladin"
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Warden
SUBCLASS.Icon = "subclasses/paladin.png"
SUBCLASS.Description = [[
Warden Subclass. Tanky melee support.
Debuff enemies with Shock and burn them or
heal allies, provide protection and armor.]]
SUBCLASS.BasePerk = "paladin_base"
SUBCLASS.Perks = {
    [1] = { title = "Enlightment", choices = { "paladin_shield_bash", "paladin_smite" } },
    [2] = { title = "Pledge", choices = { "paladin_oath_of_a_shield", "paladin_oath_of_a_sword" } },
    [3] = { title = "Valour", choices = { "paladin_providence", "paladin_excalibur" } },
    [4] = { title = "Beacon of Hope", choices = { "paladin_burning_passion", "paladin_judgement" } },
}