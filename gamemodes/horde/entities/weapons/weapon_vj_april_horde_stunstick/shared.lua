SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Stunstick"
SWEP.Author = "DrVrej"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"
SWEP.MadeForNPCsOnly = true

SWEP.NPC_NextPrimaryFire = 1
SWEP.NPC_TimeUntilFire = 0.5

SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.HoldType = "melee"

SWEP.Primary.Damage = 5
SWEP.IsMeleeWeapon = true
SWEP.MeleeWeaponSound_Hit = { "weapons/stunstick/stunstick_fleshhit1.wav", "weapons/stunstick/stunstick_fleshhit2.wav" }
SWEP.MeleeWeaponSound_Miss = { "weapons/stunstick/stunstick_swing1.wav", "weapons/stunstick/stunstick_swing2.wav" }

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	local meleeHitEnt = false
	local owner = self:GetOwner()
		for _, v in ipairs( ents.FindInSphere( owner:GetPos(), self.MeleeWeaponDistance ) ) do
			if ( ( v:IsNPC() or ( v:IsPlayer() and v:Alive() ) ) and ( owner:Disposition( v ) ~= D_LI ) and ( v ~= owner ) and ( v:GetClass() ~= owner:GetClass() ) or ( v:GetClass() == "prop_physics" ) or v:GetClass() == "func_breakable_surf" or v:GetClass() == "func_breakable" and ( owner:GetForward():Dot( ( v:GetPos() -owner:GetPos() ):GetNormalized() ) > math.cos( math.rad( owner.MeleeAttackDamageAngleRadius ) ) ) ) then
				local dmginfo = DamageInfo()
				dmginfo:SetDamage( self.Primary.Damage )
				dmginfo:SetInflictor( owner )
				dmginfo:SetAttacker( owner )
				dmginfo:SetDamageType( DMG_SLASH )
				v:TakeDamageInfo( dmginfo, owner )
				if v:IsPlayer() then
					v:ViewPunch( Angle( math.random( -1, 1 ) * 10, math.random( -1, 1 ) * 10, math.random( -1, 1 ) * 10 ) )
					v:Horde_AddDebuffBuildup( HORDE.Status_Shock, 30, owner )
				end
				VJ_DestroyCombineTurret( owner, v )
				self:CustomOnPrimaryAttack_MeleeHit( v )
				meleeHitEnt = true
			end
		end
		if meleeHitEnt == true then
			local meleeSd = VJ_PICK( self.MeleeWeaponSound_Hit )
			if meleeSd ~= false then
				self:EmitSound( meleeSd, 100, math.random( 90, 100 ) )
			end
		else
			if owner.IsVJBaseSNPC == true then owner:CustomOnMeleeAttack_Miss() end
			local meleeSd = VJ_PICK( self.MeleeWeaponSound_Miss )
			if meleeSd ~= false then
				self:EmitSound( meleeSd, 100, math.random( 90, 100 ) )
			end
		end
	return true
end