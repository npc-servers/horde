AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

ENT.CleanupPriority = 2
ENT.Removing = nil

ENT.Spawnable = false

function ENT:Horde_SetPresenceRadius( radius )
    self.Area_of_Effect_Radius = radius
    self:SetCircleRadius( radius )
end

function ENT:Horde_GetPresenceRadius()
    return self.Area_of_Effect_Radius
end

function ENT:Initialize()
    self:SetNoDraw( true )
    self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )

    self.LastSecond = 0
end

function ENT:GetPlayerOwner()
    -- Get player for Think timer so multiple presence from same owner don't stack
    local ply_owner = self:GetParent().Horde_PaladinAura
    if self:GetParent():GetNWEntity( "HordeOwner" ):IsPlayer() then
        ply_owner = self:GetParent():GetNWEntity( "HordeOwner" ).Horde_PaladinAura
    elseif self:GetParent():GetOwner():IsPlayer() then
        ply_owner = self:GetParent():GetOwner().Horde_PaladinAura
    end

    return ply_owner
end

function ENT:GetPlayerParent()
    local ply_parent = self:GetParent()
    if self:GetParent():GetNWEntity( "HordeOwner" ):IsPlayer() then
        ply_parent = self:GetParent():GetNWEntity( "HordeOwner" )
    elseif self:GetParent():GetOwner():IsPlayer() then
        ply_parent = self:GetParent():GetOwner()
    end

    return ply_parent
end

function ENT:GetDelayInterval()
    return 0.5
end

function ENT:GetLingeringDuration()
    local linger = 0.1
    local cball = self:GetParent().LingeringDuration

    if cball and cball > 0 then
        linger = cball
    end

    return linger
end

function ENT:OnEntityEnter( ent )
    if not ent:IsPlayer() then return end
    if not self:CheckCD( ent ) then return end
    local ply = self:GetPlayerParent()

    ent:Horde_AddPaladinAuraEffects( ply )
end

function ENT:OnEntityStay( ent )
    if not ent:IsPlayer() then return end
    local ply = self:GetPlayerParent()

    ent:Horde_AddPaladinAuraEffects( ply )
end

function ENT:OnEntityExit( ent )
    if not ent:IsPlayer() then return end

    ent:Horde_RemovePaladinAuraEffects()
end

ENT.Entities = {}
function ENT:CheckCD( ent )
    local ply = self:GetPlayerOwner()
    local cd = ply.Entities[ent:EntIndex()]
    if not cd then
        return true
    else
        return cd < CurTime()
    end
end

ENT.Entitieslingering = {}
function ENT:CheckLingeringDuration( ent )
    local ply = self:GetPlayerOwner()
    local dur = ply.Entitieslingering[ent:EntIndex()]
    if not dur then
        return true
    else
        return dur < CurTime()
    end
end

ENT.EntitiesInside = {}
ENT.OnEntityStayInterval = 0

local lightningdmginfo = DamageInfo()
lightningdmginfo:SetDamage( 2 )
lightningdmginfo:SetDamageType( DMG_SHOCK )

function ENT:Think()
    local tick = engine.TickCount()
    local ply = self:GetPlayerOwner()

    local radius = self.Area_of_Effect_Radius
    for _, ent in ipairs( ents.FindInSphere( self:GetPos(), radius ) ) do
        if not IsValid( ply ) then return end
        if HORDE:IsEnemy( ent ) or ent:IsPlayer() then
            if not ply.EntitiesInside[ent:EntIndex()] and self:CheckCD( ent ) then
                self:OnEntityEnter( ent )
                ply.Entities[ent:EntIndex()] = CurTime() + self:GetDelayInterval()
            end
            ply.EntitiesInside[ent:EntIndex()] = tick
            if self:GetLingeringDuration() > 0 then
                ply.Entitieslingering[ent:EntIndex()] = CurTime() + self:GetLingeringDuration()
            end
            if self:CheckCD( ent ) then
                ply.Entities[ent:EntIndex()] = CurTime() + self:GetDelayInterval()
                self:OnEntityStay( ent )
            end
        end
    end
    for entindex, tickcount in pairs( ply.EntitiesInside ) do
        local entity = Entity( entindex )
        if not IsValid( entity ) then
            ply.EntitiesInside[entindex] = nil
            continue
        end
        if tickcount != tick and self:CheckLingeringDuration( entity ) then
            ply.EntitiesInside[entindex] = nil
            self:OnEntityExit( entity )
        end
    end
    for entindex, tickcount in pairs( ply.Entitieslingering ) do
        local entity = Entity( entindex )
        if not IsValid( entity ) then
            ply.Entitieslingering[entindex] = nil
            continue
        end
        if self:CheckCD( entity ) and tickcount != tick then
            ply.Entities[entindex] = CurTime() + self:GetDelayInterval()
            self:OnEntityStay( entity )
        end
        if self:CheckLingeringDuration( entity ) then
            ply.Entitieslingering[entindex] = nil
        end
    end
    for entindex, _ in pairs( ply.Entities ) do
        local entity = Entity( entindex )
        if not IsValid( entity ) then
            ply.Entities[entindex] = nil
        end
    end

    local curTime = CurTime()

    -- TODO: Fix this
    if curTime > self.LastSecond then
        self.LastSecond = curTime + 2

        local plyParent = self:GetPlayerParent()
        if plyParent then
            local hasDawnbrinder = plyParent:Horde_GetPerk( "paladin_dawnbrinder" )
            local hasSanctuary = plyParent:Horde_GetPerk( "paladin_sanctuary" )
            local hasRallyingPresence = plyParent:Horde_GetPerk( "paladin_rallying_presence" )

            if hasDawnbrinder or hasSanctuary or hasRallyingPresence then
                for entId, _ in pairs( ply.EntitiesInside ) do
                    local ent = Entity( entId )
                    if hasDawnbrinder and IsValid( ent ) and HORDE:IsEnemy( ent ) then
                        lightningdmginfo:SetAttacker( plyParent )
                        lightningdmginfo:SetInflictor( plyParent )

                        local entPos = ent:GetPos()
                        lightningdmginfo:SetDamagePosition( entPos )

                        ent:TakeDamageInfo( lightningdmginfo )
                        ent:Horde_AddDebuffBuildup( HORDE.Status_Shock, 2, plyParent, entPos )
                    end

                    if hasSanctuary and IsValid( ent ) and ent:IsPlayer() then
                        for debuff, _ in pairs( ent.Horde_Debuff_Buildup ) do
                            ent:Horde_ReduceDebuffBuildup( debuff, 5 )
                        end
                    end

                    if hasRallyingPresence and IsValid( ent ) and ent:IsPlayer() then
                        local healinfo = HealInfo:New( { amount = 2, healer = plyParent } )
                        HORDE:OnPlayerHeal( ent, healinfo )
                    end
                end
            end
        end
    end

    self:NextThink( curTime )
    return true
end

function ENT:OnRemove()
end