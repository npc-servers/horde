AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/police.mdl"
ENT.StartHealth = 100

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }

ENT.BloodColor = "Red"

ENT.DropWeaponOnDeath = false

ENT.FootStepTimeRun = 0.4
ENT.FootStepTimeWalk = 1

ENT.OnlyDoKillEnemyWhenClear = false

ENT.HasItemDropsOnDeath = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	"npc/metropolice/gear1.wav",
	"npc/metropolice/gear2.wav",
	"npc/metropolice/gear3.wav",
	"npc/metropolice/gear4.wav",
	"npc/metropolice/gear5.wav",
	"npc/metropolice/gear6.wav"
}
ENT.SoundTbl_Idle = {
	"npc/metropolice/vo/unitreportinwith10-25suspect.wav",
	"npc/metropolice/vo/tenzerovisceratorishunting.wav",
	"npc/metropolice/vo/teaminpositionadvance.wav",
	"npc/metropolice/vo/requestsecondaryviscerator.wav",
	"npc/metropolice/vo/readytoamputate.wav",
	"npc/metropolice/vo/preparingtojudge10-107.wav",
	"npc/metropolice/vo/preparefor1015.wav",
	"npc/metropolice/vo/positiontocontain.wav",
	"npc/metropolice/vo/movingtohardpoint.wav",
	"npc/metropolice/vo/movingtohardpoint2.wav",
	"npc/metropolice/vo/movetoarrestpositions.wav",
	"npc/metropolice/vo/malcompliant10107my1020.wav",
	"npc/metropolice/vo/lockyourposition.wav",
	"npc/metropolice/vo/issuingmalcompliantcitation.wav",
	"npc/metropolice/vo/ihave10-30my10-20responding.wav",
	"npc/metropolice/vo/dispreportssuspectincursion.wav"
}
ENT.SoundTbl_Alert = {
	"npc/metropolice/vo/contactwith243suspect.wav",
	"npc/metropolice/vo/confirmadw.wav"
}
ENT.SoundTbl_OnKilledEnemy = {
	"npc/metropolice/vo/finalverdictadministered.wav",
	"npc/metropolice/vo/protectioncomplete.wav",
	"npc/metropolice/vo/chuckle.wav",
	"npc/metropolice/vo/control100percent.wav"
}
ENT.SoundTbl_AllyDeath = {
	"npc/metropolice/vo/11-99officerneedsassistance.wav",
	"npc/metropolice/vo/cpiscompromised.wav",
	"npc/metropolice/vo/cpisoverrunwehavenocontainment.wav",
	"npc/metropolice/vo/dispatchineed10-78.wav",
	"npc/metropolice/vo/officerdowncode3tomy10-20.wav",
	"npc/metropolice/vo/officerdowniam10-99.wav",
	"npc/metropolice/vo/officerneedsassistance.wav",
	"npc/metropolice/vo/officerneedshelp.wav",
	"npc/metropolice/vo/officerunderfiretakingcover.wav"
}
ENT.SoundTbl_Pain = {
	"npc/metropolice/pain1.wav",
	"npc/metropolice/pain2.wav",
	"npc/metropolice/pain3.wav",
	"npc/metropolice/pain4.wav"
}
ENT.SoundTbl_Death = {
	"npc/metropolice/die1.wav",
	"npc/metropolice/die2.wav",
	"npc/metropolice/die3.wav",
	"npc/metropolice/die4.wav"
}

ENT.IdleSoundChance = 7
ENT.AlertSoundChance = 3
ENT.AllyDeathSoundChance = 5

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:Give( "weapon_vj_april1_horde_stunstick" )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound( sdData, sdFile )
	if VJ_HasValue( self.SoundTbl_MeleeAttack, sdFile ) or VJ_HasValue( self.SoundTbl_IdleDialogue, sdFile ) or VJ_HasValue( self.SoundTbl_Pain, sdFile ) or VJ_HasValue( self.SoundTbl_Death, sdFile ) then 
		return 
	end
	VJ_EmitSound( self, { "npc/metropolice/vo/on1.wav", "npc/metropolice/vo/on2.wav" }, 75, math.random( 90, 100 ) )
	timer.Simple(SoundDuration(sdFile), function() 
		if IsValid( self ) and sdData:IsPlaying() then 
			VJ_EmitSound( self, { "npc/metropolice/vo/off1.wav", "npc/metropolice/vo/off2.wav", "npc/metropolice/vo/off3.wav", "npc/metropolice/vo/off4.wav" }, 75, math.random( 90, 100 ) ) 
		end 
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Baton Cop", "npc_vj_april1_horde_batoncop", "Zombies" )