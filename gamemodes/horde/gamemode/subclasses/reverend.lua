SUBCLASS.PrintName = "Reverend" -- Required
SUBCLASS.UnlockCost = 100 -- How many skull tokens are required to unlock this class
SUBCLASS.ParentClass = HORDE.Class_Assault -- Required for any new classes
SUBCLASS.Icon = "subclasses/reverend.png" -- Required, Subclass Icon
SUBCLASS.Description = [[
Reverend subclass.
Specializes in support and high DPS.]] -- Required
SUBCLASS.BasePerk = "reverend_base"
SUBCLASS.Perks = {
    [1] = {title = "Neophyte", choices = {"iron_faith", "enforcer"}},
    [2] = {title = "Deacon", choices = {"lazarus_gift", "precise_strike"}},
    [3] = {title = "Bishop", choices = {"sin_crusher", "executor"}},
    [4] = {title = "Cardinal", choices = {"apostolic_guiding", "taboo_breaker"}},
} -- Required