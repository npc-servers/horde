AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_light001a.mdl")
    self:SetModelScale(1.25)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(true)
        phys:SetMass(10)
    end

    self.Horde_NextThink = CurTime()
    self.Horde_Owner = self:GetNWEntity("HordeOwner")
    self.Horde_ThinkInterval = 30
    self.Horde_EnableShockwave = nil
    self.Horde_NextShockWave = CurTime()
    self.Horde_ShockwaveInterval = 2
    self.Horde_WatchTower = true
    self.Horde_NextShockAttack = CurTime()
    self.Horde_ShockAttackInterval = 1
    self.Horde_LastMovePos = self:GetPos()
    self.Horde_IdleStart = CurTime()
    self.Horde_Idle = false
    self.Horde_Immune_Status_All = true
    self:SetColor(Color(0, 150, 255))

    if self.Horde_Owner:Horde_GetPerk("warden_restock") then
        self.Horde_ThinkInterval = 15
    end
    if self.Horde_Owner:Horde_GetPerk("warden_ex_machina") then
        self:Horde_AddWardenAura()
    end
    if self.Horde_Owner:Horde_GetPerk("warden_rejection_pulse") then
        self.Horde_EnableShockwave = true
    end
end

function ENT:Think()
    local curTime = CurTime()

    if not self.Horde_Idle then
        local curPos = self:GetPos()
        if curPos:DistToSqr(self.Horde_LastMovePos) > 1 then
            self.Horde_IdleStart = curTime
            self.Horde_LastMovePos = curPos
        elseif curTime - self.Horde_IdleStart >= 5 then
            local phys = self:GetPhysicsObject()
            if IsValid(phys) then
                phys:EnableMotion(false)
                self.Horde_Idle = true
            end
        end
    end

    if curTime >= self.Horde_NextThink + self.Horde_ThinkInterval then
        if SERVER and self.Horde_Owner:IsPlayer() then
            hook.Run("Horde_WardenWatchtower", self.Horde_Owner, self)
        end
        self.Horde_NextThink = curTime
    end

    if self.Horde_EnableShockwave and curTime >= self.Horde_NextShockWave + self.Horde_ShockwaveInterval then
        local dmg = DamageInfo()
        dmg:SetAttacker(self.Horde_Owner)
        dmg:SetInflictor(self)
        dmg:SetDamageType(DMG_SHOCK)
        dmg:SetDamage(50)
        local e = EffectData()
        e:SetOrigin(self:GetPos())
        util.Effect("explosion_shock", e, true, true)
        util.BlastDamageInfo(dmg, self:GetPos(), 160)
        self.Horde_NextShockWave = curTime
    end

    if curTime >= self.Horde_NextShockAttack + self.Horde_ShockAttackInterval then
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
            if ent:IsValid() and ent:IsPlayer() then
                ent:Horde_GiveArmor(1, self.Horde_Owner)
            end
        end
        self.Horde_NextShockAttack = curTime
    end

    self:NextThink(curTime + 0.1)
end