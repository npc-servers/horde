AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = { "models/zombie/burnzie.mdl" }
ENT.StartHealth = 150

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"

ENT.HasMeleeAttack = true
ENT.TimeUntilMeleeAttackDamage = 0.75
ENT.NextAnyAttackTime_Melee = 1

ENT.FootStepTimeRun = 0.8
ENT.FootStepTimeWalk = 0.8
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	")zsszombie/foot1.wav",
	")zsszombie/foot2.wav",
	")zsszombie/foot3.wav",
	")zsszombie/foot4.wav"
}
ENT.SoundTbl_Idle = {
	")zsszombies/zmisc_idle1.wav",
	")zsszombies/zmisc_idle2.wav",
	")zsszombies/zmisc_idle3.wav",
	")zsszombies/zmisc_idle4.wav",
	")zsszombies/zmisc_idle5.wav",
	")zsszombies/zmisc_idle6.wav"
}
ENT.SoundTbl_Alert = {
	")zsszombies/zmisc_alert1.wav",
	")zsszombies/zmisc_alert2.wav"
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
	")zsszombies/zmisc_pain1.wav",
	")zsszombies/zmisc_pain2.wav",
	")zsszombies/zmisc_pain3.wav",
	")zsszombies/zmisc_pain4.wav",
	")zsszombies/zmisc_pain5.wav",
	")zsszombies/zmisc_pain6.wav"
}
ENT.SoundTbl_Death = {
	")zsszombies/zmisc_die1.wav",
	")zsszombies/zmisc_die2.wav",
	")zsszombies/zmisc_die3.wav"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds( Vector( 13, 13, 60 ), Vector( -13, -13, 0 ) )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.AnimTbl_IdleStand = { self:IsOnFire() and ACT_IDLE_ON_FIRE or ACT_IDLE }
	self.AnimTbl_Walk = { self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK }
	self.AnimTbl_Run = { self:IsOnFire() and ACT_WALK_ON_FIRE or ACT_WALK }
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks( hitEnt, isProp )
	if isProp then return end
	if math.random( 1, 3 ) == 1 then
		local e = EffectData()
		e:SetOrigin( self:GetPos() )
		util.Effect( "m2_flame_explosion", e, true, true )
		for _, ent in pairs( ents.FindInSphere( self:GetPos(), 150 ) ) do
			if ent:IsPlayer() then
				local Trace = util.TraceLine( {
					start = self:WorldSpaceCenter(),
					endpos = ent:WorldSpaceCenter(),
					mask = MASK_SOLID_BRUSHONLY
				} )
				if not Trace.HitWorld then
					ent:Horde_AddDebuffBuildup( HORDE.Status_Ignite, 50, self )
				end
			end
		end
		sound.Play( "vj_fire/fireball_explode.wav", self:GetPos() )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if HORDE:IsColdDamage( dmginfo ) then
		dmginfo:ScaleDamage( 1.25 )
	elseif HORDE:IsFireDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.5 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Burnzie", "npc_vj_horde_burnzie", "Zombies" )
