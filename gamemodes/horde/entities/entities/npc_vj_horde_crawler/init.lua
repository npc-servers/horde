AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zm_fast.mdl"}
ENT.StartHealth = 30
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 64
ENT.HasLeapAttack = false
ENT.FootStepTimeRun = 0.25
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}

ENT.SoundTbl_Idle = {"vfastzombie/fzombie_idle1.wav","vfastzombie/fzombie_idle2.wav","vfastzombie/fzombie_idle3.wav",")vfastzombie/fzombie_idle4.wav",")vfastzombie/fzombie_idle5.wav"}
ENT.SoundTbl_Alert = {"vfastzombie/fzombie_alert1.wav","vfastzombie/fzombie_alert2.wav","vfastzombie/fzombie_alert3.wav"}
ENT.SoundTbl_MeleeAttack = {"vfastzombie/attack1.wav","vfastzombie/attack2.wav","vfastzombie/attack3.wav"}
ENT.SoundTbl_Pain = {"vfastzombie/fzombie_pain1.wav","vfastzombie/fzombie_pain2.wav","vfastzombie/fzombie_pain3.wav"}
ENT.SoundTbl_Death = {"vfastzombie/fzombie_die1.wav","vfastzombie/fzombie_die2.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
	self:SetSkin(math.random(0,3))
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
    end
end
function ENT:MultipleMeleeAttacks()
	if not self.Critical then
		self.MeleeAttackDamage = 5
		self.AnimTbl_MeleeAttack = {"vjseq_melee"}
		self.TimeUntilMeleeAttackDamage = 0.25
		self.MeleeAttackExtraTimers = {0.5}
	else
		self.MeleeAttackDamage = 20
		self.AnimTbl_MeleeAttack = {"vjseq_melee2"}
		self.TimeUntilMeleeAttackDamage = 2.5
		self.SlowPlayerOnMeleeAttack = true
	end
end

ENT.Critical = nil
VJ.AddNPC("Crawler","npc_vj_horde_crawler","Zombies")
