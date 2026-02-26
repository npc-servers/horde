AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include( "shared.lua" )

ENT.CleanupPriority = 2

local expMultiConvar = GetConVar( "horde_experience_multiplier" )
local startXpMult = HORDE.Difficulty[HORDE.CurrentDifficulty].xpMultiStart
local endXpMult = HORDE.Difficulty[HORDE.CurrentDifficulty].xpMultiEnd
local endMinusStartXp = endXpMult - startXpMult
local maxLevel = HORDE.max_level
local maxWave = HORDE.max_waves

function ENT:Initialize()
    self:SetColor( Color( 0, 255, 0 ) )
    self:SetModel( "models/items/boxmrounds.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )

    self:SetSolid( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    self:SetModelScale( 1.5, 0 )
    self:SetTrigger( true )
    self:UseTriggerBounds( true, 4 )

    self.Removing = false
    self:PhysWake()
end

function ENT:DoGiveXp( ply )
    if HORDE:InBreak() then return end

    local curWave = HORDE.current_wave
    if curWave <= 0 then return end

    local class = ply:Horde_GetCurrentSubclass()
    if ply:Horde_GetLevel( class ) >= maxLevel then return end

    local wavePercent = curWave / maxWave
    local roundXpMult = startXpMult + wavePercent * endMinusStartXp
    local expMult = roundXpMult * expMultiConvar:GetInt() / 2

    ply:Horde_GiveExp( class, 5 * expMult, "Player Resupplied" )
end

function ENT:StartTouch( entity )
    if self.Removing then return end
    if not entity:Alive() then return end
    if not entity:IsPlayer() then return end

    local maxMind = entity:Horde_GetMaxMind()
    local shouldRemove = false

    if maxMind > 0 then
        local mind = entity:Horde_GetMind()
        entity:Horde_SetMind( math.min( maxMind, mind + maxMind * 0.1 ) )

        shouldRemove = shouldRemove or mind < maxMind
    else
        for _, wpn in pairs( entity:GetWeapons() ) do
            local ammo_id = wpn:GetPrimaryAmmoType()
            local ammo_id2 = wpn:GetSecondaryAmmoType()
            local clip_size2 = wpn:GetMaxClip2()

            -- Secondary Magazine size check
            if clip_size2 > 0 then
                clip_size2 = clip_size2
            elseif ammo_id2 >= 1 then
                clip_size2 = 1
            end

            -- Primary ammo
            if wpn.Primary and wpn.Primary.MaxAmmo then
                if wpn.Primary.MaxAmmo > entity:GetAmmoCount( ammo_id ) and entity:GetAmmoCount( ammo_id ) >= 0 then
                    local given = HORDE:GiveAmmo( entity, wpn, 2 )
                    shouldRemove = shouldRemove or given
                end
            elseif entity:GetAmmoCount( ammo_id ) < 9999 then
                local given = HORDE:GiveAmmo( entity, wpn, 2 )
                shouldRemove = shouldRemove or given
            end

            -- Secondary ammo and ArcCW underbarrels
            if wpn.Secondary and wpn.Secondary.MaxAmmo then
                if wpn.Secondary.MaxAmmo > entity:GetAmmoCount( ammo_id2 ) and ammo_id2 >= 0 then
                    local given2 = entity:GiveAmmo( clip_size2, ammo_id2, false )
                    shouldRemove = shouldRemove or given2
                end
            elseif entity:GetAmmoCount( ammo_id2 ) < 9999 then
                local given2 = entity:GiveAmmo( clip_size2, ammo_id2, false )
                shouldRemove = shouldRemove or given2
            end
        end
    end

    if shouldRemove then
        local owner = self:GetOwner()

        if IsValid( owner ) and owner:IsPlayer() then
            self:DoGiveXp( owner )
        end

        self.Removing = true
        self:Remove()
    end
end
