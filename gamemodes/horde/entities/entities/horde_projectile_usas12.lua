ENT.Base 				= "horde_explosive_projectile_base"
ENT.PrintName 			= "USAS-12 Round"
ENT.Model = "models/items/ar2_grenade.mdl"
ENT.LifeTime = 10 -- Time to removal
ENT.ProjectileDamage = 100 -- Projectile/explosion damage
ENT.ProjectileDamageRadius = 125 -- Explosion radius
ENT.ArmDistance = 150 -- Safety distance
ENT.Decal = "FadingScorch"

ENT.ProjectileExplosionDamageType = DMG_BULLET

ENT.Ticks = 0

AddCSLuaFile()

function ENT:CustomInitialize()
    if !SERVER then return end

    local firemode = self:GetOwner():GetActiveWeapon():GetCurrentFiremode()
    if !firemode then
        self.Firemode = 3
    end

    self.Firemode = firemode.Mode

    if self.Firemode == 3 then
        self:SetColor(Color(0, 0, 0))
    elseif self.Firemode == 4 then
        self.ProjectileExplosionDamageType = DMG_BLAST
    end
end

function ENT:CustomOnThink()
    if CLIENT and self.Ticks % 5 == 0 then
        local emitter = ParticleEmitter(self:GetPos())

        if !self:IsValid() or self:WaterLevel() > 2 then return end
        if !IsValid(emitter) then return end

        local smoke = emitter:Add("particle/particle_smokegrenade", self:GetPos())
        smoke:SetVelocity( VectorRand() * 25 )
        smoke:SetGravity( Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-20, -25)) )
        smoke:SetDieTime( math.Rand(1.5, 2.0) )
        smoke:SetStartAlpha( 255 )
        smoke:SetEndAlpha( 0 )
        smoke:SetStartSize( 0 )
        smoke:SetEndSize( 100 )
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor( 20, 20, 20 )
        smoke:SetAirResistance( 5 )
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( false )
        emitter:Finish()
    end

    self.Ticks = self.Ticks + 1
end

function ENT:Detonate(data)
    if !self:IsValid() or self.Removing then return end
    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    local nodetonate = self:CustomOnPreDetonate(data)
    local hitEnt = data.HitEntity
    if nodetonate then self:Remove() return end

    if (self.StartPos:DistToSqr(self:GetPos()) <= self.ArmDistanceSqr) or self.ProjectileSabotRound then
        if self.ProjectileSabotRound then
            self.ProjectileDamage = self.ProjectileDamage * 1.25
        end
        self:FireBullets({
            Attacker = self.Owner,
            Damage = self.ProjectileDamage * 0.85,
            Tracer = 0,
            Distance = 400,
            Dir = (data.HitPos - self:GetPos()),
            Src = self:GetPos(),
            Callback = function(att, tr, dmg)
                dmg:SetDamageType(self.ProjectileUnarmedDamageType)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)

                hook.Run("Horde_OnExplosiveProjectileHeadshot", self.Owner, dmg)
            end
        })
        self.Removing = true
        self:Remove()
        return
    end

    self:CustomOnExplode()

    if self.Horde_Armor_Piercing then
        self.ProjectileDamage = self.ProjectileDamage * 1.15
        self.ProjectileDamageRadius = self.ProjectileDamageRadius * 0.7
    end

    self:FireBullets({
		Attacker = self.Owner,
		Damage = 0,
		Tracer = 0,
		Distance = 400,
		Dir = (data.HitPos - self:GetPos()),
		Src = self:GetPos(),
		Callback = function(att, tr, dmg)
			if tr.HitGroup == HITGROUP_HEAD then
				dmg:SetDamageType(self.ProjectileExplosionDamageType)
				dmg:SetAttacker(self.Owner)
				dmg:SetInflictor(self)
				dmg:SetDamage(self.ProjectileDamage / 2)
                hook.Run("Horde_OnExplosiveProjectileHeadshot", self.Owner, dmg)
			end

            if self.Decal then
                util.Decal(self.Decal, tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
            end
		end
	})
    local dmg2 = DamageInfo()
    dmg2:SetDamageType(self.ProjectileExplosionDamageType)
    dmg2:SetAttacker(attacker)
    dmg2:SetInflictor(self)
    dmg2:SetDamage(self.ProjectileDamage)
    util.BlastDamageInfo(dmg2, self:GetPos(), self.ProjectileDamageRadius)
    hook.Run("Horde_PostExplosiveProjectileExplosion", self.Owner, self, dmg2, self.ProjectileDamageRadius)
    self.Removing = true
    self:Remove()
end

function ENT:CustomOnExplode()
    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )

    if self:WaterLevel() >= 1 then
        util.Effect( "WaterSurfaceExplosion", effectdata )
        self:EmitSound("weapons/underwater_explode3.wav", 125, 100, 1, CHAN_AUTO)

        return
    end

    if self.Firemode == 3 then
        util.Effect( "horde_shrapnel_grenade_explosion", effectdata)
        self:EmitSound("ambient/explosions/explode_1.wav", 100, 100, 1, CHAN_WEAPON)
    elseif self.Firemode == 4 then
        util.Effect( "Explosion", effectdata)
        self:EmitSound("phx/kaboom.wav", 100, 100, 1, CHAN_WEAPON)
    end
end