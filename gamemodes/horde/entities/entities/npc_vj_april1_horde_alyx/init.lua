AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/alyx.mdl"
ENT.StartHealth = 150
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.CanDetectDangers = false

ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false

ENT.Weapon_FiringDistanceFar = 750
ENT.DropWeaponOnDeath = false
ENT.DropWeaponOnDeath = false
ENT.WeaponReload_FindCover = false
ENT.WaitForEnemyToComeOut = false

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
	"vo/citadel/al_comeon.wav",
	"vo/novaprospekt/al_sealdoor02.wav"
}
ENT.SoundTbl_IdleDialogue = "vo/novaprospekt/al_notexactly.wav"
ENT.SoundTbl_IdleDialogueAnswer = {
	"vo/eli_lab/al_blamingme.wav",
	"vo/k_lab2/al_whatdoyoumean.wav",
	"vo/novaprospekt/al_betyoudid01.wav"
}
ENT.SoundTbl_Alert = {
	"vo/npc/alyx/watchout01.wav",
	"vo/npc/alyx/watchout02.wav",
	"vo/novaprospekt/al_uhoh_np.wav"
}
ENT.SoundTbl_MeleeAttack = "ambient/voices/citizen_punches2.wav"
ENT.SoundTbl_MeleeAttackMiss = {
	")zsszombie/miss1.wav",
	")zsszombie/miss2.wav",
	")zsszombie/miss3.wav",
	")zsszombie/miss4.wav"
}
ENT.SoundTbl_OnKilledEnemy = {
	"vo/npc/alyx/brutal02.wav",
	"vo/citadel/al_yes_nr.wav",
	"vo/eli_lab/al_awesome.wav",
	"vo/eli_lab/al_laugh01.wav",
	"vo/eli_lab/al_laugh02.wav",
	"vo/eli_lab/al_sweet.wav",
	"vo/eli_lab/al_gooddoggie.wav",
	"vo/k_lab2/al_whee_b.wav"
}
ENT.SoundTbl_AllyDeath = {
	"vo/npc/alyx/no01.wav",
	"vo/npc/alyx/no02.wav",
	"vo/npc/alyx/no03.wav",
	"vo/npc/alyx/ohgod01.wav",
	"vo/npc/alyx/ohno_startle01.wav",
	"vo/npc/alyx/ohno_startle03.wav"
}
ENT.SoundTbl_Pain = {
	"vo/npc/alyx/hurt04.wav",
	"vo/npc/alyx/hurt05.wav",
	"vo/npc/alyx/hurt06.wav",
	"vo/npc/alyx/hurt08.wav"
}
ENT.SoundTbl_Death = {
	"vo/npc/alyx/ohno_startle03.wav",
	"vo/npc/alyx/uggh01.wav",
	"vo/npc/alyx/uggh02.wav"
}

ENT.IdleSoundChance = 7
ENT.AlertSoundChance = 3
ENT.AllyDeathSoundChance = 5

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:Give( "weapon_vj_april1_horde_alyxgun" )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if HORDE:IsLightningDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.5 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Alyx", "npc_vj_april1_horde_alyx", "Zombies" )