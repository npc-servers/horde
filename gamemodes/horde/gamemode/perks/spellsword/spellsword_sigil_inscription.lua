PERK.PrintName = "Sigil Inscription"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
increase Slashing damage by 25%.
+3 damage block.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "spellsword_sigil_inscription" ) then return end
    if not dmginfo:IsDamageType( DMG_SLASH ) then return end

    bonus.increase = bonus.increase + 0.25
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "spellsword_sigil_inscription" ) then return end

    bonus.block = bonus.block + 3
end