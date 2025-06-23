AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/fast.mdl"}
ENT.StartHealth = 30
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 10
ENT.AnimTbl_MeleeAttack = {"vjseq_br2_attack"}
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = 0.7
ENT.HasLeapAttack = true
ENT.AnimTbl_LeapAttack = {"leapstrike"}
ENT.LeapDistance = 350
ENT.LeapToMeleeDistance = 150
ENT.TimeUntilLeapAttackDamage = 0.2
ENT.NextLeapAttackTime = 5
ENT.NextAnyAttackTime_Leap = 0.4
ENT.LeapAttackExtraTimers = {0.4,0.6,0.8,1}
ENT.TimeUntilLeapAttackVelocity = 0.2
ENT.LeapAttackVelocityForward = 250
ENT.LeapAttackVelocityUp = 200
ENT.LeapAttackDamage = 15
ENT.LeapAttackDamageDistance = 100
ENT.FootStepTimeRun = 0.25
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Idle = {"npc/fast_zombie/idle1.wav","npc/fast_zombie/idle2.wav","npc/fast_zombie/idle3.wav"}
ENT.SoundTbl_Alert = {"npc/fast_zombie/fz_alert_close1.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/fast_zombie/leap1.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_LeapAttackJump = {"npc/fast_zombie/fz_scream1.wav","npc/fast_zombie/leap1.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/fast_zombie/claw_strike1.wav","npc/fast_zombie/claw_strike2.wav","npc/fast_zombie/claw_strike3.wav"}
ENT.SoundTbl_Pain = {"npc/fast_zombie/fz_frenzy1.wav","npc/fast_zombie/idle1.wav","npc/fast_zombie/idle2.wav","npc/fast_zombie/idle3.wav"}
ENT.SoundTbl_Death = {"npc/fast_zombie/wake1.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
end