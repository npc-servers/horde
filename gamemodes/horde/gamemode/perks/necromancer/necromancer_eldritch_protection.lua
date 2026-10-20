PERK.PrintName = "Eldritch Protection"
PERK.Description =
[[{1} increased mind regeneration per active summon.
Summons return {2} of their Mind Cost to you upon death.
You take {3} reduced damage, this is doubled if your attacker has Frostbite.]]
PERK.Icon = "materials/perks/necromancer/eldritch_protection.png"

PERK.Params = {
    [1] = { value = 0.2, percent = true },
    [2] = { value = 0.5, percent = true },
    [3] = { value = 0.15, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_MindRegeneration = function(ply, bonus)
    if ply:Horde_GetPerk("necromancer_eldritch_protection") then
        bonus.increase = bonus.increase + 0.2 * ply:Horde_GetSpectreCount(isUlt)
    end
end

PERK.Hooks.Horde_OnRaiseSpectre = function(ply, properties)
    if ply:Horde_GetPerk("necromancer_eldritch_protection") then
        properties.eldritch_protection = true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("necromancer_eldritch_protection") then return end

    local attacker = dmginfo:GetAttacker()

    if attacker:IsValid() and attacker:Horde_HasDebuff(HORDE.Status_Frostbite) then
        bonus.less = bonus.less * 0.7
    else
        bonus.less = bonus.less * 0.85
    end
end
