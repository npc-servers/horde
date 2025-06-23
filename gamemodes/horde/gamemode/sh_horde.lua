CreateConVar("horde_default_enemy_config", 1, nil, "Use default enemy wave config settings.")
CreateConVar("horde_default_item_config", 1, nil, "Use default item config settings.")
CreateConVar("horde_default_class_config", 1, nil, "Use default class config settings.")
CreateConVar("horde_max_wave", 10, nil, "Max waves.")
CreateConVar("horde_break_time", 90, FCVAR_ARCHIVE, "Break time between waves.")
CreateConVar("horde_enable_shop", 1, FCVAR_REPLICATED, "Enables shop menu or not.")
CreateConVar("horde_enable_shop_icons", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Enables shop menu icons or not.")
CreateConVar("horde_enable_perk", 1, FCVAR_REPLICATED, "Enables perks or not.")
CreateConVar("horde_enable_client_gui", 1, nil, "Enables client information ui or not.")
CreateConVar("horde_max_spawn_distance", 2000, nil, "Maximum enenmy respawn distance.")
CreateConVar("horde_min_spawn_distance", 750, FCVAR_ARCHIVE, "Minimum enenmy respawn distance.")
CreateConVar("horde_max_spawn_z_distance", 500, nil, "Maximum enemy respawn height difference with players.")

CreateConVar("horde_start_money", 900, nil, "Money given at start.")
CreateConVar("horde_round_bonus", 500, nil, "Round bonus given at the end of the round.")
CreateConVar("horde_enable_ammobox", 1, nil, "Enable ammobox spawns.")
CreateConVar("horde_npc_cleanup", 1, nil, "Kills all NPCs after a wave.")
CreateConVar("horde_external_lua_config", "", nil, "Name of external config to load. This will take over the configs if exists.")
--CreateConVar("horde_starter_weapon_1", "", FCVAR_ARCHIVE, "Starter weapon 1.")
--CreateConVar("horde_starter_weapon_2", "", FCVAR_ARCHIVE, "Starter weapon 2.")

CreateConVar("horde_max_enemies_alive_base", 20, nil, "Maximum number of living enemies (base).")
CreateConVar("horde_max_enemies_alive_scale_factor", 5, nil, "Scale factor of the maximum number of living enemies for multiplayer.")
CreateConVar("horde_max_enemies_alive_max", 100, FCVAR_ARCHIVE, "Maximum number of maximum living enemies.")
CreateConVar("horde_corpse_cleanup", 1, nil, "Remove corpses.")

CreateConVar("horde_base_walkspeed", 180, nil, "Base walkspeed.")
CreateConVar("horde_base_runspeed", 220, nil, "Base runspeed.")
CreateConVar("horde_base_jumpheight", 150, nil, "Base jump height.")

CreateConVar("horde_difficulty", 6, nil, "Difficulty.")
CreateConVar("horde_disable_difficulty_voting", 0, nil, "Disable difficulty voting.")
CreateConVar("horde_endless", 0, FCVAR_ARCHIVE, "Endless.")
CreateConVar("horde_total_enemies_scaling", 0, nil, "Forces the gamemode to multiply maximum enemy count by this.")

CreateConVar("horde_perk_start_wave", 1, FCVAR_REPLICATED, "The wave when Tier 1 perks are active.")
CreateConVar("horde_perk_scaling", 2, FCVAR_REPLICATED, "The multiplier to the level for which wave it is unlocked. e.g. at 1.5, perk level 4 is unlocked at start_wave + 6.", 0)

CreateConVar("horde_enable_starter", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Enables starter weapons.")
if SERVER then
    SetGlobal2Bool( "horde_arccw_attinv_free", CreateConVar( "horde_arccw_attinv_free", 1, FCVAR_ARCHIVE, "Free ArcCW attachments." ):GetBool() )
    cvars.AddChangeCallback( "horde_arccw_attinv_free", function( _, _, new )
        SetGlobal2Bool( "horde_arccw_attinv_free", tobool( new ) )
    end )
end

CreateConVar("horde_ready_countdown_ratio", 0.5, nil, "Ratio of players required to start the 60 second countdown (0-1).")

CreateConVar("horde_enable_scoreboard", 1, nil, "Enables built-in scoreboard.")
CreateConVar("horde_enable_3d2d_icon", 1, nil, "Enables player icon renders.")

CreateConVar("horde_testing_unlimited_class_change", 0, nil, "You can change a class for an unlimited times. Please use this only for testing purposes.")
CreateConVar("horde_testing_display_damage", 0, FCVAR_ARCHIVE, "Display damage for testing.")
CreateConVar("horde_display_damage", 1, FCVAR_ARCHIVE, "Display damage.")
CreateConVar("horde_enable_health_gui", 1, FCVAR_ARCHIVE, "Enables health UI.")
CreateConVar("horde_enable_ammo_gui", 1, FCVAR_ARCHIVE, "Enables ammo UI.")

CreateConVar("horde_enable_class_models", 1, FCVAR_ARCHIVE, "Enables ammo UI.")

CreateConVar("horde_experience_multiplier", 1, FCVAR_ARCHIVE, "Changes how much kill xp is multiplied by.")

if CLIENT then
    CreateClientConVar("horde_disable_default_gadget_use_key", 0, FCVAR_ARCHIVE, "Disable default key bind for active gadgets.")
    CreateClientConVar("horde_heal_flash", "1", true, true, "Allows for a player's screen to flash to notify them when they're being healed.")
    CreateClientConVar("horde_show_leaderboard", "0", true, false, "Enables forcibly displaying the leaderboard for ranks.")
end

if SERVER then
util.AddNetworkString("Horde_SideNotification")
util.AddNetworkString("Horde_SideNotificationDebuff")
util.AddNetworkString("Horde_SideNotificationObjective")
util.AddNetworkString("Horde_PlayerInit")
util.AddNetworkString("Horde_SyncItems")
util.AddNetworkString("Horde_SyncEnemies")
util.AddNetworkString("Horde_SyncClasses")
util.AddNetworkString("Horde_SyncStatus")
util.AddNetworkString("Horde_SyncSpecialArmor")
util.AddNetworkString("Horde_PlayerReadySync")
util.AddNetworkString("Horde_AmmoboxCountdown")
util.AddNetworkString("Horde_SyncBossSpawned")
util.AddNetworkString("Horde_SyncBossHealth")
end

HORDE = {}
HORDE.__index = HORDE
HORDE.version = "1.1.2.1"
print("[HORDE] HORDE Version is " .. HORDE.version) -- Sanity check

HORDE.color_crimson = Color(220, 20, 60, 225)
HORDE.color_crimson_dim = Color(200, 0, 40)
HORDE.color_crimson_dark = Color(100,0,0)
HORDE.color_crimson_violet = Color(146, 43, 62)
HORDE.color_gadget_active = HORDE.color_crimson
HORDE.color_gadget_once = Color(238,130,238)
HORDE.color_hollow = Color(40,40,40,225)
HORDE.color_hollow_dim = Color(80, 80, 80, 225)
HORDE.color_config_bar = Color(50, 50, 50, 200)
HORDE.color_config_bg = Color(150, 150, 150, 200)
HORDE.color_config_content_bg = Color(230,230,230)
HORDE.color_none = Color(0,0,0,0)
HORDE.color_config_btn = Color(40,40,40)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {15, 19, 23, 27, 30, 33, 36, 39, 42, 45}
--HORDE.total_enemies_per_wave = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

-- Director
HORDE.CurrentDifficulty = 1
HORDE.total_enemies_this_wave = 0
HORDE.alive_enemies_this_wave = 0
HORDE.killed_enemies_this_wave = 0
HORDE.current_wave = 0
HORDE.total_break_time = math.max(10, GetConVarNumber("horde_break_time"))
HORDE.current_break_time = HORDE.total_break_time

HORDE.max_spawn_distance = math.max(100, GetConVarNumber("horde_max_spawn_distance"))
HORDE.min_spawn_distance = math.max(100, GetConVarNumber("horde_min_spawn_distance"))
HORDE.max_enemies_alive = 20
HORDE.spawned_enemies = {}
HORDE.spawned_enemies_count = {}
HORDE.ai_nodes = {}
HORDE.found_ai_nodes = false
HORDE.enemy_spawn_z = 6
HORDE.min_base_enemy_spawns_per_think = 4
HORDE.max_base_enemy_spawns_per_think = 5
HORDE.spawn_radius = 75
HORDE.max_max_waves = 10
HORDE.max_waves = math.min(HORDE.max_max_waves, math.max(1, GetConVarNumber("horde_max_wave")))
HORDE.start_money = math.max(0, GetConVarNumber("horde_start_money"))
HORDE.total_enemies_this_wave_fixed = 0
HORDE.kill_reward_base = 90
HORDE.round_bonus_base = GetConVar("horde_round_bonus"):GetInt()
HORDE.disable_levels_restrictions = 0
if CLIENT then
net.Receive("Horde_Disable_Levels", function ()
    HORDE.disable_levels_restrictions = 1
end)
end

HORDE.SPAWN_PROXIMITY = 0
HORDE.SPAWN_UNIFORM = 1
HORDE.SPAWN_PROXIMITY_NOISY = 2

-- Ammobox
HORDE.ammobox_max_count_limit = 9
HORDE.ammobox_refresh_interval = 60
HORDE.enable_ammobox = GetConVar("horde_enable_ammobox"):GetInt()

-- Statistics
-- Keep track of entities separately, so we don't have to network entities across
-- the network.
HORDE.player_drop_entities = {}
HORDE.player_ready = {}
HORDE.player_damage = {}
HORDE.player_damage_taken = {}
HORDE.player_heal = {}
HORDE.player_headshots = {}
HORDE.player_elite_kills = {}
HORDE.player_vote_map_change = {}
HORDE.player_kills_weapon = {}
HORDE.player_revives = {}
HORDE.player_revived = {}

-- Render / Gui
HORDE.render_highlight_disable = 0
HORDE.render_highlight_ammoboxes = 2

-- ArcCW Attachments
if ArcCWInstalled then
    if SERVER then
        if GetConVar("horde_arccw_attinv_free"):GetInt() == 0 then
            RunConsoleCommand("arccw_attinv_free", "0")
        else
            RunConsoleCommand("arccw_attinv_free", "1")
        end
    end

    -- Disable near-walling and lunging that messes with gameplay.
    RunConsoleCommand("arccw_override_nearwall", "0")
    RunConsoleCommand("arccw_override_lunge_off", "1")

    -- Disable perks that messes up with Horde's own system.
    if GetConVar("horde_default_item_config"):GetInt() == 1 then
        ArcCW.AttachmentBlacklistTable["go_perk_headshot"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_ace"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_last"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_refund"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_slow"] = true
        ArcCW.AttachmentBlacklistTable["go_m249_mag_12g_45"] = true
    end
end


-- Disable Godmode
RunConsoleCommand("sbox_godmode", "0")
RunConsoleCommand("vj_npc_addfrags", "0")
RunConsoleCommand("vj_npc_knowenemylocation", "1")
RunConsoleCommand("vj_npc_bleedenemyonmelee", "0")

-- Util functions
function HORDE:GiveAmmo(ply, wpn, count)
    local clip_size = wpn:GetMaxClip1()
    local ammo_id = wpn:GetPrimaryAmmoType()

    if clip_size > 0 then -- block melee
        ply:GiveAmmo(clip_size * count, ammo_id, false)
        return true
    else
        -- Give 1 piece of this ammo since clip size do not apply
        if ammo_id >= 1 then
            ply:GiveAmmo(count, ammo_id, false)
            return true
        end
    end
    return false
end

function HORDE:Round2(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function HORDE:GetUpgradePrice(class, ply)
    local level
    if CLIENT then
        level = MySelf:Horde_GetUpgrade(class)
    else
        level = ply:Horde_GetUpgrade(class)
    end
    if class == "horde_void_projector" or class == "horde_solar_seal" or class == "horde_astral_relic" or class == "horde_carcass" or class == "horde_pheropod" then
        local price = 800 + 25 * level
        return price
    else
        local base_price = HORDE.items[class].price
        local price = HORDE:Round2(math.max(100, base_price / 2) + math.max(10, base_price / 64) * level)
        return price
    end
end

-- Data structures
-- GLOBAL
HORDE.Stack = {}

-- Create a Table with stack functions
function HORDE.Stack:Create()

  -- stack table
  local t = {}
  -- entry table
  t._et = {}

  -- push a value on to the stack
  function t:push(...)
    if ... then
      local targs = {...}
      -- add values
      for _,v in ipairs(targs) do
        table.insert(self._et, v)
      end
    end
  end

  -- pop a value from the stack
  function t:pop(num)

    -- get num values from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
      -- get last entry
      if #self._et ~= 0 then
        table.insert(entries, self._et[#self._et])
        -- remove last value
        table.remove(self._et)
      else
        break
      end
    end
    -- return unpacked entries
    return unpack(entries)
  end

  -- get entries
  function t:getn()
    return #self._et
  end

  -- list values
  function t:list()
    for i,v in pairs(self._et) do
      print(i, v)
    end
  end
  return t
end

HORDE.Queue = {}
function HORDE.Queue:Create()
    local t = {}
    t._et = {}

    local first, last = 0, -1
    function t:push(item)
      last = last + 1
      t._et[last] = item
    end
    function t:pop()
      if first <= last then
        local value = t._et[first]
        t._et[first] = nil
        first = first + 1
        return value
      end
    end

    function t:size()
        return (last-first+1)
    end
    return t
  end
