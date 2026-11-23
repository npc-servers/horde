local indicators  = {}
local on = true

surface.CreateFont("Horde_Debuff", {
    font = "Arial",
    extended = false,
    size = ScreenScale( 10 ),
    blursize = 0,
    weight = 1000,
    antialias = true,
})

surface.CreateFont("Horde_Debuff_Shadow", {
    font = "Arial",
    extended = false,
    size = ScreenScale( 10 ),
    blursize = 4,
    weight = 1000,
    antialias = true,
})


local function spawnIndicator( type, text, col, icon, pos, vel, ttl )
	local ind = {}

	ind.text = text
    ind.type = type
	ind.pos  = Vector( pos.x, pos.y, pos.z )
	ind.vel  = Vector( vel.x, vel.y, vel.z )
	ind.col  = Color( col.r, col.g, col.b )
	ind.ttl = ttl
	ind.life = ttl
    ind.icon = icon
	ind.spawntime = CurTime()
	table.insert( indicators, ind )
end

local UpOffset = Vector( 0, 0, 15 )

net.Receive( "Horde_HitnumbersDebuffSpawn", function()
	if not GetConVar( "horde_enable_debuff_text" ):GetBool() then return end

	-- Get damage type and amount.
	local debuff = net.ReadUInt( 32 )
	local pos = net.ReadVector()
    local col = HORDE.STATUS_COLOR[debuff] or color_white
    local icon = Material( HORDE.Status_Icon[debuff], "mips smooth" )
    local ttl = 1.5

    spawnIndicator( 1, HORDE.Status_String[debuff], col, icon, pos, VectorRand(), ttl )
end )

hook.Add( "HUDPaint", "Horde_DrawIndicators2D", function()
    if not GetConVar( "horde_enable_debuff_text" ):GetBool() then return end

	if #indicators == 0 then return end
	local ind
    for i = 1, #indicators do
        ind = indicators[i]
        cam.Start3D()

        local spos = ind.pos:ToScreen()
        local x = spos.x
        local y = spos.y

        cam.End3D()

        cam.Start2D()

        surface.SetFont( "Horde_Debuff_Shadow" )
        local width = surface.GetTextSize(ind.text)
        surface.SetTextColor(0, 0, 0, 255 * ind.life)
        surface.SetTextPos(x - (width / 2), y)
        surface.DrawText(ind.text)

        surface.SetFont( "Horde_Debuff" )

        surface.SetTextColor( ind.col.r, ind.col.g, ind.col.b, ( ind.life / ind.ttl * 255 ) )
        surface.SetTextPos( x - ( width / 2 ), y )
        surface.DrawText( ind.text )

        surface.SetMaterial( ind.icon)
        surface.SetDrawColor( ind.col.r, ind.col.g, ind.col.b, ( ind.life / ind.ttl * 255 ) )
        surface.DrawTexturedRect( x - ( width / 2 ) + surface.GetTextSize( ind.text ) + 7, y + ScreenScale( 1 ), ScreenScale( 8 ), ScreenScale( 8 ) )

        cam.End2D()
    end

	for i = 1, #indicators do
		ind = indicators[i]
		ind.life = ind.life - RealFrameTime()
		ind.pos = ind.pos + Vector( 0, 0, RealFrameTime() * 32 )
        ind.pos = ind.pos + ( ind.vel * RealFrameTime() * 16 )
	end

	-- Check for and remove expired hit texts.
	local i = 1
	while i <= #indicators do
		if indicators[i].life < 0 then
			table.remove( indicators, i )
		else
			i = i + 1
		end
	end
end )