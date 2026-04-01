AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/barney.mdl"
ENT.StartHealth = 200
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.CanDetectDangers = false

ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false

ENT.Weapon_FiringDistanceFar = 1200
ENT.DropWeaponOnDeath = false
ENT.WeaponReload_FindCover = false
ENT.WaitForEnemyToComeOut = false
ENT.CanUseSecondaryOnWeaponAttack = false

ENT.FootStepTimeRun = 0.4
ENT.FootStepTimeWalk = 1

ENT.IdleSounds_PlayOnAttacks = true
ENT.OnlyDoKillEnemyWhenClear = false

ENT.HasItemDropsOnDeath = false
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
ENT.SoundTbl_Idle = {
	"vo/npc/barney/ba_bringiton.wav",
	"vo/npc/barney/ba_goingdown.wav",
	"vo/npc/barney/ba_yell.wav"
}
ENT.SoundTbl_IdleDialogue = "vo/k_lab/ba_itsworking04.wav"
ENT.SoundTbl_IdleDialogueAnswer = "vo/k_lab/ba_saidlasttime.wav"
ENT.SoundTbl_Alert = {
	"vo/npc/barney/ba_heretheycome01.wav",
	"vo/npc/barney/ba_heretheycome02.wav",
	"vo/npc/barney/ba_uhohheretheycome.wav"
}
ENT.SoundTbl_MeleeAttack = "ambient/voices/citizen_punches2.wav"
ENT.SoundTbl_MeleeAttackMiss = {
	")zsszombie/miss1.wav",
	")zsszombie/miss2.wav",
	")zsszombie/miss3.wav",
	")zsszombie/miss4.wav"
}
ENT.SoundTbl_OnKilledEnemy = {
	"vo/npc/barney/ba_gotone.wav",
	"vo/npc/barney/ba_laugh01.wav",
	"vo/npc/barney/ba_laugh02.wav",
	"vo/npc/barney/ba_laugh03.wav",
	"vo/npc/barney/ba_laugh04.wav",
	"vo/npc/barney/ba_losttouch.wav",
	"vo/npc/barney/ba_ohyeah.wav",
	"vo/npc/barney/ba_yell.wav"
}
ENT.SoundTbl_AllyDeath = {
	"vo/k_lab/ba_cantlook.wav",
	"vo/k_lab/ba_guh.wav",
	"vo/npc/barney/ba_getaway.wav",
	"vo/npc/barney/ba_getdown.wav",
	"vo/npc/barney/ba_getoutofway.wav"
}
ENT.SoundTbl_Pain = {
	"vo/npc/barney/ba_pain01.wav",
	"vo/npc/barney/ba_pain02.wav",
	"vo/npc/barney/ba_pain03.wav",
	"vo/npc/barney/ba_pain04.wav",
	"vo/npc/barney/ba_pain05.wav",
	"vo/npc/barney/ba_pain06.wav",
	"vo/npc/barney/ba_pain07.wav",
	"vo/npc/barney/ba_pain08.wav",
	"vo/npc/barney/ba_pain09.wav",
	"vo/npc/barney/ba_pain10.wav"
}
ENT.SoundTbl_Death = {
	"vo/npc/barney/ba_no01.wav",
	"vo/npc/barney/ba_ohshit03.wav"
}

ENT.IdleSoundChance = 7
ENT.AlertSoundChance = 3
ENT.AllyDeathSoundChance = 5

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:Give( "weapon_vj_horde_ar2" )
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Barney Calhoun", "npc_vj_april1_horde_barney", "Zombies" )