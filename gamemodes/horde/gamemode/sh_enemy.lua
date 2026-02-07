-- Enemies
HORDE.enemies = {}
HORDE.bosses = {}
HORDE.enemies_normalized = {}
HORDE.bosses_normalized = {}

-- Creates a Horde enemy.
function HORDE:CreateEnemy(name, class, weight, wave, is_elite, health_scale, damage_scale, reward_scale, model_scale, color, weapon, spawn_limit, boss_properties, mutation, skin, model, spawn_min, gadget_drop)
    if name == nil or class == nil or wave == nil or wave <= 0 or name == "" or class == "" then return end
    local enemy = {}
    enemy.name = name
    enemy.class = class
    enemy.weight = math.max(0,weight)
    enemy.wave = math.max(1,wave)
    enemy.health_scale = health_scale and health_scale or 1
    enemy.damage_scale = damage_scale and damage_scale or 1
    enemy.reward_scale = reward_scale and reward_scale or 1
    enemy.model_scale = model_scale and model_scale or 1
    enemy.color = color
    enemy.weapon = weapon
    enemy.spawn_limit = spawn_limit or 0
    enemy.is_elite = is_elite and is_elite or 0
    enemy.boss_properties = boss_properties and boss_properties or {}
    enemy.spawn_min = spawn_min or 0
    -- Prevent infinite rounds
    if enemy.boss_properties then
        if enemy.boss_properties.unlimited_enemies_spawn and (not enemy.boss_properties.end_wave) then
            enemy.boss_properties.end_wave = true
        end
    end
    enemy.mutation = mutation or nil
    if skin and skin ~= "" then
        enemy.skin = skin
    end
    enemy.gadget_drop = gadget_drop or nil
    if model and model ~= "" then enemy.model = model end

    HORDE.enemies[name .. tostring(enemy.wave)] = enemy
end

function HORDE:NormalizeEnemiesWeightOnWave(enemies)
    local total_weight = 0
    for name, weight in pairs(enemies) do
        total_weight = total_weight + weight
    end
    for name, weight in pairs(enemies) do
        enemies[name] = weight / total_weight
    end
end

function HORDE:GetForcedEnemiesOnWave(enemies, enemy_wave, total_enemies)
    local forced = {}
    for name, _ in pairs(enemies) do
        local enemy = HORDE.enemies[name .. tostring(enemy_wave)]
        if enemy.spawn_min and enemy.spawn_min > 0 then
            forced[name] = {}
            for i = 1, enemy.spawn_min do
                table.insert(forced[name], math.random(1, total_enemies))
            end
        end
    end
    return forced
end

function HORDE:NormalizeEnemiesWeight()
    if table.IsEmpty(HORDE.enemies) then return end

    for _, enemy in pairs(HORDE.enemies) do
        if enemy.boss_properties and enemy.boss_properties.is_boss and enemy.boss_properties.is_boss == true then
            if not HORDE.bosses[enemy.wave] then HORDE.bosses[enemy.wave] = {} end
            HORDE.bosses[enemy.name .. enemy.wave] = enemy
        end
    end

    for wave = 1, HORDE.max_max_waves do
        HORDE.enemies_normalized[wave] = {}
        local total_weight = 0
        for _, enemy in pairs(HORDE.enemies) do
            if enemy.boss_properties and enemy.boss_properties.is_boss and enemy.boss_properties.is_boss == true then
                goto cont
            end
            if enemy.wave == wave then
                total_weight = total_weight + enemy.weight
            end
            ::cont::
        end
        for _, enemy in pairs(HORDE.enemies) do
            if enemy.boss_properties and enemy.boss_properties.is_boss and enemy.boss_properties.is_boss == true then
                goto cont
            end
            if enemy.wave == wave then
                -- For some reason lua table key does not support nested tables lmao
                HORDE.enemies_normalized[wave][enemy.name] = enemy.weight / total_weight
            end
            ::cont::
        end
    end

    for wave = 1, HORDE.max_max_waves do
        HORDE.bosses_normalized[wave] = {}
        local total_weight = 0
        for _, enemy in pairs(HORDE.bosses) do
            if enemy.wave == wave then
                total_weight = total_weight + enemy.weight
            end
        end
        for _, enemy in pairs(HORDE.bosses) do
            if enemy.wave == wave then
                HORDE.bosses_normalized[wave][enemy.name] = enemy.weight / total_weight
            end
        end
    end

end

HORDE.InvalidateHordeEnemyCache = 1
HORDE.CachedHordeEnemies = nil
HORDE.GetCachedHordeEnemies = function()
    if HORDE.InvalidateHordeEnemyCache == 1 then
        local tab = util.TableToJSON(HORDE.enemies)
        local str = util.Compress(tab)
        HORDE.CachedHordeEnemies = str
        HORDE.InvalidateHordeEnemyCache = 0
    end
    return HORDE.CachedHordeEnemies
end

function HORDE:SyncEnemiesTo(ply)
    local str = HORDE.GetCachedHordeEnemies()
    net.Start("Horde_SyncEnemies")
        net.WriteUInt(string.len(str), 32)
        net.WriteData(str, string.len(str))
    net.Send(ply)
end

function HORDE:SyncMutationsTo(ply)
    net.Start("Horde_SyncMutations")
        -- Send the client simplified mutations
        local muts = {}
        for mut_name, mut in pairs(HORDE.mutations) do
            muts[mut_name] = mut.Description
        end
        net.WriteTable(muts)
    net.Send(ply)
end

function HORDE:SetEnemiesData()
    if SERVER then
        HORDE:NormalizeEnemiesWeight()

        if GetConVarNumber("horde_default_enemy_config") == 1 then return end
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
        end

        file.Write("horde/enemies.txt", util.TableToJSON(HORDE.enemies))
    end
end

local function GetEnemiesData()
    if SERVER then
        if not file.IsDir("horde", "DATA") then
            file.CreateDir("horde")
            return
        end

        if file.Read("horde/enemies.txt", "DATA") then
            local t = util.JSONToTable(file.Read("horde/enemies.txt", "DATA"))
            -- Integrity
            for _, enemy in pairs(t) do
                if enemy.name == nil or enemy.name == "" or enemy.class == nil or enemy.class == "" or enemy.weight == nil or enemy.wave == nil then
                    HORDE:SendNotification("Enemy config file validation failed! Please update your file or delete it.", 0)
                    return
                else
                    if not enemy.weapon then
                        enemy.weapon = ""
                    end
                end
            end

            -- Be careful of backwards compataiblity
            HORDE.enemies = t
            HORDE:NormalizeEnemiesWeight()

            print("[HORDE] - Loaded custom enemy config.")
        end
    end
end

function HORDE:GetDefaultEnemiesData ()
    -- HORDE:CreateEnemy( name, class, weight, wave, elite, health_scale, damage_scale, reward_scale, model_scale, color, weapon, spawn_limit, boss_properties, mutation, skin, model, spawn_min, gadget_drop )
    -- First Bosses
    HORDE:CreateEnemy("Mutated Hulk", "npc_vj_mutated_hulk", 1, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 1.0, music = "#music/vlvx_song23.mp3", music_duration = 168}, nil, nil, nil, nil, {gadget = "gadget_unstable_injection", drop_rate = 0.5})
    HORDE:CreateEnemy("Plague Berserker", "npc_vj_horde_platoon_berserker", 0.35, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 1.0, music = "#music/hl2_song16.mp3", music_duration = 152})
    HORDE:CreateEnemy("Plague Heavy", "npc_vj_horde_platoon_heavy", 0.35, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 1.0, music = "#music/hl2_song16.mp3", music_duration = 152})
    HORDE:CreateEnemy("Plague Demolition","npc_vj_horde_platoon_demolitionist", 0.35, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 1.0, music = "#music/hl2_song16.mp3", music_duration = 152})
    HORDE:CreateEnemy("Hell Knight", "npc_vj_horde_hellknight", 1, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave=true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/vlvx_song24.mp3", music_duration = 129}, "none", nil, nil, nil, {gadget = "gadget_hellfire_tincture", drop_rate = 0.5})
    HORDE:CreateEnemy("Xen Host Unit", "npc_vj_horde_xen_host_unit", 1, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/hl1_song10.mp3", music_duration = 106}, "none", nil, nil, nil, {gadget = "gadget_matriarch_womb", drop_rate = 0.5})
    HORDE:CreateEnemy("Xen Necromancer Unit", "npc_vj_horde_xen_necromancer_unit", 1, 5, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/Wasteshredder.mp3", music_duration = 64})
    -- Final Bosses
    HORDE:CreateEnemy("Alpha Gonome", "npc_vj_alpha_gonome", 1, 10, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/vlvx_song21.mp3", music_duration = 150}, "fume")
    HORDE:CreateEnemy("Gamma Gonome", "npc_vj_horde_gamma_gonome", 1, 10, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/vlvx_song9.mp3", music_duration = 76}, "none")
    HORDE:CreateEnemy("Subject: Wallace Breen", "npc_vj_horde_breen", 1, 10, true,  1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/hl2_song5.mp3", music_duration = 69}, "decay")
    HORDE:CreateEnemy("Xen Destroyer Unit","npc_vj_horde_xen_destroyer_unit", 1,    10, true,  1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/vlvx_song22.mp3", music_duration = 196}, "none")
    HORDE:CreateEnemy("Xen Psychic Unit","npc_vj_horde_xen_psychic_unit", 1, 10, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 0.5, music = "#music/vlvx_song11.mp3", music_duration = 80}, "regenerator")
    HORDE:CreateEnemy("Plague Platoon","npc_vj_horde_plague_platoon", 1, 10, true, 1, 1, 10, 1, nil, nil, nil,
    {is_boss = true, end_wave = true, unlimited_enemies_spawn = true, enemies_spawn_threshold = 1.0, music = "#music/hl2_song16.mp3", music_duration = 152}, "none")
    if GetConVar( "horde_difficulty" ):GetInt() == 1 then -- CASUAL
        -- Wave 1
        HORDE:CreateEnemy("Walker",         "npc_vj_horde_walker",          1.00, 1, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",       "npc_vj_horde_sprinter",        0.80, 1, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombie Torso",   "npc_vj_horde_zombie_torso",    0.25, 1, false, 1, 1, 1, 1)
        -- Wave 2
        HORDE:CreateEnemy("Walker",         "npc_vj_horde_walker",      1.00, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",       "npc_vj_horde_sprinter",    0.80, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",        "npc_vj_horde_crawler",     0.50, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",    "npc_vj_horde_fast_zombie", 0.25, 2, false, 1, 1, 1, 1)
        -- Wave 3
        HORDE:CreateEnemy("Walker",         "npc_vj_horde_walker",          1.00, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",       "npc_vj_horde_sprinter",        0.80, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",        "npc_vj_horde_crawler",         0.50, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",    "npc_vj_horde_fast_zombie",     0.25, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",  "npc_vj_horde_poison_zombie",   0.15, 3, false, 1, 1, 1, 1)
        -- Wave 4
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        0.80, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08 * 0.5, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08 * 0.5, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 4, false, 1, 1, 1, 1)
        -- First Boss Wave
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        0.80, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08 * 0.5, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08 * 0.5, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 5, false, 1, 1, 1, 1)
        -- Wave 6
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 6, false, 1, 1, 1, 1)
        -- Wave 7
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 7, false, 1, 1, 1, 1)
        -- Wave 8
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 8, false, 1, 1, 1, 1)
        -- Wave 9
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 9, false, 1, 1, 1, 1)
        -- Final Boss Wave
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 10, false, 1, 1, 1, 1)
    elseif GetConVar( "horde_difficulty" ):GetInt() == 6 then -- ELITE-RUSH
        -- Wave 1
        HORDE:CreateEnemy("Exploder", "npc_vj_horde_exploder", 1.00, 1, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter", "npc_vj_horde_vomitter", 0.15, 1, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 2
        HORDE:CreateEnemy("Exploder",   "npc_vj_horde_exploder",    1.00, 2, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",   "npc_vj_horde_vomitter",    0.15, 2, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",  "npc_vj_horde_screecher",   0.30, 2, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 3
        HORDE:CreateEnemy("Exploder",   "npc_vj_horde_exploder",    1.00, 3, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",   "npc_vj_horde_vomitter",    0.15, 3, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",  "npc_vj_horde_screecher",   0.30, 3, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 4
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",            1.00, 4, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",            0.15, 4, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",           0.30, 4, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",                0.20, 4, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- First Boss Wave
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",            1.00, 5, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",            0.15, 5, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",            0.10, 6, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",           0.30, 5, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",                0.20, 5, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 6
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",        1.00, 6, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",             "npc_vj_horde_blight",          0.40, 6, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",        0.15, 6, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.10, 6, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",       0.30, 6, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",             "npc_vj_horde_weeper",          0.15, 6, true, 1, 1, 2, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.20, 6, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",               "npc_vj_horde_yeti",            0.10, 6, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",             "npc_vj_horde_lesion",          0.05, 6, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 7
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",        1.00, 7, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",             "npc_vj_horde_blight",          0.40, 7, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",        0.15, 7, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.10, 7, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",       0.30, 7, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",             "npc_vj_horde_weeper",          0.15, 7, true, 1, 1, 2, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.20, 7, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",               "npc_vj_horde_yeti",            0.10, 7, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",             "npc_vj_horde_lesion",          0.05, 7, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 8
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",        1.00, 8, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",             "npc_vj_horde_blight",          0.40, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",        0.15, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.10, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",       0.30, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",             "npc_vj_horde_weeper",          0.15, 8, true, 1, 1, 2, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.20, 8, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",               "npc_vj_horde_yeti",            0.10, 8, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",             "npc_vj_horde_lesion",          0.05, 8, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Plague Elite",       "npc_vj_horde_plague_elite",    0.03, 8, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 9
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",        1.00, 9, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",             "npc_vj_horde_blight",          0.40, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",        0.15, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.10, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",       0.30, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",             "npc_vj_horde_weeper",          0.15, 9, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.20, 9, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",               "npc_vj_horde_yeti",            0.10, 9, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",             "npc_vj_horde_lesion",          0.05, 9, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Plague Elite",       "npc_vj_horde_plague_elite",    0.03, 9, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Final Boss Wave
        HORDE:CreateEnemy("Exploder",           "npc_vj_horde_exploder",        1.00, 10, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",             "npc_vj_horde_blight",          0.40, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",           "npc_vj_horde_vomitter",        0.15, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.10, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",          "npc_vj_horde_screecher",       0.30, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",             "npc_vj_horde_weeper",          0.15, 10, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.20, 10, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",               "npc_vj_horde_yeti",            0.10, 10, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",             "npc_vj_horde_lesion",          0.05, 10, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Plague Elite",       "npc_vj_horde_plague_elite",    0.03, 10, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
    else
        -- Wave 1
        HORDE:CreateEnemy("Walker",         "npc_vj_horde_walker",          1.00, 1, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",       "npc_vj_horde_sprinter",        0.80, 1, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombie Torso",   "npc_vj_horde_zombie_torso",    0.25, 1, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",       "npc_vj_horde_exploder",        0.20, 1, true, 1, 1, 1.5, 1)
        -- Wave 2
        HORDE:CreateEnemy("Walker",         "npc_vj_horde_walker",      1.00, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",       "npc_vj_horde_sprinter",    0.80, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",        "npc_vj_horde_crawler",     0.50, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",    "npc_vj_horde_fast_zombie", 0.25, 2, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",       "npc_vj_horde_exploder",    0.20, 2, true, 1, 1, 1.5, 1)
        -- Wave 3
        HORDE:CreateEnemy("Walker",         "npc_vj_horde_walker",          1.00, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",       "npc_vj_horde_sprinter",        0.80, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",        "npc_vj_horde_crawler",         0.50, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",    "npc_vj_horde_fast_zombie",     0.25, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",  "npc_vj_horde_poison_zombie",   0.15, 3, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",       "npc_vj_horde_exploder",        0.20, 3, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",       "npc_vj_horde_vomitter",        0.10, 3, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        -- Wave 4
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        0.80, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 4, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10, 4, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10, 4, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08 * 0.5, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08 * 0.5, 4, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 4, false, 1, 1, 1, 1)
        -- First Boss Wave
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        0.80, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 5, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10, 5, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10, 5, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08 * 0.5, 5, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08 * 0.5, 5, false, 1, 1, 1, 1)
--      HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",         0.05 * 0.5, 5, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 5, false, 1, 1, 1, 1)
        -- Wave 6
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 6, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10, 6, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",                   "npc_vj_horde_scorcher",        0.08, 6, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10, 6, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",                       "npc_vj_horde_hulk",            0.05, 6, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 6, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 6, false, 1, 1, 1, 1)
--      HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",         0.05, 6, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 6, false, 1, 1, 1, 1)
        -- Wave 7
        HORDE:CreateEnemy("Walker",                     "npc_vj_horde_walker",          1.00, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 7, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",                     "npc_vj_horde_blight",          0.05, 7, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10, 7, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",                   "npc_vj_horde_scorcher",        0.08, 7, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10, 7, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",                       "npc_vj_horde_hulk",            0.05, 7, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",                     "npc_vj_horde_lesion",          0.015, 7, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 7, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 7, false, 1, 1, 1, 1)
--      HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",         0.05, 7, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
--      HORDE:CreateEnemy("Hell Hunter",                "npc_vj_ezo_vorthunter",        0.02, 7, true, 1, 1, 3.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 7, false, 1, 1, 1, 1)
        -- Wave 8
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 8, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",                     "npc_vj_horde_blight",          0.05 * 1.25, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10 * 1.25, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",                   "npc_vj_horde_scorcher",        0.10 * 1.25, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10 * 1.25, 8, true, 1, 1, 1.5, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",                     "npc_vj_horde_weeper",          0.03, 8, true, 1, 1, 2, 1, nil, nil,nil, nil,nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",                       "npc_vj_horde_hulk",            0.05 * 1.25, 8, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",                       "npc_vj_horde_yeti",            0.025, 8, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",                     "npc_vj_horde_lesion",          0.015, 8, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 8, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 8, false, 1, 1, 1, 1)
--      HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",         0.05 * 1.25, 8, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
--      HORDE:CreateEnemy("Hell Hunter",                "npc_vj_ezo_vorthunter",        0.02, 8, true, 1, 1, 3.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 8, false, 1, 1, 1, 1)
        -- Wave 9
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 9, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",                     "npc_vj_horde_blight",          0.05 * 1.25, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10 * 1.25, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",                   "npc_vj_horde_scorcher",        0.08 * 1.25, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10 * 1.25, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",                     "npc_vj_horde_weeper",          0.03 * 1.25, 9, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",                       "npc_vj_horde_hulk",            0.05 * 1.25, 9, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",                       "npc_vj_horde_yeti",            0.025 * 1.25, 9, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",                     "npc_vj_horde_lesion",          0.015, 9, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Plague Elite",               "npc_vj_horde_plague_elite",    0.015, 9, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 9, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 9, false, 1, 1, 1, 1)
--      HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",         0.05 * 1.25, 9, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
--      HORDE:CreateEnemy("Hell Hunter",                "npc_vj_ezo_vorthunter",        0.02, 9, true, 1, 1, 3.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 9, false, 1, 1, 1, 1)
        -- Final Boss Wave
        HORDE:CreateEnemy("Sprinter",                   "npc_vj_horde_sprinter",        1.00, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Crawler",                    "npc_vj_horde_crawler",         0.50, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Fast Zombie",                "npc_vj_horde_fast_zombie",     0.25, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Zombine",                    "npc_vj_horde_zombine",         0.10, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Charred Zombine",            "npc_vj_horde_charred_zombine", 0.05, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Plague Soldier",             "npc_vj_horde_plague_soldier",  0.05, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("Exploder",                   "npc_vj_horde_exploder",        0.20, 10, true, 1, 1, 1.5, 1)
        HORDE:CreateEnemy("Blight",                     "npc_vj_horde_blight",          0.05 * 1.25, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10 * 1.25, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Scorcher",                   "npc_vj_horde_scorcher",        0.08 * 1.25, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10 * 1.25, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Weeper",                     "npc_vj_horde_weeper",          0.03 * 1.25, 10, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Hulk",                       "npc_vj_horde_hulk",            0.05 * 1.25, 10, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Yeti",                       "npc_vj_horde_yeti",            0.025 * 1.25, 10, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Lesion",                     "npc_vj_horde_lesion",          0.015, 10, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Plague Elite",               "npc_vj_horde_plague_elite",    0.015, 10, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08, 10, false, 1, 1, 1, 1)
        HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08, 10, false, 1, 1, 1, 1)
--      HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",         0.05 * 1.25, 10, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
--      HORDE:CreateEnemy("Hell Hunter",                "npc_vj_ezo_vorthunter",        0.02, 10, true, 1, 1, 3.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 10, false, 1, 1, 1, 1)
        if GetConVar( "horde_difficulty" ):GetInt() == 4 or GetConVar( "horde_difficulty" ):GetInt() == 5 then -- HARD / VETERAN
            -- Wave 1
            HORDE:CreateEnemy("Crawler",        "npc_vj_horde_crawler",         0.50, 1, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Fast Zombie",    "npc_vj_horde_fast_zombie",     0.25, 1, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Poison Zombie",  "npc_vj_horde_poison_zombie",   0.15, 1, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Vomitter",       "npc_vj_horde_vomitter",        0.10, 1, true, 1, 1, 1, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            -- Wave 2
            HORDE:CreateEnemy("Poison Zombie",              "npc_vj_horde_poison_zombie",   0.15, 2, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Vomitter",                   "npc_vj_horde_vomitter",        0.10, 2, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",       0.10, 2, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",           0.08 * 0.5, 2, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",           0.08 * 0.5, 2, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",        0.10, 2, false, 1, 1, 1, 1)
            -- Wave 3
            HORDE:CreateEnemy("Screecher",                  "npc_vj_horde_screecher",   0.10, 3, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Armed H.E.V. Zombie",        "npc_vj_ezt_weapbie",       0.08 * 0.5, 3, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("H.E.V. Zombie Shotgunner",   "npc_vj_ezt_shotbie",       0.08 * 0.5, 3, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Manhackbie",                 "npc_vj_ezt_manhackbie",    0.10, 3, false, 1, 1, 1, 1)
--          HORDE:CreateEnemy("Lesser Hunter",              "npc_vj_ezo_archunter",     0.05 * 0.5, 3, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            -- Wave 4
            HORDE:CreateEnemy("Zombine",            "npc_vj_horde_zombine",         0.10, 4, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Charred Zombine",    "npc_vj_horde_charred_zombine", 0.05, 4, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.05, 4, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
--          HORDE:CreateEnemy("Lesser Hunter",      "npc_vj_ezo_archunter",         0.05 * 0.5, 4, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.08, 4, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            -- First Boss Wave
            HORDE:CreateEnemy("Charred Zombine",    "npc_vj_horde_charred_zombine", 0.05, 5, false, 1, 1, 1, 1)
            HORDE:CreateEnemy("Hulk",               "npc_vj_horde_hulk",            0.05, 5, true, 1, 1, 2, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Scorcher",           "npc_vj_horde_scorcher",        0.08, 5, true, 1, 1, 1.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            -- Wave 6
            HORDE:CreateEnemy("Lesion",         "npc_vj_horde_lesion",          0.015, 6, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Plague Soldier", "npc_vj_horde_plague_soldier",  0.05, 6, false, 1, 1, 1, 1)
--          HORDE:CreateEnemy("Hell Hunter",    "npc_vj_ezo_vorthunter",        0.02, 6, true, 1, 1, 3.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            HORDE:CreateEnemy("Blight",         "npc_vj_horde_blight",          0.05, 6, true, 1, 1, 1.5, 1)
            HORDE:CreateEnemy("Weeper",         "npc_vj_horde_weeper",          0.03, 6, true, 1, 1, 2, 1, nil, nil,nil, nil,nil, nil, nil, 1)
            HORDE:CreateEnemy("Yeti",           "npc_vj_horde_yeti",            0.025, 6, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            -- Wave 7
            HORDE:CreateEnemy("Weeper", "npc_vj_horde_weeper",  0.03, 7, true, 1, 1, 2, 1, nil, nil,nil, nil,nil, nil, nil, 1)
            HORDE:CreateEnemy("Yeti",   "npc_vj_horde_yeti",    0.025, 7, true, 1, 1, 2.5, 1, nil, nil, nil, nil, nil, nil, nil, 1)
            -- Wave 8
            HORDE:CreateEnemy("Plague Elite", "npc_vj_horde_plague_elite", 0.015, 8, true, 1, 1, 4, 1, nil, nil, nil, nil, nil, nil, nil, 1)
        end
    end
    HORDE:NormalizeEnemiesWeight()
    print("[HORDE] - Loaded ZMod enemy config.")
end

-- Startup
if SERVER then
    util.AddNetworkString("Horde_SetEnemiesData")

    if GetConVar("horde_external_lua_config"):GetString() and GetConVar("horde_external_lua_config"):GetString() ~= "" then
    else
        if GetConVarNumber("horde_default_enemy_config") == 1 then
            HORDE:GetDefaultEnemiesData()
        else
            GetEnemiesData()
        end
    end

    net.Receive("Horde_SetEnemiesData", function (len, ply)
        if not ply:IsSuperAdmin() then return end
        local enemies_len = net.ReadUInt(32)
        local data = net.ReadData(enemies_len)
        local str = util.Decompress(data)
        HORDE.enemies = util.JSONToTable(str)
        HORDE.InvalidateHordeEnemyCache = 1
        HORDE:SetEnemiesData()
    end)
end
