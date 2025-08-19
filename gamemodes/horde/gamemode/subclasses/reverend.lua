SUBCLASS.PrintName = "Reverend" -- Required
SUBCLASS.UnlockCost = 100 -- How many skull tokens are required to unlock this class
SUBCLASS.ParentClass = HORDE.Class_Assault -- Required for any new classes
SUBCLASS.Icon = "subclasses/reverend.png" -- Required, Subclass Icon
SUBCLASS.Description = [[
Reverend subclass.
Specializes in support and high DPS.]] -- Required
SUBCLASS.BasePerk = "reverend_base"
SUBCLASS.Perks = {
    [1] = { title = "Neophyte", choices = { "reverend_iron_faith", "reverend_enforcer" } },
    [2] = { title = "Deacon", choices = { "reverend_lazarus_gift", "reverend_precise_strike" } },
    [3] = { title = "Bishop", choices = { "reverend_sin_crusher", "reverend_executor" } },
    [4] = { title = "Cardinal", choices = { "reverend_apostolic_guiding", "reverend_taboo_breaker" } },
} -- Required