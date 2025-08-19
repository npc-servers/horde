SUBCLASS.PrintName = "Cyborg Ninja" -- Required
SUBCLASS.UnlockCost = 100 -- How many skull tokens are required to unlock this class
SUBCLASS.ParentClass = HORDE.Class_Berserker -- Required for any new classes
SUBCLASS.Icon = "subclasses/cyborg_ninja.png" -- Required, Subclass Icon
SUBCLASS.Description = [[
Berserker subclass.
Deals huge damage in Blade Mode.]] -- Required
SUBCLASS.BasePerk = "cyborg_ninja_base"
SUBCLASS.Perks = {
    [1] = { title = "Enhancements", choices = { "cyborg_ninja_exoskeleton", "cyborg_ninja_cybernetic_arm" } },
    [2] = { title = "Technique", choices = { "cyborg_ninja_static_discharge", "cyborg_ninja_parry" } },
    [3] = { title = "Technology", choices = { "cyborg_ninja_sharper_blade", "cyborg_ninja_pain_inhibitors" } },
    [4] = { title = "Combat Arts", choices = { "cyborg_ninja_ripper_mode", "cyborg_ninja_rifle_mechanism" } },
} -- Required