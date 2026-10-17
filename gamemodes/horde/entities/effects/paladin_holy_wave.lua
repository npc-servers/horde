-- Must also change this in the Excalibur perk file!
EFFECT.WaveLifetime = 0.6
EFFECT.WaveCount = 3
EFFECT.WaveSpacing = 0.12
EFFECT.WaveSpeed = 900
EFFECT.WaveStartWidth = 30
EFFECT.WaveExpandRate = 400
EFFECT.WaveThickness = 40

function EFFECT:Init( data )
    self.StartPos = data:GetOrigin()
    local ang = data:GetAngles()

    self.Forward = ang:Forward()
    self.Forward.z = 0
    self.Forward:Normalize()

    self.Angle = Angle( 90, ang.y - 90, 0 )

    self.StartTime = CurTime()

    local totalLife = self.WaveLifetime + ( self.WaveCount - 1 ) * self.WaveSpacing
    self.DieTime = self.StartTime + totalLife
end

function EFFECT:Think()
    return CurTime() < self.DieTime
end

function EFFECT:Render()
    local now = CurTime() - self.StartTime

    render.SetMaterial( Material( "sprites/laserbeam" ) )
    render.SetColorMaterial()

    local points = 16

    for wave = 0, self.WaveCount - 1 do
        local waveTime = now - wave * self.WaveSpacing

        if waveTime > 0 and waveTime < self.WaveLifetime then
            local dist = waveTime * self.WaveSpeed
            local center = self.StartPos + self.Forward * dist

            local arcWidth = self.WaveStartWidth + waveTime * self.WaveExpandRate

            local frac = waveTime / self.WaveLifetime
            local alpha = 255 * ( 1 - frac )

            for i = 1, points - 1 do
                local a = 180 / ( points - 1 )
                local a1 = math.rad( 180 + a * ( i - 1 ) )
                local a2 = math.rad( 180 + a * i )

                local p1 = center
                    + self.Angle:Right() * math.sin( a1 ) * arcWidth
                    + self.Angle:Up() * math.cos( a1 ) * arcWidth

                local p2 = center
                    + self.Angle:Right() * math.sin( a2 ) * arcWidth
                    + self.Angle:Up() * math.cos( a2 ) * arcWidth

                render.DrawBeam( p1, p2, 5, 0, 1, Color( 255, 220, 0, alpha ) )
            end
        end
    end
end