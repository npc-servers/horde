include("shared.lua")

local auras = auras or {}

function ENT:Initialize()
	auras[self] = true
end

function ENT:OnRemove()
	auras[self] = nil
end

local zones = {}
local col = Color(0,255,100,100)
hook.Add( "PostDrawOpaqueRenderables", "DrawWardenRings", function()
	if next( auras ) == nil then return end
	zones = {}
	rings.StartStencils()
	for ent,bool in pairs( auras ) do
		if !IsValid(ent) then continue end
		rings.Add( zones, ent, ( ent.Horde_AuraRadius or 160 ), 5, 30)
	end

	rings.RenderSphere( zones )

	rings.CamRendering( LocalPlayer():EyeAngles():Forward(), col )
	render.SetStencilEnable( false )

end)