ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= "Gorlami Cancer Ball"

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.Model = "models/effects/combineball.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PLAYER_MOVEMENT
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER_MOVEMENT
ENT.Removing = nil
ENT.StartPos = nil

if !SERVER then
	function ENT:Initialize()
		local Pos = self:GetPos()
		local cancer = ParticleEmitter(Pos)
		self.balls = cancer:Add("models/effects/cancerball_glow1", Pos)
		if (self.balls) then
			self.balls:SetLifeTime(0)
			self.balls:SetDieTime(100)
			self.balls:SetStartSize(8)
			self.balls:SetStartAlpha(200)
			self.balls:SetAngleVelocity(Angle(math.Rand(.15,2),0,0))
			self.balls:SetRoll(math.Rand( 0, 360 ))
			self.balls:SetCollide(false)
		end
		cancer:Finish()
	end

	function ENT:Think()
		local Pos = self:GetPos()
		self.balls:SetPos(Pos)
	end

	function ENT:OnRemove()
		self.balls:SetDieTime(0)
	end
end


if !SERVER then return end
local sprunk = Color(255, 165, 0, 200)
function ENT:Initialize()
	self:SetModel(self.Model)
	self:SetModelScale(0.5)
	self:PhysicsInitSphere(1, "metal_bouncy")

	util.SpriteTrail(self, 0, sprunk, true, 15, 0, 0.1, 1 / 6 * 0.5, "sprites/combineball_trail_black_1.vmt")
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetMass(1)
		phys:SetBuoyancyRatio(0)
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end
	timer.Simple(1.5, function() if IsValid(self) then self:DeathEffects() end end)
	self:DrawShadow(false)
end

function ENT:OnBounce(data, phys)
	self:EmitSound("weapons/physcannon/energy_bounce" .. math.random(1,2) .. ".wav", 55, 100, 0.7, CHAN_AUTO )
end

function ENT:PhysicsCollide(data, phys)
	local attacker = self
	if self:GetOwner():IsValid() then
		attacker = self:GetOwner()
	end
	local hitEnt = data.HitEntity
	if IsValid(attacker) then
		local dmg = DamageInfo()
		dmg:SetDamageType(DMG_SHOCK)
		dmg:SetAttacker(attacker)
		dmg:SetInflictor(self)
		dmg:SetDamage(35)
		dmg:SetDamagePosition(self:GetPos())
		hitEnt:TakeDamageInfo(dmg)
		hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage() * 0.5, attacker, dmg:GetDamagePosition())
	end

	if (hitEnt:IsNPC() or hitEnt:IsPlayer()) then
		self:Remove()
		return
	end

	self:OnBounce(data,phys)

	local dataF = EffectData()
	dataF:SetOrigin(data.HitPos)
	--util.Effect("cball_bounce", dataF)

	dataF = EffectData()
	dataF:SetOrigin(data.HitPos)
	dataF:SetNormal(data.HitNormal)
	dataF:SetScale(5)
	util.Effect("AR2Impact", dataF)
end


function ENT:DeathEffects(data, phys)
	self:Remove()
	return

end
