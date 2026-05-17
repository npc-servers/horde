PERK.PrintName = "Warfare"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
increase Slashing and Blunt damage by 10%.
increase Global damage resistance by 10%.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "spellsword_warfare" ) then return end
    if not dmginfo:IsDamageType( DMG_SLASH + DMG_CLUB ) then return end

    bonus.increase = bonus.increase + 0.1
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "spellsword_warfare" ) then return end

    bonus.resistance = bonus.resistance + 0.10
end