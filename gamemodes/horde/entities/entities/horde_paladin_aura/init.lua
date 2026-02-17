AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

ENT.CleanupPriority = 2
ENT.Spawnable = false

ENT.Entities = {}

function ENT:Initialize()
    local vecRadius = Vector( self.Radius, self.Radius, self.Radius )
    self:SetCollisionBounds( -vecRadius, vecRadius )
    self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
    self:SetMoveType( MOVETYPE_VPHYSICS )

    self:SetTrigger( true )
    self:UseTriggerBounds( true, 4 )

    self:SetParent( self:GetOwner() )

    self:SetNoDraw( true )
    self:PhysWake()

    self.CachedOwner = self:GetOwner()
    self.Entities[self.CachedOwner] = CurTime()
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

function ENT:Horde_SetAuraRadius( radius )
    self.Radius = radius
    self:SetCircleRadius( radius + 36 ) -- +36 so it visually seems right
end

function ENT:Horde_GetAuraRadius()
    return self.Radius
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
local plyMeta = FindMetaTable( "Player" )
local entMeta = FindMetaTable( "Entity" )
local dmginfo = FindMetaTable( "CTakeDamageInfo" )

local ply_Horde_GetPerk = plyMeta.Horde_GetPerk
local ply_Horde_ReduceDebuffBuildup = plyMeta.Horde_ReduceDebuffBuildup

local ent_Health = entMeta.Health
local ent_GetMaxHealth = entMeta.GetMaxHealth
local ent_GetPos = entMeta.GetPos
local ent_NextThink = entMeta.NextThink
local ent_TakeDamageInfo = entMeta.TakeDamageInfo
local ent_Horde_AddDebuffBuildup = entMeta.Horde_AddDebuffBuildup

local dmginfo_SetDamage = dmginfo.SetDamage
local dmginfo_SetDamageType = dmginfo.SetDamageType
local dmginfo_SetAttacker = dmginfo.SetAttacker
local dmginfo_SetInflictor = dmginfo.SetInflictor
local dmginfo_SetDamagePosition = dmginfo.SetDamagePosition

local HORDE = HORDE
local horde_IsEnemy = HORDE.IsEnemy
local horde_OnPlayerHeal = HORDE.OnPlayerHeal

local STATUS_SHOCK = HORDE.Status_Shock
local STATUS_BUILDUP = 2
local DEBUFF_REDUCTION = 5
local HEAL_PERCENT = 0.02
local THINK_INTERVAL = 2
local LIGHTNING_DMG_AMOUNT = 25
local LIGHTNING_DMG_TYPE = DMG_SHOCK

local PERK_DAWNBRINDER = "paladin_dawnbrinder"
local PERK_SANCTUARY = "paladin_sanctuary"
local PERK_RALLYING_PRESENCE = "paladin_rallying_presence"

local lightningdmginfo = DamageInfo()

local CurTime = CurTime
local IsValid = IsValid
local pairs = pairs

local HealInfo = HealInfo
local healInfo_New = HealInfo.New

function ENT:Think()
    local owner = self.CachedOwner
    local curTime = CurTime()

    if not owner then
        ent_NextThink( self, curTime + THINK_INTERVAL )

        return true
    end

    local hasDawnbrinder = ply_Horde_GetPerk( owner, PERK_DAWNBRINDER )
    local hasSanctuary = ply_Horde_GetPerk( owner, PERK_SANCTUARY )
    local hasRallyingPresence = ply_Horde_GetPerk( owner, PERK_RALLYING_PRESENCE )

    if not ( hasDawnbrinder or hasSanctuary or hasRallyingPresence ) then
        ent_NextThink( self, curTime + THINK_INTERVAL )

        return true
    end

    if hasDawnbrinder then
        dmginfo_SetDamage( lightningdmginfo, LIGHTNING_DMG_AMOUNT )
        dmginfo_SetDamageType( lightningdmginfo, LIGHTNING_DMG_TYPE )
        dmginfo_SetAttacker( lightningdmginfo, owner )
        dmginfo_SetInflictor( lightningdmginfo, owner )
    end

    for ent, _ in pairs( self.Entities ) do
        if IsValid( ent ) then
            if horde_IsEnemy( HORDE, ent ) then
                if hasDawnbrinder then
                    local entPos = ent_GetPos( ent )
                    dmginfo_SetDamagePosition( lightningdmginfo, entPos )

                    ent_TakeDamageInfo( ent, lightningdmginfo )
                    ent_Horde_AddDebuffBuildup( ent, STATUS_SHOCK, STATUS_BUILDUP, owner, entPos )
                end
            elseif ent:IsPlayer() then
                if hasSanctuary then
                    for debuff, _ in pairs( ent.Horde_Debuff_Buildup ) do
                        ply_Horde_ReduceDebuffBuildup( ent, debuff, DEBUFF_REDUCTION )
                    end
                end

                if hasRallyingPresence then
                    local maxHealth = ent_GetMaxHealth( ent )
                    if ent_Health( ent ) < maxHealth then
                        horde_OnPlayerHeal( HORDE, ent, healInfo_New( HealInfo, { amount = maxHealth * HEAL_PERCENT, healer = owner } ) )
                    end
                end
            end
        end
    end

    ent_NextThink( self, curTime + THINK_INTERVAL )

    return true
end