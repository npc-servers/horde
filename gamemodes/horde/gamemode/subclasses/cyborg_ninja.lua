SUBCLASS.PrintName = "Cyborg Ninja" -- Required
SUBCLASS.UnlockCost = 100 -- How many skull tokens are required to unlock this class
SUBCLASS.ParentClass = HORDE.Class_Berserker -- Required for any new classes
SUBCLASS.Icon = "subclasses/cyborg_ninja.png" -- Required, Subclass Icon
SUBCLASS.Description = [[
Berserker subclass.
Deals huge damage in Blade Mode.]] -- Required
SUBCLASS.BasePerk = "totikfr_base"
SUBCLASS.Perks = {
    [1] = {title = "Enhancements", choices = {"totikfr_12", "totikfr_11"}},
    [2] = {title = "Technique", choices = {"totikfr_21", "totikfr_22"}},
    [3] = {title = "Technology", choices = {"totikfr_31", "totikfr_32"}},
    [4] = {title = "Combat Arts", choices = {"totikfr_42", "totikfr_41"}},
} -- Required