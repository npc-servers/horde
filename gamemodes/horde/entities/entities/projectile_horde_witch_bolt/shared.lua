AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Witch Bolt"
ENT.Author = "Alex9914"
ENT.Spawnable = false

ENT.Model = "models/Gibs/HGIBS.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PLAYER_MOVEMENT

-- Cache for perf
local CurTime = CurTime

function ENT:Initialize()
    self:SetModel( self.Model )

    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )

    self:SetCollisionGroup( self.CollisionGroup )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then
        phys:Wake()
    end

    self.SpawnTime = CurTime()
end

function ENT:PhysicsCollide(data, phys)
    if self.Exploded then return end
    self.Exploded = true

    local pos = self:GetPos()

    local effect = EffectData()
        effect:SetOrigin( pos )
    util.Effect( "Explosion", effect, true, true )

    if IsValid( data.HitEntity ) and HORDE:IsEnemy( data.HitEntity ) then
        data.HitEntity:Horde_AddDebuffBuildup( HORDE.Status_Break, 10, ply )
    end

    util.BlastDamage( self, self:GetOwner() or self, pos, 50, 75 )
    self:Remove()
end

function ENT:Think()
    if CurTime() - self.SpawnTime > 15 then
        self:Remove()
    end
end