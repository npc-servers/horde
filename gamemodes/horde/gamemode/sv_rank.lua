local EXPECTED_HEADER = "Horde_Rank"
local EXPECTED_HEADER_TOKENS = "Horde_Skull_Tokens"

function HORDE:SaveSkullTokens(ply)
	if not ply:IsValid() then return end
	if not ply.Horde_Skull_Tokens_Loaded then return end

	local path, strm

	if not file.IsDir("horde/tokens", "DATA") then
		file.CreateDir("horde/tokens", "DATA")
	end

	path = "horde/tokens/" .. HORDE:ScrubSteamID(ply) .. ".txt"

	strm = file.Open(path, "wb", "DATA")
		strm:Write(EXPECTED_HEADER_TOKENS)
        strm:WriteLong(ply:Horde_GetSkullTokens())
	strm:Close()
end

function HORDE:LoadSkullTokens(ply)
	if not ply:IsValid() then return end
	local path, strm

	if not file.IsDir("horde/tokens", "DATA") then
		file.CreateDir("horde/tokens", "DATA")
	end

	path = "horde/tokens/" .. HORDE:ScrubSteamID(ply) .. ".txt"

	if not file.Exists(path, "DATA") then
		ply:Horde_SetSkullTokens(0)
		ply.Horde_Skull_Tokens_Loaded = true
		return
	end

	strm = file.Open(path, "rb", "DATA")
		local header = strm:Read(#EXPECTED_HEADER_TOKENS)

		if header == EXPECTED_HEADER_TOKENS then
			local tokens = strm:ReadLong()
			ply:Horde_SetSkullTokens(tokens)
		else
			ply:Horde_SetSkullTokens(0)
		end
	strm:Close()

	ply.Horde_Skull_Tokens_Loaded = true
end

function HORDE:SaveRank(ply)
	if not ply:IsValid() then return end
	if not ply.Horde_Rank_Loaded then return end

	local path, strm

	if not file.IsDir("horde/ranks", "DATA") then
		file.CreateDir("horde/ranks", "DATA")
	end

	path = "horde/ranks/" .. HORDE:ScrubSteamID(ply) .. ".txt"

	strm = file.Open(path, "wb", "DATA" )
		strm:Write(EXPECTED_HEADER)
        for name, class in pairs(HORDE.classes) do
            strm:WriteShort(class.order)
            strm:WriteLong(ply:Horde_GetExp(name))
			strm:WriteShort(ply:Horde_GetLevel(name))
        end

		-- Write subclass data
		for subclass_name, subclass in pairs(HORDE.subclasses) do
			if not subclass.ParentClass then goto cont end
			strm:WriteULong(HORDE.subclass_name_to_crc[subclass.PrintName])
			strm:WriteLong(ply:Horde_GetExp(subclass.PrintName))
			strm:WriteShort(ply:Horde_GetLevel(subclass.PrintName))
			::cont::
		end
	strm:Close()
end

function HORDE:LoadRank(ply)
	if not ply:IsValid() then return end

	local path, strm

	if not file.IsDir("horde/ranks", "DATA") then
		file.CreateDir("horde/ranks", "DATA")
	end

	path = "horde/ranks/" .. HORDE:ScrubSteamID(ply) .. ".txt"

	if not file.Exists(path, "DATA") then
		ply.Horde_Rank_Loaded = true
		return
	end

	strm = file.Open(path, "rb", "DATA")
		local header = strm:Read(#EXPECTED_HEADER)

		if header == EXPECTED_HEADER then
			for _, _ in pairs(HORDE.classes) do
                local order = strm:ReadShort()
				local exp = strm:ReadLong()
				local level = strm:ReadShort()
				if order == nil then
				else
					local class_name = HORDE.order_to_class_name[order]
					ply:Horde_SetLevel(class_name, level)
					ply:Horde_SetExp(class_name, exp)
				end
            end

			-- Read subclass data
			while not strm:EndOfFile() do
				local order = strm:ReadULong()
				local exp = strm:ReadLong()
				local level = strm:ReadShort()
				if order == nil then
				else
					local class_name = HORDE.order_to_subclass_name[tostring(order)]
					ply:Horde_SetLevel(class_name, level)
					ply:Horde_SetExp(class_name, exp)
				end
				::cont::
			end
		else
			for _, class in pairs(HORDE.classes) do
				ply:Horde_SetLevel(class.name, 0)
                ply:Horde_SetExp(class.name, 0)
            end
		end
	strm:Close()

	ply.Horde_Rank_Loaded = true
end

hook.Add( "Shutdown", "Horde_SaveRank", function()
	for _, ply in pairs( player.GetHumans() ) do
		HORDE:SaveRank( ply )
	end
end )

hook.Add( "PlayerDisconnect", "Horde_SaveRank", function( ply )
	HORDE:SaveRank( ply )
end )

local expMultiConvar = GetConVar("horde_experience_multiplier")
local startXpMult = HORDE.Difficulty[HORDE.CurrentDifficulty].xpMultiStart
local endXpMult = HORDE.Difficulty[HORDE.CurrentDifficulty].xpMultiEnd
local endMinusStartXp = endXpMult - startXpMult
local maxLevel = HORDE.max_level

hook.Add( "Horde_OnEnemyKilled", "Horde_GiveExp", function( victim, killer, wpn )
	if HORDE.current_wave <= 0 then return end

	local wavePercent = HORDE.current_wave / HORDE.max_waves
	local roundXpMulti = startXpMult + ( wavePercent * endMinusStartXp ) -- This gets the xp multi number between min and max multi based on round
	local expMulti = roundXpMulti * expMultiConvar:GetInt()

	local maxHealth = victim.Horde_MaxHealth
	for dealer, amount in pairs( victim.Horde_DamageDone ) do
		if not IsValid( dealer ) or not dealer:IsPlayer() then continue end

		local subClass = dealer:Horde_GetCurrentSubclass()
		if dealer:Horde_GetLevel( subClass ) >= maxLevel then continue end

		local rewardMult = amount / maxHealth

		if rewardMult > 0.3 and victim:Horde_IsElite() then
			expMulti = expMulti * 2
			local p = math.random()
			if p < 0.01 or ( p < 0.1 and dealer:Horde_GetGadget() == "gadget_corporate_mindset" ) then
				dealer:Horde_AddSkullTokens( 1 )
			end
		end

		dealer:Horde_SetExp( subClass, dealer:Horde_GetExp( subClass ) + math.ceil( expMulti * rewardMult ), "Kill" )
	end
end )

hook.Add( "Horde_PostOnPlayerHeal", "Horde_GiveExp", function( ply, healinfo )
    if HORDE.current_wave <= 0 then return end

    if not ply:IsPlayer() then return end

    local healer = healinfo.healer
    if not IsValid( healinfo.healer ) then return end
    if not healer:IsPlayer() then return end
    if healer == ply then return end

    local subClass = healer:Horde_GetCurrentSubclass()
    if healer:Horde_GetLevel( subClass ) >= maxLevel then return end

    local wavePercent = HORDE.current_wave / HORDE.max_waves
    local roundXpMulti = startXpMult + ( wavePercent * endMinusStartXp ) -- This gets the xp multi number between min and max multi based on round
    local expMulti = roundXpMulti * expMultiConvar:GetInt()

    local rewardMulti = 0.01 * healinfo.amount

    healer:Horde_SetExp( subClass, healer:Horde_GetExp( subClass ) + math.ceil( expMulti * rewardMulti ), "Healed Player" )
end )
