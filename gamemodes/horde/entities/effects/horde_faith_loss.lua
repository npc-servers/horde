function EFFECT:Init( data )
    local emitter = ParticleEmitter( data:GetOrigin() )
    emitter:SetNearClip( 24, 32 )

    local ringstart = data:GetOrigin()

    for i = 1, 2 do
        local particle = emitter:Add( "effects/select_ring", ringstart )
        particle:SetDieTime( 0.25 + i * 0.2 )
        particle:SetColor( 255, 255, 255 )
        particle:SetStartAlpha( 255 )
        particle:SetEndAlpha( 0 )
        particle:SetStartSize( 0 )
        particle:SetEndSize( 50 )
    end

    emitter:Finish()
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end