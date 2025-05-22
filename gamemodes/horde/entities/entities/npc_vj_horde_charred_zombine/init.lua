AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zombie_soldier.mdl"}
ENT.StartHealth = 350
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.Immune_Fire = true 
ENT.AnimTbl_MeleeAttack = {"vjseq_fastattack"}
ENT.MeleeAttackDamage = 35
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 64
ENT.TimeUntilMeleeAttackDamage = 0.4
ENT.SlowPlayerOnMeleeAttack = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"zsszombine/gear1.wav","zsszombine/gear2.wav","zsszombine/gear3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}

ENT.SoundTbl_Idle = {"zsszombine/idle1.wav","zsszombine/idle2.wav","zsszombine/idle3.wav","zsszombine/idle4.wav","zsszombine/idle5.wav"}
ENT.SoundTbl_Alert = {"zsszombine/alert1.wav","zsszombine/alert2.wav","zsszombine/alert3.wav","zsszombine/alert4.wav","zsszombine/alert5.wav","zsszombine/alert6.wav"}
ENT.SoundTbl_MeleeAttack = {"zsszombine/attack1.wav","zsszombine/attack2.wav","zsszombine/attack3.wav","zsszombine/attack4.wav"}
ENT.SoundTbl_Pain = {"zsszombine/pain1.wav","zsszombine/pain2.wav","zsszombine/pain3.wav","zsszombine/pain4.wav"}
ENT.SoundTbl_Death = {"zsszombine/die1.wav","zsszombine/die2.wav"}

ENT.GeneralSoundPitch1 = 80
ENT.GeneralSoundPitch2 = 80

function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self:SetColor(Color(125,50,50))
	self:SetModelScale(1.15, 0)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnThink_AIEnabled()
	local ene = self:GetEnemy()
	if not self.Zombine_GrenadeOut then
		if IsValid(ene) and self.LatestEnemyDistance <= 200 then
			self:Zombine_CreateGrenade()
		end
	end
	if IsValid(self.Zombine_Grenade) then
		self.AnimTbl_Walk = VJ_SequenceToActivity(self,"walk_all_grenade")
		self.AnimTbl_Run = VJ_SequenceToActivity(self,"run_all_grenade")
	else
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
	end
	if not self:IsOnFire() then
		self:Ignite(9999)
	end
end
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
    if isProp then 
    	return 
    end
    if hitEnt and IsValid(hitEnt) then
        hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Ignite, 35)
    end
end
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsFireDamage(dmginfo) then
		dmginfo:ScaleDamage(0.75)
	elseif HORDE:IsColdDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end
function ENT:CustomOnKilled(dmginfo, hitgroup)
	self:Extinguish()
	if IsValid(self.Zombine_Grenade) then
		local att = self:GetAttachment(self:LookupAttachment("grenade_attachment"))
		self.Zombine_Grenade:SetOwner(NULL)
		self.Zombine_Grenade:SetParent(NULL)
		self.Zombine_Grenade:Fire("ClearParent")
		self.Zombine_Grenade:SetMoveType(MOVETYPE_VPHYSICS)
		self.Zombine_Grenade:SetPos(att.Pos)
		self.Zombine_Grenade:SetAngles(att.Ang)
		local phys = self.Zombine_Grenade:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableGravity(true)
			phys:Wake()
		end
	end
end
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	self.Corpse:Ignite(math.Rand(8, 10), 0)
end
function ENT:Zombine_CreateGrenade()
	self.Zombine_GrenadeOut = true
	self:VJ_ACT_PLAYACTIVITY("pullgrenade", true, false, true)
	timer.Simple(0.5, function()
		if IsValid(self) then
			self.Zombine_Grenade = ents.Create("npc_grenade_frag")
			self.Zombine_Grenade:SetOwner(self)
			self.Zombine_Grenade:SetParent(self)
			self.Zombine_Grenade:Fire("SetParentAttachment", "grenade_attachment", 0)
			self.Zombine_Grenade:Spawn()
			self.Zombine_Grenade:Activate()
			self.Zombine_Grenade:Input("SetTimer", self:GetOwner(), self:GetOwner(), 3)
			self.Zombine_Grenade.VJ_IsPickedUpDanger = true
			timer.Simple(5, function()
				if IsValid(self) and not IsValid(self.Zombine_Grenade) then
					self.Zombine_GrenadeOut = false
				end
			end)
		end
	end)
end

ENT.Zombine_GrenadeOut = false
VJ.AddNPC("Charred Zombine", "npc_vj_horde_charred_zombine", "Zombies")
