include("shared.lua")

local OpacityConvar = CreateClientConVar("horde_nemesis_ring_opacity",
    "100",
    true,
    false,
    "Adjusts the Opacity of the Nemesis Rings, higher values produce more solid and visible rings, Set to 0 to disable Nemesis rings from rendering",
    0,
    255
)

local opacity = OpacityConvar:GetInt()
local col = Color(200, 50, 200, opacity)
cvars.AddChangeCallback("horde_nemesis_ring_opacity", function( convar_name, oldValue, newValue )
    opacity = tonumber(newValue)
    col = Color(200, 50, 200, opacity)
end)

local auras = auras or {}

function ENT:Initialize()
    auras[self] = true
end

function ENT:OnRemove()
    auras[self] = nil
end

hook.Add( "PreDrawRings", "DrawNemesisRings", function()
    if next( auras ) == nil or opacity == 0 then return end
    local set = {}
    for aura in pairs(auras) do
        table.insert(set,{aura, 150, 5, 30})
    end
    rings.AddSet( set , col)
end)

function EFFECT:Draw()
end
