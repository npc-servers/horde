AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/horde/hulk/hulk.mdl"}
ENT.StartHealth = 1350
ENT.HullType = HULL_MEDIUM_TALL
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 50
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
	self:SetColor(Color(0, 255, 255))
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
	if self.Critical then
		if CurTime() >= self.NextTick then
			local dmg = DamageInfo()
			dmg:SetAttacker(self)
			dmg:SetInflictor(self)
			dmg:SetDamageType(DMG_REMOVENORAGDOLL)
			dmg:SetDamage(5)
			for _, ent in pairs(ents.FindInSphere(self:GetPos(), 150)) do
				if ent:IsPlayer() or HORDE:IsPlayerMinion(ent) then
					ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 4)
					ent:TakeDamageInfo(dmg)
					dmg:SetDamagePosition(ent:GetPos())
				end
			end
			local e = EffectData()
			e:SetOrigin(self:GetPos())
			e:SetScale(1)
			util.Effect("frostcloud", e, true, true)
			self.NextTick = CurTime() + 0.5
		end
	end
end
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*130 + self:GetUp()*260
end
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	if HORDE:IsColdDamage(dmginfo) then
		dmginfo:ScaleDamage(0.5)
	elseif HORDE:IsFireDamage(dmginfo) then
		dmginfo:ScaleDamage(1.25)
	end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
    end
end

ENT.Critical = false
ENT.NextTick = 0
VJ.AddNPC("Yeti", "npc_vj_horde_yeti", "Zombies")
