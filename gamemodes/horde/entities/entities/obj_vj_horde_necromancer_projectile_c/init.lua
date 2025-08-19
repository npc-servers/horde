AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/crossbow_bolt.mdl"}
ENT.DirectDamage = 10
ENT.DoesRadiusDamage = true
ENT.RadiusDamageRadius = 50 
ENT.RadiusDamageUseRealisticRadius = true
ENT.RadiusDamage = 5
ENT.RadiusDamageForce = 50
ENT.RadiusDamageType = DMG_REMOVENORAGDOLL
ENT.RadiusDamageDisableVisibilityCheck = true

ENT.SoundTbl_Idle = { "horde/weapons/void_projector/ice_arrow_launch.ogg" }
ENT.IdleSoundPitch = VJ_Set( 70, 90 )
ENT.IdleSoundLevel = 100

function ENT:CustomOnInitializeBeforePhys()
	self:PhysicsInitSphere( 1, "metal_bouncy" )
end
function ENT:CustomPhysicsObjectOnInitialize( phys )
	phys:SetMass( 0.1 )
	phys:EnableGravity( false )
	phys:EnableDrag( false )
	phys:SetBuoyancyRatio( 0 )
end
function ENT:CustomOnInitialize()
	ParticleEffectAttach( "ice_arrow_trail_3", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	ParticleEffectAttach( "ice_arrow_hit", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	self:SetMaterial( "spells/effects/frozen" )
    self:SetModelScale( 3 )
	self:DrawShadow( false )
	timer.Simple( 1, function()
		if IsValid( self ) then
			self:Remove()
		end
	end)
end
function ENT:CustomOnThink()
	local e = EffectData()
	e:SetOrigin( self:GetPos() )
	e:SetScale( 0.5 )
end
function ENT:DeathEffects( data, phys )
	ParticleEffect( "ice_arrow_hit", data.HitPos, Angle(0, 0, 0) )
	sound.Play( "horde/weapons/void_projector/void_spear_hit.ogg", data.HitPos, 100, math.random(70, 90) )
end