SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Stunstick"
SWEP.Author = "DrVrej"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"
SWEP.MadeForNPCsOnly = true -- Is this weapon meant to be for NPCs only?
	-- NPC Settings 
SWEP.NPC_NextPrimaryFire = 1 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire = 0.5 -- How much time until the bullet/projectile is fired?
	-- Main Settings 
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.HoldType = "melee"
	-- Primary Fire 
SWEP.Primary.Damage = 5 -- Damage
SWEP.IsMeleeWeapon = true -- Should this weapon be a melee weapon?
SWEP.MeleeWeaponSound_Hit = {"weapons/stunstick/stunstick_fleshhit1.wav","weapons/stunstick/stunstick_fleshhit2.wav"}
SWEP.MeleeWeaponSound_Miss = {"weapons/stunstick/stunstick_swing1.wav","weapons/stunstick/stunstick_swing2.wav"}

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
    local meleeHitEnt = false
    local owner = self:GetOwner()
		for _,v in ipairs(ents.FindInSphere(owner:GetPos(), self.MeleeWeaponDistance)) do
			if ((v:IsNPC() or (v:IsPlayer() && v:Alive())) && (owner:Disposition(v) ~= D_LI) && (v ~= owner) && (v:GetClass() ~= owner:GetClass()) or (v:GetClass() == "prop_physics") or v:GetClass() == "func_breakable_surf" or v:GetClass() == "func_breakable" && (owner:GetForward():Dot((v:GetPos() -owner:GetPos()):GetNormalized()) > math.cos(math.rad(owner.MeleeAttackDamageAngleRadius)))) then
                local dmginfo = DamageInfo()
				dmginfo:SetDamage(self.Primary.Damage)
				dmginfo:SetInflictor(owner)
				dmginfo:SetAttacker(owner)
				dmginfo:SetDamageType(DMG_SLASH)
				v:TakeDamageInfo(dmginfo, owner)
				if v:IsPlayer() then
					v:ViewPunch(Angle(math.random(-1, 1)*10, math.random(-1, 1)*10, math.random(-1, 1)*10))
                    v:Horde_AddDebuffBuildup(HORDE.Status_Shock, 30, owner)
                end
				VJ_DestroyCombineTurret(owner, v)
				self:CustomOnPrimaryAttack_MeleeHit(v)
				meleeHitEnt = true
			end
		end
		if meleeHitEnt == true then
			local meleeSd = VJ_PICK(self.MeleeWeaponSound_Hit)
			if meleeSd ~= false then
				self:EmitSound(meleeSd, 100, math.random(90, 100))
			end
		else
			if owner.IsVJBaseSNPC == true then owner:CustomOnMeleeAttack_Miss() end
			local meleeSd = VJ_PICK(self.MeleeWeaponSound_Miss)
			if meleeSd ~= false then
				self:EmitSound(meleeSd, 100, math.random(90, 100))
			end
		end
    return true
end