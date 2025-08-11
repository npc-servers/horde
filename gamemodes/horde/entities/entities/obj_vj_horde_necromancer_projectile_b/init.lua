AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/spitball_small.mdl"}
ENT.ShakeWorldOnDeath = true
ENT.ShakeWorldOnDeathAmplitude = 2
ENT.ShakeWorldOnDeathRadius = 100
ENT.ShakeWorldOnDeathDuration = 1
ENT.ShakeWorldOnDeathFrequency = 100
ENT.DoesRadiusDamage = true
ENT.RadiusDamageRadius = 175
ENT.RadiusDamageUseRealisticRadius = true
ENT.RadiusDamage = 20
ENT.RadiusDamageForce = 350
ENT.RadiusDamageForce_Up = 200
ENT.RadiusDamageType = DMG_REMOVENORAGDOLL
ENT.RadiusDamageDisableVisibilityCheck = true
  
ENT.SoundTbl_Idle = {"weapons/physcannon/energy_bounce2.wav"}
ENT.IdleSoundPitch = VJ_Set(50, 50)
ENT.IdleSoundLevel = 100

function ENT:CustomPhysicsObjectOnInitialize( phys )
	phys:Wake()
	phys:SetBuoyancyRatio( 0 )
	phys:EnableDrag( false )
end
function ENT:CustomOnInitialize()
	ParticleEffectAttach( "snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	local e = EffectData()
	e:SetOrigin(self:GetPos())
	e:SetScale(0.5)
	util.Effect("frostcloud", e, true, true)
	self:SetMaterial( "models/effects/vol_light001.mdl" )
	self:DrawShadow( false )
	self:SetColor( Color( 255, 0, 0 ) )
	timer.Simple( 1, function()
		if IsValid( self ) then
			self:Remove()
		end
	end)
end
function ENT:CustomOnThink()
	local e = EffectData()
	e:SetOrigin(self:GetPos())
	e:SetScale(0.5)
end
function ENT:DeathEffects( data, phys )
	ParticleEffect( "ice_impact_heavy", data.HitPos, Angle(0, 0, 0) )
	sound.Play( "horde/weapons/void_projector/void_spear_hit.ogg", data.HitPos, 100, math.random(70, 90) )
	local effectdata = EffectData()
	effectdata:SetOrigin( data.HitPos )
	effectdata:SetScale( 2 )
	util.Effect( "frostcloud", effectdata, true, true )
	sound.Play( "npc/vort/vort_explode1.wav", data.HitPos, 100, 100 )
end