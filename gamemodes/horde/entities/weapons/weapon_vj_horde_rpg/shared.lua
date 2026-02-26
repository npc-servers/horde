if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Platoon Demolitionist RPG"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "rpg"

SWEP.WorldModel = "models/vj_weapons/w_ins_rpg7.mdl"
SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector( -10, 0, 180 )
SWEP.WorldModel_CustomPositionOrigin = Vector( -1.5, -0.5, 1 )

SWEP.NPC_NextPrimaryFire = 8
SWEP.NPC_TimeUntilFire = 0.8
SWEP.NPC_CanBePickedUp = false
SWEP.NPC_StandingOnly = true

SWEP.NPC_FiringDistanceScale = 2.5

SWEP.NPC_ReloadSound = { "vj_weapons/reload_rpg.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.HasDryFireSound = false

SWEP.Primary.ClipSize = 1
SWEP.Primary.Ammo = "RPG_Round"

SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Sound = "^horde/weapons/plague/rpg_fire.wav"
SWEP.Primary.SoundLevel = 140
SWEP.Primary.SoundPitch	= VJ_Set( 100, 105 )
SWEP.Primary.HasDistantSound = false

SWEP.PrimaryEffects_SpawnShells = false

function SWEP:CustomOnThink()
	if not self.Critical and self:GetOwner() and IsValid( self:GetOwner() ) then
		if not self:GetOwner().Critical then return end

		self.NPC_NextPrimaryFire = 5
	end
end

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end

	local owner = self:GetOwner()
	local proj = ents.Create( "obj_vj_horde_platoon_rpg_projectile" )
	local ply_Ang = owner:GetAimVector():Angle()
	local ply_Pos = owner:GetShootPos() + ply_Ang:Forward() * -20 + ply_Ang:Up() * -9 + ply_Ang:Right() * 10
	proj:SetPos( self:GetNW2Vector( "VJ_CurBulletPos" ) )
	proj:SetAngles( owner:GetAngles() )
	proj:SetOwner( owner )
	proj:Activate()
	proj:Spawn()

	local phys = proj:GetPhysicsObject()
	if not IsValid( phys ) then return end
	
	phys:SetVelocity( owner:CalculateProjectile ( "Line", self:GetNW2Vector( "VJ_CurBulletPos" ), owner:GetEnemy():GetPos() + owner:GetEnemy():OBBCenter(), 2500 ) )

	self:SetBodygroup(1, 1)
end

function SWEP:CustomOnPrimaryAttackEffects()
	ParticleEffectAttach( "smoke_exhaust_01a", PATTACH_POINT_FOLLOW, self, 2 )
	-- ParticleEffectAttach( "smoke_exhaust_01a", PATTACH_POINT_FOLLOW, self, 2 )
	-- ParticleEffectAttach( "smoke_exhaust_01a", PATTACH_POINT_FOLLOW, self, 2 )
	timer.Simple( 4, function() if IsValid( self ) then self:StopParticles() end end )
	return true
end

function SWEP:CustomOnReload_Finish()
	self:SetBodygroup( 1, 0 )
	return true
end