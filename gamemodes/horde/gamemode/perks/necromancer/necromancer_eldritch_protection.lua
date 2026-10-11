PERK.PrintName = "Eldritch Protection"
PERK.Description =
[[Summons return {1} their Mind Cost to you upon death.
The Mind you regain increases by {2} per upgrade level.
You take {3} reduced damage, this is doubled if your attacker has Frostbite.]]
PERK.Icon = "materials/perks/necromancer/eldritch_protection.png"

PERK.Params = {
    [1] = { value = 0.5, percent = true },
    [2] = { value = 5 },
    [3] = { value = 0.15, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnRaiseSpectre = function(ply, properties)
    if ply:Horde_GetPerk("necromancer_eldritch_protection") then
        properties.eldritch_protection = true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_eldritch_protection") then return end

    local attacker = dmginfo:GetAttacker()
    if not attacker:IsValid() then return end

    bonus.less = bonus.less * (attacker:Horde_HasDebuff(HORDE.Status_Frostbite) and 0.30 or 0.15)
end
