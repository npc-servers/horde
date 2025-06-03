AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.Removing = nil

function ENT:Horde_SetAuraRadius(radius)
    self.Horde_AuraRadius = radius or 250
    self:SetRadius( radius )
end

function ENT:Initialize()
    self:PhysicsInitSphere(250)
    self:SetCollisionBounds(Vector(-250, -250, -250), Vector(250, 250, 250))
    self:SetSolid(SOLID_NONE)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)
    self:PhysWake()
    self:SetRenderMode(RENDERMODE_ENVIROMENTAL)
    self:SetColor(Color(0, 0, 0, 0))
    self:DrawShadow(false)
end

function ENT:OnRemove()
    self.Removing = true
end