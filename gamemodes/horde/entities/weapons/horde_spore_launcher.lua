sound.Add(
{
    name = "Weapon_HLOF_Spore_Launcher.Single",
    channel = CHAN_WEAPON,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "horde/weapons/spore_launcher/splauncher_fire.ogg"
} )

sound.Add(
{
    name = "Weapon_HLOF_Spore_Launcher.Double",
    channel = CHAN_WEAPON,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "horde/weapons/spore_launcher/splauncher_altfire.ogg"
} )

sound.Add(
{
    name = "Weapon_HLOF_Spore_Launcher.Reload",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "horde/weapons/spore_launcher/splauncher_reload.ogg"
} )

sound.Add(
{
    name = "Weapon_HLOF_Spore_Launcher.Pet",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "horde/weapons/spore_launcher/splauncher_pet.ogg"
} )

sound.Add(
{
    name = "Weapon_HLOF_Spore_Launcher.Impact",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "horde/weapons/spore_launcher/splauncher_impact.ogg"
} )

sound.Add(
{
    name = "Weapon_HLOF_Spore_Launcher.Bounce",
    channel = CHAN_ITEM,
    volume = VOL_NORM,
    soundlevel = SNDLVL_NORM,
    sound = "horde/weapons/spore_launcher/splauncher_bounce.ogg"
} )

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/horde_spore_launcher" )
    SWEP.DrawWeaponInfoBox = false
    SWEP.BounceWeaponIcon = false
    killicon.Add( "horde_spore_launcher", "vgui/hud/horde_spore_launcher", Color( 255, 255, 255, 255 ) )
    killicon.Add( "horde_spore", "vgui/hud/horde_spore_launcher", Color( 255, 255, 255, 255 ) )
    killicon.Add( "horde_spore_alt", "vgui/hud/horde_spore_launcher", Color( 255, 255, 255, 255 ) )
end

SWEP.PrintName = "Spore Launcher"
SWEP.Category = "Horde"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 85
SWEP.ViewModel = "models/horde/weapons/v_spore_launcher.mdl"
SWEP.WorldModel = "models/horde/weapons/w_spore_launcher.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 1
SWEP.SwayScale = 0

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 5
SWEP.Slot = 4
SWEP.SlotPos = 3

SWEP.UseHands = true
SWEP.HoldType = "shotgun"
SWEP.FiresUnderwater = true
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = true
SWEP.CSMuzzleFlashes = 1
SWEP.Base = "weapon_base"

SWEP.Reloading = 0
SWEP.ReloadingTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Primary.Sound = Sound( "Weapon_HLOF_Spore_Launcher.Single" )
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Gravity"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Delay = 0.5
SWEP.Primary.Force = 100

SWEP.Secondary.Sound = Sound( "Weapon_HLOF_Spore_launcher.Double" )
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Force = 1000

SWEP.ActivePos = Vector( 0, -2, 0 )
SWEP.ActiveAng = Angle( 0, 0, 0 )

function SWEP:Initialize()
    self:SetWeaponHoldType( self.HoldType )
    self.Idle = 0
    self.IdleTimer = CurTime() + 1
end

function SWEP:DrawHUD()
    if CLIENT then
        local owner = self:GetOwner()
        if not IsValid( owner ) then return end

        local x, y
        local tr = owner:GetEyeTrace()

        if owner == LocalPlayer() and owner:ShouldDrawLocalPlayer() then
            local coords = tr.HitPos:ToScreen()
            x, y = coords.x, coords.y
        else
            x, y = ScrW() / 2, ScrH() / 2
        end

        surface.SetTexture( surface.GetTextureID( "vgui/hud/gl_crosshair" ) )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( x - ScrW() / 40, y - ScrW() / 40, ScrW() / 20, ScrW() / 20 )
    end
end

function SWEP:Deploy()
    local owner = self:GetOwner()
    if not IsValid( owner ) then
        return false
    end

    self:SetWeaponHoldType( self.HoldType )
    self:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 0.5 )
    self:SetNextSecondaryFire( CurTime() + 0.5 )
    self.Reloading = 0
    self.ReloadingTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime() + owner:GetViewModel():SequenceDuration()
    return true
end

function SWEP:Holster()
    self.Reloading = 0
    self.ReloadingTimer = CurTime()
    self.Idle = 0
    self.IdleTimer = CurTime()
    return true
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if not IsValid( owner ) then
        return
    end

    if self.Reloading == 1 then
        self.Reloading = 2
        return
    end

    if self.Reloading ~= 0 then
        return
    end

    if SERVER and owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
        self:SetClip1( self.Primary.ClipSize + 1 )
        owner:RemoveAmmo( 1, self.Primary.Ammo, false )
    end

    if self:Clip1() <= 0 then
        self:Reload()
        return
    end

    if not self.FiresUnderwater and owner:WaterLevel() == 3 then
        return
    end

    if SERVER then
        local entity = ents.Create( "horde_spore" )
        entity:SetOwner( owner )

        if IsValid( entity ) then
            local forward = owner:EyeAngles():Forward()
            local right = owner:EyeAngles():Right()
            local up = owner:EyeAngles():Up()

            entity:SetPos( owner:GetShootPos() + forward * 12 + right * 4 + up * -4 )
            entity:SetAngles( owner:EyeAngles() )
            entity:Spawn()

            local phys = entity:GetPhysicsObject()
            phys:SetMass( 1 )
            phys:EnableGravity( false )

            timer.Create( "Flight" .. entity:EntIndex(), 0, 0, function()
                if not IsValid( phys ) then
                    timer.Stop( "Flight" )
                end

                if IsValid( entity ) and IsValid( phys ) then
                    phys:ApplyForceCenter( entity:GetForward() * 100 )
                end
            end )
        end
    end

    self:EmitSound( self.Primary.Sound )
    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    owner:SetAnimation( PLAYER_ATTACK1 )
    self:TakePrimaryAmmo( self.Primary.TakeAmmo )
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self.Idle = 0
    self.IdleTimer = CurTime() + owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()
    if not IsValid( owner ) then
        return
    end

    if self.Reloading == 1 then
        self.Reloading = 2
        return
    end

    if self.Reloading ~= 0 then
        return
    end

    if SERVER and owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
        self:SetClip1( self.Primary.ClipSize + 1 )
        owner:RemoveAmmo( 1, self.Primary.Ammo, false )
    end

    if self:Clip1() <= 0 then
        self:Reload()
        return
    end

    if not self.FiresUnderwater and owner:WaterLevel() == 3 then
        return
    end

    if SERVER then
        local entity = ents.Create( "horde_spore_alt" )
        entity:SetOwner( owner )

        if IsValid( entity ) then
            local forward = owner:EyeAngles():Forward()
            local right = owner:EyeAngles():Right()
            local up = owner:EyeAngles():Up()

            entity:SetPos( owner:GetShootPos() + forward * 12 + right * 4 + up * -4 )
            entity:SetAngles( owner:EyeAngles() )
            entity:Spawn()

            local phys = entity:GetPhysicsObject()
            phys:SetVelocity( owner:GetAimVector() * self.Secondary.Force )
        end
    end

    self:EmitSound( self.Secondary.Sound )
    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    owner:SetAnimation( PLAYER_ATTACK1 )
    self:TakePrimaryAmmo( self.Primary.TakeAmmo )
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self.Idle = 0
    self.IdleTimer = CurTime() + owner:GetViewModel():SequenceDuration()
end

function SWEP:Reload()
    local owner = self:GetOwner()
    if self.Reloading == 0 and self:Clip1() < self.Primary.ClipSize and self:Ammo1() > 0 then
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
        if IsValid( owner ) then
            owner:SetAnimation( PLAYER_RELOAD )
        end
        self:SetNextPrimaryFire( CurTime() + 0.8 )
        self:SetNextSecondaryFire( CurTime() + 0.8 )
        self.Reloading = 1
        self.ReloadingTimer = CurTime() + 0.75 / 1.5
        self.Idle = 1
    end
end

function SWEP:Think()
    local owner = self:GetOwner()
    if IsValid( owner ) then
        if self.Reloading > 0 or self.IdleTimer > CurTime() then
            owner:GetViewModel():SetPlaybackRate( 1.5 )
        else
            owner:GetViewModel():SetPlaybackRate( 1 )
        end
    end

    if self.Reloading == 1 and self.ReloadingTimer <= CurTime() and self:Clip1() < self.Primary.ClipSize and self:Ammo1() > 0 then
        if SERVER then
            owner:EmitSound( "Weapon_HLOF_Spore_Launcher.Reload" )
        end

        self:SendWeaponAnim( ACT_VM_RELOAD )
        self:SetClip1( self:Clip1() + 1 )
        owner:RemoveAmmo( 1, self.Primary.Ammo, false )
        self.ReloadingTimer = CurTime() + 1 / 1.5
        self.Idle = 1
    end

    if self.Reloading == 1 and self.ReloadingTimer <= CurTime() and self:Clip1() == self.Primary.ClipSize then
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 0
        self.ReloadingTimer = CurTime() + 0.5 / 1.5
        self.Idle = 0
        if IsValid( owner ) then
            self.IdleTimer = CurTime() + owner:GetViewModel():SequenceDuration() / 1.5
        end
    end

    if self.Reloading == 1 and self.ReloadingTimer <= CurTime() and self:Clip1() > 0 and self:Ammo1() <= 0 then
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 0
        self.ReloadingTimer = CurTime() + 0.5 / 1.5
        self.Idle = 0
        if IsValid( owner ) then
            self.IdleTimer = CurTime() + owner:GetViewModel():SequenceDuration() / 1.5
        end
    end

    if self.Reloading == 2 and self.ReloadingTimer <= CurTime() then
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
        self:SetNextPrimaryFire( CurTime() + 0.5 )
        self:SetNextSecondaryFire( CurTime() + 0.5 )
        self.Reloading = 3
        self.ReloadingTimer = CurTime() + 0.5 / 1.5
        self.Idle = 0
        if IsValid( owner ) then
            self.IdleTimer = CurTime() + owner:GetViewModel():SequenceDuration() / 1.5
        end
    end

    if self.Reloading == 3 and self.ReloadingTimer <= CurTime() then
        self.Reloading = 0
    end

    if self.Idle == 0 and self.IdleTimer <= CurTime() then
        if SERVER then
            self:SendWeaponAnim( ACT_VM_IDLE )
        end

        self.Idle = 1
    end
end

local lst = SysTime()

local function scrunkly()
    local ret = ( SysTime() - ( lst or SysTime() ) ) * GetConVar( "host_timescale" ):GetFloat()
    return ret
end

local f_lerp = Lerp
local m_appor = math.Approach

local function ApprVecAng( from, to, dlt )
    local ret = ( isangle( from ) and isangle( to ) ) and Angle() or Vector()
    ret[1] = m_appor( from[1], to[1], dlt )
    ret[2] = m_appor( from[2], to[2], dlt )
    ret[3] = m_appor( from[3], to[3], dlt )

    return ret
end

function SWEP:GetViewModelPosition( pos, ang )
    if GetConVar( "arccw_dev_benchgun" ):GetBool() then
        if GetConVar( "arccw_dev_benchgun_custom" ):GetString() then
            local bgc = GetConVar( "arccw_dev_benchgun_custom" ):GetString()

            if string.Left( bgc, 6 ) ~= "setpos" then
                return Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
            end

            bgc = string.TrimLeft( bgc, "setpos " )
            bgc = string.Replace( bgc, ";setang", "" )
            bgc = string.Explode( " ", bgc )

            return Vector( bgc[1], bgc[2], bgc[3] ), Angle( bgc[4], bgc[5], bgc[6] )
        else
            return Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
        end
    end

    local owner = self:GetOwner()
    if not IsValid( owner ) or not owner:Alive() then
        return
    end

    local FT = scrunkly()
    local TargetTick = ( 1 / FT ) / 66.66

    if TargetTick < 1 then
        FT = FT * TargetTick
    end

    local oldpos, oldang = Vector(), Angle()

    oldpos:Set( pos )
    oldang:Set( ang )

    actual = self.ActualVMData or {
        pos = Vector(),
        ang = Angle(),
        down = 1,
        sway = 1,
        bob = 1
    }

    local target = {}
    target.pos = self.ActivePos
    target.ang = self.ActiveAng
    target.down = 1
    target.sway = 2
    target.bob = 2

    local speed = target.speed or 3
    actual.pos = LerpVector( speed, actual.pos, target.pos )
    actual.ang = LerpAngle( speed, actual.ang, target.ang )
    actual.down = f_lerp( speed, actual.down, target.down )
    actual.sway = f_lerp( speed, actual.sway, target.sway )
    actual.bob = f_lerp( speed, actual.bob, target.bob )
    actual.evpos = f_lerp( speed, actual.evpos or Vector(), target.evpos or Vector() )
    actual.evang = f_lerp( speed, actual.evang or Angle(), target.evang or Angle() )
    actual.pos = ApprVecAng( actual.pos, target.pos, speed * 0.1 )
    actual.ang = ApprVecAng( actual.ang, target.ang, speed * 0.1 )
    actual.down = m_appor( actual.down, target.down, speed * 0.1 )

    ang:RotateAroundAxis( oldang:Right(), actual.ang.x )
    ang:RotateAroundAxis( oldang:Up(), actual.ang.y )
    ang:RotateAroundAxis( oldang:Forward(), actual.ang.z )
    ang:RotateAroundAxis( oldang:Right(), actual.evang.x )
    ang:RotateAroundAxis( oldang:Up(), actual.evang.y )
    ang:RotateAroundAxis( oldang:Forward(), actual.evang.z )

    pos = pos + ( oldang:Right() * actual.evpos.x )
    pos = pos + ( oldang:Forward() * actual.evpos.y )
    pos = pos + ( oldang:Up() * actual.evpos.z )
    pos = pos + actual.pos.x * ang:Right()
    pos = pos + actual.pos.y * ang:Forward()
    pos = pos + actual.pos.z * ang:Up()
    pos = pos - Vector( 0, 0, actual.down )

    lst = SysTime()

    return pos, ang
end
