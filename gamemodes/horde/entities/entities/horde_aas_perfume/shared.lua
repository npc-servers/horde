ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Fire Particle"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/Items/AR2_Grenade.mdl"

ENT.FireTime = 5

ENT.Armed = false

ENT.NextDamageTick = 0

ENT.Ticks = 0
ENT.TouchedEntities = {}

ENT.ArcCW_Killable = false

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:DrawShadow( false )
        self:SetCollisionBounds(Vector(-150,-150,-100), Vector(150,150,100))
        self:SetTrigger(true)
        self:UseTriggerBounds(true, 24)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.SpawnTime = CurTime()
        self:Detonate()

        self.FireTime = math.Rand(4.5, 5.5)
        timer.Simple(0, function()
            if not IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PLAYER_MOVEMENT)
        end)
    end
end

local fired = {
    "particle/smokesprites_0001",
    "particle/smokesprites_0002",
    "particle/smokesprites_0003",
    "particle/smokesprites_0004",
    "particle/smokesprites_0005",
}
local function GetFireParticle()
    return fired[math.random(#fired)]
end

function ENT:Think()
    if not self.SpawnTime then self.SpawnTime = CurTime() end

    if CLIENT then
        local emitter = ParticleEmitter(self:GetPos())

        if not self:IsValid() or self:WaterLevel() > 2 then return end
        if not IsValid(emitter) then return end

        for i = 1,10 do
            local fire = emitter:Add(GetFireParticle(), self:GetPos() + (VectorRand() * 30))
            fire:SetVelocity( 250 * VectorRand() )
            fire:SetGravity( Vector(0, 0, 1000) )
            fire:SetDieTime( math.Rand(0.1, 0.3) )
            fire:SetStartAlpha( 255 )
            fire:SetEndAlpha( 0 )
            fire:SetStartSize( 0 )
            fire:SetEndSize( 50 )
            fire:SetRoll( math.Rand(-180, 180) )
            fire:SetRollDelta( math.Rand(-0.2,0.2) )
            fire:SetColor(255,105,180)
            fire:SetAirResistance( 200 )
            local pos = VectorRand() * math.random(20,100)
            pos.z = 0
            fire:SetPos( self:GetPos() + pos )
            fire:SetLighting( false )
            fire:SetCollide(true)
            fire:SetBounce(0.75)
            fire:SetNextThink( CurTime() + FrameTime() )
            fire:SetThinkFunction( function(pa)
                if not pa then return end
                local col1 = Color(255,105,180, 255)
                local col2 = Color(255,255,255, 0)

                local col3 = col1
                local d = pa:GetLifeTime() / pa:GetDieTime()
                col3.r = Lerp(d, col1.r, col2.r)
                col3.g = Lerp(d, col1.g, col2.g)
                col3.b = Lerp(d, col1.b, col2.b)
                col3.a = Lerp(d, col1.a, col2.a)

                pa:SetColor(col3.r, col3.g, col3.b, col3.a)
                pa:SetNextThink( CurTime() + FrameTime() )
            end )
        end

        emitter:Finish()

        self.Ticks = self.Ticks + 1
    else

        if self.NextDamageTick > CurTime() then return end
        local ply = self:GetOwner()
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
            if ent:IsPlayer() then
                ent:Horde_AddHypertrophyStack(true)
            end
            if IsValid( ent ) and HORDE:IsEnemy( ent ) then
            ent:Horde_AddWeaken(ply, ply:Horde_GetApplyDebuffDuration(), ply:Horde_GetApplyDebuffMore())
            end
        end

        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(self)
        dmg:SetDamageType(DMG_NERVEGAS)
        dmg:SetDamage(50)
        dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
        util.BlastDamageInfo(dmg, self:GetPos(), 200)

        if self:WaterLevel() > 2 then self:Remove() return end

        self.NextDamageTick = CurTime() + 0.5

        if self.SpawnTime + self.FireTime <= CurTime() then self:Remove() return end
    end
end

function ENT:OnRemove()
    if not self.FireSound then return end
    self.FireSound:Stop()

    if SERVER then
        for _, ent in pairs(self.TouchedEntities) do
            if ent:IsValid() then ent:Horde_RemoveEffect_Perfume() end
        end
    end
end

function ENT:Detonate()
    if not self:IsValid() then return end
        timer.Simple(0.01, function()
            if not IsValid(self) then return end
                self:SetMoveType(MOVETYPE_NONE)
        end)
    self.Armed = true

    if self.Order and self.Order != 1 then return end

    timer.Simple(self.FireTime - 1, function()
        if not IsValid(self) then return end

    end)

    timer.Simple(self.FireTime, function()
        if not IsValid(self) then return end

        self:Remove()
    end)
end

function ENT:Draw()
end