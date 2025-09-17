AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/combine_soldier.mdl" -- Leave empty if using more than one model
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
	"npc/combine_soldier/gear1.wav",
	"npc/combine_soldier/gear2.wav",
	"npc/combine_soldier/gear3.wav",
	"npc/combine_soldier/gear4.wav",
	"npc/combine_soldier/gear5.wav",
	"npc/combine_soldier/gear6.wav"
}
ENT.SoundTbl_Idle = {
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
	"npc/combine_soldier/pain1.wav",
	"npc/combine_soldier/pain2.wav",
	"npc/combine_soldier/pain3.wav"
}
ENT.SoundTbl_Death = {
	"npc/combine_soldier/die1.wav",
	"npc/combine_soldier/die2.wav",
	"npc/combine_soldier/die3.wav"
}

ENT.UseTheSameGeneralSoundPitch = true

ENT.GeneralSoundPitch1 = 100

local sdCombine_Radio_On = "npc/combine_soldier/clik.wav"
local sdCombine_Radio_Off = "npc/combine_soldier/click_off.wav"

function ENT:CustomOnInitialize()
	local p = math.random()
	if p <= 0.5 then
		self:Give("weapon_vj_horde_smg1")
	else
		self:SetSkin(1)
		self:Give("weapon_vj_horde_shotgun")
		self.Weapon_FiringDistanceFar = 750
	end

	local pos = Vector()
	local ang = Angle()
	local attach_id = self:LookupAttachment("eyes")
	local attach = self:GetAttachment(attach_id)
	pos = attach.Pos
	ang = attach.Ang
	pos.x = pos.x - 5
	pos.z = pos.z - 6
	pos.y = pos.y

	self.model = ents.Create("prop_dynamic")
	self.model:SetModel("models/headcrabblack.mdl")
	self.model:SetCollisionGroup(0)
	self.model:SetColor(Color(255, 0, 0))
	self.model:SetSequence("ragdoll")
	self.model:SetPos(pos)
	self.model:SetAngles(ang)
	self.model:Spawn()
	self.model:SetParent(self, attach_id)
	self.model:SetModelScale(1.25)
end

function ENT:OnPlayCreateSound(sdData, sdFile)
	if VJ_HasValue(self.SoundTbl_MeleeAttack, sdFile) or VJ_HasValue(self.SoundTbl_IdleDialogue, sdFile) or VJ_HasValue(self.SoundTbl_Pain, sdFile) or VJ_HasValue(self.SoundTbl_Death, sdFile) then 
		return 
	end
	VJ_EmitSound(self, sdCombine_Radio_On, 75, 100)
	timer.Simple(SoundDuration(sdFile), function() 
		if IsValid(self) && sdData:IsPlaying() then 
			VJ_EmitSound(self, sdCombine_Radio_Off, 75, 100) 
		end 
	end)
end

VJ.AddNPC("Plague Solder","npc_vj_horde_plague_soldier", "Zombies")
