AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zombie_soldier.mdl"}
ENT.StartHealth = 250
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 25
ENT.AnimTbl_MeleeAttack = {"vjseq_fastattack"}
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = 0.3
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 1
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"zsszombine/gear1.wav","zsszombine/gear2.wav","zsszombine/gear3.wav"}
ENT.SoundTbl_Idle = {"zsszombine/idle1.wav","zsszombine/idle2.wav","zsszombine/idle3.wav","zsszombine/idle4.wav","zsszombine/idle5.wav"}
ENT.SoundTbl_Alert = {"zsszombine/alert1.wav","zsszombine/alert2.wav","zsszombine/alert3.wav","zsszombine/alert4.wav","zsszombine/alert5.wav","zsszombine/alert6.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"zsszombine/attack1.wav","zsszombine/attack2.wav","zsszombine/attack3.wav","zsszombine/attack4.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"zsszombine/pain1.wav","zsszombine/pain2.wav","zsszombine/pain3.wav","zsszombine/pain4.wav"}
ENT.SoundTbl_Death = {"zsszombine/die1.wav","zsszombine/die2.wav"}

ENT.GeneralSoundPitch1 = 100

ENT.Critical = false
ENT.CurrentGrenadeCount = 0
ENT.GrenadeOut = false
ENT.MaxGrenades = 1

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:SetBodygroup(1,1)
end
function ENT:CustomOnThink_AIEnabled()
	if IsValid(self.Grenade) then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"idle_grenade")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"walk_all_grenade")}
		self.AnimTbl_Run = {self.Critical and VJ_SequenceToActivity(self,"run_all_grenade") or VJ_SequenceToActivity(self,"walk_all_grenade")}
	else
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {self.Critical and ACT_RUN or ACT_WALK}
	end
	if not self.GrenadeOut and self.CurrentGrenadeCount < self.MaxGrenades then
		if IsValid(self:GetEnemy()) and self.LatestEnemyDistance <= 200 and self:Health() < self:GetMaxHealth() / 4 then
			self:CreateGrenade()
		end
	end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	self.Critical = self:Health() < self:GetMaxHealth() / 2
	self.FootStepTimeRun = self.Critical and 0.5 or 1
end
function ENT:CustomOnKilled(dmginfo,hitgroup)
	timer.Remove("GrenadeSpawn")
	timer.Remove("GrenadeReset")
	if IsValid(self.Grenade) then
		local att = self:GetAttachment(self:LookupAttachment("grenade_attachment"))
		self.Grenade:SetOwner(NULL)
		self.Grenade:SetParent(NULL)
		self.Grenade:Fire("ClearParent")
		self.Grenade:SetMoveType(MOVETYPE_VPHYSICS)
		self.Grenade:SetPos(att.Pos)
		self.Grenade:SetAngles(att.Ang)
		local phys = self.Grenade:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableGravity(true)
			phys:Wake()
		end
	end
end
function ENT:CreateGrenade()
	self:VJ_ACT_PLAYACTIVITY("pullgrenade",true,false,true)
	self.GrenadeOut = true
	timer.Create("GrenadeSpawn",0.5,1,function()
		if IsValid(self) then
			self.CurrentGrenadeCount = self.CurrentGrenadeCount + 1
			self.Grenade = ents.Create("npc_grenade_frag")
			self.Grenade:SetOwner(self)
			self.Grenade:SetParent(self)
			self.Grenade:Fire("SetParentAttachment","grenade_attachment",0)
			self.Grenade:Spawn()
			self.Grenade:Activate()
			self.Grenade:Input("SetTimer",self:GetOwner(),self:GetOwner(),3)
			self.Grenade.VJ_IsPickedUpDanger = true
			timer.Create("GrenadeReset",3.5,1,function()
				if IsValid(self) then
					self.GrenadeOut = false
				end
			end)
		end
	end)
end

ENT.EntitiesToNoCollide = {
	"npc_vj_alpha_gonome", 
	"npc_vj_ezt_manhackbie", 
	"npc_vj_ezt_shotbie", 
	"npc_vj_ezt_weapbie", 
	"npc_vj_horde_blight", 
	"npc_vj_horde_breen", 
	"npc_vj_horde_charred_zombine", 
	"npc_vj_horde_crawler", 
	"npc_vj_horde_exploder", 
	"npc_vj_horde_fast_zombie",
	"npc_vj_horde_gamma_gonome",
	"npc_vj_horde_headcrab_baby",
	"npc_vj_horde_hellknight",
	"npc_vj_horde_hulk",
	"npc_vj_horde_lesion",
	"npc_vj_horde_plague_elite",
	"npc_vj_horde_plague_platoon",
	"npc_vj_horde_plague_soldier",
	"npc_vj_horde_platoon_berserker",
	"npc_vj_horde_platoon_demolitionist",
	"npc_vj_horde_platoon_heavy",
	"npc_vj_horde_poison_zombie",
	"npc_vj_horde_scorcher",
	"npc_vj_horde_screecher",
	"npc_vj_horde_sprinter",
	"npc_vj_horde_vomitter",
	"npc_vj_horde_walker",
	"npc_vj_horde_weeper",
	"npc_vj_horde_xen_destroyer_unit",
	"npc_vj_horde_xen_host_unit",
	"npc_vj_horde_xen_necromancer_unit",
	"npc_vj_horde_xen_psychic_unit",
	"npc_vj_horde_yeti",
	"npc_vj_horde_zombie_torso",
	"npc_vj_horde_zombine",
	"npc_vj_mutated_hulk"
}