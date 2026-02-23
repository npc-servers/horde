AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end

    return
end

ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel( "models/items/battery.mdl" )
    self:SetModelScale( 1.5, 0 )

    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

    self:SetTrigger( true )
    self:UseTriggerBounds( true, 4 )

    self:PhysWake()
end

function ENT:StartTouch( ent )
    if self.Removing then return end
    if not ent:IsPlayer() then return end
end