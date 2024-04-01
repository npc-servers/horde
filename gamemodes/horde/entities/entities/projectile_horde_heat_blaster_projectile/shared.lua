ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "Heat Bolt"
ENT.Author 				= ""
ENT.Information 		= ""
ENT.Spawnable 			= false
AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.FuseTime = 10
ENT.CollisionGroup = COLLISION_GROUP_PLAYER_MOVEMENT
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER_MOVEMENT
ENT.Removing = nil
ENT.Horde_Charged = 0

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Charged" )

    if SERVER then
        self:SetCharged(false)
    end
end

if SERVER then

function ENT:Initialize()
    self:SetModelScale(0.5)
    self:PhysicsInitSphere(1, "metal_bouncy")

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:SetMass(1)
        phys:SetBuoyancyRatio(0)
        phys:EnableDrag(false)
        phys:EnableGravity(true)
    end

    timer.Simple(2, function() if IsValid(self) then
        self.Removing = true
        self:Remove()
        end
    end)

    self:DrawShadow(false)
    self.SpawnTime = CurTime()
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Remove()
    end
end

function ENT:PhysicsCollide(data, collider)
    if self.Removing then return end
    local v = 80
    if self:GetCharged() == true then
        v = 250
    end
    local owner = self:GetOwner()
    local dmg = DamageInfo()
    dmg:SetAttacker(owner)
    dmg:SetInflictor(self)
    dmg:SetDamageType(DMG_BURN)
    dmg:SetDamage(v)
    util.BlastDamageInfo(dmg, self:GetPos(), v)
    if self.AlreadyPaintedDeathDecal == false then
        self.AlreadyPaintedDeathDecal = true
        util.Decal("Scorch", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
    end

    local attacker = self
    if self:GetOwner():IsValid() then
        attacker = owner
    end

    self:FireBullets({
        Attacker = attacker,
        Damage = v,
        Tracer = 0,
        Distance = 1000,
        Dir = data.HitPos - self:GetPos(),
        Src = self:GetPos(),
        Callback = function(att, tr, dmginfo)
            dmginfo:SetDamageType(DMG_BURN)
        end
        })

        local effectdata = EffectData()
        effectdata:SetOrigin(data.HitPos)
        if self:GetCharged() == true then
            effectdata:SetScale(2 / 2.5)
        else
            effectdata:SetScale(1 / 2.5)
        end
        effectdata:SetEntity(owner)
        util.Effect("horde_blaster_flame_explosion", effectdata )
        self:EmitSound("horde/weapons/blaster/fire_explosion.ogg")
        self:Remove()
    end
end

if CLIENT then
    function ENT:Initialize()
        local Pos = self:GetPos()
        local cancer = ParticleEmitter(Pos)
        self.balls = cancer:Add("sprites/orangeflare1", Pos)
        if (self.balls) then
            self.balls:SetLifeTime(0)
            self.balls:SetDieTime(100)
            if self:GetCharged() == true then
                self.balls:SetStartSize(32)
            else
                self.balls:SetStartSize(8)
            end
            self.balls:SetColor(255, 0, 0, 255)
            self.balls:SetStartAlpha(150)
            self.balls:SetAngleVelocity(Angle(math.Rand(.15,2),0,0))
            self.balls:SetRoll(math.Rand( 0, 360 ))
            self.balls:SetCollide(false)
        end
        cancer:Finish()
    end

    function ENT:OnRemove()
        self.balls:SetDieTime(0)
    end

    function ENT:Think()
        local Pos = self:GetPos()
        self.balls:SetPos(Pos)
        if self.Ticks % 1 == 0 then
            local emitter = ParticleEmitter(self:GetPos())
            local particle = emitter:Add("particles/smokey", self:GetPos())
            particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(50, 100))
            particle:SetAirResistance(100)
            particle:SetDieTime(0.5)
            particle:SetStartAlpha(175)
            particle:SetEndAlpha(0)
                if self:GetCharged() == true then
                    particle:SetStartSize(math.Rand(10, 30))
                else
                    particle:SetStartSize(math.Rand(5, 15))
                end
            particle:SetEndSize(0)
            particle:SetRoll(math.Rand(0, 360))
            particle:SetRollDelta(math.Rand(-30, 30))
            particle:SetColor(255, 255, 255)
            particle:SetLighting(true)
            emitter:Finish()
        end

        self.Ticks = self.Ticks + 1
    end
end
