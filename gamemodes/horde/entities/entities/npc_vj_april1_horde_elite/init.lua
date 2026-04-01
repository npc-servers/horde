AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
--[[---------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------]]
ENT.Model = "models/combine_super_soldier.mdl"
ENT.StartHealth = 250
ENT.AllowMovementJumping = false

ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.CanDetectDangers = false

ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false

ENT.Weapon_FiringDistanceFar = 1200
ENT.WeaponAttackSecondaryTimeUntilFire = 0.5
ENT.DropWeaponOnDeath = false
ENT.WeaponReload_FindCover = false
ENT.WaitForEnemyToComeOut = false

ENT.FootStepTimeRun = 0.4
ENT.FootStepTimeWalk = 1

ENT.OnlyDoKillEnemyWhenClear = false

ENT.HasItemDropsOnDeath = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {
	"npc/combine_soldier/gear1.wav",
	"npc/combine_soldier/gear2.wav",
	"npc/combine_soldier/gear3.wav",
	"npc/combine_soldier/gear4.wav",
	"npc/combine_soldier/gear5.wav",
	"npc/combine_soldier/gear6.wav"
}
ENT.SoundTbl_Idle = {
	"npc/combine_soldier/vo/unitisclosing.wav",
	"npc/combine_soldier/vo/unitisinbound.wav",
	"npc/combine_soldier/vo/unitismovingin.wav"
}
ENT.SoundTbl_Alert = {
	"npc/combine_soldier/vo/contact.wav",
	"npc/combine_soldier/vo/contactconfim.wav",
	"npc/combine_soldier/vo/engaging.wav",
	"npc/combine_soldier/vo/targetmyradial.wav",
	"npc/combine_soldier/vo/viscon.wav"
}
ENT.SoundTbl_OnKilledEnemy = {
	"npc/combine_soldier/vo/engagedincleanup.wav",
	"npc/combine_soldier/vo/affirmativewegothimnow.wav",
	"npc/combine_soldier/vo/contained.wav",
	"npc/combine_soldier/vo/cleaned.wav",
	"npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav",
	"npc/combine_soldier/vo/overwatchtarget1sterilized.wav",
	"npc/combine_soldier/vo/overwatchtargetcontained.wav"
}
ENT.SoundTbl_AllyDeath = {
	"npc/combine_soldier/vo/overwatchrequestreinforcement.wav",
	"npc/combine_soldier/vo/overwatchrequestreserveactivation.wav",
	"npc/combine_soldier/vo/overwatchrequestskyshield.wav",
	"npc/combine_soldier/vo/overwatchrequestwinder.wav",
	"npc/combine_soldier/vo/overwatchsectoroverrun.wav",
	"npc/combine_soldier/vo/overwatchteamisdown.wav"
}
ENT.SoundTbl_GrenadeAttack = {
	"npc/combine_soldier/vo/extractoraway.wav",
	"npc/combine_soldier/vo/extractorislive.wav"
}
ENT.SoundTbl_Pain = {
	"npc/combine_soldier/pain1.wav",
	"npc/combine_soldier/pain2.wav",
	"npc/combine_soldier/pain3.wav"
}
ENT.SoundTbl_Death = {
	"npc/combine_soldier/die1.wav",
	"npc/combine_soldier/die2.wav",
	"npc/combine_soldier/die3.wav"
}

ENT.IdleSoundChance = 7
ENT.AlertSoundChance = 3
ENT.AllyDeathSoundChance = 5

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:Give( "weapon_vj_horde_ar2" )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound( sdData, sdFile )
	if VJ_HasValue( self.SoundTbl_MeleeAttack, sdFile ) or VJ_HasValue( self.SoundTbl_IdleDialogue, sdFile ) or VJ_HasValue( self.SoundTbl_Pain, sdFile ) or VJ_HasValue( self.SoundTbl_Death, sdFile ) then 
		return 
	end
	VJ_EmitSound( self, { "npc/combine_soldier/vo/on1.wav", "npc/combine_soldier/vo/on2.wav" }, 75, math.random( 90, 100 ) )
	timer.Simple(SoundDuration(sdFile), function() 
		if IsValid( self ) and sdData:IsPlaying() then 
			VJ_EmitSound( self, { "npc/combine_soldier/vo/off1.wav", "npc/combine_soldier/vo/off2.wav", "npc/combine_soldier/vo/off3.wav" }, 75, math.random( 90, 100 ) ) 
		end 
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if HORDE:IsPhysicalDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.5 )
	elseif HORDE:IsLightningDamage( dmginfo ) then
		dmginfo:ScaleDamage( 0.75 )
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
VJ.AddNPC( "Elite Soldier", "npc_vj_april1_horde_elite", "Zombies" )