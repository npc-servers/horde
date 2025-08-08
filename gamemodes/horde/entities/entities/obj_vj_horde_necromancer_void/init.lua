AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/spitball_small.mdl"} -- The models it should spawn with | Picks a random one from the table
-- ====== Shake World On Death Variables ====== --
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 2 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 100 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathDuration = 1 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 100 -- The frequency
-- ====== Radius Damage Variables ====== --
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 50 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamageUseRealisticRadius = false -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamage = 5  -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageType = DMG_REMOVENORAGDOLL -- Damage type
ENT.RadiusDamageForce = false -- Put the force amount it should apply | false = Don't apply any force
ENT.RadiusDamageForce_Up = false -- How much up force should it have? | false = Let the base automatically decide the force using RadiusDamageForce value
ENT.RadiusDamageDisableVisibilityCheck = false -- Should it disable the visibility check? | true = Disables the visibility check
    -----------------------------------------------------
ENT.SoundTbl_Idle = {"weapons/physcannon/energy_bounce2.wav"}
ENT.SoundTbl_OnCollide = {"weapons/physcannon/energy_bounce2.wav"}

ENT.IdleSoundPitch = VJ_Set(50, 50)
ENT.OnCollideSoundPitch = VJ_Set(50, 50)

ENT.IdleSoundLevel = 100
ENT.OnCollideSoundLevel = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	self:SetColor(Color(0,150,255,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	self:SetMaterial( "models/effects/vol_light001.mdl" )
	self:DrawShadow( false )
	self:SetColor( Color(255, 0, 0) )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local e = EffectData()
	e:SetOrigin(self:GetPos())
	e:SetScale(0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	ParticleEffect("ice_impact_heavy", data.HitPos, Angle(0, 0, 0) )
	sound.Play("horde/weapons/void_projector/void_spear_hit.ogg", data.HitPos, 100, math.random(70, 90) )
end