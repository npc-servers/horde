if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Plague Soldier Shotgun"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "shotgun"

SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.NPC_NextPrimaryFire = 5
SWEP.NPC_CanBePickedUp = false

SWEP.NPC_FiringDistanceScale = 0.5

SWEP.NPC_ReloadSound = { "vj_weapons/reload_shotgun.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.NPC_ExtraFireSound = { "vj_weapons/perform_shotgunpump.wav" }
SWEP.NPC_ExtraFireSoundLevel = 75

SWEP.HasDryFireSound = false

SWEP.Primary.ClipSize = 6
SWEP.Primary.Ammo = "Buckshot"

SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Sound = "^horde/weapons/plague/shotgun_fire.ogg"
SWEP.Primary.SoundLevel = 140
SWEP.Primary.SoundPitch	= VJ_Set( 100, 105 )
SWEP.Primary.HasDistantSound = false

SWEP.PrimaryEffects_SpawnShells = false

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end

	for i = 1, 6 do

		local bullet = ents.Create( "obj_vj_horde_bullet" )
		bullet:SetPos( self:GetAttachment ( self:LookupAttachment( "muzzle" ) ) .Pos )
		bullet:SetAngles( self:GetOwner():GetAngles() )
		bullet:SetOwner( self:GetOwner() )
		bullet:Activate()
		bullet:Spawn()

		bullet.DirectDamage = 3

		local phy = bullet:GetPhysicsObject()
		if not phy:IsValid() then return end

		local dir = ( self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos() )
		dir:Normalize()
		dir = dir + VectorRand() * 0.1
		dir:Normalize()
		phy:ApplyForceCenter( dir * 2000 )
	end
end