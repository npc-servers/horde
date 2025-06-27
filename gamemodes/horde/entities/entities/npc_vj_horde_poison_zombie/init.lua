AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/poison.mdl"}
ENT.StartHealth = 500
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 40
ENT.AnimTbl_MeleeAttack = {"vjseq_melee_01","vjseq_melee_02","vjseq_melee_03"}
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = 1
ENT.SlowPlayerOnMeleeAttack = true
ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = {"vjseq_throw"}
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_pzombie_projectile"
ENT.RangeDistance = 500
ENT.RangeToMeleeDistance = 100
ENT.TimeUntilRangeAttackProjectileRelease = 1.3
ENT.NextRangeAttackTime = 10
ENT.FootStepTimeRun = 1
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/zombie_poison/pz_left_foot1.wav","npc/zombie_poison/pz_right_foot1.wav"}
ENT.SoundTbl_Idle = {"npc/zombie_poison/pz_idle2.wav","npc/zombie_poison/pz_idle3.wav","npc/zombie_poison/pz_idle3.wav"}
ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_alert1.wav","npc/zombie_poison/pz_alert2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/zombie_poison/pz_warn1.wav","npc/zombie_poison/pz_warn2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"npc/zombie_poison/pz_warn1.wav","npc/zombie_poison/pz_warn2.wav"}
ENT.SoundTbl_RangeAttack = {"npc/zombie_poison/pz_throw2.wav","npc/zombie_poison/pz_throw3.wav"}
ENT.SoundTbl_Pain = {"npc/zombie_poison/pz_pain1.wav","npc/zombie_poison/pz_pain2.wav","npc/zombie_poison/pz_pain3.wav"}
ENT.SoundTbl_Death = {"npc/zombie_poison/pz_die1.wav","npc/zombie_poison/pz_die2.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
end
