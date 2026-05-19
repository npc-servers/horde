PERK.PrintName = "Runic Inscription"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
Increase Blunt damage by 25%.
Increase Global damage resistance by 20%.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "spellsword_runic_inscription" ) then return end
    if not dmginfo:IsDamageType( DMG_CLUB ) then return end

    bonus.increase = bonus.increase + 0.25
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "spellsword_runic_inscription" ) then return end

    bonus.resistance = bonus.resistance + 0.2
end