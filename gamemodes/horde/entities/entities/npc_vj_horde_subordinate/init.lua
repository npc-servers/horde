AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = { "models/zombie/classic_gal_boss_mini2.mdl" }
ENT.StartHealth = 250

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"
ENT.CanFlinch = 1

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamage = 15
ENT.AnimTbl_MeleeAttack = { "vjseq_attacka", "vjseq_attackb", "vjseq_attackc", "vjseq_attackd", "vjseq_attacke", "vjseq_attackf" }
ENT.TimeUntilMeleeAttackDamage = 1

ENT.FootStepTimeRun = 0.8
ENT.FootStepTimeWalk = 0.8
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	")zsszombie/foot1.wav",
	")zsszombie/foot2.wav",
	")zsszombie/foot3.wav",
	")zsszombie/foot4.wav"
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.AnimTbl_IdleStand = { self:IsOnFire() and ACT_IDLE_ON_FIRE or ACT_IDLE }
	self.AnimTbl_Walk = { self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK }
	self.AnimTbl_Run = { self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if not HORDE:IsPhysicalDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.5 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Subordinate", "npc_vj_horde_subordinate", "Zombies" )
