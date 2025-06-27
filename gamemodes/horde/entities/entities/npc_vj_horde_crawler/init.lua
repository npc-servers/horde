AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zm_fast.mdl"}
ENT.StartHealth = 30
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = {"vjseq_melee"}
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = 0.25
ENT.NextMeleeAttackTime = 1
ENT.MeleeAttackExtraTimers = {0.5}
ENT.FootStepTimeRun = 0.25
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Idle = {"vfastzombie/fzombie_idle1.wav","vfastzombie/fzombie_idle2.wav","vfastzombie/fzombie_idle3.wav",")vfastzombie/fzombie_idle4.wav",")vfastzombie/fzombie_idle5.wav"}
ENT.SoundTbl_Alert = {"vfastzombie/fzombie_alert1.wav","vfastzombie/fzombie_alert2.wav","vfastzombie/fzombie_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vfastzombie/attack1.wav","vfastzombie/attack2.wav","vfastzombie/attack3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"vfastzombie/fzombie_pain1.wav","vfastzombie/fzombie_pain2.wav","vfastzombie/fzombie_pain3.wav"}
ENT.SoundTbl_Death = {"vfastzombie/fzombie_die1.wav","vfastzombie/fzombie_die2.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:SetSkin(math.random(0,3))
end
