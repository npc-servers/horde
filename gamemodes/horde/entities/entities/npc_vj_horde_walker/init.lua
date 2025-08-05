AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vj_zombies/slow2.mdl","models/vj_zombies/slow3.mdl","models/vj_zombies/slow5.mdl","models/vj_zombies/slow7.mdl","models/vj_zombies/slow8.mdl"}
ENT.StartHealth = 75
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"vjges_flinch_chest"}
ENT.MeleeAttackDamage = 20
ENT.AnimTbl_MeleeAttack = {"vjseq_attacka","vjseq_attackb","vjseq_attackc","vjseq_attackd","vjseq_attacke","vjseq_attackf"}
ENT.TimeUntilMeleeAttackDamage = 1
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 1
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav","npc/zombie/foot_slide1.wav","npc/zombie/foot_slide2.wav","npc/zombie/foot_slide3.wav"}
ENT.SoundTbl_Idle = {")vj_zombies/slow/zombie_idle1.wav",")vj_zombies/slow/zombie_idle2.wav",")vj_zombies/slow/zombie_idle3.wav",")vj_zombies/slow/zombie_idle4.wav",")vj_zombies/slow/zombie_idle5.wav",")vj_zombies/slow/zombie_idle6.wav"}
ENT.SoundTbl_Alert = {")vj_zombies/slow/zombie_alert1.wav",")vj_zombies/slow/zombie_alert2.wav",")vj_zombies/slow/zombie_alert3.wav",")vj_zombies/slow/zombie_alert4.wav"}
ENT.SoundTbl_MeleeAttack = {")vj_zombies/slow/zombie_attack_1.wav",")vj_zombies/slow/zombie_attack_2.wav",")vj_zombies/slow/zombie_attack_3.wav",")vj_zombies/slow/zombie_attack_4.wav",")vj_zombies/slow/zombie_attack_5.wav",")vj_zombies/slow/zombie_attack_6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav","vj_zombies/slow/miss2.wav","vj_zombies/slow/miss3.wav","vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_Pain = {")vj_zombies/slow/zombie_pain1.wav",")vj_zombies/slow/zombie_pain2.wav",")vj_zombies/slow/zombie_pain3.wav",")vj_zombies/slow/zombie_pain4.wav",")vj_zombies/slow/zombie_pain5.wav",")vj_zombies/slow/zombie_pain6.wav",")vj_zombies/slow/zombie_pain7.wav",")vj_zombies/slow/zombie_pain8.wav"}
ENT.SoundTbl_Death = {")vj_zombies/slow/zombie_die1.wav",")vj_zombies/slow/zombie_die2.wav",")vj_zombies/slow/zombie_die3.wav",")vj_zombies/slow/zombie_die4.wav",")vj_zombies/slow/zombie_die5.wav",")vj_zombies/slow/zombie_die6.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
end
function ENT:CustomOnThink_AIEnabled()
	self.AnimTbl_IdleStand = {self:IsOnFire() and ACT_IDLE_ON_FIRE or ACT_IDLE}
	self.AnimTbl_Walk = {self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK}
	self.AnimTbl_Run = {self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_RUN}
end
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if hitgroup == HITGROUP_LEFTARM then
		self.AnimTbl_Flinch = {"vjges_flinch_leftarm"}
	elseif hitgroup == HITGROUP_RIGHTARM then
		self.AnimTbl_Flinch = {"vjges_flinch_rightarm"}
	elseif hitgroup == HITGROUP_LEFTLEG then
		self.AnimTbl_Flinch = {"vjseq_flinch_leftleg"}
	elseif hitgroup == HITGROUP_RIGHTLEG then
		self.AnimTbl_Flinch = {"vjseq_flinch_rightleg"}
	elseif hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Flinch = {"vjges_flinch_head"}
	end
end
