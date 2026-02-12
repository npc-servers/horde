AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = { "models/zombie/poison.mdl" }
ENT.StartHealth = 500

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"
ENT.CanFlinch = 1

ENT.MeleeAttackDamage = 40
ENT.AnimTbl_MeleeAttack = { "vjseq_melee_01", "vjseq_melee_03" }
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 85
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 2

ENT.HasRangeAttack = true
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_pzombie_projectile"
ENT.AnimTbl_RangeAttack = { "vjseq_throw" }
ENT.RangeDistance = 800
ENT.RangeToMeleeDistance = 250
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = 10
ENT.RangeAttackPos_Up = 40

ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = { "npc/zombie_poison/pz_left_foot1.wav" }
ENT.SoundTbl_Idle = {
	"npc/zombie_poison/pz_idle2.wav",
	"npc/zombie_poison/pz_idle3.wav",
	"npc/zombie_poison/pz_idle3.wav"
}
ENT.SoundTbl_Alert = {
	"npc/zombie_poison/pz_alert1.wav",
	"npc/zombie_poison/pz_alert2.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"npc/zombie_poison/pz_warn1.wav",
	"npc/zombie_poison/pz_warn2.wav"
}
ENT.SoundTbl_MeleeAttack = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"zsszombie/miss1.wav",
	"zsszombie/miss2.wav",
	"zsszombie/miss3.wav",
	"zsszombie/miss4.wav"
}
ENT.SoundTbl_BeforeRangeAttack = {
	"npc/zombie_poison/pz_warn1.wav",
	"npc/zombie_poison/pz_warn2.wav"
}
ENT.SoundTbl_RangeAttack = { "npc/antlion_grub/squashed.wav" }
ENT.SoundTbl_Pain = {
	"npc/zombie_poison/pz_pain1.wav",
	"npc/zombie_poison/pz_pain2.wav",
	"npc/zombie_poison/pz_pain3.wav"
}
ENT.SoundTbl_Death = {
	"npc/zombie_poison/pz_die1.wav",
	"npc/zombie_poison/pz_die2.wav"
}

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100

local sdFootScuff = { "npc/zombie_poison/pz_right_foot1.wav" }
local sdThrow = { "npc/zombie_poison/pz_throw2.wav", "npc/zombie_poison/pz_throw3.wav" }
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup( 1, 1 )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.AnimTbl_Walk = { VJ_SequenceToActivity( self, "firewalk" ) }
		self.AnimTbl_Run = { VJ_SequenceToActivity( self, "firewalk" ) }
	else
		self.AnimTbl_Walk = { ACT_WALK }
		self.AnimTbl_Run = { ACT_WALK }
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:CustomOnHandleAnimEvent( ev, evTime, evCycle, evType, evOptions )
	local eventName = getEventName( ev )
	if eventName == "AE_ZOMBIE_STEP_LEFT" then
		self:FootStepSoundCode()
	elseif eventName == "AE_ZOMBIE_STEP_RIGHT" then
		self:FootStepSoundCode( sdFootScuff )
	elseif eventName == "AE_ZOMBIE_ATTACK_LEFT" or eventName == "AE_ZOMBIE_ATTACK_RIGHT" or eventName == "AE_ZOMBIE_ATTACK_BOTH" then
		self:MeleeAttackCode()
	elseif eventName == "AE_ZOMBIE_POISON_THROW_SOUND" then
		self:PlaySoundSystem( "GeneralSpeech", sdThrow )
	elseif eventName == "AE_ZOMBIE_POISON_THROW_CRAB" then
		self:RangeAttackCode()
	end
end