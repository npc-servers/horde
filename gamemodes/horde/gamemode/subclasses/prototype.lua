SUBCLASS.PrintName = "Prototype"
SUBCLASS.Icon = "materials/subclasses/prototype.png"
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Survivor
SUBCLASS.Description = [[
Survivor subclass.
Close-range fighter with unique abilities.]]

SUBCLASS.BasePerk = "prototype_base"
SUBCLASS.Perks = {
    [ 1 ] = { title = "Hemorrhage", choices = { "prototype_gluttonous_maw", "prototype_hemo_siphon" } },
    [ 2 ] = { title = "Momentum", choices = { "prototype_overdrive", "prototype_countermeasures" } },
    [ 3 ] = { title = "Defiance", choices = { "prototype_knuckleblaster", "prototype_feedbacker" } },
    [ 4 ] = { title = "Pestilence", choices = { "prototype_rupture", "prototype_ascendent" } },
}
