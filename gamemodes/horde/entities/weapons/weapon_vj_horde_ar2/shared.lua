if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Plague Elite AR2"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "ar2"

SWEP.WorldModel = "models/weapons/w_irifle.mdl"

SWEP.NPC_NextPrimaryFire = 3
SWEP.NPC_TimeUntilFireExtraTimers = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6 }
SWEP.NPC_CanBePickedUp = false

SWEP.NPC_ReloadSound = { "weapons/ar2/npc_ar2_reload.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.NPC_HasSecondaryFire = true
SWEP.NPC_SecondaryFireEnt = "obj_vj_horde_cball"
SWEP.NPC_SecondaryFireChance = 1
SWEP.NPC_SecondaryFireDistance = 1500
SWEP.NPC_SecondaryFireNext = VJ_Set(15, 18)
SWEP.NPC_SecondaryFireSound = { ")weapons/irifle/irifle_fire2.wav" }

SWEP.HasDryFireSound = false

SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "AR2"

SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Sound = "^weapons/ar1/ar1_dist1.wav"
SWEP.Primary.SoundLevel = 140
SWEP.Primary.SoundPitch	= VJ_Set( 95, 105 )
SWEP.Primary.HasDistantSound = false

SWEP.PrimaryEffects_MuzzleParticles = { "vj_rifle_full_blue" }
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_DynamicLightColor = Color( 0, 31, 225 )

function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end

	local bullet = ents.Create( "obj_vj_horde_bullet" )
	bullet:SetPos( self:GetAttachment ( self:LookupAttachment( "muzzle" ) ) .Pos )
	bullet:SetAngles( self:GetOwner():GetAngles() )
	bullet:SetOwner( self:GetOwner() )
	bullet:Activate()
	bullet.TracerColor = Color( 0, 191, 255 )
	bullet.TracerWidth = 20
	bullet:Spawn()

	bullet.DirectDamage = 4

	local phy = bullet:GetPhysicsObject()
	if not phy:IsValid() then return end

	local dir = ( self:GetOwner():GetEnemy():GetPos() - self:GetOwner():GetPos() )
	dir:Normalize()
	dir = dir + VectorRand() * 0.03
	dir:Normalize()
	phy:ApplyForceCenter( dir * 1500 )
end

function SWEP:NPC_SecondaryFire_BeforeTimer(eneEnt, fireTime)
	local myPos = self:GetOwner():GetPos()
	effects.BeamRingPoint( myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )
	-- effects.BeamRingPoint( myPos, 1.5, 0, 200, 10, 64, Color( 255, 255, 255 ) )

	VJ_EmitSound(self, ")weapons/cguard/charging.wav", 90)
end

function SWEP:NPC_SecondaryFire()
	local owner = self:GetOwner()
	local pos = self:GetNW2Vector( "VJ_CurBulletPos" )
	local proj = ents.Create( self.NPC_SecondaryFireEnt )
	
	proj:SetPos( pos )
	proj:SetAngles( owner:GetAngles() )
	proj:SetOwner(owner)
	proj:Spawn()
	proj:Activate()
	
	local phys = proj:GetPhysicsObject()
	if IsValid( phys ) then
		phys:Wake()
		phys:SetVelocity( owner:CalculateProjectile( "Line", pos, owner.EnemyData.LastVisiblePos, 1000 ) )
	end
end
