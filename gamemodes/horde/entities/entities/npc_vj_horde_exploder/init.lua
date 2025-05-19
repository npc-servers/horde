AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/classic.mdl"}
ENT.StartHealth = 350
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.BloodColor = "Red"
ENT.HasDeathRagdoll = false
ENT.MeleeAttackDistance = 32
ENT.MeleeAttackDamageDistance = 64
ENT.TimeUntilMeleeAttackDamage = 0.8
ENT.SlowPlayerOnMeleeAttack = true
ENT.FootStepTimeRun = 1
ENT.AlertSounds_OnlyOnce = true
ENT.HasExtraMeleeAttackSounds = true

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav","npc/zombie/foot_slide1.wav","npc/zombie/foot_slide2.wav","npc/zombie/foot_slide3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}

ENT.SoundTbl_Idle = {"npc/zombie/zombie_voice_idle1.wav","npc/zombie/zombie_voice_idle2.wav","npc/zombie/zombie_voice_idle3.wav","npc/zombie/zombie_voice_idle4.wav","npc/zombie/zombie_voice_idle5.wav","npc/zombie/zombie_voice_idle6.wav","npc/zombie/zombie_voice_idle7.wav","npc/zombie/zombie_voice_idle8.wav","npc/zombie/zombie_voice_idle9.wav","npc/zombie/zombie_voice_idle10.wav","npc/zombie/zombie_voice_idle11.wav","npc/zombie/zombie_voice_idle12.wav","npc/zombie/zombie_voice_idle13.wav","npc/zombie/zombie_voice_idle14.wav"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/zo_attack1.wav","npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_pain1.wav","npc/zombie/zombie_pain2.wav","npc/zombie/zombie_pain3.wav","npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}

ENT.GeneralSoundPitch1 = 100

function ENT:CustomOnInitialize()
    self:SetBodygroup(1,1)
    self:SetColor(Color(255, 0, 255))
    self:SetModelScale(1.25, 0)
    self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
    if hitgroup == HITGROUP_HEAD then 
        self.HasDeathRagdoll = true 
        return 
    end
    local e = EffectData()
    e:SetOrigin(self:GetPos())
    util.Effect("exploder_explosion", e, true, true)
    local dmg = DamageInfo()
    dmg:SetInflictor(self)
    dmg:SetAttacker(self)
    dmg:SetDamageType(DMG_ACID)
    dmg:SetDamage(50)
    util.BlastDamageInfo(dmg, self:GetPos(), 250)
    self:EmitSound("vj_acid/acid_splat.wav")
end
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
    if hitgroup == HITGROUP_HEAD then
        dmginfo:ScaleDamage(4)
    elseif HORDE:IsBlastDamage(dmginfo) or HORDE:IsFireDamage(dmginfo) then
        dmginfo:ScaleDamage(1.5)
    elseif HORDE:IsPoisonDamage(dmginfo) then
		dmginfo:ScaleDamage(0.25)
    end
end

VJ.AddNPC("Exploder", "npc_vj_horde_exploder", "Zombies")
