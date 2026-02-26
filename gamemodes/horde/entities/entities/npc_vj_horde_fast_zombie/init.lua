AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/zombie/fast.mdl"
ENT.StartHealth = 40

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"

ENT.MeleeAttackDamage = 15
ENT.AnimTbl_MeleeAttack = "vjseq_br2_attack"
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 85
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 1.5

ENT.HasLeapAttack = true
ENT.AnimTbl_LeapAttack = ACT_JUMP
ENT.LeapAttackExtraTimers = { 0.2, 0.4, 0.6, 0.8, 1 }
ENT.TimeUntilLeapAttackVelocity = 0.2
ENT.LeapDistance = 300
ENT.LeapAttackVelocityForward = 250
ENT.LeapAttackVelocityUp = 200

ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	")zsszombie/foot1.ogg",
	")zsszombie/foot2.ogg",
	")zsszombie/foot3.ogg",
	")zsszombie/foot4.wav"
}
ENT.SoundTbl_Idle = {
	"npc/fast_zombie/idle1.wav",
	"npc/fast_zombie/idle2.wav",
	"npc/fast_zombie/idle3.wav"
}
ENT.SoundTbl_Alert = "npc/fast_zombie/fz_alert_close1.wav"
ENT.SoundTbl_BeforeMeleeAttack = "npc/fast_zombie/leap1.wav"
ENT.SoundTbl_MeleeAttack = {
	"npc/zombie/claw_strike1.ogg",
	"npc/zombie/claw_strike2.ogg",
	"npc/zombie/claw_strike3.ogg"
}
ENT.SoundTbl_MeleeAttackMiss = {
	"zsszombie/miss1.wav",
	"zsszombie/miss2.wav",
	"zsszombie/miss3.wav",
	"zsszombie/miss4.wav"
}
ENT.SoundTbl_LeapAttackJump = {
	"npc/fast_zombie/fz_scream1.wav",
	"npc/fast_zombie/leap1.wav"
}
ENT.SoundTbl_LeapAttackDamage = {
	"npc/zombie/claw_strike1.ogg",
	"npc/zombie/claw_strike2.ogg",
	"npc/zombie/claw_strike3.ogg"
}
ENT.SoundTbl_Pain = "npc/fast_zombie/fz_frenzy1.wav"
ENT.SoundTbl_Death = "npc/fast_zombie/wake1.wav"

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup( 1, 1 )
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:CustomOnHandleAnimEvent( ev )
	local eventName = getEventName( ev )

	if eventName == "AE_FASTZOMBIE_GALLOP_LEFT" or eventName == "AE_FASTZOMBIE_GALLOP_RIGHT" then
		self:FootStepSoundCode()
	elseif eventName == "AE_ZOMBIE_ATTACK_LEFT" or eventName == "AE_ZOMBIE_ATTACK_RIGHT" then
		self:MeleeAttackCode()
	end
end