PERK.PrintName = "Cybernetic Arm"
PERK.Description = [[
Leech up to {1} health upon dealing melee damage.
Gain immunity to Bleeding.
Kills leech {2} armor while not in Blade Mode or Ripper Mode.]]
PERK.Icon = "materials/perks/berserk.png"
PERK.Params = {
    [1] = { value = hpleech, percent = true },
    [2] = { value = 4 },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_cybernetic_arm" then
        ply:Horde_SetImmuneToDebuff( HORDE.Status_Bleeding, true )
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if SERVER and perk == "cyborg_ninja_cybernetic_arm" then
        ply:Horde_SetImmuneToDebuff( HORDE.Status_Bleeding, false )
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, _, _, _, dmginfo )
    if ply:Horde_GetPerk( "cyborg_ninja_cybernetic_arm" ) and HORDE:IsMeleeDamage( dmginfo ) then
        local leech = math.min( 10, dmginfo:GetDamage() * 0.10 )
        HORDE:SelfHeal( ply, leech )
    end
end

PERK.Hooks.Horde_OnEnemyKilled = function( _, killer )
    if not killer:Horde_GetPerk( "cyborg_ninja_cybernetic_arm" ) then return end
    if killer.Horde_In_Frenzy_Mode then return end
    if killer.Horde_Ripper_Mode then return end
    killer:SetArmor( math.min( killer:GetMaxArmor(), killer:Armor() + 4 ) )
end