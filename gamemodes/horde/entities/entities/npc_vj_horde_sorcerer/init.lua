AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = { "models/zombie/classic_gal_boss.mdl" }
ENT.StartHealth = 750

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"
ENT.CanFlinch = 1

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamage = 35
ENT.AnimTbl_MeleeAttack = { "vjseq_attacka", "vjseq_attackb", "vjseq_attackc", "vjseq_attackd", "vjseq_attacke", "vjseq_attackf" }
ENT.TimeUntilMeleeAttackDamage = 1

ENT.FootStepTimeRun = 0.8
ENT.FootStepTimeWalk = 0.8

ENT.NextSummonTime = 0
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
---------------------------------------------------------------------------------------------------------------------------------------------
local defAng = Angle( 0, 0, 0 )
--
function ENT:CustomOnThink()
	self.AnimTbl_IdleStand = { self:IsOnFire() and ACT_IDLE_ON_FIRE or ACT_IDLE }
	self.AnimTbl_Walk = { self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK }
	self.AnimTbl_Run = { self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK }

	local enemyDistance = self.NearestPointToEnemyDistance

	if not IsValid( self:GetEnemy() ) or enemyDistance > 1000 then return end

	if self.NextSummonTime < CurTime() then
		if not IsValid( self.MiniBoss1 ) or not IsValid( self.MiniBoss2 ) then
			VJ_EmitSound( self, "npc/zombie_poison/pz_call1.wav", 140, 100 )

			ParticleEffect( "aurora_shockwave", self:GetPos(), defAng, nil )
			ParticleEffect( "aurora_shockwave_debris", self:GetPos(), defAng, nil )

			self:VJ_ACT_PLAYACTIVITY( "vjseq_releasecrab", true, false, false )

			if not IsValid( self.MiniBoss1 ) then
				self.MiniBoss1 = ents.Create( "npc_vj_horde_subordinate" )
				self.MiniBoss1:SetPos( self:GetPos() + self:GetRight() * 50 + self:GetUp() * 5 )
				self.MiniBoss1:Spawn()
				self.MiniBoss1:VJ_ACT_PLAYACTIVITY( "vjseq_canal5aattack", true, false, false )
				self.MiniBoss1:SetOwner( self )
				self.MiniBoss1:Activate()
			end

			if not IsValid( self.MiniBoss2 ) then
				self.MiniBoss2 = ents.Create( "npc_vj_horde_subordinate" )
				self.MiniBoss2:SetPos( self:GetPos() + self:GetRight() * -50 + self:GetUp() * 5 )
				self.MiniBoss2:Spawn()
				self.MiniBoss2:VJ_ACT_PLAYACTIVITY( "vjseq_canal5aattack", true, false, false )
				self.MiniBoss2:SetOwner( self )
				self.MiniBoss2:Activate()
			end
		end
		self.NextSummonTime = CurTime() + 15
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled( dmginfo, hitgroup )
	if IsValid( self.MiniBoss1 ) then self.MiniBoss1:Remove() end
	if IsValid( self.MiniBoss2 ) then self.MiniBoss2:Remove() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Sorcerer", "npc_vj_horde_sorcerer", "Zombies" )
