AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/vj_zombies/panic_carrier.mdl"}
ENT.StartHealth = 90
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 15
ENT.AnimTbl_MeleeAttack = {"vjges_attack1","vjges_attack2","vjges_attack3"}
ENT.TimeUntilMeleeAttackDamage = 0.4
ENT.NextMeleeAttackTime = 1
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 0.5
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {")vj_zombies/panic/male/zmale_taunt1.wav",")vj_zombies/panic/male/zmale_taunt2.wav",")vj_zombies/panic/male/zmale_taunt3.wav",")vj_zombies/panic/male/zmale_taunt4.wav",")vj_zombies/panic/male/zmale_taunt5.wav",")vj_zombies/panic/male/zmale_taunt6.wav",")vj_zombies/panic/male/zmale_taunt7.wav",")vj_zombies/panic/male/zmale_taunt8.wav",")vj_zombies/panic/male/zmale_taunt9.wav",")vj_zombies/panic/male/zmale_taunt10.wav"}
ENT.SoundTbl_Alert = {")vj_zombies/panic/male/zmale_berserk-01.wav",")vj_zombies/panic/male/zmale_berserk-02.wav",")vj_zombies/panic/male/zmale_berserk-03.wav",")vj_zombies/panic/male/zmale_berserk-04.wav",")vj_zombies/panic/male/zmale_berserk-05.wav",")vj_zombies/panic/male/zmale_berserk-06.wav",")vj_zombies/panic/male/zmale_berserk-07.wav",")vj_zombies/panic/male/zmale_berserk-08.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {")vj_zombies/panic/male/zmale_attack1.wav",")vj_zombies/panic/male/zmale_attack2.wav",")vj_zombies/panic/male/zmale_attack3.wav",")vj_zombies/panic/male/zmale_attack4.wav",")vj_zombies/panic/male/zmale_attack5.wav",")vj_zombies/panic/male/zmale_attack6.wav",")vj_zombies/panic/male/zmale_attack7.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav","vj_zombies/slow/miss2.wav","vj_zombies/slow/miss3.wav","vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_Pain = {")vj_zombies/panic/male/zmale_pain1.wav",")vj_zombies/panic/male/zmale_pain2.wav",")vj_zombies/panic/male/zmale_pain3.wav",")vj_zombies/panic/male/zmale_pain4.wav",")vj_zombies/panic/male/zmale_pain5.wav",")vj_zombies/panic/male/zmale_pain6.wav"}
ENT.SoundTbl_Death = {")vj_zombies/panic/male/zmale_death1.wav",")vj_zombies/panic/male/zmale_death2.wav",")vj_zombies/panic/male/zmale_death3.wav",")vj_zombies/panic/male/zmale_death4.wav",")vj_zombies/panic/male/zmale_death5.wav",")vj_zombies/panic/male/zmale_death6.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:SetSkin(math.random(0,1))
end
