AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_light001a.mdl")
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

    self.Horde_Ammobox = nil
    self.Horde_NextThink = CurTime()
    self.Horde_Owner = self:GetNWEntity("HordeOwner")
    self.Horde_ThinkInterval = 30
    self.Horde_EnableShockwave = nil
    self.Horde_NextShockWave = CurTime()
    self.Horde_ShockwaveInterval = 2
    self.Horde_WatchTower = true
    self.Horde_LastMovePos = self:GetPos()
    self.Horde_IdleStart = CurTime()
    self.Horde_Idle = false
    self.Horde_Immune_Status_All = true

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
        if self.Horde_Ammobox and self.Horde_Ammobox:IsValid() then
            self.Horde_Ammobox:Remove()
        end
        self.Horde_Ammobox = ents.Create("horde_ammobox")
        self.Horde_Ammobox:SetPos(self:GetPos() - self:GetAngles():Forward() * 30)
        self.Horde_Ammobox:SetOwner(self.Horde_Owner)
        self.Horde_Ammobox:Spawn()
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

    self:NextThink(curTime + 0.1)
end

hook.Add("PlayerUse", "PickUpWatchtower", function(ply, ent)
    if not HORDE:IsWatchTower(ent) then return end
    if not ent:GetNWEntity("HordeOwner"):IsValid() then return end
    if ent:GetNWEntity("HordeOwner") ~= ply then return false end
    if not ent.Horde_WatchtowerPickupCd then
        ent.Horde_WatchtowerPickupCd = CurTime() + 0.5
    else
        if ent.Horde_WatchtowerPickupCd > CurTime() then
            return
        else
            if ent.Horde_WatchtowerPickedUp then
                ply:DropObject(ent)
                ent.Horde_WatchtowerPickupCd = CurTime() + 0.5
                ent.Horde_WatchtowerPickedUp = nil
                return
            end
        end
    end
    if not ply.IsHoldingObject then
        local p = ent:GetPos()
        p.z = ply:GetPos().z + 12
        ent:SetPos(p)
        local a = ply:GetAngles()
        ent:SetAngles(Angle(0, a.y, 0))
        ply:PickupObject(ent)
    end
    ent.Horde_WatchtowerPickedUp = ply
    ent.Horde_WatchtowerPickupCd = CurTime() + 0.5
end )

hook.Add("OnPlayerPhysicsPickup","DetectPickup", function(ply, ent)
    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(true)
        ent.Horde_Idle = false
    end

    ply.IsHoldingObject = true
end)

hook.Add("OnPlayerPhysicsDrop","Detectdrop", function(ply, ent)
    ply.IsHoldingObject = nil
end)