AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/blacktea/zpszombie1.mdl","models/blacktea/zpszombie2.mdl","models/blacktea/zpszombie3.mdl","models/blacktea/zpszombie5.mdl"}
ENT.StartHealth = 90
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.AnimTbl_MeleeAttack = {"vjseq_weapon_attack1","vjseq_weapon_attack2"}
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 60
ENT.MeleeAttackDamage = 15
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 0.5
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {")zsszombie/zombie_idle1.wav",")zsszombie/zombie_idle2.wav",")zsszombie/zombie_idle3.wav",")zsszombie/zombie_idle4.wav",")zsszombie/zombie_idle5.wav","zsszombie/zombie_idle6.wav"}
ENT.SoundTbl_Alert = {")zsszombie/zombie_alert1.wav",")zsszombie/zombie_alert2.wav","zsszombie/zombie_alert3.wav","zsszombie/zombie_alert4.wav"}
ENT.SoundTbl_MeleeAttack = {"zsszombie/zombie_attack_1.wav","zsszombie/zombie_attack_2.wav",")zsszombie/zombie_attack_3.wav","zsszombie/zombie_attack_4.wav","zsszombie/zombie_attack_5.wav","zsszombie/zombie_attack_6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"zsszombie/zombie_pain1.wav","zsszombie/zombie_pain2.wav","zsszombie/zombie_pain3.wav","zsszombie/zombie_pain4.wav","zsszombie/zombie_pain5.wav","zsszombie/zombie_pain6.wav","zsszombie/zombie_pain7.wav","zsszombie/zombie_pain8.wav"}
ENT.SoundTbl_Death = {"zsszombie/zombie_die1.wav",")zsszombie/zombie_die2.wav","zsszombie/zombie_die3.wav",")zsszombie/zombie_die4.wav",")zsszombie/zombie_die5.wav",")zsszombie/zombie_die6.wav","common/null.wav"}

ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 60
ENT.MeleeAttackSoundPitch = VJ_Set(100, 100)

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:AddRelationship("npc_headcrab_poison D_LI 99")
end
