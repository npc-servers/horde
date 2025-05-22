AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/horde/infected_stalker/infected_stalker.mdl"}
ENT.StartHealth = 550
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.AnimTbl_Run = {ACT_WALK}
ENT.BloodColor = "Red"
ENT.HasMeleeAttack = false
ENT.FootStepTimeRun = 1
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/stalker/stalker_footstep_left1.wav","npc/stalker/stalker_footstep_left2.wav","npc/stalker/stalker_footstep_right1.wav","npc/stalker/stalker_footstep_right2.wav"}

ENT.SoundTbl_Idle = {"ep1/npc/stalker/stalker_ambient01.wav"}
ENT.SoundTbl_Alert = {"ep1/npc/stalker/stalker_alert1b.wav","ep1/npc/stalker/stalker_alert2b.wav","ep1/npc/stalker/stalker_alert3b.wav"}
ENT.SoundTbl_Pain = {"ep1/npc/stalker/stalker_pain1.wav","ep1/npc/stalker/stalker_pain2.wav","ep1/npc/stalker/stalker_pain3.wav"}
ENT.SoundTbl_Death = {"ep1/npc/stalker/stalker_die1.wav","ep1/npc/stalker/stalker_die2.wav"}

ENT.GeneralSoundPitch1 = 50
ENT.GeneralSoundPitch2 = 50

function ENT:CustomOnInitialize()
	self:SetColor(Color(0, 150, 250))
	self:SetModelScale(self:GetModelScale() * 1.25, 0)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnThink()
	if not self:GetEnemy() then return end
	local EnemyDistance = self.NearestPointToEnemyDistance
	if EnemyDistance < 250 then
		if CurTime() > self.NextBlastTime then
			self:EmitSound("npc/stalker/go_alert2.wav", 140, 50)
			self:VJ_ACT_PLAYACTIVITY("podconvulse", true, 1.5, false)
			self:ShockAttack(1.5)
			self:ShockAttack(1.75)
			self:ShockAttack(2.0)
			self:ShockAttack(2.25)
			self:ShockAttack(2.5)
			self.NextBlastTime = CurTime() + self.NextBlastCooldown
			timer.Simple(2.5, function ()
				if not self:IsValid() then 
					return 
				end
				self:VJ_ACT_PLAYACTIVITY("walk")
			end)
		end
	end
end
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsColdDamage(dmginfo) then
		dmginfo:ScaleDamage(0.5)
	elseif HORDE:IsLightningDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsBlastDamage(dmginfo) or HORDE:IsFireDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
		self.AnimTbl_Run = {ACT_RUN}
		self.FootStepTimeRun = 0.25
		self.Critical = true
    end
end
function ENT:ShockAttack(delay)
	if self.Horde_Stunned then 
		return 
	end
	timer.Simple(delay, function()
		if not self:IsValid() then 
			return 
		end
		local dmg = DamageInfo()
		dmg:SetAttacker(self)
		dmg:SetInflictor(self)
		dmg:SetDamageType(DMG_REMOVENORAGDOLL)
		dmg:SetDamage(15)
		util.BlastDamageInfo(dmg, self:GetPos(), 350)
		for _, ent in pairs(ents.FindInSphere(self:GetPos(), 350)) do
			if ent:IsPlayer() then
				ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 4, self)
			end
		end
		local e = EffectData()
		e:SetOrigin(self:GetPos())
		e:SetNormal(Vector(0,0,1))
		e:SetScale(1.25)
		util.Effect("weeper_blast", e, true, true)
	end)
end
function ENT:OnRemove()
    self:StopSound("npc/stalker/go_alert2.wav")
end

ENT.Critical = nil
ENT.NextBlastCooldown = 5
ENT.NextBlastTime = CurTime()
VJ.AddNPC("Weeper", "npc_vj_horde_weeper", "Zombies")
