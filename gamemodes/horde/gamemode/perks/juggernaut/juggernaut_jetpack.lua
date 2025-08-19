PERK.PrintName = "Jetpack"
PERK.Description = [[
Press Shift + E to boost yourself forwards into the air.
Gain immunity to fall damage. {2} second cooldown.]]
PERK.Icon = "materials/perks/specops/smokescreen.png"
PERK.Params = {
    [1] = { value = 0.9, percent = true },
    [2] = { value = 10 },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "juggernaut_jetpack" then return end

    ply:Horde_SetPerkCooldown( 10 )

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Smokescreen, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "juggernaut_jetpack" then return end

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Smokescreen, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "juggernaut_jetpack" ) then return end

    local effectdata = EffectData()
    effectdata:SetOrigin( ply:GetPos() )
    util.Effect( "m2_flame_explosion", effectdata )

    sound.Play( "horde/juggernaut/jetpack.wav", ply:GetPos() )

    local dir = 0.6 * ply:GetForward() + 0.4 * vector_up
    dir:Normalize()
    local vel = dir * 650
    ply:SetLocalVelocity( vel )
end

PERK.Hooks.Horde_GetFallDamage = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "juggernaut_jetpack" ) then return end

    bonus.less = bonus.less * 0
end