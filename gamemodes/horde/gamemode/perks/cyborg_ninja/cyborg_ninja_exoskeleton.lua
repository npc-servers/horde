PERK.PrintName = "Exoskeleton"
PERK.Description = [[{1} increased max health and max armor.
Regenerate {2} health per second.
Gain immunity to poison damage and break.]]
PERK.Icon = "materials/perks/unwavering_guard.png"
PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.02, percent = true },
    [3] = { value = 1 },
    [4] = { value = 25 },
    [5] = { value = 0.25, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_exoskeleton" then
        ply:Horde_SetHealthRegenPercentage( 0.02 )
        ply:Horde_SetImmuneToDebuff( HORDE.Status_Break, true )
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_exoskeleton" then
        ply:Horde_SetHealthRegenPercentage( 0 )
        ply:Horde_SetImmuneToDebuff( HORDE.Status_Break, false )
    end
end

PERK.Hooks.Horde_OnSetMaxHealth = function( ply, bonus )
    if SERVER and ply:Horde_GetPerk( "cyborg_ninja_exoskeleton" ) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnSetMaxArmor = function( ply, bonus )
    if SERVER and ply:Horde_GetPerk( "cyborg_ninja_exoskeleton" ) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if ply:Horde_GetPerk( "cyborg_ninja_exoskeleton" ) and HORDE:IsPoisonDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 1.0
    end
end