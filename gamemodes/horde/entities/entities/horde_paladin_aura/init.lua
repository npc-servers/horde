AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

ENT.CleanupPriority = 2
ENT.Spawnable = false

ENT.Entities = {}

function ENT:Initialize()
    local vecRadius = Vector( self.Radius, self.Radius, self.Radius )
    self:SetCollisionBounds( -vecRadius, vecRadius )
    self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
    self:SetMoveType( MOVETYPE_VPHYSICS )

    self:SetTrigger( true )
    self:UseTriggerBounds( true, 4 )

    self:SetParent( self:GetOwner() )

    self:SetNoDraw( true )
    self:PhysWake()

    self.CachedOwner = self:GetOwner()
    self.Entities[self.CachedOwner] = CurTime()
end

function ENT:StartTouch( ent )
    if self.Removing then return end

    self.Entities[ent] = CurTime()

    if ent:IsPlayer() then
        ent:Horde_AddPaladinAuraEffects( self:GetOwner() )
    end
end

function ENT:EndTouch( ent )
    if self.Removing then return end

    self.Entities[ent] = nil

    if ent:IsPlayer() then
        ent:Horde_RemovePaladinAuraEffects( self:GetOwner() )
    end
end

function ENT:Horde_SetAuraRadius( radius )
    self.Radius = radius
    self:SetCircleRadius( radius + 36 ) -- +36 so it visually seems right
end

function ENT:Horde_GetAuraRadius()
    return self.Radius
end

function ENT:OnRemove()
    self.Removing = true
    if not self.Entities then return end

    for ent, _ in pairs( self.Entities ) do
        if ent:IsPlayer() then
            ent:Horde_RemovePaladinAuraEffects()
        end
    end
end