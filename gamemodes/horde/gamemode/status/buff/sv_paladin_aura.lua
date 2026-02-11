local entmeta = FindMetaTable( "Entity" )
local plymeta = FindMetaTable( "Player" )

function entmeta:Horde_AddPaladinAura()
    self:Horde_RemovePaladinAura()

    local ent = ents.Create( "horde_paladin_aura" )
    ent:SetPos( self:GetPos() )
    ent:SetParent( self )

    ent:Horde_SetPresenceRadius( self:Horde_GetPaladinAuraRadius() * self:Horde_GetPerkLevelBonus( "paladin_base" ) )

    ent:Spawn()
    self.Horde_PaladinAura = ent
end

function entmeta:Horde_RemovePaladinAura()
    if not self:IsValid() then return end
    if not IsValid( self.Horde_PaladinAura ) then return end
    self.Horde_PaladinAura:Remove()
    self.Horde_PaladinAura = nil

    if not self:IsPlayer() then return end
    timer.Simple( 0, function()
        self:Horde_RemovePaladinAuraEffects()
    end )
end

function plymeta:Horde_SetPaladinAuraRadius( radius )
    self.Horde_PaladinAuraRadius = radius
end

function plymeta:Horde_GetPaladinAuraRadius()
    return self.Horde_PaladinAuraRadius or 160
end

function plymeta:Horde_AddPaladinAuraEffects( provider )
    if not provider or not provider:IsValid() then return end
    self.Horde_PaladinAuraProvider = provider

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinAura, 8 )
        net.WriteUInt( 1, 8 )
    net.Send( self )
end

function plymeta:Horde_RemovePaladinAuraEffects()
    self.Horde_PaladinAuraProvider = nil

    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinAura, 8 )
        net.WriteUInt( 1, 8 )
    net.Send( self )
end

hook.Add( "PlayerTick", "Horde_PaladinAura_Buff_CurTime", function( ply )
    if not ply:Alive() then return end
end )

hook.Add( "Horde_ResetStatus", "Horde_PaladinAuraEffectsReset", function( ply )
    ply:Horde_RemovePaladinAuraEffects()
end )

hook.Add( "DoPlayerDeath", "Horde_PaladinAura", function( victim )
    victim:Horde_RemovePaladinAura()
end )

-- Armor on heal
hook.Add( "Horde_PostOnPlayerHeal", "Horde_PaladinAura", function( ply, healinfo )
    local healer = healinfo.healer
    if not IsValid( healer ) then return end
    if not healer:Horde_GetPerk( "paladin_base" ) then return end

    -- Check if inside aura and if aura is owned by healer
    local paladinAuraProvider = ply.Horde_PaladinAuraProvider
    if not IsValid( paladinAuraProvider ) or paladinAuraProvider ~= healer then return end

    -- Give 50% of healing as armor
    if ply:Armor() == ply:GetMaxArmor() then return end
    ply:SetArmor( math.Min( ply:GetMaxArmor(), ply:Armor() + healinfo.amount / 2 ) )
end )