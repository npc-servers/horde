ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Fire Particle"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/Items/AR2_Grenade.mdl"

ENT.FireTime = 3

ENT.Armed = false

ENT.NextDamageTick = 0

ENT.Ticks = 0
ENT.TouchedEntities = {}

ENT.ArcCW_Killable = false

AddCSLuaFile()

local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddEffect_Molotov(ent)
    if self.horde_effect_Molotov then return end
    self.horde_effect_Molotov = true
    local id = self:GetCreationID()
    timer.Create("Horde_MolotovEffect" .. id, 0.5, 0, function ()
        if not self:IsValid() then timer.Remove("Horde_MolotovEffect" .. id) return end
        local d = DamageInfo()
        d:SetDamage(10)
        d:SetAttacker(ent.Owner)
        d:SetInflictor(ent)
        d:SetDamageType(DMG_BURN)
        d:SetDamagePosition(self:GetPos())
        self:TakeDamageInfo(d)
    end)
end

function entmeta:Horde_RemoveEffect_Molotov()
    if self.horde_effect_Molotov then
        timer.Remove("Horde_MolotovEffect" .. self:GetCreationID())
        self.horde_effect_Molotov = nil
    end
end

function ENT:Touch(ent)
    if SERVER then
        if self.TouchedEntities[ent:GetCreationID()] and ent.horde_effect_Molotov then return end
        if (ent:IsPlayer() or ent:IsNPC()) then
            self.TouchedEntities[ent:GetCreationID()] = ent
            ent:Horde_AddEffect_Molotov(self)
        end
    end
end

function ENT:EndTouch(ent)
    if SERVER then
        if not (ent:IsNPC() or ent:IsPlayer()) then return end
        self.TouchedEntities[ent:GetCreationID()] = nil
        ent:Horde_RemoveEffect_Molotov()
    end
end

function ENT:Initialize()
   self:SetSolid( SOLID_OBB )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    if SERVER then
        self:SetModel( self.Model )
        self:PhysicsInit(SOLID_OBB)

        local maxs = Vector(100, 100, 100)
        local mins = -maxs
        self:SetCollisionBounds(mins, maxs)
        self:DrawShadow( false )
        local phys = self:GetPhysicsObject()
        if IsValid( phys ) then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end
        self.SpawnTime = CurTime()
        self:Detonate()

        self.FireTime = math.Rand(2.5, 3.5)

        timer.Simple(0.1, function()
            if not IsValid(self) then return end
            self:AddSolidFlags(FSOLID_TRIGGER)
            self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
        end)
    end
end

local fired = {
    "sprites/flamelet1",
    "sprites/flamelet2",
    "sprites/flamelet3",
    "sprites/flamelet4",
    "sprites/flamelet5",
}
local function GetFireParticle()
    return fired[math.random(#fired)]
end

function ENT:Think()
    if not self.SpawnTime then self.SpawnTime = CurTime() end
    if SERVER then
        for _, e in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
            if e:GetClass() == "horde_butane_can" and self:GetOwner() == e.Horde_Owner then
                e:Detonate()
            end
        end
    end
    if CLIENT then
        local emitter = ParticleEmitter(self:GetPos())

        if not self:IsValid() or self:WaterLevel() > 2 then return end
        if not IsValid(emitter) then return end

        for i = 1, 4 do
            local fire = emitter:Add(GetFireParticle(), self:GetPos() + (VectorRand() * 30))
            fire:SetVelocity( VectorRand() * 500 * VectorRand() )
            fire:SetGravity( Vector(0, 0, 2000) )
            fire:SetDieTime( math.Rand(0.2, 0.5) )
            fire:SetStartAlpha( 55 )
            fire:SetEndAlpha( 0 )
            fire:SetStartSize( 25 )
            fire:SetEndSize( 3 )
            fire:SetRoll( math.Rand(-180, 180) )
            fire:SetRollDelta( math.Rand(-0.2,0.2) )
            fire:SetColor( 255, 255, 255 )
            fire:SetAirResistance( 150 )
            local pos = VectorRand() * math.random(20,100)
            pos.z = 0
            fire:SetPos( self:GetPos() + pos )
            fire:SetLighting( false )
            fire:SetCollide(true)
            fire:SetBounce(0.75)
            fire:SetNextThink( CurTime() + FrameTime() )
            fire:SetThinkFunction( function(pa)
                if not pa then return end
                local col1 = Color(255, 195, 117)
                local col2 = Color(189, 38, 38)

                local col3 = col1
                local d = pa:GetLifeTime() / pa:GetDieTime()
                col3.r = Lerp(d, col1.r, col2.r)
                col3.g = Lerp(d, col1.g, col2.g)
                col3.b = Lerp(d, col1.b, col2.b)

                pa:SetColor(col3.r, col3.g, col3.b)
                pa:SetNextThink( CurTime() + FrameTime() )
            end )
        end

        emitter:Finish()

        self.Ticks = self.Ticks + 1
    else

        if self:GetVelocity():LengthSqr() <= 32 then
            self:SetMoveType( MOVETYPE_NONE )
        end

        if self.NextDamageTick > CurTime() then return end

        if self:WaterLevel() > 2 then self:Remove() return end

        self.NextDamageTick = CurTime() + 0.25

        if self.SpawnTime + self.FireTime <= CurTime() then self:Remove() return end
    end
end

function ENT:OnRemove()
    if not self.FireSound then return end
    self.FireSound:Stop()

    if SERVER then
        for _, ent in pairs(self.TouchedEntities) do
            if ent:IsValid() then ent:Horde_RemoveEffect_Molotov() end
        end
    end
end

function ENT:Detonate()
    if not self:IsValid() then return end

    self.Armed = true

    if self.Order and self.Order ~= 1 then return end

    self.FireSound = CreateSound(self, "arccw_go/molotov/fire_loop_1.wav")
    self.FireSound:Play()

    self.FireSound:ChangePitch(80, self.FireTime)

    timer.Simple(self.FireTime - 1, function()
        if not IsValid(self) then return end

        self.FireSound:ChangeVolume(0, 1)
    end)

    timer.Simple(self.FireTime, function()
        if not IsValid(self) then return end

        self:Remove()
    end)
end

function ENT:Draw()
    -- cam.Start3D() -- Start the 3D function so we can draw onto the screen.
    --     render.SetMaterial( GetFireParticle() ) -- Tell render what material we want, in this case the flash from the gravgun
    --     render.DrawSprite( self:GetPos(), math.random(200, 250), math.random(200, 250), Color(255, 255, 255) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
    -- cam.End3D()
end
