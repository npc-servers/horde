AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

ENT.CleanupPriority = 2
ENT.Spawnable = false

ENT.Entities = {}

function ENT:Initialize()
    local vecRadius = Vector( self.Area_of_Effect_Radius, self.Area_of_Effect_Radius, self.Area_of_Effect_Radius )
    self:SetCollisionBounds( -vecRadius, vecRadius )
    self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
    self:SetMoveType( MOVETYPE_VPHYSICS )

    self:SetTrigger( true )
    self:UseTriggerBounds( true, 4 )

    self:SetParent( self:GetOwner() )

    self:SetNoDraw( true )
    self:PhysWake()

    self.CachedOwner = self:GetOwner()
end

function ENT:StartTouch( ent )
    if self.Removing then return end

    self.Entities[ent] = CurTime()

    if ent:IsPlayer() then
        ent:Horde_AddPaladinAuraEffects( self:GetOwner() )
    end
end

function ENT:EndTouch( ent )
    if self.Removing then return end

    self.Entities[ent] = nil

    if ent:IsPlayer() then
        ent:Horde_RemovePaladinAuraEffects()
    end
end

function ENT:Horde_SetPresenceRadius( radius )
    self.Area_of_Effect_Radius = radius
    self:SetCircleRadius( radius + 36 ) -- +36 so it visually seems right
end

function ENT:Horde_GetPresenceRadius()
    return self.Area_of_Effect_Radius
end

function ENT:OnRemove()
    self.Removing = true
    if not self.Entities then return end

    for ent, _ in pairs( self.Entities ) do
        if ent:IsPlayer() then
            ent:Horde_RemovePaladinAuraEffects()
        end
    end
end

-- Cache for perf
local thinkInterval = 2

local lightningdmginfo = DamageInfo()
lightningdmginfo:SetDamage( 2 )
lightningdmginfo:SetDamageType( DMG_SHOCK )

function ENT:Think()
    local owner = self.CachedOwner

    if not owner then
        self:NextThink( CurTime() + thinkInterval )

        return true
    end

    local curTime = CurTime()

    local hasDawnbrinder = owner:Horde_GetPerk( "paladin_dawnbrinder" )
    local hasSanctuary = owner:Horde_GetPerk( "paladin_sanctuary" )
    local hasRallyingPresence = owner:Horde_GetPerk( "paladin_rallying_presence" )

    if not ( hasDawnbrinder or hasSanctuary or hasRallyingPresence ) then return end

    for ent, _ in pairs( self.Entities ) do
        if IsValid( ent ) then
            if HORDE:IsEnemy( ent ) then
                if hasDawnbrinder then
                    lightningdmginfo:SetAttacker( owner )
                    lightningdmginfo:SetInflictor( owner )

                    local entPos = ent:GetPos()
                    lightningdmginfo:SetDamagePosition( entPos )

                    ent:TakeDamageInfo( lightningdmginfo )
                    ent:Horde_AddDebuffBuildup( HORDE.Status_Shock, 2, owner, entPos )
                end
            elseif ent:IsPlayer() then
                if hasSanctuary then
                    for debuff, _ in pairs( ent.Horde_Debuff_Buildup ) do
                        ent:Horde_ReduceDebuffBuildup( debuff, 5 )
                    end
                end

                if hasRallyingPresence and ent:Health() < ent:GetMaxHealth() then
                    local healinfo = HealInfo:New( { amount = 2, healer = owner } )
                    HORDE:OnPlayerHeal( ent, healinfo )
                end
            end
        end
    end

    self:NextThink( curTime + thinkInterval )

    return true
end