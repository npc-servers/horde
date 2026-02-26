if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Platoon Heavy M249"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "ar2"

SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

SWEP.NPC_NextPrimaryFire = 5
SWEP.NPC_TimeUntilFireExtraTimers = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1 }
SWEP.NPC_CanBePickedUp = false

SWEP.NPC_ReloadSound = { "vj_weapons/reload_rifle.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.HasDryFireSound = false

SWEP.Primary.ClipSize = 100
SWEP.Primary.Ammo = "AR2"

SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Sound = "^horde/weapons/plague/lmg_fire.wav"
SWEP.Primary.SoundLevel = 140
SWEP.Primary.SoundPitch	= VJ_Set( 100, 105 )
SWEP.Primary.HasDistantSound = false

SWEP.PrimaryEffects_SpawnShells = false

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end

	local bullet = ents.Create( "obj_vj_horde_bullet" )
	bullet:SetPos( self:GetAttachment ( self:LookupAttachment( "muzzle" ) ) .Pos )
	bullet:SetAngles( self:GetOwner():GetAngles() )
	bullet:SetOwner( self:GetOwner() )
	bullet:Activate()
	bullet:Spawn()

	bullet.DirectDamage = 8

	if self.Owner.Weaken then
		bullet.Weaken = true
	elseif self.Owner.Hinder then
		bullet.Hinder = true
	end

	local phy = bullet:GetPhysicsObject()
	if not phy:IsValid() then return end

	local dir = ( self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos() )
	dir:Normalize()
	dir = dir + VectorRand() * 0.03
	dir:Normalize()
	phy:ApplyForceCenter( dir * 4000 )
end

function SWEP:CustomOnThink()
	if not self.Critical and self:GetOwner() and IsValid( self:GetOwner() ) then
		if not self:GetOwner().Critical then return end

		self.NPC_NextPrimaryFire = 3
	end
end