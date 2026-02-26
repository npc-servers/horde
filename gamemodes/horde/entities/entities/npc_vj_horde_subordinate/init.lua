AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/zombie/classic_gal_boss_mini2.mdl"
ENT.StartHealth = 250

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
ENT.SoundTbl_MeleeAttack = {
	"npc/zombie/claw_strike1.ogg",
	"npc/zombie/claw_strike2.ogg",
	"npc/zombie/claw_strike3.ogg"
}
ENT.SoundTbl_MeleeAttackMiss = {
	")zsszombie/miss1.wav",
	")zsszombie/miss2.wav",
	")zsszombie/miss3.wav",
	")zsszombie/miss4.wav"
}

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100

local sdFootScuff = {
	"npc/zombie/foot_slide1.ogg",
	"npc/zombie/foot_slide2.ogg",
	"npc/zombie/foot_slide3.ogg"
}
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if not HORDE:IsPhysicalDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.5 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Subordinate", "npc_vj_horde_subordinate", "Zombies" )