AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/combine_super_soldier.mdl"
ENT.StartHealth = 4500
ENT.HullType = MEDIUM_TALL_HULL
ENT.EntitiesToNoCollide = { "npc_vj_horde_platoon_heavy", "npc_vj_horde_platoon_berserker", "npc_vj_horde_platoon_demolitionist" }
ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.AnimTbl_Walk = { ACT_RUN }
ENT.ConstantlyFaceEnemy_IfVisible = false
ENT.ConstantlyFaceEnemy_IfAttacking = true
ENT.CanDetectDangers = false
ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false
ENT.DropWeaponOnDeath = false
ENT.HasItemDropsOnDeath = false
ENT.MeleeAttackDamage = 30
ENT.Weapon_FiringDistanceFar = 1500
ENT.WeaponBackAway_Distance = 0
ENT.CanCrouchOnWeaponAttack = false
ENT.AnimTbl_ShootWhileMovingWalk = { ACT_RUN_AIM }
ENT.WeaponAttackSecondaryTimeUntilFire = 1
ENT.WeaponReload_FindCover = false
ENT.WaitForEnemyToComeOut = false
ENT.HasGrenadeAttack = true
ENT.GrenadeAttackEntity = "horde_vj_platoon_heavy_nade"
ENT.GrenadeAttackThrowDistance = 1000
ENT.GrenadeAttackThrowDistanceClose = 500
ENT.Horde_Plague_Soldier = true

ENT.SoundTbl_FootStep = {
	"npc/zombine/gear1.wav",
	"npc/zombine/gear2.wav",
	"npc/zombine/gear3.wav"
}
ENT.SoundTbl_Combat_Idle = {
	"npc/combine_soldier/assault1.wav",
	"npc/combine_soldier/assault2.wav",
	"npc/combine_soldier/assault3.wav"
}
ENT.SoundTbl_Alert = {
	"npc/combine_soldier/go_alert1.wav",
	"npc/combine_soldier/go_alert2.wav",
	"npc/combine_soldier/go_alert3.wav"
}
ENT.SoundTbl_Suppressing = {
	"npc/combine_soldier/announce1.wav",
	"npc/combine_soldier/announce2.wav",
	"npc/combine_soldier/announce3.wav"
}
ENT.SoundTbl_GrenadeAttack = {
	"npc/combine_soldier/throw_grenade1.wav",
	"npc/combine_soldier/throw_grenade2.wav",
	"npc/combine_soldier/throw_grenade3.wav"
}
ENT.SoundTbl_Pain = {
	"npc/zombine/zombine_pain1.wav",
	"npc/zombine/zombine_pain2.wav",
	"npc/zombine/zombine_pain3.wav",
	"npc/zombine/zombine_pain4.wav"
}
ENT.SoundTbl_Death = {
	"npc/zombine/zombine_die1.wav",
	"npc/zombine/zombine_die1.wav"
}

ENT.UseTheSameGeneralSoundPitch = true

ENT.GeneralSoundPitch1 = 100

ENT.Critical = false

local sdCombine_Radio_On = "npc/combine_soldier/clik.wav"
local sdCombine_Radio_Off = "npc/combine_soldier/click_off.wav"
local sdPlague_Die = "npc/combine_soldier/click_terminated.wav"

function ENT:CustomOnInitialize()
	self:SetModelScale( 1.25 )
	self:SetColor( Color( 100, 100, 100 ) )

	self:Give( "weapon_vj_horde_m249" )
	local p = math.random()
	if p <= 0.5 then
		self.Weaken = true
	else
		self.Hinder = true
	end

	local pos = Vector()
	local ang = Angle()
	local attach_id = self:LookupAttachment( "eyes" )
	local attach = self:GetAttachment( attach_id )
	pos = attach.Pos
	ang = attach.Ang
	pos.x = pos.x - 6
	pos.z = pos.z - 6
	pos.y = pos.y

	self.model = ents.Create( "prop_dynamic" )
	self.model:SetModel( "models/headcrabblack.mdl" )
	self.model:SetCollisionGroup( 0 )
	self.model:SetColor( Color ( 100, 100, 100 ) )
	self.model:SetSequence( "ragdoll" )
	self.model:SetPos( pos )
	self.model:SetAngles( ang )
	self.model:Spawn()
	self.model:SetParent( self, attach_id )
	self.model:SetModelScale( 1.5 )

	VJ_EmitSound( self, "npc/combine_gunship/see_enemy.wav", 140, 100 )
end

function ENT:OnPlayCreateSound( sdData, sdFile )
	if VJ_HasValue( self.SoundTbl_MeleeAttack, sdFile ) or VJ_HasValue( self.SoundTbl_IdleDialogue, sdFile ) or VJ_HasValue( self.SoundTbl_Pain, sdFile ) or VJ_HasValue( self.SoundTbl_Death, sdFile ) then return end
	VJ_EmitSound( self, sdCombine_Radio_On, 75, 100 )
	timer.Simple( SoundDuration( sdFile ), function() 
		if IsValid( self ) && sdData:IsPlaying() then 
			VJ_EmitSound( self, sdCombine_Radio_Off, 75, 100 ) 
		end 
	end )
end

function ENT:CustomOnTakeDamage_BeforeDamage( dmginfo, hitgroup )
	if not HORDE:IsPhysicalDamage( dmginfo ) then return end

	dmginfo:ScaleDamage(0.75)
end

function ENT:CustomOnTakeDamage_AfterDamage( dmginfo, hitgroup )
	self.Critical = self:Health() <= self:GetMaxHealth() * 0.5
end

function ENT:CustomOnKilled( dmginfo, hitgroup )
    VJ_EmitSound( self, sdPlague_Die, 75, 100 )
end

VJ.AddNPC( "Platoon Heavy", "npc_vj_horde_platoon_heavy", "Zombies" )