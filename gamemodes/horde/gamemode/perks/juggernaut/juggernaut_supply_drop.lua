PERK.PrintName = "Supply Drop"
PERK.Description = [[
Press Shift + E to spawn a super ammo box.
Super ammo boxes will give you ammo for all of your weapons,
along with refilling your entire clip instantly. {2} second cooldown.]]
PERK.Icon = "materials/perks/specops/flare.png"
PERK.Params = {
    [1] = { value = 3, percent = true },
    [2] = { value = 20 },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "juggernaut_supply_drop" then return end

    ply:Horde_SetPerkCooldown( 20 )

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Flare, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "juggernaut_supply_drop" then return end

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_Flare, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "juggernaut_supply_drop" ) then return end

    sound.Play( "horde/juggernaut/supply.wav", ply:GetPos() )

    local pos = ply:GetPos()
    local dir = ply:GetEyeTrace().HitPos - pos
    dir:Normalize()
    local dropPos = pos + dir * 100
    dropPos.z = pos.z + 15

    local ent = ents.Create( "horde_super_ammo_box" )
    ent:SetPos( dropPos )
    ent:SetAngles( Angle( 0, ply:GetAngles().y, 0 ) )
    ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
    ent:Spawn()
end