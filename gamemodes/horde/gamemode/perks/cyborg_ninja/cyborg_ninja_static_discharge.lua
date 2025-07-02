PERK.PrintName = "Static Discharge"
PERK.Description = "Receiving damage from enemies releases a pulse that deals {1} Electric damage."
PERK.Icon = "materials/perks/artificer/purge.png"
PERK.Params = {
    [1] = { value = 150 },
    [2] = { value = 5, percent = true },
}

PERK.Hooks = {}

PERK.Hooks.PlayerHurt = function( victim, attacker )
    if not victim:Horde_GetPerk( "cyborg_ninja_static_discharge" ) then return end
    if not not victim:Alive() then return end
    if victim.DischargeActive then return end
    if not attacker:IsValid() or not attacker:IsNPC() then return end

    local dmg = DamageInfo()
    dmg:SetAttacker( victim )
    dmg:SetInflictor( victim )
    dmg:SetDamageType( DMG_SHOCK )
    dmg:SetDamage( 150 )

    local e = EffectData()
    e:SetOrigin( victim:GetPos() )
    util.Effect( "explosion_shock", e, true, true )

    victim.DischargeActive = true
    util.BlastDamageInfo( dmg, victim:GetPos(), 160 )
    victim.DischargeActive = nil
end