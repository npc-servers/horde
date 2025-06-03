SUBCLASS.PrintName = "Cyborg Ninja" -- Required
SUBCLASS.UnlockCost = 100 -- How many skull tokens are required to unlock this class
SUBCLASS.ParentClass = HORDE.Class_Berserker -- Required for any new classes
SUBCLASS.Icon = "subclasses/cyborg_ninja.png" -- Required, Subclass Icon
SUBCLASS.Description = [[
Berserker subclass.
Deals huge damage in Blade Mode.]] -- Required
SUBCLASS.BasePerk = "cyborg_base"
SUBCLASS.Perks = {
    [1] = {title = "Enhancements", choices = {"cyborg_11", "cyborg_12"}},
    [2] = {title = "Technique", choices = {"cyborg_21", "cyborg_22"}},
    [3] = {title = "Technology", choices = {"cyborg_31", "cyborg_32"}},
    [4] = {title = "Combat Arts", choices = {"cyborg_41", "cyborg_42"}},
} -- Required