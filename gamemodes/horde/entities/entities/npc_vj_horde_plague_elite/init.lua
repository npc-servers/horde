AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/combine_super_soldier.mdl"
ENT.StartHealth = 1050
ENT.HullType = MEDIUM_TALL_HULL
ENT.EntitiesToNoCollide = { "npc_vj_horde_plague_soldier" }
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
ENT.Weapon_FiringDistanceFar = 1200
ENT.WeaponBackAway_Distance = 500
ENT.CanCrouchOnWeaponAttack = false
ENT.AnimTbl_ShootWhileMovingWalk = { ACT_RUN_AIM }
ENT.WeaponAttackSecondaryTimeUntilFire = 1
ENT.WeaponReload_FindCover = false
ENT.WaitForEnemyToComeOut = false
ENT.HasGrenadeAttack = true
ENT.GrenadeAttackEntity = "npc_grenade_frag"
ENT.GrenadeAttackThrowDistance = 1200
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

ENT.NextSummonTime = CurTime()
ENT.NextSummonCooldown = 15

local sdCombine_Radio_On = "npc/combine_soldier/clik.wav"
local sdCombine_Radio_Off = "npc/combine_soldier/click_off.wav"
local sdPlague_Summon = "npc/combine_soldier/go.wav"
local sdPlague_Die = "npc/combine_soldier/click_terminated.wav"

function ENT:CustomOnInitialize()
	self:SetModelScale( 1.25 )
	self:SetColor( Color( 50, 50, 50 ) )

	self:Give( "weapon_vj_horde_ar2" )

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
	self.model:SetColor( Color ( 255, 0, 0 ) )
	self.model:SetSequence( "ragdoll" )
	self.model:SetPos( pos )
	self.model:SetAngles( ang )
	self.model:Spawn()
	self.model:SetParent( self, attach_id )
	self.model:SetModelScale( 1.5 )

	VJ_EmitSound( self, "npc/combine_gunship/see_enemy.wav", 140, 100 )
end

local defAng = Angle(0, 0, 0)

function ENT:CustomOnThink_AIEnabled()
	local enemyDistance = self.NearestPointToEnemyDistance

	if IsValid( self:GetEnemy() ) and CurTime() > self.NextSummonTime and enemyDistance <= 1000 then
		if not IsValid( self.MiniBoss1 ) or not IsValid( self.MiniBoss2 ) then
			self:PlaySoundSystem( "CallForHelp", sdPlague_Summon )
			self:VJ_ACT_PLAYACTIVITY( "vjseq_signal_advance", true, false, false )

			ParticleEffect( "aurora_shockwave_debris", self:GetPos(), defAng, nil )
			ParticleEffect( "aurora_shockwave", self:GetPos(), defAng, nil )

			VJ_EmitSound( self, "horde/plague_elite/summon.ogg", 140, 100 )

			if not IsValid( self.MiniBoss1 ) then
				self.MiniBoss1 = ents.Create( "npc_vj_horde_plague_soldier" )
				self.MiniBoss1:SetPos( self:GetPos() + self:GetRight() * 50 + self:GetUp() * 5 )
				self.MiniBoss1:Spawn()
				self.MiniBoss1:SetOwner( self )
				self.MiniBoss1:Activate()
			end

			if not IsValid( self.MiniBoss2 ) then
				self.MiniBoss2 = ents.Create( "npc_vj_horde_plague_soldier" )
				self.MiniBoss2:SetPos( self:GetPos() + self:GetRight() * -50 + self:GetUp() * 5 )
				self.MiniBoss2:Spawn()
				self.MiniBoss2:SetOwner( self )
				self.MiniBoss2:Activate()
			end
		end
		self.NextSummonTime = CurTime() + self.NextSummonCooldown
	end
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

function ENT:CustomOnKilled( dmginfo, hitgroup )
	if IsValid( self.MiniBoss1 ) then self.MiniBoss1:Remove() end
	if IsValid( self.MiniBoss2 ) then self.MiniBoss2:Remove() end
    VJ_EmitSound( self, sdPlague_Die, 75, 100 )
end

VJ.AddNPC( "Plague Elite","npc_vj_horde_plague_elite", "Zombies" )

ENT.EntitiesToNoCollide = {
	"npc_vj_alpha_gonome", 
	"npc_vj_ezt_manhackbie", 
	"npc_vj_ezt_shotbie", 
	"npc_vj_ezt_weapbie", 
	"npc_vj_horde_blight", 
	"npc_vj_horde_breen", 
	"npc_vj_horde_charred_zombine", 
	"npc_vj_horde_crawler", 
	"npc_vj_horde_exploder", 
	"npc_vj_horde_fast_zombie",
	"npc_vj_horde_gamma_gonome",
	"npc_vj_horde_headcrab_baby",
	"npc_vj_horde_hellknight",
	"npc_vj_horde_hulk",
	"npc_vj_horde_lesion",
	"npc_vj_horde_plague_elite",
	"npc_vj_horde_plague_platoon",
	"npc_vj_horde_plague_soldier",
	"npc_vj_horde_platoon_berserker",
	"npc_vj_horde_platoon_demolitionist",
	"npc_vj_horde_platoon_heavy",
	"npc_vj_horde_poison_zombie",
	"npc_vj_horde_scorcher",
	"npc_vj_horde_screecher",
	"npc_vj_horde_sprinter",
	"npc_vj_horde_vomitter",
	"npc_vj_horde_walker",
	"npc_vj_horde_weeper",
	"npc_vj_horde_xen_destroyer_unit",
	"npc_vj_horde_xen_host_unit",
	"npc_vj_horde_xen_necromancer_unit",
	"npc_vj_horde_xen_psychic_unit",
	"npc_vj_horde_yeti",
	"npc_vj_horde_zombie_torso",
	"npc_vj_horde_zombine",
	"npc_vj_mutated_hulk"
}