AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
/*-----------------------------------------------
    *** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
    No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
    without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/combine_turrets/floor_turret.mdl" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 400
ENT.SightDistance = 8000
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.SightAngle = 80 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.LastSeenEnemyTimeUntilReset = 60 -- Time until it resets its enemy if its current enemy is not visible
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = { "CLASS_COMBINE" } -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Oil" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodDecal = false
ENT.PlayerFriendly = true -- Makes the SNPC friendly to the player and HL2 Resistance
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
-- Miscellaneous ---------------------------------------------------------------------------------------------------------------------------------------------
-- ====== Other Variables ====== --
ENT.RunAwayOnUnknownDamage = false -- Should run away on damage
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackAngleRadius = 80
-- ====== Animation Variables ====== --
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.RangeAttackReps = 1 -- How many times does it run the projectile code?
ENT.NextRangeAttackTime = 0.07 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.07 -- How much time until it can use any attack again? | Counted in Seconds
-- ====== Distance Variables ====== --
ENT.TimeUntilRangeAttackProjectileRelease = 0 -- How much time until the projectile code is ran?
ENT.RangeDistance = 1200 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.HasFootStepSound = false
ENT.SoundTbl_FootStep = {}
ENT.CanTurnWhileStationary = false
ENT.HasOnPlayerSight = true

ENT.HasPoseParameterLooking = true -- Does it look at its enemy using poseparameters?
ENT.PoseParameterLooking_CanReset = true -- Should it reset its pose parameters if there is no enemies?
ENT.PoseParameterLooking_InvertPitch = false -- Inverts the pitch poseparameters (X)
ENT.PoseParameterLooking_InvertYaw = false -- Inverts the yaw poseparameters (Y)
ENT.PoseParameterLooking_InvertRoll = false -- Inverts the roll poseparameters (Z)

-- Custom
ENT.Sentry_MuzzleAttach = "eyes" -- The bullet attachment
ENT.Sentry_AlarmAttach = "light" -- Attachment that the alarm sprite spawns
ENT.Sentry_Type = 0 -- 0 = Regular Ground Sentry | 1 = Big Ceiling/Ground Turret | 2 = Mini Ceiling/Ground Turret
ENT.Sentry_OrientationType = 0 -- 0 = Ground | 1 = Ceiling
ENT.Sentry_GroundType = 0 -- 0 = Regular Ground Sentry | 1 = Decay Ground Sentry

ENT.Sentry_HasLOS = false -- Has line of sight
ENT.Sentry_StandDown = true
ENT.Sentry_SpunUp = false
ENT.Sentry_CurrentParameter = 0
ENT.Sentry_NextAlarmT = 0
ENT.Sentry_ControllerStatus = 0 -- Current status of the controller, 0 = Idle | 1 = Alerted

-- ====== Sounds ====== --
ENT.HasSounds = true
ENT.SoundTbl_CombatIdle = {
    "npc/turret_floor/ping.wav"
}
ENT.SoundTbl_Idle = {
    "npc/turret_floor/ping.wav"
}
ENT.SoundTbl_Pain = {}
ENT.SoundTbl_Death = {
    "npc/turret_floor/die.wav"
}
ENT.SoundTbl_Alert = {
    "npc/turret_floor/deploy.wav"
}
ENT.SoundTbl_RangeAttack = {
    "npc/turret_floor/shoot1.wav"
}

ENT.Horde_Immune_Status = {
    [HORDE.Status_Bleeding] = true,
    [HORDE.Status_Frostbite] = true,
    [HORDE.Status_Ignite] = true,
    [HORDE.Status_Break] = true,
    [HORDE.Status_Necrosis] = true,
    [HORDE.Status_Hemorrhage] = true,
}
ENT.Immune_AcidPoisonRadiation = true

function ENT:CustomOnInitialize()
    self:SetCollisionBounds( Vector( 13, 13, 60 ), Vector( -13, -13, 0 ) )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_WORLD )

    timer.Simple( 0, function ()
        HORDE:DropTurret( self )

        if self.Horde_Is_Mini_Sentry then
            self:SetMaxHealth(200)
            self:SetHealth(200)
        end
    end )
end

function ENT:CustomOnThink_AIEnabled()
    if self.Dead then return end
    local eneValid = IsValid( self:GetEnemy() )

    -- Make it not reset its pose parameters while its transitioning from Alert to Idle
    if self.Alerted and not eneValid then
        self.PoseParameterLooking_CanReset = false
    else
        self.PoseParameterLooking_CanReset = true
    end
    if ( self.Sentry_ControllerStatus == 1 ) or ( not self.VJ_IsBeingControlled and ( eneValid or self.Alerted == true ) ) then
        self.Sentry_StandDown = false
        self.AnimTbl_IdleStand = { "spin" }

        if CurTime() > self.Sentry_NextAlarmT and self.Sentry_Type ~= 2 then
            local glow = ents.Create( "env_sprite" )
            glow:SetKeyValue( "model", "vj_base/sprites/vj_glow1.vmt" )
            glow:SetKeyValue( "scale", self.Sentry_Type == 1 and "0.35" or "0.15" )
            glow:SetKeyValue( "rendermode", "5" )
            glow:SetKeyValue( "rendercolor", "255 0 0" )
            glow:SetKeyValue( "spawnflags", "1" ) -- If animated
            glow:SetParent( self )
            glow:Fire( "SetParentAttachment", self.Sentry_AlarmAttach )
            glow:Spawn()
            glow:Activate()
            glow:Fire( "Kill", "", 0.1 )
            self:DeleteOnRemove( glow )
            self.Sentry_NextAlarmT = CurTime() + 1
        end
    end
end

local coneAngleDegrees = 5
local coneAngleTangent = math.tan( math.rad( coneAngleDegrees ) )
local bulletSpreadCone = Vector( coneAngleTangent, coneAngleTangent, 0 )

function ENT:FireBullet( gunPos )
    local enemy = self:GetEnemy()
    local bullet = {}
    bullet.Num = 1
    bullet.Src = gunPos
    bullet.Dir = ( enemy:GetPos() + enemy:OBBCenter() + Vector( 0, 0, 10 ) - gunPos ):GetNormalized()
    bullet.Spread = bulletSpreadCone
    bullet.Tracer = 1
    bullet.TracerName = "Tracer"
    bullet.Force = 1
    bullet.Damage = 15
    bullet.AmmoType = "Pistol"

    self:FireBullets( bullet )
end

function ENT:CustomRangeAttackCode()
    local gunPos = self:GetAttachment( self:LookupAttachment( self.Sentry_MuzzleAttach ) ).Pos
    self:FireBullet( gunPos )

    VJ_EmitSound( self, "npc/turret_floor/shoot1.wav", 80, 100 )

    local muz = ents.Create( "env_sprite_oriented" )
    muz:SetKeyValue( "model", "vj_hl/sprites/muzzleflash3.vmt" )
    if self.Sentry_Type == 1 then
        muz:SetKeyValue( "scale", "" .. math.Rand( 0.8, 1 ) )
    else
        muz:SetKeyValue( "scale", "" .. math.Rand( 0.3, 0.5 ) )
    end
    muz:SetKeyValue( "GlowProxySize", "2.0" ) -- Size of the glow to be rendered for visibility testing.
    muz:SetKeyValue( "HDRColorScale", "1.0" )
    muz:SetKeyValue( "renderfx", "14" )
    muz:SetKeyValue( "rendermode", "3" ) -- Set the render mode to "3" (Glow)
    muz:SetKeyValue( "renderamt", "255" ) -- Transparency
    muz:SetKeyValue( "disablereceiveshadows", "0" ) -- Disable receiving shadows
    muz:SetKeyValue( "framerate", "10.0" ) -- Rate at which the sprite should animate, if at all.
    muz:SetKeyValue( "spawnflags", "0" )
    muz:SetParent( self )
    muz:Fire( "SetParentAttachment", self.Sentry_MuzzleAttach )
    muz:SetAngles( Angle( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -100, 100 ) ) )
    muz:Spawn()
    muz:Activate()
    muz:Fire( "Kill", "", 0.08 )

    local muzzleLight = ents.Create( "light_dynamic" )
    muzzleLight:SetKeyValue( "brightness", "4" )
    muzzleLight:SetKeyValue( "distance", "120" )
    muzzleLight:SetPos( gunPos )
    muzzleLight:SetLocalAngles( self:GetAngles() )
    muzzleLight:Fire( "Color", "255 150 60" )
    muzzleLight:SetParent( self )
    muzzleLight:Spawn()
    muzzleLight:Activate()
    muzzleLight:Fire( "TurnOn", "", 0 )
    muzzleLight:Fire( "Kill", "", 0.07 )
    self:DeleteOnRemove( muzzleLight )
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

ENT.Horde_TurretMinion = true

function ENT:Follow( ply )
    if self:GetNWEntity( "HordeOwner" ) ~= ply then return end

    local a = self:GetAngles()
    self:SetAngles( Angle( 0, a.y, 0 ) )

    ply:PickupObject( self )
    self:GetPhysicsObject():EnableMotion( true )
end

VJ.AddNPC( "SMG Turret", "npc_vj_horde_smg_turret", "Horde" )