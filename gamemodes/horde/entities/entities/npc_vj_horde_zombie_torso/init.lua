AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/classic_torso.mdl"}
ENT.StartHealth = 60
ENT.HullType = HULL_TINY
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.BloodColor = "Red"
ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.MeleeAttackDistance = 15
ENT.MeleeAttackDamageDistance = 35
ENT.TimeUntilMeleeAttackDamage = 0.4
ENT.MeleeAttackDamage = 20
ENT.MeleeAttackBleedEnemy = true
ENT.FootStepTimeRun = 0.6
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false
ENT.HasExtraMeleeAttackSounds = true

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"npc/zombie/zombie_voice_idle1.wav","npc/zombie/zombie_voice_idle2.wav","npc/zombie/zombie_voice_idle3.wav","npc/zombie/zombie_voice_idle4.wav","npc/zombie/zombie_voice_idle5.wav","npc/zombie/zombie_voice_idle6.wav"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/zombie/zo_attack1.wav","npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_pain1.wav","npc/zombie/zombie_pain2.wav","npc/zombie/zombie_pain3.wav","npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self:SetCollisionBounds(Vector(20, 20 , 26), Vector(-20, -20, 0))
end