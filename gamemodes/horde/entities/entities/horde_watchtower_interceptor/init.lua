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

    self.Horde_NextThink = CurTime()
    self.Horde_Owner = self:GetNWEntity("HordeOwner")
    self.Horde_ThinkInterval = 30
    self.Horde_EnableShockwave = nil
    self.Horde_NextShockWave = CurTime()
    self.Horde_ShockwaveInterval = 2
    self.Horde_WatchTower = true
    self.Horde_NextShockAttack = CurTime()
    self.Horde_ShockAttackInterval = 0.1
    self.Horde_LastMovePos = self:GetPos()
    self.Horde_IdleStart = CurTime()
    self.Horde_Idle = false
    self.Horde_Immune_Status_All = true
    self:SetColor(Color(255, 150, 0))

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
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 500)) do
            if ent ~= self and ent.Horde_WatchTower and ent.Horde_Owner == self.Horde_Owner then
                local start = self:GetPos() + self:OBBCenter()
                local epos = ent:GetPos() + ent:OBBCenter()

                local tr = util.TraceLine({
                    start = start,
                    endpos = epos,
                    filter = self,
                    mask = MASK_SHOT_HULL
                })

                if tr.Hit and tr.Entity:IsWorld() then
                    return
                end

                local enes = ents.FindInBox(start + self:GetRight(), epos + ent:GetRight())
                for _, ene in pairs(enes) do
                    if HORDE:IsEnemy(ene) then
                        local dmg = DamageInfo()
                        dmg:SetAttacker(self.Horde_Owner)
                        dmg:SetInflictor(self)
                        dmg:SetDamageType(DMG_BLAST)
                        dmg:SetDamage(5)
                        dmg:SetDamagePosition(ene:GetPos())
                        ene:TakeDamageInfo(dmg)
                    end
                end

                local effectdata = EffectData()
                effectdata:SetOrigin( epos )
                effectdata:SetStart( start )
                effectdata:SetEntity( self )
                util.Effect( "horde_laser_turret_laser", effectdata )
            end
        end

        self.Horde_NextShockAttack = curTime
    end
end