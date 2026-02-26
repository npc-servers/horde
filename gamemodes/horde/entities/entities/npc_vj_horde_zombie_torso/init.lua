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

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.ogg","npc/zombie/foot2.ogg","npc/zombie/foot3.ogg"}
ENT.SoundTbl_Idle = {"npc/zombie/zombie_voice_idle1.ogg","npc/zombie/zombie_voice_idle2.ogg","npc/zombie/zombie_voice_idle3.ogg","npc/zombie/zombie_voice_idle4.ogg","npc/zombie/zombie_voice_idle5.ogg","npc/zombie/zombie_voice_idle6.ogg"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.ogg","npc/zombie/zombie_alert2.ogg","npc/zombie/zombie_alert3.ogg"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/zombie/zo_attack1.ogg","npc/zombie/zo_attack2.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.ogg","npc/zombie/claw_strike2.ogg","npc/zombie/claw_strike3.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_pain1.ogg","npc/zombie/zombie_pain2.ogg","npc/zombie/zombie_pain3.ogg","npc/zombie/zombie_pain4.ogg","npc/zombie/zombie_pain5.ogg","npc/zombie/zombie_pain6.ogg"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die1.ogg","npc/zombie/zombie_die2.ogg","npc/zombie/zombie_die3.ogg"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self:SetCollisionBounds(Vector(20, 20 , 26), Vector(-20, -20, 0))
end