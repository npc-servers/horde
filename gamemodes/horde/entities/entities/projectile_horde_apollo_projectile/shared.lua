ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.Model = "models/dav0r/hoverball.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PLAYER_MOVEMENT
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER_MOVEMENT
ENT.Removing = nil
ENT.StartPos = nil
	local sprunk = Color(255, 100, 0, 200)
if !SERVER then

	function ENT:Initialize()
		local Pos = self:GetPos()
		local cancer = ParticleEmitter(Pos)
		self.balls = cancer:Add("sprites/orangeflare1", Pos)
		if (self.balls) then
			self.balls:SetLifeTime(0)
			self.balls:SetDieTime(100)
			self.balls:SetStartSize(8)
			self.balls:SetColor(255, 165, 0, 255)
			self.balls:SetStartAlpha(150)
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

function ENT:Initialize()
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
	timer.Simple(2, function() if IsValid(self) then self:DeathEffects() end end)
	self:DrawShadow(false)
end


function ENT:PhysicsCollide(data, phys)
	local owner = self:GetOwner()
	local hitEnt = data.HitEntity
	if IsValid(owner) then
		local dmg = DamageInfo()
		dmg:SetDamageType(DMG_BURN)
		dmg:SetAttacker(owner)
		dmg:SetInflictor(self)
		dmg:SetDamage(60)
		dmg:SetDamagePosition(self:GetPos())
		self:FireBullets({
			Attacker = owner,
			Inflitor = self,
			Damage = 60,
			Tracer = 0,
			Distance = 1000,
			Dir = data.HitPos - self:GetPos(),
			Src = self:GetPos(),
			Callback = function(att, tr, dmginfo)
				dmginfo:SetDamageType(DMG_BURN)
				if ( ! tr.Entity:IsValid()) or (! tr.Entity:IsNPC()) then
					hitEnt:TakeDamageInfo(dmg)
				end
			end
		})
	end

	dataF = EffectData()
	dataF:SetOrigin(data.HitPos)
	dataF:SetNormal(data.HitNormal)
	dataF:SetScale(50)
	util.Effect("AR2Impact", dataF)

	self:Remove()
end

function ENT:DeathEffects(data, phys)
	self:Remove()
	return
end
