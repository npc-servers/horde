AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/spitball_large.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DecalTbl_DeathDecals = {"VJ_AcidSlime1"}
ENT.SoundTbl_Idle = {"vj_acid/acid_idle1.wav"}
ENT.SoundTbl_OnCollide = {"vj_acid/acid_splat.wav"}
ENT.DoesRadiusDamage = false -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 150 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 10 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_POISON -- Damage type
ENT.DoesDirectDamage = false

function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
	phys:SetMass(1)
	phys:EnableGravity(false)
	timer.Simple(1, function ()
		if self:IsValid() then self:Remove() end
	end)
end
function ENT:CustomOnInitialize()
	ParticleEffectAttach("blood_impact_green_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
function ENT:DeathEffects(data,phys)
	local effectdata = EffectData()
	effectdata:SetOrigin(data.HitPos)
	effectdata:SetColor(1)
	effectdata:SetScale(5)
	util.Effect("BloodImpact",effectdata)
end
function ENT:CustomOnPhysicsCollide(data, phys)
	if self.Dead then return end
	self.Dead = true
	local dmg = DamageInfo()
    local attacker = self.Owner
	if not IsValid( attacker ) then
		attacker = self
	end
    dmg:SetAttacker(attacker)
	dmg:SetInflictor(self)
	dmg:SetDamageType(DMG_GENERIC)
	dmg:SetDamage(20)
	util.BlastDamageInfo(dmg, self:GetPos(), 150)
	for _, e in pairs(ents.FindInSphere(self:GetPos(), 180)) do
		if e:IsPlayer() then
			e:Horde_AddDebuffBuildup(HORDE.Status_Break, 20, attacker)
		end
	end
	for _, d in pairs(ents.FindInSphere(self:GetPos(), 15)) do
		if d:IsPlayer() then
			d:Horde_AddDebuffBuildup(HORDE.Status_Break, 80, attacker)
		end
	end
	self:OnCollideSoundCode()
	if self.PaintDecalOnDeath == true && VJ_PICK(self.DecalTbl_DeathDecals) != false && self.AlreadyPaintedDeathDecal == false then
		self.AlreadyPaintedDeathDecal = true
		util.Decal(VJ_PICK(self.DecalTbl_DeathDecals), data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
	end
	self:SetDeathVariablesTrue(data, phys, true)
	self:Remove()
end
