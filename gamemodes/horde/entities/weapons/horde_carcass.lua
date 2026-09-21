
AddCSLuaFile()
if CLIENT then
	killicon.Add("horde_carcass", "vgui/hud/punch", Color(0, 0, 0, 255))
end

SWEP.PrintName = "Carcass Biosystem"
SWEP.Author = "Gorlami"
SWEP.Purpose = ""

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

SWEP.HitDistance = 100

SWEP.Charging = 0
SWEP.ChargingTimer = 0

SWEP.Charged = 0
SWEP.Delay = 0.4
SWEP.DrainInterval = 0.1
SWEP.LastDrain = CurTime()
SWEP.BaseDamage = 35
SWEP.TransferInterval = 0.1
SWEP.LastTransfer = CurTime()
SWEP.LastPulse = CurTime()
SWEP.ToggleInterval = 0.5
SWEP.LastToggle = CurTime()
SWEP.ThrustInterval = 1
SWEP.LastThrust = CurTime()
SWEP.Grapper = CurTime()

local sndPowerUp = Sound("horde/player/carcass/intestine_throw.ogg")
local sndTooFar	= Sound("buttons/button10.wav")
local SwingSound = Sound( "WeaponFrag.Throw" )
local HitSound = Sound( "Flesh.ImpactHard" )
local pull = false
local biothruster = true
local intestine_endpos
local target_pos

function SWEP:Initialize()
	nextshottime = CurTime()
	self:SetHoldType( "fist" )
end

function SWEP:SetupDataTables()

	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )
	self:NetworkVar( "Int", 2, "Combo" )

end

function SWEP:SecondaryAttack()
end

function SWEP:UpdateNextIdle()

	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() )

end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Delay )
	self.Charging = 1
	self.ChargingTimer = CurTime() + 0.5

end

function SWEP:Punch(charged)
	self.Charged = charged

	local anim = "fists_left"
	local right = math.random(0,1)
	if ( right == 1) then anim = "fists_right" end
	if ( self:GetCombo() >= 2 ) then
		anim = "fists_uppercut"
	end

	if charged == 1 then
		anim = "fists_uppercut"
	end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( SwingSound )

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.1 )

	self:SetNextPrimaryFire( CurTime() + self.Delay )
end

local phys_pushscale = GetConVar( "phys_pushscale" )

function SWEP:DealDamage()
	local owner = self:GetOwner()

	if SERVER then
		local level = owner:Horde_GetUpgrade("horde_carcass")
		self.BaseDamage = 35 + (9 * level)
	end

	local anim = self:GetSequenceName(owner:GetViewModel():GetSequence())

	owner:LagCompensation( true )

	local tr = util.TraceLine( {
		start = owner:GetShootPos(),
		endpos = owner:GetShootPos() + owner:GetAimVector() * self.HitDistance,
		filter = owner,
		mask = MASK_SHOT_HULL
	} )

	if ( not IsValid( tr.Entity ) ) then
		tr = util.TraceHull( {
			start = owner:GetShootPos(),
			endpos = owner:GetShootPos() + owner:GetAimVector() * self.HitDistance,
			filter = owner,
			mins = Vector( -10, -10, -8 ),
			maxs = Vector( 10, 10, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	local hitent = tr.Entity

	-- We need the second part for single player because SWEP:Think is ran shared in SP
	if ( tr.Hit and not ( game.SinglePlayer() and CLIENT ) ) then
		self:EmitSound( HitSound )
	end

	if tr.Hit and hitent:IsWorld() and self.Charged == 1 and owner:Horde_GetPerk("carcass_reinforced_arms") then
		local hitnormal = tr.HitNormal
		owner:SetVelocity(owner:GetVelocity() + hitnormal * 250)
	end

	local hit = false
	local scale = phys_pushscale:GetFloat()

	if ( SERVER and IsValid( hitent ) and ( hitent:IsNPC() or hitent:IsPlayer() or hitent:Health() > 0 ) ) then
		local attacker = owner
		if ( not IsValid( attacker ) ) then attacker = self end

		local dmginfo = DamageInfo()
		dmginfo:SetDamage(self.BaseDamage)
		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamageType(DMG_CLUB)
		dmginfo:SetDamagePosition(tr.HitPos)

		local bonus = {increase = 0, more = 1}
		if self.Charged == 1 then
			dmginfo:ScaleDamage(2)
		end
		if owner.Horde_Bio_Thruster_Stack and owner.Horde_Bio_Thruster_Stack > 0 then
			bonus.increase = bonus.increase + owner.Horde_Bio_Thruster_Stack * 0.1
		end

		local grappendix = owner:Horde_GetPerk("carcass_grappendix")
		local vel = owner:GetVelocity():Length()
		if grappendix and vel >= 400 and owner:Horde_GetGadget() ~= "gadget_exoskeleton" then
			bonus.more = bonus.more * math.min(20, vel / 100)
		elseif grappendix and vel >= 400 and ((vel < 1000) or (vel > 1020 )) and owner:Horde_GetGadget() == "gadget_exoskeleton" then
			bonus.more = bonus.more * math.min(20, owner:GetVelocity():Length() / 100)
		elseif owner:GetVelocity():Length() >= 360 then
			bonus.more = bonus.more * math.max(1, owner:GetVelocity():Length() / 180)
		end

		dmginfo:ScaleDamage((1 + bonus.increase) * bonus.more)
		local uppercut = false
		local reinforced = owner:Horde_GetPerk("carcass_reinforced_arms")
		local lvl = owner:Horde_GetUpgrade("horde_carcass")
		local vmult = math.max(1, owner:GetVelocity():Length() / 200)
		if anim == "fists_left" then
			dmginfo:SetDamageForce(owner:GetRight() * 4912 * scale + owner:GetForward() * 9998 * scale) -- Yes we need those specific numbers
		elseif anim == "fists_right" then
			dmginfo:SetDamageForce(owner:GetRight() * -4912 * scale + owner:GetForward() * 9989 * scale)
		elseif anim == "fists_uppercut" then
			dmginfo:SetDamageForce(owner:GetUp() * 5158 * scale + owner:GetForward() * 10012 * scale)
			if reinforced then
				dmginfo:SetDamageForce(owner:GetUp() * 5158 * scale * vmult + owner:GetForward() * 10012 * scale * vmult)
			end
			uppercut = true
		end

		hitent:DispatchTraceAttack(dmginfo, tr, tr.Normal)

		if uppercut then
			local pos, damage = dmginfo:GetDamagePosition(), dmginfo:GetDamage() / 2
			local lvlmult = 5 * lvl
			local dmg = DamageInfo()
			dmg:SetAttacker(attacker)
			dmg:SetInflictor(hitent)
			dmg:SetDamageType(DMG_CLUB)
			dmg:SetDamage(damage)
			dmg:SetDamageForce(Vector(0, 0, 0))
			dmg:SetDamagePosition(pos)
			dmg:SetDamageCustom(HORDE.DMG_SPLASH)

			util.BlastDamageInfo(dmg, pos, (( 140 or ( reinforced and 200 )) + lvlmult) * ( vmult or 1 ))
		end

		SuppressHostEvents( NULL ) -- Let the breakable gibs spawn in multiplayer on client
		SuppressHostEvents( owner )

		hit = true

	end

	if ( IsValid( hitent ) ) then
		local phys = hitent:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( owner:GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos )
		end
	end

	if ( SERVER ) then
		if ( hit and anim ~= "fists_uppercut" ) then
			self:SetCombo( self:GetCombo() + 1 )
		else
			self:SetCombo( 0 )
		end
	end

	owner:LagCompensation( false )

end

function SWEP:OnDrop()
	self:Remove() -- You can't drop fists
end

function SWEP:Reload()
	if CLIENT then return end
	HORDE:UsePerkSkill(self:GetOwner())
end

function SWEP:TwinHeart()
	if self.LastToggle > CurTime() then return end
	self.LastToggle = CurTime() + self.ToggleInterval
	local ply = self:GetOwner()
	if ply.Horde_TwinHeartStack <= 0 then
		ply.TwinHeartToggleOn = false
		return
	end

	if ply.TwinHeartToggleOn then
		ply:EmitSound("items/suitchargeno1.wav")
	else
		ply:EmitSound("buttons/combine_button5.wav")
	end

	ply.TwinHeartToggleOn = not ply.TwinHeartToggleOn
end

function SWEP:AAS_Perfume()
	local ply = self:GetOwner()
	local rocket = ents.Create("projectile_horde_aas_perfume")
	local vel = 2000
	local ang = ply:EyeAngles()

	local src = ply:GetPos() + Vector(0,0,50) + ply:GetEyeTrace().Normal * 5

	if not rocket:IsValid() then print("!!! Invalid Projectile: " .. rocket) return end

	local rocketAng = Angle(ang.p, ang.y, ang.r)

	rocket:SetAngles(rocketAng)
	rocket:SetPos(src)

	rocket:SetOwner(ply)
	rocket.Owner = ply
	rocket.Inflictor = rocket

	rocket.Damage = 100
	rocket.BlastRadius = 150

	local RealVelocity = (ply:GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel / 0.0254
	rocket.CurVel = RealVelocity -- for non-physical projectiles that move themselves

	rocket:Spawn()
	rocket:Activate()
	if not rocket.NoPhys and rocket:GetPhysicsObject():IsValid() then
		rocket:SetCollisionGroup(rocket.CollisionGroup or COLLISION_GROUP_DEBRIS)
		rocket:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
	end

	if rocket.Launch and rocket.SetState then
		rocket:SetState(1)
		rocket:Launch()
	end

	ply:EmitSound("horde/player/carcass/aas.ogg")
end

function SWEP:Deploy()

	local speed = cvars.Number( "sv_defaultdeployspeed", 4)

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	vm:SetPlaybackRate( speed )

	self:SetNextPrimaryFire( CurTime() + vm:SequenceDuration() / speed )
	self:SetNextSecondaryFire( CurTime() + vm:SequenceDuration() / speed )
	self:UpdateNextIdle()

	if ( SERVER ) then
		self:SetCombo( 0 )
	end

	return true

end

function SWEP:Holster()

	self:SetNextMeleeAttack( 0 )

	return true

end

function SWEP:DoTrace( endpos )
	local trace = {}
		trace.start = self:GetOwner():GetShootPos()
		trace.endpos = trace.start + ( self:GetOwner():GetAimVector() * 14096 ) --14096 is length modifier.
		if ( endpos ) then trace.endpos = ( endpos - self.Tr.HitNormal * 7 ) end
		trace.filter = { self:GetOwner(), self }

	self.Tr = nil
	self.Tr = util.TraceLine( trace )
end

function SWEP:StartAttack()
	local ply = self:GetOwner()
	if SERVER and ply:Horde_GetPerk( "carcass_bio_thruster" ) then
		if not ply:IsValid() then return end
		if self.LastThrust > CurTime() then return end

		if ( ply:Health() <= ( ply:GetMaxHealth() * 0.05 * math.max( 1, ply.Horde_Bio_Thruster_Stack ))) then
			self.LastThrust = CurTime() + self.ThrustInterval
			ply:EmitSound( sndTooFar )
			return
		end

		self.LastThrust = CurTime() + self.ThrustInterval
		local id = ply:SteamID()
		timer.Remove( "Horde_BioThrusterDegen" .. id )
		timer.Create( "Horde_BioThrusterDegen" .. id, 4, 0, function ()
			if not ply:IsValid() then
				timer.Remove( "Horde_BioThrusterDegen" .. id )
				return
			end
			if not ply:Alive() then return end
			ply.Horde_Bio_Thruster_Stack = math.max( 0, ply.Horde_Bio_Thruster_Stack - 1 )
			ply:Horde_SyncStatus( HORDE.Status_Bio_Thruster, ply.Horde_Bio_Thruster_Stack )
		end)

		ply.Horde_Bio_Thruster_Stack = math.min( 5, ply.Horde_Bio_Thruster_Stack + 1 )
		ply:Horde_SyncStatus( HORDE.Status_Bio_Thruster, ply.Horde_Bio_Thruster_Stack )

		local dir = ply:GetAimVector()
		dir:Normalize()

		local force = 800
		local vel = dir * force
		ply:SetLocalVelocity( vel )

		ply:SetHealth( math.max( 1, ply:Health() - ply:GetMaxHealth() * 0.05 * ply.Horde_Bio_Thruster_Stack ))
		ply:EmitSound( "horde/player/carcass/biothruster" .. math.random(1,2) .. ".ogg" )
		ply:EmitSound( "horde/player/carcass/pain.ogg" )
		return
	end

	if SERVER and ply:Horde_GetPerk( "carcass_grappendix" ) then
	else
		return
	end
	-- Get begining and end poins of trace.
	local gunPos = ply:GetShootPos() -- Start of distance trace.
	local disTrace = ply:GetEyeTrace() -- Store all results of a trace in disTrace.
	local hitPos = disTrace.HitPos -- Stores Hit Position of disTrace.

	-- Calculate Distance
	-- Thanks to rgovostes for this code.
	local x = ( gunPos.x - hitPos.x ) ^ 2;
	local y = ( gunPos.y - hitPos.y ) ^ 2;
	local z = ( gunPos.z - hitPos.z ) ^ 2;
	local distance = math.sqrt( x + y + z );

	-- Only latches if distance is less than distance CVAR, or CVAR negative
	local distanceCvar = 1000
	inRange = false
	if distanceCvar < 0 or distance <= distanceCvar then
		inRange = true
	end

	if inRange then
		if SERVER then

			if not self.Horde_Intestine then -- If the beam does not exist, draw the beam.
				-- grapple_beam
				self.Horde_Intestine = ents.Create( "horde_intestine" )
					self.Horde_Intestine:SetPos( ply:GetShootPos() )
					self.Horde_Intestine.Owner = ply
				self.Horde_Intestine:Spawn()
			end

			self.Horde_Intestine:SetParent( ply )
			self.Horde_Intestine:SetOwner( ply )
		end

		self:DoTrace()
		self.speed = 10000 -- Rope latch speed. Was 3000.
		self.startTime = CurTime()
		self.endTime = CurTime() + self.speed
		self.dtt = -1

		if ( SERVER and self.Horde_Intestine ) then
			if self.Tr.Entity:IsNPC() then
				self.Horde_Intestine:GetTable():SetEndPos( self.Tr.HitPos + self.Tr.Entity:OBBCenter() )
			else
				self.Horde_Intestine:GetTable():SetEndPos( self.Tr.HitPos )
			end

		end

		self:UpdateAttack()
		--hacky fix for the grappendix sound
		if self:GetOwner():Health() <= 1 then
		ply:EmitSound( sndTooFar )
		return end

	else
		-- Play a sound
		ply:EmitSound( sndTooFar )
	end
end

function SWEP:UpdateAttack()
	local owner = self:GetOwner()
	if not owner then return end
	if owner:Horde_GetPerk( "carcass_bio_thruster" ) then return end
	if not ( owner:Horde_GetPerk( "carcass_grappendix" )) then return end

	owner:LagCompensation( true )

	if not intestine_endpos then
		intestine_endpos = self.Tr.HitPos
		if IsValid(self.Tr.Entity) and self.Tr.Entity:IsNPC() then
			intestine_endpos = intestine_endpos + self.Tr.Entity:OBBCenter()
		end
		if pull == true then
			target_pos = owner:GetPos() + owner:OBBCenter()
		else
			target_pos = self.Tr.HitPos
		end
	end

	if SERVER and self.Horde_Intestine then
		self.Horde_Intestine:GetTable():SetEndPos( intestine_endpos )
	end

	if self.Tr.Entity:IsValid() then
		intestine_endpos = self.Tr.Entity:GetPos()
		if self.Tr.Entity:IsNPC() then
			intestine_endpos = intestine_endpos + self.Tr.Entity:OBBCenter()
		end
		if SERVER then
			self.Horde_Intestine:GetTable():SetEndPos( intestine_endpos )
			if pull == true and not HORDE:IsEnemy( self.Tr.Entity ) then
				return
			end
		end
	end

	local vVel, Distance
	if pull == true then
		vVel = (( owner:GetPos() + owner:OBBCenter() ) - self.Tr.Entity:GetPos() )
		Distance = self.Tr.Entity:GetPos():Distance( owner:GetPos() + owner:OBBCenter() )
	else
		vVel = ( intestine_endpos - owner:GetPos() )
		Distance = intestine_endpos:Distance( owner:GetPos() )
	end

	local et = ( self.startTime + (Distance / self.speed ))
	if self.dtt ~= 0 then
		self.dtt = ( et - CurTime() ) / ( et - self.startTime )
	end
	if self.dtt < 0 then
		self:GetOwner():EmitSound( sndPowerUp )
		self.dtt = 0
	end

	if self.dtt == 0 then
		local zVel = owner:GetVelocity().z
		vVel = vVel:GetNormalized() * ( math.Clamp( Distance, 0, 7 ) )
		if SERVER then
			local gravity = cvars.Number( "sv_gravity", 600 )
			vVel:Add( Vector( 0, 0, ( gravity / 100 ) * 1.5 )) -- Player speed. DO NOT MESS WITH THIS VALUE!

			if zVel < 0 then
				vVel:Sub( Vector( 0, 0, zVel / 100 ))
			end
			if pull == true then
				self.Tr.Entity:SetVelocity( vVel )
			else
				owner:SetVelocity( vVel * 1.5 )
			end
		end
	end

	intestine_endpos = nil

	if self.LastDrain <= CurTime() then
		owner:SetHealth( math.max( 1, owner:Health() - owner:GetMaxHealth() * 0.01 ))
		if owner:Health() <= 1 then
			self:EndAttack( true )
			--hacky workaround to make the weapon think it couldn't successfully find a trace to achieve the effect of forcibly stopping a grapple
			owner:LagCompensation( false ) --DO NOT REMOVE THIS
			inRange = false
			return
		end
		self.LastDrain = CurTime() + self.DrainInterval
	end

	owner:LagCompensation( false )
end

function SWEP:EndAttack( shutdownsound )

	if CLIENT then return end
	if not self.Horde_Intestine then return end

	self.Horde_Intestine:Remove()
	self.Horde_Intestine = nil
end

local Cur = CurTime()
function SWEP:Think()
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if ( idletime > 0 and CurTime() > idletime ) then
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
		self:UpdateNextIdle()
	end

	local meleetime = self:GetNextMeleeAttack()

	if ( meleetime > 0 and CurTime() > meleetime ) then
		self:DealDamage()
		self:SetNextMeleeAttack( 0 )
	end

	if self.Charging == 1 and not owner:KeyDown( IN_ATTACK ) and owner:KeyDownLast( IN_ATTACK ) and ( CurTime() >= Cur + self.Delay ) then
		Cur = CurTime()
		owner:SetAnimation( PLAYER_ATTACK1 )
	end

	if SERVER and self.Charging == 1 and not owner:KeyDown( IN_ATTACK ) then
		self:SetNextPrimaryFire( CurTime() + self.Delay )
		self.Charging = 0

		if self.ChargingTimer <= CurTime() then
			self:Punch( 1 )
		else
			self:Punch( 0 )
		end
	end


	if SERVER and self.Charging == 1 then
		self:SetNextPrimaryFire( CurTime() + self.Delay )
	end

	if SERVER and self.Charging == 1 and self.ChargingTimer <= CurTime() + 0.2 then
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "seq_admire" ) )
	end

	if ( SERVER and CurTime() > self:GetNextPrimaryFire() + 0.1 ) then

		self:SetCombo( 0 )

	end

	if owner:KeyPressed( IN_ATTACK2 ) then
		self:StartAttack()
	elseif owner:KeyDown( IN_ATTACK2 ) and inRange then
		self:UpdateAttack()
	elseif owner:KeyReleased( IN_ATTACK2 ) and inRange then
		self:EndAttack( true )
		owner:LagCompensation( false )
	end

	if SERVER then
		local ply = self:GetOwner()
		if ply.TwinHeartToggleOn and self.LastTransfer <= CurTime() and ply.TwinHeartToggleOn == true then
			if ply.Horde_TwinHeartStack <= 0 or ply:Horde_HasDebuff( HORDE.Status_Decay ) then
				ply.TwinHeartToggleOn = false
				ply:EmitSound( "items/suitchargeno1.wav" )
				return
			end

			if ply:Health() < ply:GetMaxHealth() then
				ply.Horde_TwinHeartStack = math.max( 0, ply.Horde_TwinHeartStack - 1 )
				ply:Horde_SyncStatus( HORDE.Status_Twin_Heart, ply.Horde_TwinHeartStack )
				ply:SetHealth( math.min( ply:GetMaxHealth(), ply:Health() + ply:GetMaxHealth() * 0.01 ))
				self.LastTransfer = CurTime() + self.TransferInterval
			end
		end
		if  ply.TwinHeartToggleOn and ply.TwinHeartToggleOn == true and ply.Horde_TwinHeartStack >= 1 and self.LastPulse <= CurTime() and self.LastToggle > CurTime() then
			local rad, pos = 220, ply:GetPos()
			local e = EffectData()
			e:SetNormal( Vector( 0, 0, 1 ) )
			e:SetOrigin( pos )
			e:SetRadius( rad )
			util.Effect( "horde_twin_heart", e, true, true )
			self.LastPulse = CurTime() + 10
			ply:EmitSound( "horde/player/life_diffuser.ogg", 100, 80, 1, CHAN_AUTO )

			for _, target in ipairs( ents.FindInSphere( pos, rad ) ) do
				if IsValid( target ) and HORDE:IsEnemy( target ) and target.Horde_Mutation and table.Count( target.Horde_Mutation ) > 0  then
					target:Horde_UnsetMutations()
				end
			end
		end
	end
end

if CLIENT then
	surface.CreateFont( "Carcass_velocity", { font = "Trebuchet18", size = ScreenScale( 5.7 ), weight = 1000, extended = true, blursize = 0, scanlines = 0, antialias = false, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = true, } )
end

function SWEP:DrawHUD()
	if CLIENT then
		local owner = self:GetOwner()
		if tobool( owner:GetInfoNum( "horde_carcass_spedometer", 1 ) ) then
			local CLR_W = Color( 255, 255, 255, 175 )

			local vel = owner:GetVelocity():Length()
			local veltext = "Velocity:"
			local velocity =  math.Truncate( vel, 0 )
			local grappendix = owner:Horde_GetPerk( "carcass_grappendix" )
			local spedometer_x = owner:GetInfoNum( "horde_carcass_spedometer_x", 2 )
			local spedometer_y = owner:GetInfoNum( "horde_carcass_spedometer_y", 1.8 )
			local style = owner:GetInfoNum( "horde_carcass_spedometer_style", 1 )
			local clampedVel = math.Clamp( vel / 10, 0, 350 )
			local alpha = 255

			if style == 1 then
				draw.RoundedBox( 10, ( ScrW() / spedometer_x ) - ScreenScale( 15 ), ScrH() / spedometer_y + ScreenScale( 0.2 ), ScreenScale( 30 ), ScreenScale( 12 ), Color( 40, 40, 40, 150 ) )
			end

			if style == 2 then
				draw.RoundedBoxEx( 10, ( ScrW() / spedometer_x ) - ScreenScale( 14 ), ScrH() / spedometer_y + ScreenScale( 1 ), ScreenScale( 30 ), ScreenScale( 12 ), Color( 146, 16, 92, 100 ), true, false, false, true )
				draw.RoundedBoxEx(10, ( ScrW() / spedometer_x ) - ScreenScale( 15 ), ScrH() / spedometer_y, ScreenScale( 30 ), ScreenScale( 12 ), Color( 40, 40, 40, 150 ), true, false, false, true )
			end

			if style <= 2 then --changes to alpha based on style choice have to be defined before color changes
				alpha = 230
			else
				alpha = 150
			end
			if vel >= 2000 then
				CLR_W = Color( 0, 255, 255, alpha )
			elseif grappendix and vel >= 400 and owner:Horde_GetGadget() ~= "gadget_exoskeleton" then
				CLR_W = Color( 0, 255, 179, alpha )
			elseif grappendix and vel >= 400 and ( ( vel < 1000 ) or ( vel > 1020 ) ) and owner:Horde_GetGadget() == "gadget_exoskeleton" then
				CLR_W = Color( 0, 255, 179, alpha )
			elseif vel >= 360 then
				CLR_W = Color( 21, 255, 0, alpha )
			else
				CLR_W = Color( 255, 0, 0, alpha )
			end

			if style <= 2 then
				draw.DrawText( veltext .. "\n" .. velocity, "Carcass_velocity", ScrW() / spedometer_x, ScrH() / spedometer_y, CLR_W, TEXT_ALIGN_CENTER, true )
			end

			if style == 3 then
				draw.RoundedBoxEx( 20, ( ScrW() / spedometer_x ) - ( clampedVel / 4 ) + ScreenScale( 1 ), ScrH() / spedometer_y + ScreenScale( 1 ), clampedVel / 2, ScreenScale( 5 ), Color( 40, 40, 40, 150 ), true, false, false, true )
				draw.RoundedBoxEx( 20, ( ScrW() / spedometer_x ) - ( clampedVel / 4 ), ScrH() / spedometer_y, clampedVel / 2, ScreenScale( 5 ), CLR_W, true, false, false, true )
			end

			if style == 4 then
				draw.RoundedBoxEx( 20, ( ScrW() / spedometer_x ) + ScreenScale( 1 ), ( ScrH() / spedometer_y ) - ( clampedVel / 4 ) + ScreenScale( 1 ), ScreenScale( 5 ), clampedVel / 2, Color( 40, 40, 40, 150 ), true, false, false, true )
				draw.RoundedBoxEx( 20, ScrW() / spedometer_x, ( ScrH() / spedometer_y ) - ( clampedVel / 4 ), ScreenScale( 5 ), clampedVel / 2, CLR_W, true, false, false, true )
			end
		end
	end
end