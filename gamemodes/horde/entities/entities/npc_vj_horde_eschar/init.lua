AddCSLuaFile("shared.lua")
include('shared.lua')
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = { "models/humans/zm_draggy.mdl" }
ENT.StartHealth = 125

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"

ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = { ACT_MELEE_ATTACK1 }
ENT.TimeUntilMeleeAttackDamage = 0.2
ENT.NextAnyAttackTime_Melee = 0.5

ENT.NextTick = 0
---------------------------------------------------------------------------------------------------------------------------------------------
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
	")zsszombies/bite1.wav",
	")zsszombies/bite2.wav",
	")zsszombies/bite3.wav",
	")zsszombies/bite4.wav",
	")zsszombies/bite5.wav"
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
	self:SetCollisionBounds( Vector( 12, 12, 60 ), Vector( -12, -12, 0 ) )
	self:SetSkin( math.random( 0, 3 ) )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:Health() < self:GetMaxHealth() / 2 then
		if self.NextTick < CurTime() then
			for _, ent in pairs( ents.FindInSphere( self:GetPos(), 150 ) ) do
				if ent:IsPlayer() then
					local Trace = util.TraceLine( {
						start = self:WorldSpaceCenter(),
						endpos = ent:WorldSpaceCenter(),
						mask = MASK_SOLID_BRUSHONLY
					} )
					if not Trace.HitWorld then
						ent:Horde_AddDebuffBuildup( HORDE.Status_Necrosis, 5, self )
					end
				end
			end
			local e = EffectData()
			e:SetOrigin( self:GetPos() )
			util.Effect( "blight_mini_explosion", e, true, true )

			self.NextTick = CurTime() + 0.5
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if HORDE:IsPhysicalDamage( dmginfo ) then
		dmginfo:ScaleDamage( 1.25 )
	elseif HORDE:IsLightningDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.5 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Eschar", "npc_vj_horde_eschar", "Zombies" )