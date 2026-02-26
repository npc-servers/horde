AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.StartHealth = 80
ENT.Model = {
	"models/zombie/zclassic_01.mdl",
	"models/zombie/zclassic_02.mdl",
	"models/zombie/zclassic_03.mdl",
	"models/zombie/zclassic_04.mdl",
	"models/zombie/zclassic_05.mdl",
	"models/zombie/zclassic_07.mdl",
	"models/zombie/zclassic_08.mdl",
	"models/zombie/zclassic_09.mdl",
	"models/zombie/zclassic_10.mdl",
	"models/zombie/zclassic_11.mdl",
	"models/zombie/zclassic_12.mdl",
	"models/zombie/classic.mdl"
}

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"
ENT.CanFlinch = 1

ENT.MeleeAttackDamage = 25
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 65
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 2
ENT.AnimTbl_MeleeAttack = {
	"vjseq_attacka",
	"vjseq_attackb",
	"vjseq_attackc",
	"vjseq_attackd",
	"vjseq_attacke",
	"vjseq_attackf"
}

ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	")zsszombie/foot1.ogg",
	")zsszombie/foot2.ogg",
	")zsszombie/foot3.ogg",
	")zsszombie/foot4.wav"
}
ENT.SoundTbl_Idle = {
	")zsszombie/zombie_idle1.wav",
	")zsszombie/zombie_idle2.wav",
	")zsszombie/zombie_idle3.wav",
	")zsszombie/zombie_idle4.wav",
	")zsszombie/zombie_idle5.wav",
	")zsszombie/zombie_idle6.wav"
}
ENT.SoundTbl_Alert = {
	")zsszombie/zombie_alert1.ogg",
	")zsszombie/zombie_alert2.ogg",
	")zsszombie/zombie_alert3.ogg",
	")zsszombie/zombie_alert4.wav"
}
ENT.SoundTbl_MeleeAttack = {
	")zsszombie/zombie_attack_1.wav",
	")zsszombie/zombie_attack_2.wav",
	")zsszombie/zombie_attack_3.wav",
	")zsszombie/zombie_attack_4.wav",
	")zsszombie/zombie_attack_5.wav",
	")zsszombie/zombie_attack_6.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	")zsszombie/miss1.wav",
	")zsszombie/miss2.wav",
	")zsszombie/miss3.wav",
	")zsszombie/miss4.wav"
}
ENT.SoundTbl_Pain = {
	")zsszombie/zombie_pain1.ogg",
	")zsszombie/zombie_pain2.ogg",
	")zsszombie/zombie_pain3.ogg",
	")zsszombie/zombie_pain4.ogg",
	")zsszombie/zombie_pain5.ogg",
	")zsszombie/zombie_pain6.ogg",
	")zsszombie/zombie_pain7.wav",
	")zsszombie/zombie_pain8.wav"
}
ENT.SoundTbl_Death = {
	")zsszombie/zombie_die1.ogg",
	")zsszombie/zombie_die2.ogg",
	")zsszombie/zombie_die3.ogg",
	")zsszombie/zombie_die4.wav",
	")zsszombie/zombie_die5.wav",
	")zsszombie/zombie_die6.wav"
}

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100

local sdFootScuff = {
	"npc/zombie/foot_slide1.ogg",
	"npc/zombie/foot_slide2.ogg",
	"npc/zombie/foot_slide3.ogg"
}
local sdClassic_Idle = {
	"npc/zombie/zombie_voice_idle1.ogg",
	"npc/zombie/zombie_voice_idle2.ogg",
	"npc/zombie/zombie_voice_idle3.ogg",
	"npc/zombie/zombie_voice_idle4.ogg",
	"npc/zombie/zombie_voice_idle5.ogg",
	"npc/zombie/zombie_voice_idle6.ogg",
	"npc/zombie/zombie_voice_idle7.ogg",
	"npc/zombie/zombie_voice_idle8.ogg",
	"npc/zombie/zombie_voice_idle9.wav",
	"npc/zombie/zombie_voice_idle10.ogg",
	"npc/zombie/zombie_voice_idle11.ogg",
	"npc/zombie/zombie_voice_idle12.ogg",
	"npc/zombie/zombie_voice_idle13.ogg",
	"npc/zombie/zombie_voice_idle14.ogg"
}
local sdClassic_Alert = {
	"npc/zombie/zombie_alert1.ogg",
	"npc/zombie/zombie_alert2.ogg",
	"npc/zombie/zombie_alert3.ogg"
}
local sdClassic_BeforeMeleeAttack = {
	"npc/zombie/zo_attack1.ogg",
	"npc/zombie/zo_attack2.ogg"
}
local sdClassic_MeleeAttack = {
	"npc/zombie/claw_strike1.ogg",
	"npc/zombie/claw_strike2.ogg",
	"npc/zombie/claw_strike3.ogg"
}
local sdClassic_Pain = {
	"npc/zombie/zombie_pain1.ogg",
	"npc/zombie/zombie_pain2.ogg",
	"npc/zombie/zombie_pain3.ogg",
	"npc/zombie/zombie_pain4.ogg",
	"npc/zombie/zombie_pain5.ogg",
	"npc/zombie/zombie_pain6.ogg"
}
local sdClassic_Death = {
	"npc/zombie/zombie_die1.ogg",
	"npc/zombie/zombie_die2.ogg",
	"npc/zombie/zombie_die3.ogg"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	local myModel = self:GetModel()

	if myModel == "models/zombie/classic.mdl" then
		self:SetBodygroup( 1, 1 )

		self.SoundTbl_Idle = sdClassic_Idle
		self.SoundTbl_Alert = sdClassic_Alert
		self.SoundTbl_BeforeMeleeAttack = sdClassic_BeforeMeleeAttack
		self.SoundTbl_MeleeAttack = sdClassic_MeleeAttack
		self.SoundTbl_Pain = sdClassic_Pain
		self.SoundTbl_Death = sdClassic_Death
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local entMeta = FindMetaTable( "Entity" )
local entIsOnFire = entMeta.IsOnFire
local actFireIdle = ACT_IDLE_ON_FIRE
local actFireWalk = ACT_WALK_ON_FIRE
local actIdle = ACT_IDLE
local actWalk = ACT_WALK
--
function ENT:CustomOnThink()
	if entIsOnFire( self ) then
		self.AnimTbl_IdleStand = { actFireIdle }
		self.AnimTbl_Run = actFireWalk
		self.AnimTbl_Walk = actFireWalk
	else
		self.AnimTbl_IdleStand = { actIdle }
		self.AnimTbl_Run = actWalk
		self.AnimTbl_Walk = actWalk
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:CustomOnHandleAnimEvent( ev )
	local eventName = getEventName( ev )

	if eventName == "AE_ZOMBIE_STEP_LEFT" or eventName == "AE_ZOMBIE_STEP_RIGHT" then
		self:FootStepSoundCode()
	elseif eventName == "AE_ZOMBIE_SCUFF_LEFT" or eventName == "AE_ZOMBIE_SCUFF_RIGHT" then
		self:FootStepSoundCode( sdFootScuff )
	elseif eventName == "AE_ZOMBIE_ATTACK_LEFT" or eventName == "AE_ZOMBIE_ATTACK_RIGHT" or eventName == "AE_ZOMBIE_ATTACK_BOTH" then
		self:MeleeAttackCode()
	end
end