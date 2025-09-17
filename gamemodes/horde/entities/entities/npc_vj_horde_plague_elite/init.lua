AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = "models/combine_super_soldier.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 1050
ENT.HullType = MEDIUM_TALL_HULL
ENT.EntitiesToNoCollide = {"npc_vj_horde_zombine", "npc_vj_horde_plague_soldier"}
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.AnimTbl_Run = {ACT_WALK}
ENT.ConstantlyFaceEnemy_IfVisible = false
ENT.ConstantlyFaceEnemy_IfAttacking = true
ENT.CanDetectDangers = false
ENT.BloodColor = "Red"
ENT.MoveOrHideOnDamageByEnemy = false
ENT.DropWeaponOnDeath = false
ENT.HasItemDropsOnDeath = false
ENT.MeleeAttackDamage = 30
ENT.Weapon_FiringDistanceFar = 1200
ENT.HasWeaponBackAway = false
ENT.CanCrouchOnWeaponAttack = false
ENT.WeaponAttackSecondaryTimeUntilFire = 1.5
ENT.HasShootWhileMoving = false
ENT.WeaponReload_FindCover = false
ENT.MoveRandomlyWhenShooting = false
ENT.WaitForEnemyToComeOut = false
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

ENT.GeneralSoundPitch1 = 75
ENT.GeneralSoundPitch2 = 75

ENT.NextSummonTime = CurTime()
ENT.NextSummonCooldown = 15

local sdCombine_Radio_On = "npc/combine_soldier/clik.wav"
local sdCombine_Radio_Off = "npc/combine_soldier/click_off.wav"
local sdPlague_Summon = "npc/combine_soldier/go!.wav"
local sdPlague_Die = "npc/combine_soldier/click_terminated.wav"

function ENT:CustomOnInitialize()
	self:SetModelScale(1.25)
	self:SetColor(Color(50, 50, 50))

	self:Give("weapon_vj_horde_ar2")

	local pos = Vector()
	local ang = Angle()
	local attach_id = self:LookupAttachment("eyes")
	local attach = self:GetAttachment(attach_id)
	pos = attach.Pos
	ang = attach.Ang
	pos.x = pos.x - 6
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
	self.model:SetModelScale(1.5)

	VJ_EmitSound(self, "npc/combine_gunship/see_enemy.wav", 140, 100)
end

local defAng = Angle(0, 0, 0)

function ENT:CustomOnThink_AIEnabled()
	local enemyDistance = self.NearestPointToEnemyDistance

	if IsValid( self:GetEnemy() ) and CurTime() > self.NextSummonTime and enemyDistance <= 1000 then
		if not IsValid(self.MiniBoss1) or not IsValid(self.MiniBoss2) then
			self:PlaySoundSystem("Alert", sdPlague_Summon)
			self:VJ_ACT_PLAYACTIVITY("vjseq_signal_advance", true, false, false)

			ParticleEffect("aurora_shockwave_debris", self:GetPos(), defAng, nil)
			ParticleEffect("aurora_shockwave", self:GetPos(), defAng, nil)

			VJ_EmitSound(self, "horde/plague_elite/summon.ogg", 140, 100)

			if not IsValid(self.MiniBoss1) then
				self.MiniBoss1 = ents.Create("npc_vj_horde_plague_soldier")
				self.MiniBoss1:SetPos( self:GetPos() + self:GetRight() * 50 + self:GetUp() * 5 )
				self.MiniBoss1:Spawn()
				self.MiniBoss1:SetOwner( self )
				self.MiniBoss1:Activate()
			end

			if not IsValid(self.MiniBoss2) then
				self.MiniBoss2 = ents.Create("npc_vj_horde_zombine")
				self.MiniBoss2:SetPos( self:GetPos() + self:GetRight() * -50 + self:GetUp() * 5 )
				self.MiniBoss2:Spawn()
				self.MiniBoss2:SetOwner( self )
				self.MiniBoss2:Activate()
			end
		end
		self.NextSummonTime = CurTime() + self.NextSummonCooldown
	end
end

function ENT:OnPlayCreateSound(sdData, sdFile)
	if VJ_HasValue(self.SoundTbl_MeleeAttack, sdFile) or VJ_HasValue(self.SoundTbl_IdleDialogue, sdFile) or VJ_HasValue(self.SoundTbl_Pain, sdFile) or VJ_HasValue(self.SoundTbl_Death, sdFile) then 
		return 
	end
	VJ_EmitSound(self, sdCombine_Radio_On, 75, 75)
	timer.Simple(SoundDuration(sdFile) * 1.25, function() 
		if IsValid(self) && sdData:IsPlaying() then 
			VJ_EmitSound(self, sdCombine_Radio_Off, 75, 75) 
		end 
	end)
end

function ENT:CustomOnKilled(dmginfo, hitgroup)
	if IsValid(self.MiniBoss1) then
		self.MiniBoss1:Remove() 
	end

	if IsValid(self.MiniBoss2) then
    	self.MiniBoss2:Remove() 
    end
    VJ_EmitSound(self, sdPlague_Die, 80, 100)
end

VJ.AddNPC("Plague Elite","npc_vj_horde_plague_elite", "Zombies")
