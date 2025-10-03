include( "shared.lua" )

local opacityConvar = CreateClientConVar( "horde_overlord_aura_ring_opacity",
    "100",
    true,
    false,
    "Controls the Opacity of the Warden Aura Rings, the higher, the more opaque/visible, Set to 0 to disable Warden Aura rings from rendering",
    0,
    255
)

local opacity = opacityConvar:GetInt()
local col = Color( 32, 0, 56, opacity )

cvars.AddChangeCallback( "horde_overlord_aura_ring_opacity", function( _, _, newValue )
    opacity = tonumber( newValue )
    col.a = opacity
end )

local auras = auras or {}

function ENT:Initialize()
    auras[self] = true
end

function ENT:OnRemove()
    auras[self] = nil
end

hook.Add( "PreDrawRings", "DrawOverlordRings", function()
    if next( auras ) == nil then return end

    local set = {}
    for aura in pairs( auras ) do
        table.insert( set, { aura, aura:GetCircleRadius() or 160, 5, 30 } )
    end

    rings.AddSet( set, col )
end )