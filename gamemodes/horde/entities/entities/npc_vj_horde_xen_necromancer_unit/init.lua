AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = { "models/vj_hlr/sven/tor.mdl" }
ENT.StartHealth = 7000
ENT.VJ_NPC_Class = { "CLASS_ZOMBIE", "CLASS_XEN" }
ENT.HullType = HULL_HUMAN
ENT.BloodColor = "Yellow"
ENT.HasMeleeAttack = true
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDamageDistance = 100
ENT.AnimTbl_MeleeAttack = { "vjseq_attack_stab" }
ENT.HasMeleeAttackKnockBack = true
ENT.HasRangeAttack = true
ENT.AnimTbl_RangeAttack = { "vjseq_attack_range_projec" }
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_necromancer_void"
ENT.RangeDistance = 700
ENT.RangeToMeleeDistance = 350
ENT.RangeAttackExtraTimers = { 0.8, 1 }
ENT.TimeUntilRangeAttackProjectileRelease = 0.6
ENT.NextRangeAttackTime = 2
ENT.NextRangeAttackTime_DoRand = 6
ENT.RangeUseAttachmentForPos = true
ENT.RangeUseAttachmentForPosID = "0"
ENT.AnimTbl_Run = {ACT_WALK}
ENT.DisableFootStepOnWalk = true
ENT.AlertSounds_OnlyOnce = true
ENT.HasImpactSounds = false

ENT.SoundTbl_FootStep = {
	"npc/vort/vort_foot1.wav",
	"npc/vort/vort_foot2.wav",
	"npc/vort/vort_foot3.wav",
	"npc/vort/vort_foot4.wav"
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"npc/vort/claw_swing1.wav",
	"npc/vort/claw_swing1.wav"
}
ENT.SoundTbl_MeleeAttack = { "npc/strider/strider_skewer1.wav" }
ENT.SoundTbl_MeleeAttackMiss = {
	"npc/vort/claw_swing1.wav",
	"npc/vort/claw_swing2.wav"
}
ENT.SoundTbl_BeforeRangeAttack = { "horde/weapons/void_projector/void_spear_launch.ogg" }

ENT.SoundTbl_CombatIdle = {
	"aslave/slv_word1.wav",
	"aslave/slv_word2.wav",
	"aslave/slv_word3.wav",
	"aslave/slv_word4.wav",
	"aslave/slv_word5.wav",
	"aslave/slv_word6.wav",
	"aslave/slv_word7.wav",
	"aslave/slv_word8.wav"
}
ENT.SoundTbl_Alert = {
	"aslave/slv_alert1.wav",
	"aslave/slv_alert3.wav",
	"aslave/slv_alert4.wav"
}
ENT.SoundTbl_Pain = {
	"aslave/slv_pain1.wav",
	"aslave/slv_pain2.wav"
}
ENT.SoundTbl_Death = {
	"aslave/slv_die1.wav",
	"aslave/slv_die2.wav"
}

ENT.GeneralSoundPitch1 = 50
ENT.GeneralSoundPitch2 = 50

ENT.BeforeMeleeAttackSoundPitch = VJ_Set(100, 100)
ENT.MeleeAttackSoundPitch = VJ_Set(100, 100)
ENT.BeforeRangeAttackPitch = VJ_Set(100, 100)

ENT.NextBlastTime = CurTime()
ENT.NextBlastCooldown = 10
ENT.NextSummonTime = CurTime()
ENT.NextSummonCooldown = 5
ENT.CanSummon = true
ENT.DamageReceived = 0

function ENT:CustomOnInitialize()
	self:SetSkin(1)
	self:RageTimer()
end

local defAng = Angle(0, 0, 0)

function ENT:CustomOnThink()
	if self.Raged and self:IsOnGround() then
		self:SetLocalVelocity(self:GetMoveVelocity() * 1.5)
	end
	
	if IsValid( self:GetEnemy() ) and self.CanSummon then
		if self.Raging or self.Raged or self.RangeAttacking or self.Slamming then
			return
		end
		if CurTime() > self.NextSummonTime and not IsValid(self.MiniBoss1) and not IsValid(self.MiniBoss2) and self:Health() > self:GetMaxHealth() * 0.5 then
			self.Summoning = true

			self:VJ_ACT_PLAYACTIVITY( "vjseq_summon", true, false, false )

			--ParticleEffect( "aurora_shockwave_debris", self:GetPos(), self:GetAngles(), nil )
			--ParticleEffect( "aurora_shockwave", self:GetPos(), self:GetAngles(), nil )

			sound.Play( "horde/spells/raise.ogg", self:GetPos(), 140, 100 )

			if not IsValid(self.MiniBoss1) then
				self.MiniBoss1 = ents.Create("npc_vj_horde_weeper")
				self.MiniBoss1:SetPos( self:GetPos() + self:GetForward() * 100 + self:GetUp() * 5 )
				self.MiniBoss1:Spawn()
				self.MiniBoss1:SetOwner( self )
				self.MiniBoss1:Activate()
			end

			if not IsValid(self.MiniBoss2) then
				self.MiniBoss2 = ents.Create("npc_vj_horde_yeti")
				self.MiniBoss2:SetPos( self:GetPos() + self:GetForward() * -100 + self:GetUp() * 5 )
				self.MiniBoss2:Spawn()
				self.MiniBoss2:SetOwner( self )
				self.MiniBoss2:Activate()
			end

			local e = EffectData()
			e:SetOrigin( self.MiniBoss1:GetPos() )
			e:SetNormal( Vector( 0, 0, 1 ) )
			e:SetScale( 1.4 )
			util.Effect( "abyssal_roar", e, true, true )

			local e1 = EffectData()
			e1:SetOrigin( self.MiniBoss2:GetPos() )
			e1:SetNormal( Vector( 0, 0, 1 ) )
			e1:SetScale( 1.4 )
			util.Effect( "abyssal_roar", e, true, true )

			timer.Simple(2, function ()
        		if not IsValid( self ) then 
        			return 
        		end
        		self.Summoning = nil
			end)
		end
		self.NextSummonTime = CurTime() + self.NextSummonCooldown
	end

	local enemyDistance = self.NearestPointToEnemyDistance
	if IsValid( self:GetEnemy() ) and enemyDistance < 150 and enemyDistance > 60 then
		if self.Raging or self.RangeAttacking or self.Summoning then
			return
		end
		if CurTime() > self.NextBlastTime then
			self.Slamming = true

			self:VJ_ACT_PLAYACTIVITY("vjseq_slam", true, false, false)

			sound.Play("horde/spells/void_charge.ogg", self:GetPos(), 100, 100)

			self:ShockAttack(0.75)

			self.NextBlastTime = CurTime() + self.NextBlastCooldown

			timer.Simple(2, function ()
        		if not IsValid( self ) then 
        			return 
        		end
        		self.Slamming = nil
			end)
		end
	end
end

function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
    if hitEnt and IsValid( hitEnt ) and hitEnt:IsPlayer() then
        self:UnRage()
    end
end

function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() * math.random( 400, 450 ) + self:GetUp() * 400
end

function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)
	self.RangeAttacking = true
	timer.Simple(2, function ()
		if not IsValid( self ) then 
			return 
		end
		self.RangeAttacking = nil
	end)
end

function ENT:RageTimer()
	local id = self:GetCreationID()
    timer.Remove("Horde_FlayerRage" .. id)
    timer.Create("Horde_FlayerRage" .. id, 15, 1, function ()
        if not IsValid(self) then 
        	return 
        end
        self:Rage()
    end)
end

function ENT:Rage()
    if self.Raging or self.Raged or self.Summoning or self.RangeAttacking or self.Slamming then 
    	return 
    end
    self.Raging = true
    self.CanSummon = false
    self.HasRangeAttack = false

    self:VJ_ACT_PLAYACTIVITY( "vjseq_victory", true, false, false )

    local e = EffectData()
	e:SetOrigin( self:GetPos() )
	e:SetNormal( Vector( 0, 0, 1 ) )
	e:SetScale( 1.4 )
	util.Effect( "abyssal_roar", e, true, true )

	sound.Play( "horde/spectres/abyssal_roar.ogg", self:GetPos(), 140, 100 )

    timer.Simple(2, function ()
        if not IsValid( self ) then 
        	return 
        end
        self.Raged = true
        self.Raging = nil
        self.AnimationPlaybackRate = 1.5
        self.AnimTbl_Run = {ACT_RUN}
    end)
end

function ENT:UnRage()
    self.Raged = nil
    self.Raging = nil
    self.CanSummon = true
    self.HasRangeAttack = true
    self.AnimationPlaybackRate = 1
    self.AnimTbl_Run = {ACT_WALK}
    self:RageTimer()
end

function ENT:ShockAttack(delay)
	timer.Simple(delay, function()
		if not self:IsValid() then 
			return 
		end
		local e = EffectData()
		e:SetOrigin(self:GetPos())
		e:SetNormal(Vector(0,0,1))
		e:SetScale(1.4)
		util.Effect("abyssal_roar", e, true, true)

		sound.Play("npc/vort/vort_explode1.wav", self:GetPos(), 100, 100)

		for _, ent in pairs(ents.FindInSphere(self:GetPos(), 350)) do
            if ent:IsPlayer() then
                local Trace = util.TraceLine({
                    start = self:WorldSpaceCenter(),
                    endpos = ent:WorldSpaceCenter(),
                    mask = MASK_SOLID_BRUSHONLY
                })
                if not Trace.HitWorld then
                    ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 25, self)

                    local dmginfo = DamageInfo()
        			dmginfo:SetAttacker( self )
        			dmginfo:SetInflictor( self )
        			dmginfo:SetDamageType( DMG_REMOVENORAGDOLL )
        			dmginfo:SetDamage(5)
        			dmginfo:SetDamagePosition( ent:GetPos() )
        			ent:TakeDamageInfo( dmginfo )
                end
            end
        end
	end)
end

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    self.DamageReceived = self.DamageReceived + dmginfo:GetDamage()
    if self.DamageReceived >= self:GetMaxHealth() * 0.10 then
        self:Rage()
        self.DamageReceived = 0
    end
    if self:Health() <= self:GetMaxHealth() * 0.5 then
    	if IsValid(self.MiniBoss1) then 
    		local e = EffectData()
			e:SetOrigin( self.MiniBoss1:GetPos() )
			e:SetNormal( Vector( 0, 0, 1 ) )
			e:SetScale( 1.4 )
			util.Effect( "abyssal_roar", e, true, true )
    		self.MiniBoss1:Remove() 
    	end
    	if IsValid(self.MiniBoss2) then
    		local e1 = EffectData()
			e1:SetOrigin( self.MiniBoss2:GetPos() )
			e1:SetNormal( Vector( 0, 0, 1 ) )
			e1:SetScale( 1.4 )
			util.Effect( "abyssal_roar", e, true, true )
    		self.MiniBoss2:Remove() 
    	end
    end
end

VJ.AddNPC( "Xen Necromancer Unit", "npc_vj_horde_xen_necromancer_unit", "Zombies" )

-- horde/spells/raise.ogg // abyssal_roar