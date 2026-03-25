if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_pistol.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_pistol.png")
    killicon.AddAlias("arccw_horde_bo_makarov", "weapon_pistol")
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "Makarov"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Standard pistol of Soviet design.\nThis one is loaded with healing darts."
SWEP.Trivia_Manufacturer = "Izhevsk Mechanical Plant"
SWEP.Trivia_Calibre = "9x18mm Makarov"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1948"

SWEP.ViewModel = "models/horde/weapons/bo/makarov/viewmodel.mdl"
SWEP.WorldModel = "models/horde/weapons/bo/makarov/worldmodel.mdl"

SWEP.Damage = 25
SWEP.DamageMin = 10
SWEP.Range = 50
SWEP.Penetration = 5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 8
SWEP.ExtendedClipSize = 15

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 450
SWEP.Firemodes = {
	{
		Mode = 1,
	}
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 5
SWEP.HipDispersion = 450
SWEP.MoveDispersion = 100

SWEP.ShootSound = {
	")horde/weapons/bo_makarov/shot_00.wav",
	")horde/weapons/bo_makarov/shot_01.wav",
	")horde/weapons/bo_makarov/shot_02.wav",
	")horde/weapons/bo_makarov/shot_03.wav",
	")horde/weapons/bo_makarov/shot_04.wav"
}
SWEP.LowShootSound = "horde/weapons/bo_makarov/lfe_00.wav"
SWEP.ShootSoundSilenced = {
	")horde/weapons/bo_m16/silenced/silenced_00.wav",
	")horde/weapons/bo_m16/silenced/silenced_01.wav",
	")horde/weapons/bo_m16/silenced/silenced_02.wav",
	")horde/weapons/bo_m16/silenced/silenced_03.wav"
}
SWEP.LowShootSoundSilenced = "horde/weapons/bo_shared/wpn_lfe_sweet_02.wav"
SWEP.DistantShootSound = ")horde/weapons/bo_makarov/ringoff_00.wav"
SWEP.DistantShootSoundSilenced = ")horde/weapons/bo_aug/silenced/sweet_00.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.95

SWEP.IronSightStruct = {
    Pos = Vector(-1.9846, 0.582, 1.241),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.AttachmentElements = {
    ["silencer"] = {
        VMElements = {
            {
                Model = "models/horde/weapons/bo/makarov/atts/attachment_silencer.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector( 0, 0, 0 ),
                    ang = Angle( 0, -90, 0 ),
                },
                Scale = Vector( 0.875, 0.875, 0.875 ),
            }
        },
    },
    ["ext_mag"] = {
        VMBodygroups = {
            { ind = 3, bg = 1 },
        },
    },
}

SWEP.Attachments = {
	{
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "horde_bo_muzzle"
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = "horde_bo_ammo"
    },
    {
        PrintName = "Ammo Type",
        DefaultAttName = "Standard Ammo",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
	{
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(2.7, -0.1, -0.4),
            vang = Angle(0, 0, 0),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
	["ready"] = {
		Source = "reg_draw_first",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Pickup", t = 1 / 35 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_slide_back.wav", t = 7 / 35 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_slide_forward.wav", t = 24 / 35 },
		}
	},
	["draw"] = {
		Source = "reg_draw",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Rattle", t = 1 / 40 },
		}
	},
	["draw_empty"] = {
		Source = "reg_draw_empty",
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Rattle", t = 1 / 40 },
		}
	},
	["holster"] = {
		Source = "reg_holster"
	},
	["holster_empty"] = {
		Source = "reg_holster_empty"
	},
	["reload"] = {
		Source = "reg_reload",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 15 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_out.wav", t = 5 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_futz.wav", t = 17 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_in.wav", t = 23 / 25 },
		}
	},
	["reload_ext"] = {
		Source = "reg_reload_ext",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 15 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_out.wav", t = 5 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_futz.wav", t = 17 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_in.wav", t = 23 / 25 },
		}
	},
	["reload_empty"] = {
		Source = "reg_reload_empty",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 15 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_out.wav", t = 5 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_futz.wav", t = 19 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_in.wav", t = 23 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_slide_forward.wav", t = 32 / 25 },
		}
	},
	["reload_ext_empty"] = {
		Source = "reg_reload_empty_ext",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		SoundTable = {
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 1 / 25 },
			{ s = "ArcCW_Horde_BO_1911.Reload", t = 15 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_out.wav", t = 5 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_futz.wav", t = 19 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_mag_in.wav", t = 23 / 25 },
			{ s = "horde/weapons/bo_makarov/reload/fly_makarov_slide_forward.wav", t = 32 / 25 },
		}
	},
	["fire"] = {
		Source = "reg_fire"
	},
	["fire_iron"] = {
		Source = "reg_ads_fire"
	},
	["fire_empty"] = {
		Source = "reg_fire_last"
	},
	["fire_iron_empty"] = {
		Source = "reg_ads_fire_last"
	},
	["idle"] = {
		Source = "reg_idle"
	},
	["idle_empty"] = {
		Source = "reg_idle_empty"
	},
	["idle_sprint"] = {
		Source = "reg_sprint"
	},
	["idle_sprint_empty"] = {
		Source = "reg_sprint_empty"
	},
	["enter_sprint"] = {
		Source = "reg_sprint_in"
	},
	["exit_sprint"] = {
		Source = "reg_sprint_out"
	}
}

hook.Add( "Horde_ShouldCollide", "Horde_Medic_Rifle", function( ent1, ent2 )
    local entClass = "arccw_horde_bo_makarov"

    if ent1 == entClass or ent2 == entClass then
        return true
    end
end )

function SWEP:DoPrimaryFire( isent, data )
    local clip = self:Clip1()

    if self:HasBottomlessClip() then
        clip = self:Ammo1()
    end

    local owner = self:GetOwner()

    local shouldphysical = GetConVar( "arccw_bullet_enable" ):GetBool()

    if self.AlwaysPhysBullet or self:GetBuff_Override( "Override_AlwaysPhysBullet" ) then
        shouldphysical = true
    end

    if self.NeverPhysBullet or self:GetBuff_Override( "Override_NeverPhysBullet" ) then
        shouldphysical = false
    end

    if isent then
        self:FireRocket( data.ent, data.vel, data.ang, self.PhysBulletDontInheritPlayerVelocity )
    else
        if not IsFirstTimePredicted() then return end

        if shouldphysical then
            local vel = self:GetBuff_Override( "Override_PhysBulletMuzzleVelocity" ) or self.PhysBulletMuzzleVelocity

            local tracernum = data.TracerNum or 1
            local prof

            if tracernum == 0 or clip % tracernum ~= 0 then
                prof = 7
            end

            if not vel then
                vel = math.Clamp( self:GetBuff( "Range" ), 30, 300 ) * 8

                if self.DamageMin > self.Damage then
                    vel = vel * 3
                end
            end

            vel = vel / ArcCW.HUToM

            vel = vel * self:GetBuff_Mult( "Mult_PhysBulletMuzzleVelocity" ) * self:GetBuff_Mult( "Mult_Range" )

            vel = vel * GetConVar( "arccw_bullet_velocity" ):GetFloat()

            vel = vel * data.Dir:GetNormalized()

            ArcCW:ShootPhysBullet( self, data.Src, vel, prof )
        else
            if owner:IsPlayer() then
                owner:LagCompensation( true )
            end

            self:FireBullets( data )

            if owner:IsPlayer() then
                owner:LagCompensation( false )
            end
        end
    end
end

hook.Add( "Hook_BulletHit", "Horde_MakarovHeal", function( wpn, data )
    if wpn:GetClass() == "arccw_horde_bo_makarov" then
        if SERVER and ( data.tr.Entity:IsPlayer() ) then
        	local healinfo = HealInfo:New( { amount = 5, healer = wpn:GetOwner() } )
			HORDE:OnPlayerHeal( data.tr.Entity, healinfo )

			data.Damage = 0
        end
        if CLIENT then
            local emitter = ParticleEmitter( data.tr.HitPos )
            local smoke = emitter:Add( "particles/smokey", data.tr.HitPos )

            smoke:SetGravity( Vector( 0, 0, 1500 ) )
            smoke:SetDieTime( math.Rand( 0.5, 1 ) )
            smoke:SetStartAlpha( 100 )
            smoke:SetEndAlpha( 0 )
            smoke:SetStartSize( 10 )
            smoke:SetEndSize( 50 )
            smoke:SetRoll( math.Rand( -180, 180 ) )
            smoke:SetRollDelta( math.Rand( -0.2, 0.2 ) )
            smoke:SetColor( 50, 200, 50 )
            smoke:SetAirResistance( 1000 )
            smoke:SetLighting( false )
            smoke:SetCollide( false )
            smoke:SetBounce( 0 )

            emitter:Finish()
        end
    end
end )

function SWEP:DoShootSound( sndoverride, dsndoverride, voloverride, pitchoverride )
    local fsound = self.ShootSound
    local lsound = self.LowShootSound
    local dsound = self.DistantShootSound

    local suppressed = self:GetBuff_Override( "Silencer" )

    if suppressed then
        fsound = self.ShootSoundSilenced
        lsound = self.LowShootSoundSilenced
        dsound = self.DistantShootSoundSilenced
    end

    fsound = self:GetBuff_Hook( "Hook_GetShootSound", fsound )

    local volume = self.ShootVol
    local spv = self.ShootPitchVariation
    local pitch  = self.ShootPitch * math.Rand( 1 - spv, 1 + spv ) * self:GetBuff_Mult( "Mult_ShootPitch" )

    local v = GetConVar( "arccw_weakensounds" ):GetFloat()
    
    volume = volume - v
    volume = volume * self:GetBuff_Mult( "Mult_ShootVol" )

    volume = math.Clamp( volume, 60, 140 )
    pitch = math.Clamp( pitch, 0, 255 )

    if sndoverride then fsound = sndoverride end
    if voloverride then volume = voloverride end
    if pitchoverride then pitch = pitchoverride end

    if fsound then self:MyEmitSound( fsound, volume, pitch, 1, CHAN_STATIC ) end
    if lsound then self:MyEmitSound( lsound, 65, 100, 1, CHAN_BODY ) end
    if dsound then self:MyEmitSound( dsound, volume, pitch, 1, CHAN_WEAPON ) end

    local data = {
    	sound = fsound,
    	volume = volume,
    	pitch = pitch,
    }

    self:GetBuff_Hook( "Hook_AddShootSound", data )
end