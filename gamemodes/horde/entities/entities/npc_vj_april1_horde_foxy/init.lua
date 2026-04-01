AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/horde/april_fooling/withered_foxy.mdl"
ENT.StartHealth = 50
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = "vjseq_melee"
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 85
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 1

ENT.HasLeapAttack = false
ENT.LeapAttackDamage = 40
ENT.AnimTbl_LeapAttack = ACT_JUMP
ENT.LeapAttackExtraTimers = { 0.2, 0.4, 0.6, 0.8, 1 }
ENT.TimeUntilLeapAttackVelocity = 0.2
ENT.LeapDistance = 300
ENT.LeapAttackVelocityForward = 250
ENT.LeapAttackVelocityUp = 200
ENT.NextLeapAttackTime = 10

ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	"player/footsteps/duct1.wav",
	"player/footsteps/duct2.wav",
	"player/footsteps/duct3.wav",
	"player/footsteps/duct4.wav"
}
ENT.SoundTbl_Breath = ")horde/april_fooling/fnaf2/With_S2.wav"
ENT.SoundTbl_Alert = ")horde/april_fooling/fnaf2/Robot.wav"
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
ENT.SoundTbl_LeapAttackJump = ")horde/april_fooling/fnaf2/Xscream3.wav"
ENT.SoundTbl_LeapAttackDamage = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"
}
ENT.SoundTbl_Pain = {
	"npc/scanner/scanner_pain1.wav",
	"npc/scanner/scanner_pain2.wav"
}
ENT.SoundTbl_Death = "npc/scanner/scanner_explode_crash2.wav"

ENT.BreathSoundLevel = 90

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup( 16, 1 )
	timer.Simple( 5, function()
		if IsValid( self ) then
			self.HasLeapAttack = true
		end
	end )
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if HORDE:IsLightningDamage( dmginfo ) then
		dmginfo:ScaleDamage( 1.25 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomLeapAttackHitDetection()
	local obbmin = self:OBBMins() - Vector(20,20,2)
	local obbmax = self:OBBMaxs() + Vector(20,20,2)
	local pos = self:GetPos() + (self:GetForward() * 18)
	return ents.FindInBox(pos + obbmin, pos + obbmax)
end
