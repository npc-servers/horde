AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zclassic_01.mdl","models/zombie/zclassic_02.mdl","models/zombie/zclassic_03.mdl","models/zombie/zclassic_04.mdl","models/zombie/zclassic_05.mdl","models/zombie/zclassic_06.mdl","models/zombie/zclassic_07.mdl","models/zombie/zclassic_08.mdl","models/zombie/zclassic_09.mdl","models/zombie/zclassic_10.mdl","models/zombie/zclassic_11.mdl","models/zombie/zclassic_12.mdl"}
ENT.StartHealth = 75
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 20
ENT.AnimTbl_MeleeAttack = {"vjseq_attacka","vjseq_attackb","vjseq_attackc","vjseq_attackd","vjseq_attacke","vjseq_attackf"}
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = 1
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 1
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav","npc/zombie/foot_slide1.wav","npc/zombie/foot_slide2.wav","npc/zombie/foot_slide3.wav"}
ENT.SoundTbl_Idle = {")zsszombie/zombie_idle1.wav",")zsszombie/zombie_idle2.wav",")zsszombie/zombie_idle3.wav",")zsszombie/zombie_idle4.wav",")zsszombie/zombie_idle5.wav","zsszombie/zombie_idle6.wav"}
ENT.SoundTbl_Alert = {")zsszombie/zombie_alert1.wav",")zsszombie/zombie_alert2.wav","zsszombie/zombie_alert3.wav","zsszombie/zombie_alert4.wav"}
ENT.SoundTbl_MeleeAttack = {"zsszombie/zombie_attack_1.wav","zsszombie/zombie_attack_2.wav",")zsszombie/zombie_attack_3.wav","zsszombie/zombie_attack_4.wav","zsszombie/zombie_attack_5.wav","zsszombie/zombie_attack_6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"zsszombie/zombie_pain1.wav","zsszombie/zombie_pain2.wav","zsszombie/zombie_pain3.wav","zsszombie/zombie_pain4.wav","zsszombie/zombie_pain5.wav","zsszombie/zombie_pain6.wav","zsszombie/zombie_pain7.wav","zsszombie/zombie_pain8.wav"}
ENT.SoundTbl_Death = {"zsszombie/zombie_die1.wav",")zsszombie/zombie_die2.wav","zsszombie/zombie_die3.wav",")zsszombie/zombie_die4.wav",")zsszombie/zombie_die5.wav",")zsszombie/zombie_die6.wav"}

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