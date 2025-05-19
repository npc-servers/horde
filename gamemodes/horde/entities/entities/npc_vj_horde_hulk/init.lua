AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/horde/hulk/hulk.mdl"}
ENT.StartHealth = 1200
ENT.HullType = HULL_MEDIUM_TALL
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 40
ENT.HasMeleeAttackKnockBack = true
ENT.MeleeAttackDistance = 64
ENT.MeleeAttackDamageDistance = 100
ENT.TimeUntilMeleeAttackDamage = 0.8
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 0.5
ENT.HasWorldShakeOnMove = true
ENT.WorldShakeOnMoveAmplitude = 5
ENT.WorldShakeOnMoveRadius = 200
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}

ENT.SoundTbl_Breath = {"npc/zombie_poison/pz_breathe_loop1.wav"}
ENT.SoundTbl_Idle = {"npc/zombie_poison/pz_idle2.wav","npc/zombie_poison/pz_idle3.wav","npc/zombie_poison/pz_idle4.wav"}
ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_alert1.wav","npc/zombie_poison/pz_alert2.wav"}
ENT.SoundTbl_Pain = {"npc/zombie_poison/pz_pain1.wav","npc/zombie_poison/pz_pain2.wav","npc/zombie_poison/pz_pain3.wav"}
ENT.SoundTbl_Death = {"npc/zombie_poison/pz_die1.wav","npc/zombie_poison/pz_die2.wav"}

ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 60
ENT.FootStepPitch = VJ_Set(40, 60)

function ENT:CustomOnInitialize()
	self:SetSkin(math.random(0, 3))
	self:EmitSound("npc/zombie_poison/pz_call1.wav", 140)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("FireWalk"))}
		self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("FireWalk"))}
	else
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
	end
	if self.Critical and self:IsOnGround() then
		self:SetLocalVelocity(self:GetMoveVelocity() * 1.5)
	end
end
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*100 + self:GetUp()*240
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.AnimationPlaybackRate = 1.5
        self.FootStepTimeRun = 0.25
        self.HasPainSounds = false
        self.SoundTbl_Breath = {"npc/zombie_poison/pz_breathe_loop2.wav"}
        self.Critical = true
        self:SetColor(Color(255, 0, 0))
        self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    end
end
function ENT:OnRemove()
    self:StopSound("npc/zombie_poison/pz_call1.wav")
end

ENT.Critical = false
VJ.AddNPC("Hulk", "npc_vj_horde_hulk", "Zombies")
