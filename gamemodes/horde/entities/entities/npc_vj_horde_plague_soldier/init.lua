AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/combine_soldier.mdl"
ENT.StartHealth = 325
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.AnimTbl_Walk = {ACT_RUN}
ENT.ConstantlyFaceEnemy_IfVisible = false
ENT.ConstantlyFaceEnemy_IfAttacking = true
ENT.CanDetectDangers = false
ENT.BloodColor = "Red"
ENT.CanFlinch = 1
ENT.AnimTbl_Flinch = {"vjseq_flinchsmall"}
ENT.HitGroupFlinching_Values = {{HitGroup  = {HITGROUP_HEAD}, Animation = {"vjseq_flinchhead"}}, {HitGroup  = {HITGROUP_CHEST}, Animation = {"vjseq_flinchchest"}}, {HitGroup  = {HITGROUP_STOMACH}, Animation = {"vjseq_flinchgut"}}, {HitGroup  = {HITGROUP_LEFTARM}, Animation = {"vjseq_flinchleft"}}, {HitGroup  = {HITGROUP_RIGHTARM}, Animation = {"vjseq_flinchright"}}}
ENT.MoveOrHideOnDamageByEnemy = false
ENT.DropWeaponOnDeath = false
ENT.HasItemDropsOnDeath = false
ENT.Weapon_FiringDistanceFar = 1000
ENT.HasWeaponBackAway = false
ENT.CanCrouchOnWeaponAttack = false
ENT.AnimTbl_ShootWhileMovingWalk = {ACT_RUN_AIM}
ENT.WeaponReload_FindCover = false
ENT.WaitForEnemyToComeOut = false
ENT.HasGrenadeAttack = true
ENT.GrenadeAttackEntity = "npc_grenade_frag"
ENT.GrenadeAttackThrowDistance = 1000
ENT.GrenadeAttackThrowDistanceClose = 500
ENT.Horde_Plague_Soldier = true

ENT.SoundTbl_FootStep = {
	"npc/zombine/gear1.wav",
	"npc/zombine/gear2.wav",
	"npc/zombine/gear3.wav"
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
ENT.SoundTbl_GrenadeAttack = {
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
	"npc/zombine/zombine_die1.wav"
}

ENT.UseTheSameGeneralSoundPitch = true

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	local p = math.random()
	if p <= 0.5 then
		self:Give( "weapon_vj_horde_smg1" )
	else
		self:SetSkin( 1 )
		self:Give( "weapon_vj_horde_shotgun" )
		self.Weapon_FiringDistanceFar = 750
	end

	local pos = Vector()
	local ang = Angle()
	local attach_id = self:LookupAttachment( "eyes" )
	local attach = self:GetAttachment( attach_id )
	pos = attach.Pos
	ang = attach.Ang
	pos.x = pos.x - 5
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
	self.model:SetModelScale( 1.25 )
end

VJ.AddNPC( "Plague Soldier", "npc_vj_horde_plague_soldier", "Zombies" )

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