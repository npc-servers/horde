AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vj_zombies/fast4.mdl"}
ENT.StartHealth = 30
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = {"vjseq_melee"}
ENT.TimeUntilMeleeAttackDamage = 0.2
ENT.NextMeleeAttackTime = 1
ENT.FootStepTimeRun = 0.25
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_Idle = {")vj_zombies/fast/fzombie_idle1.wav",")vj_zombies/fast/fzombie_idle2.wav",")vj_zombies/fast/fzombie_idle3.wav",")vj_zombies/fast/fzombie_idle4.wav",")vj_zombies/fast/fzombie_idle5.wav"}
ENT.SoundTbl_Alert = {")vj_zombies/fast/fzombie_alert1.wav",")vj_zombies/fast/fzombie_alert2.wav",")vj_zombies/fast/fzombie_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {")vj_zombies/fast/attack1.wav",")vj_zombies/fast/attack2.wav",")vj_zombies/fast/attack3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav","vj_zombies/slow/miss2.wav","vj_zombies/slow/miss3.wav","vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_Pain = {")vj_zombies/fast/fzombie_pain1.wav",")vj_zombies/fast/fzombie_pain2.wav",")vj_zombies/fast/fzombie_pain3.wav"}
ENT.SoundTbl_Death = {")vj_zombies/fast/fzombie_die1.wav",")vj_zombies/fast/fzombie_die2.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:SetSkin(math.random(0,3))
end
