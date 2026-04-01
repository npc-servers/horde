AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/kleiner.mdl"
ENT.StartHealth = 100
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.CanDetectDangers = false

ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false

ENT.MeleeAttackDamage = 5
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 65
ENT.TimeUntilMeleeAttackDamage = 0.5
ENT.NextMeleeAttackTime = 2
ENT.AnimTbl_MeleeAttack = "vjseq_swing"

ENT.FootStepTimeRun = 0.4
ENT.FootStepTimeWalk = 1

ENT.IdleSounds_PlayOnAttacks = true
ENT.OnlyDoKillEnemyWhenClear = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	"npc/footsteps/hardboot_generic1.wav",
	"npc/footsteps/hardboot_generic2.wav",
	"npc/footsteps/hardboot_generic3.wav",
	"npc/footsteps/hardboot_generic4.wav",
	"npc/footsteps/hardboot_generic5.wav",
	"npc/footsteps/hardboot_generic6.wav",
	"npc/footsteps/hardboot_generic8.wav"
}
ENT.SoundTbl_Idle = "vo/k_lab/kl_fiddlesticks.wav"
ENT.SoundTbl_Alert = "vo/k_lab/kl_fiddlesticks.wav"
ENT.SoundTbl_MeleeAttack = "ambient/voices/citizen_punches2.wav"
ENT.SoundTbl_MeleeAttackMiss = {
	")zsszombie/miss1.wav",
	")zsszombie/miss2.wav",
	")zsszombie/miss3.wav",
	")zsszombie/miss4.wav"
}
ENT.SoundTbl_OnKilledEnemy = "vo/k_lab/kl_excellent.wav"
ENT.SoundTbl_AllyDeath = "vo/k_lab/kl_ohdear.wav"
ENT.SoundTbl_Death = "vo/k_lab/kl_ahhhh.wav"

ENT.IdleSoundChance = 7
ENT.AlertSoundChance = 3
ENT.AllyDeathSoundChance = 5

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if not HORDE:IsPhysicalDamage( dmginfo ) then
		dmginfo:ScaleDamage( 1.25 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "MingeBag", "npc_vj_april1_horde_minge", "Zombies" )