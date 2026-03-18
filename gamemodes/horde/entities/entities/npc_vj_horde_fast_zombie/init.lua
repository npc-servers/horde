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
ENT.MeleeAttackDamageDistance = 50
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = 1.5

ENT.HasLeapAttack = false
ENT.LeapAttackDamage = 13
ENT.AnimTbl_LeapAttack = ACT_JUMP
ENT.LeapAttackExtraTimers = { 0.2, 0.4, 0.6, 0.8, 1 }
ENT.TimeUntilLeapAttackVelocity = 0.2
ENT.LeapDistance = 300
ENT.LeapAttackVelocityForward = 250
ENT.LeapAttackVelocityUp = 200
ENT.NextLeapAttackTime = 3
ENT.DisableFootStepSoundTimer = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	")zsszombie/foot1.wav",
	")zsszombie/foot2.wav",
	")zsszombie/foot3.wav",
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
ENT.SoundTbl_LeapAttackJump = {
	"npc/fast_zombie/fz_scream1.wav",
	"npc/fast_zombie/leap1.wav"
}
ENT.SoundTbl_LeapAttackDamage = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav"
}
ENT.SoundTbl_Pain = "npc/fast_zombie/fz_frenzy1.wav"
ENT.SoundTbl_Death = "npc/fast_zombie/wake1.wav"

ENT.FootStepSoundLevel = 65

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup( 1, 1 )
	self.LeapAttackGrace = true
	self.TimeSinceSpawn = CurTime()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if (self.TimeSinceSpawn + 3) <= CurTime() and self.LeapAttackGrace then
		self.HasLeapAttack = true
		self.LeapAttackGrace = false
	end
end

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

local finishAttack = {
	[VJ_ATTACK_MELEE] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_melee_finished" .. self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Melee, self.NextAnyAttackTime_Melee_DoRand, self.TimeUntilMeleeAttackDamage, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_melee_finished_abletomelee" .. self:EntIndex(), self:DecideAttackTimer(self.NextMeleeAttackTime, self.NextMeleeAttackTime_DoRand), 1, function()
			self.IsAbleToMeleeAttack = true
		end)
	end,
	[VJ_ATTACK_RANGE] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_range_finished" .. self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Range, self.NextAnyAttackTime_Range_DoRand, self.TimeUntilRangeAttackProjectileRelease, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_range_finished_abletorange" .. self:EntIndex(), self:DecideAttackTimer(self.NextRangeAttackTime, self.NextRangeAttackTime_DoRand), 1, function()
			self.IsAbleToRangeAttack = true
		end)
	end,
	[VJ_ATTACK_LEAP] = function(self, skipStopAttacks)
		if skipStopAttacks != true then
			timer.Create("timer_leap_finished" .. self:EntIndex(), self:DecideAttackTimer(self.NextAnyAttackTime_Leap, self.NextAnyAttackTime_Leap_DoRand, self.TimeUntilLeapAttackDamage, self.CurrentAttackAnimationDuration), 1, function()
				self:StopAttacks()
				self:DoChaseAnimation()
			end)
		end
		timer.Create("timer_leap_finished_abletoleap" .. self:EntIndex(), self:DecideAttackTimer(self.NextLeapAttackTime, self.NextLeapAttackTime_DoRand), 1, function()
			self.IsAbleToLeapAttack = true
		end)
	end
}


function ENT:LeapDamageCode()

	local IsProp = VJ_IsProp
	local obbmin = self:OBBMins() - Vector(20,20,2)
	local obbmax = self:OBBMaxs() + Vector(20,20,2)
	local pos = self:GetPos() + (self:GetForward() * 16)

	if self.Dead or self.vACT_StopAttacks == true or self.Flinching == true or (self.StopLeapAttackAfterFirstHit && self.AttackStatus == VJ_ATTACK_STATUS_EXECUTED_HIT) then return end
	self:CustomOnLeapAttack_BeforeChecks()
	local hitRegistered = false
	for _,v in ipairs(ents.FindInBox(pos + obbmin, pos + obbmax)) do--(ents.FindInSphere(self:GetPos(), self.LeapAttackDamageDistance)) do
		if (self.VJ_IsBeingControlled && self.VJ_TheControllerBullseye == v) or (v:IsPlayer() && v.IsControlingNPC == true) then continue end
		if (v:IsNPC() or (v:IsPlayer() && v:Alive()) && !VJ_CVAR_IGNOREPLAYERS) && (self:Disposition(v) != D_LI) && (v != self) && (v:GetClass() != self:GetClass()) or IsProp(v) == true or v:GetClass() == "func_breakable_surf" or v:GetClass() == "func_breakable" then
			self:CustomOnLeapAttack_AfterChecks(v)
			-- Damage
			if self.DisableDefaultLeapAttackDamageCode == false then
				local leapdmg = DamageInfo()
				leapdmg:SetDamage(self:VJ_GetDifficultyValue(self.LeapAttackDamage))
				leapdmg:SetInflictor(self)
				leapdmg:SetDamageType(self.LeapAttackDamageType)
				leapdmg:SetAttacker(self)
				if v:IsNPC() or v:IsPlayer() then leapdmg:SetDamageForce(self:GetForward() * ((leapdmg:GetDamage() + 100) * 70)) end
				v:TakeDamageInfo(leapdmg, self)
			end
			if v:IsPlayer() then
				v:ViewPunch(Angle(math.random(-1,1 ) * self.LeapAttackDamage, math.random(-1, 1) * self.LeapAttackDamage,math.random(-1, 1) * self.LeapAttackDamage))
			end
			hitRegistered = true
		end
	end
	if self.AttackStatus < VJ_ATTACK_STATUS_EXECUTED then
		self.AttackStatus = VJ_ATTACK_STATUS_EXECUTED
		if self.TimeUntilLeapAttackDamage != false then
			finishAttack[VJ_ATTACK_LEAP](self)
		end
	end
	if hitRegistered == true then
		self:PlaySoundSystem("LeapAttackDamage")
		self.AttackStatus = VJ_ATTACK_STATUS_EXECUTED_HIT
	else
		self:CustomOnLeapAttack_Miss()
		self:PlaySoundSystem("LeapAttackDamageMiss", nil, VJ_EmitSound)
	end
end
