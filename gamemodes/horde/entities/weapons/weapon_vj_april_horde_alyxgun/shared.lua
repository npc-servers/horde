if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Alyx Gun"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "pistol"

SWEP.WorldModel = "models/weapons/w_alyx_gun.mdl"

SWEP.NPC_NextPrimaryFire = 5
SWEP.NPC_TimeUntilFireExtraTimers = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 }
SWEP.NPC_CanBePickedUp = false

SWEP.NPC_ReloadSound = { "vj_weapons/reload_pistol.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.HasDryFireSound = false

SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "SMG1"

SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Sound = { "^weapons/alyx_gun/alyx_gun_fire5.wav", "^weapons/alyx_gun/alyx_gun_fire6.wav" }
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

	bullet.DirectDamage = 9

	local phy = bullet:GetPhysicsObject()
	if not phy:IsValid() then return end

	local dir = ( self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos() )
	dir:Normalize()
	dir = dir + VectorRand() * 0.03
	dir:Normalize()
	phy:ApplyForceCenter( dir * 4000 )
end