GM.Name = "Horde"
GM.Author = "tpan496"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("sandbox")

function GM:Initialize()
    game.AddAmmoType({
        name = "arccw_horde_nade_incendiary"
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_molotov"
    })
    game.AddAmmoType({
        name = "arccw_nade_m67"
    })
    game.AddAmmoType({
        name = "arccw_horde_m67"
    })
    game.AddAmmoType({
        name = "arccw_nade_medic_ubgl"
    })
    game.AddAmmoType({
        name = "arccw_nade_knife"
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_stun"
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_nanobot",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_hemo",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_shrapnel",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_sonar",
    })
    game.AddAmmoType({
        name = "arccw_horde_nade_emp",
    })
    game.AddAmmoType({
        name = "horde_mine",
    })
    game.AddAmmoType({
        name = "horde_m2_flamethrower"
    })
    if SERVER then
        HORDE.NPCS = list.Get("NPC")
    end
end

function GM:PlayerLoadout(ply) return true end

hook.Add("SpawnMenuOpen", "Horde_SpawnMenu", function() return false end)

function GM:CanProperty() return false end

function GM:ContextMenuOpen() return false end

function GM:PlayerNoClip(ply,desiredState)
    if SERVER then
        ply:Horde_DropMoney()
    end

    return false
end

function GM:PlayerDeathSound() return true end

--function GM:DrawDeathNotice(x,y) return true end

function GM:PlayerSpawnVehicle(ply,model,name,table) return false end

function GM:PlayerSpawnSWEP(ply,weapon,info) return false end

function GM:PlayerSpawnSENT(ply,class) return false end

function GM:PlayerSpawnRagdoll(ply,model) return false end

function GM:PlayerSpawnProp(ply,model) return false end

function GM:PlayerSpawnObject(ply,model,skin) return false end

function GM:PlayerSpawnNPC(ply,npc_type,weapon) return false end

function GM:PlayerSpawnEffect(ply,model) return false end

function GM:PlayerGiveSWEP(ply,weapon,swep) return false end

function GM:HUDAmmoPickedUp(item, amount) return false end

CreateConVar("horde_disable_f1", 0, FCVAR_ARCHIVE, "Disables F1 hotkey for stats menu.")

if GetConVar("horde_disable_f1"):GetInt() == 0 then
    function GM:ShowHelp(ply)
        StatsMenu(ply)
    end
end

function GM:ShowTeam(ply) ConfigMenu(ply) end

function GM:ShowSpare1(ply)
    if MapVote and MapVote.state and MapVote.state.isInProgress then return end
    Shop(ply)
end

function GM:ShowSpare2(ply) Ready(ply) end

function GM:PlayerSetModel(ply)
    local class = ply:Horde_GetClass()
    if class and class.model and class.model ~= nil then
        ply:Horde_SetClassModel(class)
        return
    end

    player_manager.RunClass( ply, "SetModel" )
end

-- ~40% gain in GM:ShouldCollide() performance when these are cached
local entMeta = FindMetaTable("Entity")
local playerMeta = FindMetaTable("Player")
local entGetOwner = entMeta.GetOwner
local entGetNWEntity = entMeta.GetNWEntity
local entGetClass = entMeta.GetClass

local isValid = IsValid
local hookRun = hook.Run
local getMetatable = getmetatable

local HORDE_OWNER_KEY = "HordeOwner"

function GM:ShouldCollide(ent1, ent2)
    local ent1IsPlayer = getMetatable(ent1) == playerMeta
    local ent2IsPlayer = getMetatable(ent2) == playerMeta

    if ent1IsPlayer or ent2IsPlayer then
        if ent1IsPlayer and ent2IsPlayer then
            return false
        end

        local ent1Owner = entGetOwner(ent1)
        local ent2Owner = entGetOwner(ent2)

        -- Player projectiles, Minion Projectiles, Minions
        local ent1IsFriendly = isValid(ent1Owner)
            and (getMetatable(ent1Owner) == playerMeta or isValid(entGetNWEntity(ent1Owner, HORDE_OWNER_KEY)))
            or isValid(entGetNWEntity(ent1, HORDE_OWNER_KEY))
        local ent2IsFriendly = isValid(ent2Owner)
            and (getMetatable(ent2Owner) == playerMeta or isValid(entGetNWEntity(ent2Owner, HORDE_OWNER_KEY)))
            or isValid(entGetNWEntity(ent2, HORDE_OWNER_KEY))

        local ent1Class, ent2Class = entGetClass(ent1), entGetClass(ent2)
        local res = hookRun("Horde_ShouldCollide", ent1Class, ent2Class)
        if res ~= nil then
            return res
        end

        if ent1IsFriendly or ent2IsFriendly then
            return false
        end
    end

    return true
end

function GM:PlayerButtonDown(ply, button)
    if (ply:Horde_GetMaxMind() <= 0) then return end
    if button != KEY_F then return end
    if CLIENT then
		if ( IsFirstTimePredicted() ) then ply.Horde_UseSpellUtlity = true end
	else
		ply.Horde_UseSpellUtlity = true
	end
end

function GM:PlayerButtonUp(ply, button)
    if not IsFirstTimePredicted() then return end
    if (ply:Horde_GetMaxMind() <= 0) then return end
    if button != KEY_F then return end
    ply.Horde_UseSpellUtlity = nil
end
--[[
function GM:SetupWorldFog()
	render.FogMode(1)
	render.FogStart(500)
	render.FogEnd(1000)
	render.FogMaxDensity(1)
	--local col = self:GetFogColor()
	render.FogColor(150,150,150)
	return true
end]]--