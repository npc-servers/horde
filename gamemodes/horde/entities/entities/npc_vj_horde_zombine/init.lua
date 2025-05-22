AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zombie_soldier.mdl"}
ENT.StartHealth = 250
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.AnimTbl_Run = {ACT_WALK}
ENT.BloodColor = "Red"
ENT.AnimTbl_MeleeAttack = {"vjseq_fastattack"}
ENT.MeleeAttackDamage = 25
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 64
ENT.TimeUntilMeleeAttackDamage = 0.4
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 1
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"zsszombine/gear1.wav","zsszombine/gear2.wav","zsszombine/gear3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}

ENT.SoundTbl_Idle = {"zsszombine/idle1.wav","zsszombine/idle2.wav","zsszombine/idle3.wav","zsszombine/idle4.wav","zsszombine/idle5.wav"}
ENT.SoundTbl_Alert = {"zsszombine/alert1.wav","zsszombine/alert2.wav","zsszombine/alert3.wav","zsszombine/alert4.wav","zsszombine/alert5.wav","zsszombine/alert6.wav"}
ENT.SoundTbl_MeleeAttack = {"zsszombine/attack1.wav","zsszombine/attack2.wav","zsszombine/attack3.wav","zsszombine/attack4.wav"}
ENT.SoundTbl_Pain = {"zsszombine/pain1.wav","zsszombine/pain2.wav","zsszombine/pain3.wav","zsszombine/pain4.wav"}
ENT.SoundTbl_Death = {"zsszombine/die1.wav","zsszombine/die2.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnThink_AIEnabled()
	local ene = self:GetEnemy()
	if not self.Zombine_GrenadeOut then
		if IsValid(ene) and self.LatestEnemyDistance <= 200 and self:Health() <= 50 then
			self:Zombine_CreateGrenade()
		end
	end
	if IsValid(self.Zombine_Grenade) then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"idle_grenade")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"walk_all_grenade")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"run_all_grenade")}
	else
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
	end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
		self.AnimTbl_Run = {ACT_RUN}
		self.FootStepTimeRun = 0.5
		self.Critical = true
    end
end
function ENT:Zombine_CreateGrenade()
	self.Zombine_GrenadeOut = true
	self:VJ_ACT_PLAYACTIVITY("pullgrenade", true, false, true)
	timer.Simple(0.5, function()
		if IsValid(self) then
			self.Zombine_Grenade = ents.Create("npc_grenade_frag")
			self.Zombine_Grenade:SetOwner(self)
			self.Zombine_Grenade:SetParent(self)
			self.Zombine_Grenade:Fire("SetParentAttachment", "grenade_attachment", 0)
			self.Zombine_Grenade:Spawn()
			self.Zombine_Grenade:Activate()
			self.Zombine_Grenade:Input("SetTimer", self:GetOwner(), self:GetOwner(), 3)
			self.Zombine_Grenade.VJ_IsPickedUpDanger = true
			timer.Simple(5, function()
				if IsValid(self) and not IsValid(self.Zombine_Grenade) then
					self.Zombine_GrenadeOut = false
				end
			end)
		end
	end)
end
function ENT:CustomOnKilled(dmginfo,hitgroup)
	if IsValid(self.Zombine_Grenade) then
		local att = self:GetAttachment(self:LookupAttachment("grenade_attachment"))
		self.Zombine_Grenade:SetOwner(NULL)
		self.Zombine_Grenade:SetParent(NULL)
		self.Zombine_Grenade:Fire("ClearParent")
		self.Zombine_Grenade:SetMoveType(MOVETYPE_VPHYSICS)
		self.Zombine_Grenade:SetPos(att.Pos)
		self.Zombine_Grenade:SetAngles(att.Ang)
		local phys = self.Zombine_Grenade:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableGravity(true)
			phys:Wake()
		end
	end
end

ENT.Critical = nil
ENT.Zombine_GrenadeOut = false
ENT.Zombie_LastAnimSet = 0
VJ.AddNPC("Zombine", "npc_vj_horde_zombine", "Zombies")
