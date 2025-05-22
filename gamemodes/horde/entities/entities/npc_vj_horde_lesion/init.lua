AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/zombie/zombie_fast02.mdl"}
ENT.StartHealth = 1000
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.AnimTbl_Run = {ACT_WALK}
ENT.BloodColor = "Red"
ENT.MeleeAttackDamage = 50
ENT.HasMeleeAttackKnockBack = true
ENT.AnimTbl_MeleeAttack = {"vjseq_br2_attack"}
ENT.MeleeAttackDistance = 64
ENT.MeleeAttackDamageDistance = 100
ENT.TimeUntilMeleeAttackDamage = 0.5
ENT.NextAnyAttackTime_Melee = 1
ENT.SlowPlayerOnMeleeAttack = true
ENT.LeapAttackDamage = 40
ENT.AnimTbl_LeapAttack = {"leapstrike"}
ENT.LeapDistance = 400
ENT.LeapToMeleeDistance = 150
ENT.NextLeapAttackTime = 10
ENT.LeapAttackExtraTimers = {0.4,0.6,0.8,1}
ENT.LeapAttackVelocityForward = 300
ENT.LeapAttackVelocityUp = 250
ENT.FootStepTimeRun = 1
ENT.HasWorldShakeOnMove = true
ENT.WorldShakeOnMoveAmplitude = 5
ENT.WorldShakeOnMoveRadius = 200
ENT.HasExtraMeleeAttackSounds = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {"npc/fast_zombie/foot1.wav","npc/fast_zombie/foot2.wav","npc/fast_zombie/foot3.wav","npc/fast_zombie/foot4.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/zombie_pain1.wav","npc/zombie/zombie_pain2.wav","npc/zombie/zombie_pain3.wav","npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/fast_zombie/claw_strike1.wav","npc/fast_zombie/claw_strike2.wav","npc/fast_zombie/claw_strike3.wav"}

ENT.SoundTbl_Pain = {"npc/fast_zombie/wake1.wav"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}

ENT.GeneralSoundPitch1 = 50
ENT.GeneralSoundPitch2 = 50
ENT.FootStepPitch = VJ_Set(40, 60)

function ENT:CustomOnInitialize()
    self:EmitSound(")horde/lesion/lesion_roar.wav", 140)
    self:SetModelScale(1.75)
    local id = self:GetCreationID()
    timer.Remove("Horde_FlayerRage" .. id)
    timer.Create("Horde_FlayerRage" .. id, 10, 1, function ()
        if not IsValid(self) then 
            return 
        end
        self:Rage()
    end)
    local mat = Material("models/horde/lesion/lesion_sheet", "mips smooth")
    self:SetSubMaterial(0, "models/horde/lesion/lesion_sheet")
    self:AddRelationship("npc_headcrab_poison D_LI 99")
    self:AddRelationship("npc_headcrab_fast D_LI 99")
end
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
    if isProp then 
        return 
    end
    if hitEnt and IsValid(hitEnt) and hitEnt:IsPlayer() then
        self:UnRage()
        hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 30, self)
    elseif not self.Raging then
        local id = self:GetCreationID()
        timer.Remove("Horde_FlayerRage" .. id)
        timer.Create("Horde_FlayerRage" .. id, 10, 1, function ()
            if not IsValid(self) then 
                return 
            end
            self:Rage()
        end)
    end
end
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
    return self:GetForward()*130 + self:GetUp()*100
end
function ENT:CustomOnMeleeAttack_Miss()
    if not self.Raging then
        local id = self:GetCreationID()
        timer.Remove("Horde_FlayerRage" .. id)
        timer.Create("Horde_FlayerRage" .. id, 10, 1, function ()
            if not IsValid(self) then 
                return 
            end
            self:Rage()
        end)
    end
end
function ENT:CustomOnLeapAttack_BeforeChecks(hitEnt, isProp)
    self:EmitSound("horde/lesion/lesion_leap.wav", 140)
end
function ENT:CustomOnLeapAttack_AfterChecks(hitEnt, isProp)
    if isProp then 
        return 
    end
    if hitEnt and IsValid(hitEnt) and (HORDE:IsPlayerOrMinion(hitEnt) == true) then
        self:UnRage()
        hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 60, self)
    end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    self.DamageReceived = self.DamageReceived + dmginfo:GetDamage()
    if self.DamageReceived >= self:GetMaxHealth() * 0.25 then
        if self.Horde_Stunned then 
            return 
        end
        self:Rage()
        self.DamageReceived = 0
    end
end
function ENT:Rage()
    if self.Raging or self.Raged then 
        return 
    end
    self.Raging = true
    self:EmitSound("horde/lesion/lesion_enrage.wav", 140)
    self:VJ_ACT_PLAYACTIVITY("BR2_Roar", true, 1.5, false)
    timer.Simple(1.5, function ()
        if not IsValid(self) then 
            return 
        end
        self:SetColor(Color(255, 50, 50))
        self.AnimTbl_Run = ACT_RUN
        self.HasLeapAttack = true
        self.FootStepTimeRun = 0.25
        self.Raged = true
        self.Raging = false
    end)
end
function ENT:UnRage()
    self:SetColor(Color(255,255,255))
    self.AnimTbl_Run = ACT_WALK
    self.HasLeapAttack = false
    self.FootStepTimeRun = 1
    self.Raged = nil
    self.Raging = nil
    self.DamageReceived = 0
    local id = self:GetCreationID()
    timer.Remove("Horde_FlayerRage" .. id)
    timer.Create("Horde_FlayerRage" .. id, 10, 1, function ()
        if not IsValid(self) then 
            return 
        end
        self:Rage()
    end)
end
function ENT:OnRemove()
    self:StopSound("horde/lesion/lesion_enrage.wav")
    self:StopSound("horde/lesion/lesion_leap.wav")
    self:StopSound("horde/lesion/lesion_roar.wav")
end

ENT.DamageReceived = 0
ENT.Raged = false
ENT.Raging = false
VJ.AddNPC("Lesion", "npc_vj_horde_lesion", "Zombies")
