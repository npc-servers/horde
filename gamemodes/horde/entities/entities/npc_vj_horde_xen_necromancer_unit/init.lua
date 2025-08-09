AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = { "models/vj_hlr/sven/tor.mdl" }
ENT.EntitiesToNoCollide = {"npc_vj_horde_yeti","npc_vj_horde_weeper"}
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
ENT.RangeDistance = 1250
ENT.RangeToMeleeDistance = 350
ENT.NextRangeAttackTime = 1
ENT.NextRangeAttackTime_DoRand = 3
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
ENT.SoundTbl_BeforeRangeAttack = { "horde/spells/void_charge.ogg" }
ENT.SoundTbl_RangeAttack = { "horde/weapons/void_projector/void_spear_launch.ogg" }
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

ENT.BeforeRangeAttackSoundLevel = 100
ENT.RangeAttackSoundLevel = 100

ENT.GeneralSoundPitch1 = 50
ENT.GeneralSoundPitch2 = 50

ENT.BeforeMeleeAttackSoundPitch = VJ_Set(100, 100)
ENT.MeleeAttackSoundPitch = VJ_Set(100, 100)
ENT.BeforeRangeAttackPitch = VJ_Set(100, 100)
ENT.RangeAttackPitch = VJ_Set(100, 100)

ENT.NextBlastTime = CurTime()
ENT.NextBlastCooldown = 10
ENT.NextSummonTime = CurTime()
ENT.NextSummonCooldown = 5
ENT.DamageReceived = 0
ENT.Projectile = 0

function ENT:CustomOnInitialize()
	self:SetSkin(1)
	self:RageTimer()
end

function ENT:CustomOnThink()

	local enemyDistance = self.NearestPointToEnemyDistance

	if self.Raged and self:IsOnGround() then
		self:SetLocalVelocity(self:GetMoveVelocity() * 2)
	end
	
	if IsValid( self:GetEnemy() ) and CurTime() > self.NextSummonTime and self:Health() > self:GetMaxHealth() * 0.5 and enemyDistance >= 150 then
		if not IsValid(self.MiniBoss1) or not IsValid(self.MiniBoss2) or not IsValid(self.MiniBoss3) or not IsValid(self.MiniBoss4) then
		
			self:VJ_ACT_PLAYACTIVITY( "vjseq_summon", true, false, false )

			sound.Play( "horde/spells/raise.ogg", self:GetPos(), 140, 100 )

			if not IsValid(self.MiniBoss1) then
				self.MiniBoss1 = ents.Create("npc_vj_horde_weeper")
				self.MiniBoss1:SetPos( self:GetPos() + self:GetForward() * 50 + self:GetUp() * 5 )
				self.MiniBoss1:Spawn()
				self.MiniBoss1:SetOwner( self )
				self.MiniBoss1:Activate()

				local e = EffectData()
				e:SetOrigin( self.MiniBoss1:GetPos() )
				e:SetNormal( Vector( 0, 0, 1 ) )
				e:SetScale( 1.4 )
				util.Effect( "abyssal_roar", e, true, true )
			end

			if not IsValid(self.MiniBoss2) then
				self.MiniBoss2 = ents.Create("npc_vj_horde_yeti")
				self.MiniBoss2:SetPos( self:GetPos() + self:GetForward() * -50 + self:GetUp() * 5 )
				self.MiniBoss2:Spawn()
				self.MiniBoss2:SetOwner( self )
				self.MiniBoss2:Activate()

				local e1 = EffectData()
				e1:SetOrigin( self.MiniBoss2:GetPos() )
				e1:SetNormal( Vector( 0, 0, 1 ) )
				e1:SetScale( 1.4 )
				util.Effect( "abyssal_roar", e1, true, true )
			end

			if not IsValid(self.MiniBoss3) then
				self.MiniBoss3 = ents.Create("npc_vj_horde_weeper")
				self.MiniBoss3:SetPos( self:GetPos() + self:GetRight() * 50 + self:GetUp() * 5 )
				self.MiniBoss3:Spawn()
				self.MiniBoss3:SetOwner( self )
				self.MiniBoss3:Activate()

				local e2 = EffectData()
				e2:SetOrigin( self.MiniBoss3:GetPos() )
				e2:SetNormal( Vector( 0, 0, 1 ) )
				e2:SetScale( 1.4 )
				util.Effect( "abyssal_roar", e2, true, true )
			end

			if not IsValid(self.MiniBoss4) then
				self.MiniBoss4 = ents.Create("npc_vj_horde_yeti")
				self.MiniBoss4:SetPos( self:GetPos() + self:GetRight() * -50 + self:GetUp() * 5 )
				self.MiniBoss4:Spawn()
				self.MiniBoss4:SetOwner( self )
				self.MiniBoss4:Activate()

				local e3 = EffectData()
				e3:SetOrigin( self.MiniBoss4:GetPos() )
				e3:SetNormal( Vector( 0, 0, 1 ) )
				e3:SetScale( 1.4 )
				util.Effect( "abyssal_roar", e3, true, true )
			end
		end
		self.NextSummonTime = CurTime() + self.NextSummonCooldown
	end

	if IsValid( self:GetEnemy() ) and enemyDistance < 150 and enemyDistance > 60 then
		if CurTime() > self.NextBlastTime then
			self.Slamming = true

			self:VJ_ACT_PLAYACTIVITY("vjseq_slam", true, false, false)

			sound.Play("horde/spells/void_charge.ogg", self:GetPos(), 100, 100)

			self:ShockAttack(0.75)

			self.NextBlastTime = CurTime() + self.NextBlastCooldown

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

function ENT:MultipleRangeAttacks()
	local randomRangeAttack = math.random( 1, 5 )

	if randomRangeAttack == 1 then
		self.HasRangeAttackSound = false
		self.AnimTbl_RangeAttack = { "vjseq_attack_big" }
		self.RangeAttackEntityToSpawn = "obj_vj_horde_necromancer_arrow"
		self.TimeUntilRangeAttackProjectileRelease = 0.2
		self.RangeAttackExtraTimers = { 0.4, 0.6, 0.8 }
		self.RangeAttackPos_Up = 50
	elseif randomRangeAttack == 2 then
		self.HasRangeAttackSound = true
		self.AnimTbl_RangeAttack = { "vjseq_attack_range_projec" }
		self.RangeAttackEntityToSpawn = "obj_vj_horde_necromancer_void_large"
		self.TimeUntilRangeAttackProjectileRelease = 0.8
		self.RangeAttackExtraTimers = nil
		self.RangeAttackPos_Up = 100
	else
		self.HasRangeAttackSound = true
		self.AnimTbl_RangeAttack = { "vjseq_attack_range_projec" }
		self.RangeAttackEntityToSpawn = "obj_vj_horde_necromancer_void"
		self.TimeUntilRangeAttackProjectileRelease = 0.6
		self.RangeAttackExtraTimers = { 0.8, 1 }
		self.RangeAttackPos_Up = 100
	end
end


function ENT:RageTimer()
	local id = self:GetCreationID()
    timer.Remove("Horde_FlayerRage" .. id)
    timer.Create("Horde_FlayerRage" .. id, 20, 1, function ()
        if not IsValid(self) then return end
        self:Rage()
    end)
end

function ENT:Rage()
    if self.Raging or self.Raged then return end
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

    timer.Simple(1, function ()
        if not IsValid( self ) then return end
        self.Raged = true
        self.Raging = nil
        self.AnimTbl_Run = {ACT_RUN}

        timer.Simple(10, function ()
        if not IsValid( self ) and not self.Raging or not self.Raged then return end
        	self:UnRage()
        	self:VJ_ACT_PLAYACTIVITY("vjseq_alert", true, false, false)
    	end)
    end)
end

function ENT:UnRage()
    self.Raged = nil
    self.Raging = nil
    self.CanSummon = true
    self.HasRangeAttack = true
    self.AnimTbl_Run = {ACT_WALK}
    self:RageTimer()
end

function ENT:ShockAttack(delay)
	timer.Simple(delay, function()
		if not self:IsValid() then return end

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
			util.Effect( "abyssal_roar", e1, true, true )
    		self.MiniBoss2:Remove() 
    	end

    	if IsValid(self.MiniBoss3) then
    		local e2 = EffectData()
			e2:SetOrigin( self.MiniBoss3:GetPos() )
			e2:SetNormal( Vector( 0, 0, 1 ) )
			e2:SetScale( 1.4 )
			util.Effect( "abyssal_roar", e2, true, true )
    		self.MiniBoss3:Remove() 
    	end

    	if IsValid(self.MiniBoss4) then
    		local e3 = EffectData()
			e3:SetOrigin( self.MiniBoss4:GetPos() )
			e3:SetNormal( Vector( 0, 0, 1 ) )
			e3:SetScale( 1.4 )
			util.Effect( "abyssal_roar", e3, true, true )
    		self.MiniBoss4:Remove() 
    	end
    end
end

VJ.AddNPC( "Xen Necromancer Unit", "npc_vj_horde_xen_necromancer_unit", "Zombies" )

-- horde/spells/raise.ogg // abyssal_roar
