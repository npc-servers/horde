SUBCLASS.PrintName = "Paladin"
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Warden
SUBCLASS.Icon = "subclasses/paladin.png"
SUBCLASS.Description = [[
Warden Subclass.
Paladin is a tanky melee shieldbearer, using his shield and aura to protect and support his allies or use it for self defense,
banishing his enemies.]]
SUBCLASS.BasePerk = "paladin_base"
SUBCLASS.Perks = {
    [1] = { title = "Inner Strength", choices = { "paladin_shield_bash", "paladin_smite" } },
    [2] = { title = "Recuperate", choices = { "paladin_protectors_oath", "paladin_inquisitors_oath" } },
    [3] = { title = "Codex", choices = { "paladin_providence", "paladin_dawnbrinder" } },
    [4] = { title = "Ascension", choices = { "paladin_sanctuary", "paladin_rallying_presence" } },
}