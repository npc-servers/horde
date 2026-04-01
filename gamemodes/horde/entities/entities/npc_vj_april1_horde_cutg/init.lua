AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/horde/april_fooling/ilikeyhacutg.mdl"
ENT.StartHealth = 50
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.CanDetectDangers = false

ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false

ENT.MeleeAttackDamage = 40
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 65
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 10
ENT.AnimTbl_MeleeAttack = { ACT_MELEE_ATTACK1, ACT_RANGE_ATTACK1 }

ENT.FootStepTimeRun = 0.05
ENT.FootStepTimeWalk = 0.5

ENT.IdleSounds_PlayOnAttacks = true
ENT.OnlyDoKillEnemyWhenClear = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = ")horde/april_fooling/ilikeyhacutg/g_step.wav"
ENT.SoundTbl_Idle = ")horde/april_fooling/ilikeyhacutg/oh-you-playin-minecraf.wav"
ENT.SoundTbl_IdleCombat = ")horde/april_fooling/ilikeyhacutg/oh-you-playin-minecraf.wav"
ENT.SoundTbl_Alert = ")horde/april_fooling/ilikeyhacutg/oh-you-playin-minecraf.wav"
ENT.SoundTbl_BeforeMeleeAttack = ")horde/april_fooling/ilikeyhacutg/i-like-ya-cut-g.wav"
ENT.SoundTbl_Death = ")horde/april_fooling/ilikeyhacutg/death_01.wav"

ENT.BeforeMeleeAttackSoundLevel = 120
ENT.ExtraMeleeAttackSoundLevel = 120
ENT.DeathSoundLevel = 120
ENT.CombatIdleSoundPitch1 = 90
ENT.CombatIdleSoundPitch2 = 105
ENT.AlertSoundPitch1 = 90
ENT.AlertSoundPitch2 = 105
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput( key )
	if key == "melee" then
		self:MeleeAttackCode()
	end
	if key == "range" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	self:VJ_ACT_PLAYACTIVITY( ACT_IDLE_ANGRY, true, false, true )
	VJ_EmitSound( self, ")horde/april_fooling/ilikeyhacutg/oh-you-playin-minecraf-noclip.wav", 140 )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks( ent )
	VJ_CreateSound( ent, ")horde/april_fooling/ilikeyhacutg/dong.wav", 90 )
	VJ_CreateSound( ent, ")horde/april_fooling/ilikeyhacutg/smack_" .. math.random( 1, 3 ) .. ".wav", 90 )
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "I Like Yha Cut G", "npc_vj_april1_horde_cutg", "Zombies" )