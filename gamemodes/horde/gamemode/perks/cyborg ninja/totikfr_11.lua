PERK.PrintName = "Exoskeleton"
PERK.Description = "{1} increased max health and max armor. \nRegenerate {2} health per second. \nGain immunity to poison damage."
PERK.Icon = "materials/perks/unwavering_guard.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.01, percent = true},
	[3] = {value = 1},
	[4] = {value = 25},
	[5] = {value = 0.25, percent = true},
}

PERK.Hooks = {}


PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_11" then
	ply:Horde_SetHealthRegenPercentage(0.01)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "totikfr_11" then
	ply:Horde_SetHealthRegenPercentage(0)
    end
end

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("totikfr_11") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSetMaxArmor = function (ply, bonus)
	if SERVER and ply:Horde_GetPerk("totikfr_11") then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("totikfr_11") then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 1.0
    end
end


PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("totikfr_11") and debuff == HORDE.Status_Break then
        bonus.apply = 0
        return true
    end
end