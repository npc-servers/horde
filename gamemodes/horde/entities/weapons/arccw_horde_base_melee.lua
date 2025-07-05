SWEP.Base = "arccw_base_melee"

function SWEP:MeleeAttack(melee2)
    local reach = 32 + self:GetBuff_Add("Add_MeleeRange") + (melee2 and self.Melee2Range or self.MeleeRange)
    local dmg = self:GetBuff_Override("Override_MeleeDamage", melee2 and self.Melee2Damage or self.MeleeDamage) or 20

    dmg = dmg * self:GetBuff_Mult("Mult_MeleeDamage")

    self:GetOwner():LagCompensation(true)

    local filter = {self:GetOwner()}

    table.Add(filter, self.Shields)

    local tr = util.TraceLine({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * reach,
        filter = filter,
        mask = MASK_SHOT_HULL
    })

    if (!IsValid(tr.Entity)) then
        tr = util.TraceHull({
            start = self:GetOwner():GetShootPos(),
            endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * reach,
            filter = filter,
            mins = Vector(-16, -16, -8),
            maxs = Vector(16, 16, 8),
            mask = MASK_SHOT_HULL
        })
    end

    local hitent = tr.Entity

    -- Backstab damage if applicable
    local backstab = tr.Hit and self:CanBackstab(melee2, hitent)
    if backstab then
        if melee2 then
            local bs_dmg = self:GetBuff_Override("Override_Melee2DamageBackstab", self.Melee2DamageBackstab)
            if bs_dmg then
                dmg = bs_dmg * self:GetBuff_Mult("Mult_MeleeDamage")
            else
                dmg = dmg * self:GetBuff("BackstabMultiplier") * self:GetBuff_Mult("Mult_MeleeDamage")
            end
        else
            local bs_dmg = self:GetBuff_Override("Override_MeleeDamageBackstab", self.MeleeDamageBackstab)
            if bs_dmg then
                dmg = bs_dmg * self:GetBuff_Mult("Mult_MeleeDamage")
            else
                dmg = dmg * self:GetBuff("BackstabMultiplier") * self:GetBuff_Mult("Mult_MeleeDamage")
            end
        end
    end

    -- We need the second part for single player because SWEP:Think is ran shared in SP
    if !(game.SinglePlayer() and CLIENT) then
        if tr.Hit then
            if hitent:IsNPC() or hitent:IsNextBot() or hitent:IsPlayer() then
                self:MyEmitSound(self.MeleeHitNPCSound, 75, 100, 1, CHAN_USER_BASE + 2)
            else
                self:MyEmitSound(self.MeleeHitSound, 75, 100, 1, CHAN_USER_BASE + 2)
            end

            if tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_BLOODYFLESH then
                local fx = EffectData()
                fx:SetOrigin(tr.HitPos)

                util.Effect("BloodImpact", fx)
            end
        else
            self:MyEmitSound(self.MeleeMissSound, 75, 100, 1, CHAN_USER_BASE + 3)
        end
    end

    if SERVER and IsValid(hitent) and (hitent:IsNPC() or hitent:IsPlayer() or hitent:Health() > 0) then
        local attacker = self:GetOwner()
        if !IsValid(attacker) then attacker = self end

        local dmginfo = DamageInfo()
        dmginfo:SetDamage(dmg)
        dmginfo:SetAttacker(attacker)
        dmginfo:SetInflictor(self)
        dmginfo:SetDamageType(self:GetBuff_Override("Override_MeleeDamageType") or self.MeleeDamageType or DMG_CLUB)
        dmginfo:SetDamagePosition(tr.HitPos)
	dmginfo:SetDamageForce(self:GetOwner():GetRight() * -4912 + self:GetOwner():GetForward() * 9989)
        if hitent:IsPlayer() and tr.HitGroup == HITGROUP_HEAD then hitent:SetLastHitGroup(HITGROUP_HEAD) end

        hitent:DispatchTraceAttack( dmginfo, tr, tr.Normal )

        if hitent:GetClass() == "func_breakable_surf" then
            hitent:Fire("Shatter", "0.5 0.5 256")
        end

    end

    if SERVER and IsValid(hitent) and IsValid(self:GetOwner()) then
        local phys = hitent:GetPhysicsObject()
        if IsValid(phys) then
            phys:ApplyForceOffset(self:GetOwner():GetAimVector() * 80 * phys:GetMass(), tr.HitPos)
        end
    end

    self:GetBuff_Hook("Hook_PostBash", {tr = tr, dmg = dmg, melee2 = melee2})

    self:GetOwner():LagCompensation(false)
end