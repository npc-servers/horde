if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Weakened SMG1"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "smg"

SWEP.WorldModel = "models/weapons/w_smg1.mdl"

SWEP.NPC_NextPrimaryFire = 7.5
SWEP.NPC_TimeUntilFireExtraTimers = { 0.15, 0.3, 0.45, 0.6, 0.75, 0.9 }
SWEP.NPC_CanBePickedUp = false

SWEP.NPC_ReloadSound = { "vj_weapons/reload_rifle.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.NPC_HasSecondaryFire = true
SWEP.NPC_SecondaryFireEnt = "obj_vj_horde_pzombie_projectile"
SWEP.NPC_SecondaryFireChance = 1
SWEP.NPC_SecondaryFireDistance = 1000
SWEP.NPC_SecondaryFireNext = VJ_Set(15, 18)
SWEP.NPC_SecondaryFireSound = { ")weapons/ar2/ar2_altfire.wav" }

SWEP.HasDryFireSound = false

SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "SMG1"

SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Sound = "^horde/weapons/plague/smg_fire.wav"
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

	bullet.DirectDamage = 3

	local phy = bullet:GetPhysicsObject()
	if not phy:IsValid() then return end

	local dir = ( self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos() )
	dir:Normalize()
	dir = dir + VectorRand() * 0.03
	dir:Normalize()
	phy:ApplyForceCenter( dir * 4000 )
end

function SWEP:NPC_SecondaryFire_BeforeTimer(eneEnt, fireTime)
	local myPos = self:GetOwner():GetPos()
	effects.BeamRingPoint( myPos, 1.25, 0, 100, 5, 32, Color( 0, 255, 0 ) )
	-- effects.BeamRingPoint( myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )

	VJ_EmitSound(self, ")weapons/physcannon/physcannon_charge.wav", 90)
end

function SWEP:NPC_SecondaryFire()
	local owner = self:GetOwner()
	local pos = self:GetNW2Vector( "VJ_CurBulletPos" )

	local proj = ents.Create( self.NPC_SecondaryFireEnt )
	proj:SetPos(pos)
	proj:SetAngles(owner:GetAngles())
	proj:SetOwner(owner)
	proj:Spawn()
	proj:Activate()

	local phys = proj:GetPhysicsObject()
	if not IsValid( phys ) then return end

	phys:Wake()
	phys:SetVelocity( owner:CalculateProjectile ( "Line", pos, owner.EnemyData.LastVisiblePos, 1000 ) )
end