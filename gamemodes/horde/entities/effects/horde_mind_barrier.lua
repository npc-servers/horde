function EFFECT:Init( effect )
    local pos = effect:GetOrigin()
    local normal = Vector( 0, 0, 1 )

    local emitter = ParticleEmitter( pos, true )
    local ringstart = pos + Vector( 0, 0, 1 ) * 10

    for i = 1, 3 do
        local particle = emitter:Add( "effects/select_ring", ringstart )
        particle:SetDieTime( 0.5 + i * 0.1 )
        particle:SetColor( 0, 240, 255 )
        particle:SetStartAlpha( 255 )
        particle:SetEndAlpha( 0 )
        particle:SetStartSize( 0 )
        particle:SetEndSize( effect:GetRadius() )
        particle:SetAngles( normal:Angle() )
    end

    emitter:Finish()
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end