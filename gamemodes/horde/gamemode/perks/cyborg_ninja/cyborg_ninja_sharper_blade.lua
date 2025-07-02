PERK.PrintName = "Sharper Blade"
PERK.Description = "+{1} Blade Mode damage increase. \nLeech a flat {4} armor on hit while not in Blade Mode or Ripper Mode."
PERK.Icon = "materials/perks/samurai/demon_strike.png"
PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.3, percent = true },
    [3] = { value = 5 },
    [4] = { value = 1 },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, _, _, _, dmginfo )
    if not ply:Horde_GetPerk( "cyborg_ninja_sharper_blade" ) then return end
    if ply.Horde_In_Frenzy_Mode then return end
    if ply.Horde_Ripper_Mode then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end

    ply:SetArmor( math.min( ply:GetMaxArmor(), ply:Armor() + 1 ) )
end