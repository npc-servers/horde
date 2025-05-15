SUBCLASS.PrintName = "Vanguard" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Warden -- Required for any new classes
SUBCLASS.Icon = "subclasses/vanguard.png" -- Required
SUBCLASS.Description = [[
Warden subclass.
Combatant capable of controlling individual threats.]] -- Required
SUBCLASS.BasePerk = "vanguard_base"
SUBCLASS.Perks = {
    [1] = {title = "Ability", choices = {"vanguard_charge", "vanguard_stasis"}},
    [2] = {title = "Steadfast", choices = {"vanguard_kinetic", "vanguard_surge"}},
    [3] = {title = "Control", choices = {"vanguard_enhancement", "vanguard_singularity"}},
    [4] = {title = "Mass Effect", choices = {"vanguard_epinephrine", "vanguard_mastery"}},
} -- Required