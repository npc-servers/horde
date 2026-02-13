AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/zombie/zm_fast.mdl"
ENT.StartHealth = 50

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"

ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = "vjseq_melee"
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 85
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 1

ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	")zsszombie/foot1.wav",
	")zsszombie/foot2.wav",
	")zsszombie/foot3.wav",
	")zsszombie/foot4.wav"
}
ENT.SoundTbl_Idle = {
	")vfastzombie/fzombie_idle1.wav",
	")vfastzombie/fzombie_idle2.wav",
	")vfastzombie/fzombie_idle3.wav",
	")vfastzombie/fzombie_idle4.wav",
	")vfastzombie/fzombie_idle5.wav"
}
ENT.SoundTbl_Alert = {
	"vfastzombie/fzombie_alert1.wav",
	"vfastzombie/fzombie_alert2.wav",
	"vfastzombie/fzombie_alert3.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vfastzombie/attack1.wav",
	"vfastzombie/attack2.wav",
	"vfastzombie/attack3.wav"
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
ENT.SoundTbl_Pain = {
	"vfastzombie/fzombie_pain1.wav",
	"vfastzombie/fzombie_pain2.wav",
	"vfastzombie/fzombie_pain3.wav"
}
ENT.SoundTbl_Death = {
	"vfastzombie/fzombie_die1.wav",
	"vfastzombie/fzombie_die2.wav"
}

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetSkin( math.random( 0, 3 ) )
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