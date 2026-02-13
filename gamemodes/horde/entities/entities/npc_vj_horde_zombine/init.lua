AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/zombie/zombie_soldier.mdl"
ENT.StartHealth = 200

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"
ENT.CanFlinch = 1

ENT.MeleeAttackDamage = 20
ENT.MeleeAttackDistance = 30
ENT.MeleeAttackDamageDistance = 70
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 1.5

ENT.HasRangeAttack = false
ENT.AnimTbl_RangeAttack = { "vjseq_pullgrenade" }
ENT.NextRangeAttackTime = 10
ENT.RangeDistance = 256
ENT.RangeToMeleeDistance = 0
ENT.DisableDefaultRangeAttackCode = true

ENT.DisableFootStepSoundTimer = true

ENT.Zombine_Max_Grenades = 1
ENT.Zombine_Grenades_Pulled = 0
ENT.Zombine_Charging = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	"npc/zombine/gear1.wav",
	"npc/zombine/gear2.wav",
	"npc/zombine/gear3.wav"
}
ENT.SoundTbl_Idle = {
	"npc/zombine/zombine_idle1.wav",
	"npc/zombine/zombine_idle2.wav",
	"npc/zombine/zombine_idle3.wav",
	"npc/zombine/zombine_idle4.wav"
}
ENT.SoundTbl_Alert = {
	"npc/zombine/zombine_alert1.wav",
	"npc/zombine/zombine_alert2.wav",
	"npc/zombine/zombine_alert3.wav",
	"npc/zombine/zombine_alert4.wav",
	"npc/zombine/zombine_alert5.wav",
	"npc/zombine/zombine_alert6.wav",
	"npc/zombine/zombine_alert7.wav"
}
ENT.SoundTbl_MeleeAttack = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"
}
ENT.SoundTbl_MeleeAttackMiss = {
	")zsszombie/miss1.wav",
	")zsszombie/miss2.wav",
	")zsszombie/miss3.wav",
	")zsszombie/miss4.wav"
}
ENT.SoundTbl_BeforeRangeAttack = {
	"npc/zombine/zombine_readygrenade1.wav",
	"npc/zombine/zombine_readygrenade2.wav"
}
ENT.SoundTbl_Pain = {
	"npc/zombine/zombine_pain1.wav",
	"npc/zombine/zombine_pain2.wav",
	"npc/zombine/zombine_pain3.wav",
	"npc/zombine/zombine_pain4.wav"
}
ENT.SoundTbl_Death = {
	"npc/zombine/zombine_die1.wav",
	"npc/zombine/zombine_die2.wav"
}

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100

local sdCharge = { "npc/zombine/zombine_charge1.wav", "npc/zombine/zombine_charge2.wav" }
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup( 1, 1 )
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sequenceToActivity = VJ_SequenceToActivity
local actIdle = ACT_IDLE
local actRun = ACT_RUN
local actWalk = ACT_WALK
--
function ENT:CustomOnThink()
	if self:Health() < self:GetMaxHealth() / 2 and not self.Zombine_Charging then
		self.Zombine_Charging = true
		self:PlaySoundSystem( "GeneralSpeech", sdCharge )
	elseif self:Health() >= self:GetMaxHealth() / 2 and self.Zombine_Charging then
		self.Zombine_Charging = false
	end

	if IsValid( self.Grenade ) then
		local grenadeIdle = "idle_grenade"
		local grenadeIdleAnim = sequenceToActivity( self, grenadeIdle )
		local grenadeRun = "run_all_grenade"
		local grenadeRunAnim = sequenceToActivity( self, grenadeRun )
		local grenadeWalk = "walk_all_grenade"
		local grenadeWalkAnim = sequenceToActivity( self, grenadeWalk )

		self.AnimTbl_IdleStand = { grenadeIdleAnim }
		self.AnimTbl_Run = { self.Zombine_Charging and grenadeRunAnim or grenadeWalkAnim }
		self.AnimTbl_Walk = { self.Zombine_Charging and grenadeRunAnim or grenadeWalkAnim }
	else
		self.AnimTbl_IdleStand = { actIdle }
		self.AnimTbl_Run = { self.Zombine_Charging and actRun or actWalk }
		self.AnimTbl_Walk = { self.Zombine_Charging and actRun or actWalk }
	end

	self.HasRangeAttack = self.Zombine_Grenades_Pulled < self.Zombine_Max_Grenades and self:Health() < self:GetMaxHealth() / 4
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:CustomOnHandleAnimEvent( ev )
	local eventName = getEventName( ev )
	if eventName == "AE_ZOMBIE_STEP_LEFT" or eventName == "AE_ZOMBIE_STEP_RIGHT" then
		self:FootStepSoundCode()
	elseif eventName == "AE_ZOMBIE_ATTACK_LEFT" or eventName == "AE_ZOMBIE_ATTACK_RIGHT" or eventName == "AE_ZOMBIE_ATTACK_BOTH" then
		self:MeleeAttackCode()
	elseif eventName == "AE_ZOMBINE_PULLPIN" then
		self:ZombineGrenadeCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if IsValid( self.Grenade ) or self.Zombine_Charging then
		self.AnimTbl_MeleeAttack = { "vjseq_fastattack" }
	else
		self.AnimTbl_MeleeAttack = { "vjseq_attacka", "vjseq_attackb", "vjseq_attackc", "vjseq_attackd", "vjseq_attacke", "vjseq_attackf" }
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ZombineGrenadeCode()
	if not IsValid( self ) then return end

	self.Zombine_Grenades_Pulled = self.Zombine_Grenades_Pulled + 1

	self.Grenade = ents.Create( "npc_grenade_frag" )
	self.Grenade:SetOwner( self )
	self.Grenade:SetParent( self )
	self.Grenade:Fire( "SetParentAttachment", "grenade_attachment", 0 )
	self.Grenade:Spawn()
	self.Grenade:Activate()
	self.Grenade:Input( "SetTimer", self:GetOwner(), self:GetOwner(), 3 )
	self.Grenade.VJ_IsPickedUpDanger = true
end