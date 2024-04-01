PERK.PrintName = "Overclock"
PERK.Description = "Recover {1} armor per adrenaline stack for each enemy you killed"
PERK.Icon = "materials/perks/overclock.png"
PERK.Params = {
    [1] = {value = 0.01, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("assault_overclock")  then return end
    killer:SetArmor(math.min (killer:GetMaxArmor(), killer:Armor() + killer:Horde_GetAdrenalineStack()))
    --HORDE:SetArmor(math.min(ent:GetMaxArmor(), ent:Armor() + 1))
end


