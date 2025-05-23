PERK.PrintName = "Kinetic Armor"
PERK.Description = [[Generate a shield that absorbs {1} damage every {2} seconds.
While you are shielded, reflect {3} of incoming damage back to the attacker.]]
PERK.Icon = "materials/perks/reactive_armor.png"
PERK.Params = {
    [1] = { value = 100 },
    [2] = { value = 5 },
    [3] = { value = 1, percent = true },
}

PERK.Hooks = {}