include("shared.lua")

local OpacityConvar = CreateClientConVar( "horde_reverend_aura_ring_opacity",
	"100",
	true,
	false,
	"Controls the Opacity of the Reverend Rings, the higher, the more opaque/visible, Set to 0 to disable Reverend rings from rendering",
	0,
	255
)

local opacity = OpacityConvar:GetInt()
local col = Color( 255, 0, 0, opacity )
cvars.AddChangeCallback("horde_reverend_aura_ring_opacity", function( convar_name, oldValue, newValue ) 
	opacity = tonumber(newValue)
	col = Color( 255, 0, 0, opacity )
end)

local auras = auras or {}

function ENT:Initialize()
	auras[self] = true
end

function ENT:OnRemove()
	auras[self] = nil
end

hook.Add( "PreDrawRings", "DrawReverendRings", function()
	if next( auras ) == nil or opacity == 0 then return end
	local set = {}
	for aura in pairs(auras) do
		table.insert( set, { aura, 250, 5, 30 } )
	end
	rings.AddSet( set, col )
end )

function ENT:Draw()
end