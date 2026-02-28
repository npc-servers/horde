-- Basic user ui
local font = translate.GetFont()
local bold_font = translate.GetBoldFont()
local font_scale = translate.Get("Default_Font_Scale") or 1
surface.CreateFont("Horde_PerkTitle", { font = font, size = 24 * font_scale, bold = true, extended = true })
surface.CreateFont("Horde_PerkButton_Name", { font = font, size = 20 * font_scale, extended = true })
surface.CreateFont("Horde_PerkButton_Text", { font = font, size = 15 * font_scale, extended = true })
surface.CreateFont("Title", { font = font, size = 30 * font_scale, extended = true })
surface.CreateFont("Content", { font = font, size = 20 * font_scale, extended = true })
surface.CreateFont("Warning", { font = font, size = 30 * font_scale, strikeout = true, extended = true })
surface.CreateFont("LargeTitle", { font = bold_font, size = 35 * font_scale, extended = true })
surface.CreateFont("Heading", { font = font, size = 22 * font_scale, extended = true })
surface.CreateFont("Category", { font = bold_font, size = 22 * font_scale, extended = true })
surface.CreateFont("Item", { font = font, size = 20 * font_scale, extended = true })
surface.CreateFont("Info", { font = font, size = ScreenScale(7) * font_scale, extended = true})
surface.CreateFont("SmallInfo", { font = font, size = 20 * font_scale, extended = true})
surface.CreateFont("Horde_Ready", { font = font, size = ScreenScale(5) * font_scale, extended = true })
surface.CreateFont("Horde_Cd", { font = bold_font, size = ScreenScale(8) * font_scale, extended = true })
surface.CreateFont("Horde_Wave_Banner", { font = bold_font, size = ScreenScale(15) * font_scale, extended = true })
surface.CreateFont("Horde_Javeline", { font = "Arial", size = ScreenScale(8), extended = true })
surface.CreateFont("Horde_WaveLabel", { font = font, size = ScreenScale(4.5) * font_scale, extended = true })
surface.CreateFont("Horde_WaveNum",   { font = bold_font, size = ScreenScale(9) * font_scale, extended = true })

local width = ScreenScale(100)
local height = ScreenScale(15)

-- Enemy count tracking for the progress bar
local enemy_count     = 0
local enemy_max_count = 0
local center_panel_mode = "text" -- "text" | "enemies" | "boss" | "objectives"
local objectives_count = 0
local objectives_max   = 0

local center_panel = vgui.Create("DPanel")
local center_panel_str = ""
center_panel:SetSize(width, height)
center_panel:SetPos(ScreenScale(6), ScreenScale(23))
center_panel.Paint = function (w, h)
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    if center_panel_str == "" then return end

    local BAR_H   = math.max(3, math.floor(height * 0.12))
    local TEXT_Y  = (height - BAR_H) / 2
    local diff    = HORDE.Difficulty and HORDE.Difficulty[HORDE.CurrentDifficulty]
    local diff_name = diff and diff.name or ""
    local diff_col  = (diff and diff.color) or Color(200, 200, 200)

    draw.RoundedBox(8, 0, 0, width, height, Color(20, 20, 20, 220))

    if center_panel_mode == "enemies" and enemy_max_count > 0 then
        -- Progress bar at the bottom (enemies remaining)
        local fraction = math.Clamp(enemy_count / enemy_max_count, 0, 1)
        draw.RoundedBox(4, 0, height - BAR_H, width, BAR_H, Color(50, 50, 50, 200))
        draw.RoundedBox(4, 0, height - BAR_H, width * fraction, BAR_H, Color(220, 80, 60, 230))
        -- Difficulty label (left) and enemy count (right)
        if diff_name ~= "" then
            draw.SimpleText(diff_name, "Info", ScreenScale(6), TEXT_Y, diff_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        draw.SimpleText(translate.Get("Game_Enemies") .. ": " .. tostring(enemy_count), "Info", width - ScreenScale(5), TEXT_Y, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

    elseif center_panel_mode == "boss" then
        -- Red left stripe for boss
        surface.SetDrawColor(220, 20, 60, 255)
        surface.DrawRect(0, 0, 3, height)
        if diff_name ~= "" then
            draw.SimpleText(diff_name, "Info", ScreenScale(6), TEXT_Y, diff_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        draw.SimpleText("BOSS", "Info", width / 2, TEXT_Y, Color(220, 20, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    elseif center_panel_mode == "objectives" then
        -- Progress bar for objectives
        if objectives_max > 0 then
            local frac = math.Clamp(objectives_count / objectives_max, 0, 1)
            draw.RoundedBox(4, 0, height - BAR_H, width, BAR_H, Color(50, 50, 50, 200))
            draw.RoundedBox(4, 0, height - BAR_H, width * frac, BAR_H, Color(84, 107, 255, 230))
        end
        surface.SetDrawColor(84, 107, 255, 255)
        surface.DrawRect(0, 0, 3, height - BAR_H)
        if diff_name ~= "" then
            draw.SimpleText(diff_name, "Info", ScreenScale(6), TEXT_Y, diff_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        draw.SimpleText("Objectives: " .. tonumber(objectives_count) .. "/" .. tonumber(objectives_max), "Info", width - ScreenScale(5), TEXT_Y, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

    else
        draw.SimpleText(center_panel_str, "Info", width / 2, height / 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

local ammobox_refresh_count = 0
net.Receive("Horde_AmmoboxCountdown", function ()
    ammobox_refresh_count = 60 - net.ReadInt(8)
end)

local wave_str
local corner_panel = vgui.Create("DPanel")
corner_panel:SetSize(width, height)
corner_panel:SetPos(ScreenScale(6), ScreenScale(6))
corner_panel.Paint = function () end
timer.Simple(5, function ()
    local ammoMaterial = Material("materials/ammo.png", "mips smooth")
    corner_panel.Paint = function ()
        if GetConVarNumber("horde_enable_client_gui") == 0 then return end
        local panel_w = width - height - ScreenScale(2)

        draw.RoundedBox(8, 0, 0, panel_w, height, Color(20, 20, 20, 220))

        if (HORDE.current_wave <= 0) or (wave_str == nil) then
            draw.SimpleText(translate.Get("Game_Preparing..."), "Info", panel_w / 2, height / 2, Color(180, 180, 180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            -- Measure both pieces so they sit centered together
            surface.SetFont("Horde_WaveLabel")
            local lw = surface.GetTextSize("WAVE ")
            surface.SetFont("Horde_WaveNum")
            local nw = surface.GetTextSize(wave_str)
            local start_x = math.floor((panel_w - lw - nw) / 2)
            draw.SimpleText("WAVE ", "Horde_WaveLabel", start_x,        height / 2, Color(160, 160, 160), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(wave_str,  "Horde_WaveNum",   start_x + lw,  height / 2, Color(255, 210, 100), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            -- Gold accent bar at bottom
            surface.SetDrawColor(255, 200, 80, 180)
            surface.DrawRect(0, height - 2, panel_w, 2)
        end

        draw.RoundedBox(8, width - height, 0, height, height, Color(20, 20, 20, 220))
        if ammobox_refresh_count > 5 then
            draw.RoundedBox(8, width - height, height * (1 - ammobox_refresh_count / HORDE.ammobox_refresh_interval), height, height * (ammobox_refresh_count / HORDE.ammobox_refresh_interval), HORDE.color_crimson_dark)
        end
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(ammoMaterial)
        surface.DrawTexturedRect(width - height + ScreenScale(2), ScreenScale(2), ScreenScale(10), ScreenScale(10))
    end
end)

local delayed_boss_health = 0
local boss_name = ""
local boss_health = 0
local boss_max_health = 0
local boss_health_bar = vgui.Create("DPanel")
boss_health_bar:SetSize(ScrW() - (width + ScreenScale(10)) * 2, 75)
boss_health_bar:SetPos(ScrW() / 2 - boss_health_bar:GetWide() / 2, 25)
boss_health_bar.Paint = function()
    if boss_health <= 0 or boss_max_health <= 0 then return end
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide(), 35, HORDE.color_hollow)
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide() * delayed_boss_health / boss_max_health, 35, Color(255,255,255,225))
    draw.RoundedBox(10, 0, 0, boss_health_bar:GetWide() * boss_health / boss_max_health, 35, Color(220, 20, 60))
    draw.SimpleText(boss_name, "Info", boss_health_bar:GetWide() / 2, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
end

local holdzone_progress = 0
local holdzone_bar = vgui.Create("DPanel")
holdzone_bar:SetSize(ScrW() - (width + ScreenScale(20)) * 2, 75)
holdzone_bar:SetPos(ScrW() / 2 - holdzone_bar:GetWide() / 2, 25)
holdzone_bar.Paint = function()
    if holdzone_progress <= 0 then return end
    draw.RoundedBox(10, 0, 0, holdzone_bar:GetWide(), 35, HORDE.color_hollow)
    draw.RoundedBox(10, 0, 0, holdzone_bar:GetWide() * holdzone_progress / 100, 35, Color(84, 107, 255))
    draw.SimpleText("Hold Progress", "Info", holdzone_bar:GetWide() / 2, 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5)
end

HORDE.Notifications_Count = 0
local function inQuad(fraction, beginning, change)
	return change * (fraction ^ 2) + beginning
end

local warning_mat = Material("warning.png", "mips smooth")
local ok_mat = Material("ok.png", "mips smooth")

local materialCache = {}

function HORDE:PlayNotification(text, type, icon, col)
    if not type then type = 0 end
    if not text then return end
    local s = string.len(text) * ScreenScale(3) + ScreenScale(20)
    local main = vgui.Create("DPanel")
    local y_start = ScrH() - ScreenScale(40) - HORDE.Notifications_Count * ScreenScale(18)
    main:SetSize(s, ScreenScale(15))
    main:SetPos(ScrW() - s, y_start)
    local mat
    if type == 0 then
        mat = ok_mat
    else
        mat = warning_mat
    end
    if icon then
        if not materialCache[icon] then
            materialCache[icon] = Material(icon, "mips smooth")
        end
        mat = materialCache[icon]
    end
    local color = color_white
    if col then color = col end
    main.Paint = function ()
        draw.RoundedBox(10, 0, 0, s, ScreenScale(15), Color(40,40,40,150))
        draw.SimpleText(text, "Info", ScreenScale(4) + ScreenScale(10), ScreenScale(4), color_white, TEXT_ALIGN_LEFT)
        surface.SetDrawColor(color)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(ScreenScale(2), ScreenScale(2), ScreenScale(10), ScreenScale(10))
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetPos(ScrW() - s - ScreenScale(8), inQuad(delta, y_start, - ScreenScale(30))) -- Change the X coordinate from 200 to 200+600
        pnl:SetAlpha(delta * 255)
    end)
    main.Think = function(self)
        if anim:Active() then
            anim:Run()
        end
    end
    anim:Start(0.5) -- Animate for two seconds
    if anim:Active() then
        anim:Run()
    end
    timer.Simple(5, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetAlpha(255 - delta * 255)
        end)
        anim2:Start(0.5)
        if anim2:Active() then
            anim2:Run()
        end
        main.Think = function(self)
            if anim2:Active() then
                anim2:Run()
            end
        end
        timer.Simple(0.5, function ()
            main:Remove()
            HORDE.Notifications_Count = math.max(0, HORDE.Notifications_Count - 1)
        end)
    end)
    HORDE.Notifications_Count = HORDE.Notifications_Count + 1
end

function HORDE:PlayWaveNotification(wave)
    local text = (translate.Get("Game_WAVE ") or "WAVE ") .. wave
    local main = vgui.Create("DPanel")
    local y_start = ScrH() / 4
    local h = ScreenScale(40)
    main:SetSize(ScrW(), h)
    main:SetPos(0, y_start)
    main.Paint = function ()
        surface.SetDrawColor(Color(40,40,40,200))
        surface.DrawRect(0, 0, ScrW(), h)
        draw.SimpleText(text, "Horde_Wave_Banner", ScrW()/2, ScreenScale(12), color_white, TEXT_ALIGN_CENTER)
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetTall(delta * h)
        pnl:SetPos(0, y_start - h/2 * delta)
        pnl:SetAlpha(delta * 255)
    end)
    main.Think = function(self)
        if anim:Active() then
            anim:Run()
        end
    end
    anim:Start(0.5) -- Animate for two seconds
    if anim:Active() then
        anim:Run()
    end
    timer.Simple(5, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetTall((1 - delta) * h)
            pnl:SetPos(0, y_start - h/2 + h/2 * delta)
            pnl:SetAlpha(255 - delta * 255)
        end)
        anim2:Start(0.5)
        if anim2:Active() then
            anim2:Run()
        end
        main.Think = function(self)
            if anim2:Active() then
                anim2:Run()
            end
        end
        timer.Simple(0.5, function ()
            main:Remove()
        end)
    end)
end

function HORDE:DisplayObjective(text, type, icon, col)
    if not type then type = 0 end
    if not text then return end
    local s = string.len(text) * ScreenScale(3) + ScreenScale(20)
    local main = vgui.Create("DPanel")
    local y_start = ScrH() - ScreenScale(40) - HORDE.Notifications_Count * ScreenScale(18)
    main:SetSize(s, ScreenScale(15))
    main:SetPos(ScrW() - s, y_start)
    local mat
    if type == 0 then
        mat = ok_mat
    else
        mat = warning_mat
    end
    if icon then
        if not materialCache[icon] then
            materialCache[icon] = Material(icon, "mips smooth")
        end
        mat = materialCache[icon]
    end
    local color = color_white
    if col then color = col end
    main.Paint = function ()
        draw.RoundedBox(10, 0, 0, s, ScreenScale(15), Color(40,40,40,150))
        draw.SimpleText(text, "Info", ScreenScale(4) + ScreenScale(10), ScreenScale(4), color_white, TEXT_ALIGN_LEFT)
        surface.SetDrawColor(color)
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(ScreenScale(2), ScreenScale(2), ScreenScale(10), ScreenScale(10))
    end
    local anim = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
        pnl:SetPos(ScrW() - s - ScreenScale(8), inQuad(delta, y_start, - ScreenScale(30))) -- Change the X coordinate from 200 to 200+600
        pnl:SetAlpha(delta * 255)
    end)
    main.Think = function(self)
        if anim:Active() then
            anim:Run()
        end
    end
    anim:Start(0.5) -- Animate for two seconds
    if anim:Active() then
        anim:Run()
    end
    timer.Simple(5, function ()
        local anim2 = Derma_Anim("Linear", main, function(pnl, anim, delta, data)
            pnl:SetAlpha(255 - delta * 255)
        end)
        anim2:Start(0.5)
        if anim2:Active() then
            anim2:Run()
        end
        main.Think = function(self)
            if anim2:Active() then
                anim2:Run()
            end
        end
        timer.Simple(0.5, function ()
            main:Remove()
        end)
        HORDE.Notifications_Count = math.max(0, HORDE.Notifications_Count - 1)
    end)
    HORDE.Notifications_Count = HORDE.Notifications_Count + 1
end


net.Receive("Horde_SyncGameInfo", function()
    HORDE.current_wave = net.ReadUInt(16)
end)

net.Receive("Horde_SyncBossSpawned", function ()
    boss_name = net.ReadString()
    boss_max_health = net.ReadInt(32)
    boss_health = net.ReadInt(32)
    delayed_boss_health = boss_health
    timer.Create("Horde_BossHealthDelayedDisplay", 0.1, 0, function ()
        if delayed_boss_health ~= boss_health then
            delayed_boss_health = delayed_boss_health - (delayed_boss_health - boss_health) / 2.5
        end
    end)
end)

net.Receive("Horde_SyncBossHealth", function ()
    boss_health = net.ReadInt(32)
    if boss_health <= 0 then
        timer.Remove("Horde_BossHealthDelayedDisplay")
    end
end)

net.Receive("Horde_SyncHoldProgress", function ()
    holdzone_progress = net.ReadUInt(8)
end)

net.Receive("Horde_RenderPlayersReady", function()
    local str = net.ReadString()
    center_panel_str = translate.Get("Game_Players_Ready") .. ": "  ..str
end)

net.Receive("Horde_RenderBreakCountDown", function()
    local num = net.ReadInt(8)
    local is_end_message = net.ReadBool()
    if is_end_message then
        surface.PlaySound("hl1/fvox/blip.wav")
        center_panel_str = translate.Get("Game_Wave_Completed") .. "!"
        wave_str = nil
        return
    end
    if num then
        if num >= 0 and num <= 10 then
            if HORDE.PlayerReadyPanel then
                HORDE.PlayerReadyPanel:Remove()
                HORDE.HelpPanel:SetVisible(false)
                HORDE.TipPanel:SetVisible(false)
                HORDE.leader_board:SetVisible(false)
            end
            if num == 10 then
                surface.PlaySound("hl1/fvox/ten.wav")
            elseif num == 5 then
                surface.PlaySound("hl1/fvox/five.wav")
            elseif num == 0 then
                surface.PlaySound("ambient/alarms/warningbell1.wav")
            else
                surface.PlaySound("horde/cd/" .. tostring(num) ..".mp3")
            end
        elseif num > 0 then
            if not HORDE.HelpPanel:IsVisible() then
                HORDE.HelpPanel:SetVisible(true)
                HORDE.TipPanel:SetVisible(true)
                HORDE:ShowLeaderboardThenFadeOut()
            end
        end
    end
    if num == 0 then
        -- Reset enemy progress tracking for the new wave
        enemy_count     = 0
        enemy_max_count = 0
        center_panel_mode = "text"
        center_panel_str = translate.Format("Game_Wave_Has_Started", tostring(HORDE.current_wave)) .. "!"
        timer.Simple(1, function() HORDE:PlayWaveNotification(HORDE.current_wave) end)
    else
        center_panel_mode = "text"
        center_panel_str = translate.Format("Game_Next_Wave_Starts_In", num)
    end
end)

net.Receive("Horde_RenderEnemiesCount", function()
    local is_boss = net.ReadBool()
    wave_str = net.ReadString()
    local count = net.ReadUInt(12)
    enemy_count = count
    if count > enemy_max_count then enemy_max_count = count end
    if is_boss then
        is_boss_wave = true
        center_panel_mode = "boss"
    else
        is_boss_wave = false
        center_panel_mode = "enemies"
    end
    -- Keep center_panel_str updated for fallback / other callers
    local diff_name = HORDE.Difficulty and HORDE.Difficulty[HORDE.CurrentDifficulty] and HORDE.Difficulty[HORDE.CurrentDifficulty].name or ""
    if is_boss then
        center_panel_str = "|" .. diff_name .. "|  BOSS"
    else
        center_panel_str = "|" .. diff_name .. "|  " .. translate.Get("Game_Enemies") .. ": " .. tostring(count)
    end
end)

net.Receive("Horde_RenderObjectives", function()
    local count = net.ReadUInt(4)
    local max_count = net.ReadUInt(4)
    objectives_count = count
    objectives_max   = max_count
    center_panel_mode = "objectives"
    local diff_name = HORDE.Difficulty and HORDE.Difficulty[HORDE.CurrentDifficulty] and HORDE.Difficulty[HORDE.CurrentDifficulty].name or ""
    center_panel_str = "|" .. diff_name .. "|  Objectives: " .. tonumber(count) .. "/" .. tonumber(max_count)
end)

net.Receive("Horde_RenderGameResult", function()
    local status = net.ReadString()
    local wave = net.ReadUInt(32)
    center_panel_mode = "text"
    center_panel_str = translate.Get("Game_Result_" .. status) .. "! " .. translate.Get("Game_Wave") .. ": " .. tostring(wave)
end)

net.Receive("Horde_SyncEscapeStart", function ()
    center_panel_mode = "text"
    local diff_name = HORDE.Difficulty and HORDE.Difficulty[HORDE.CurrentDifficulty] and HORDE.Difficulty[HORDE.CurrentDifficulty].name or ""
    center_panel_str = "|" .. diff_name .. "|  Escape!"
end)

local heal_msg_cd = 0
timer.Create("Horde_PreventHealSpam", 1, 0, function()
    if heal_msg_cd > 0 then
        heal_msg_cd = heal_msg_cd - 1
    end
end)

net.Receive("Horde_RenderHealer", function()
    local healer = net.ReadString()
    if heal_msg_cd <= 0 then
        HORDE:PlayNotification(string.sub(healer, 0, 20) .. " " .. translate.Get("Game_Healed_You") .. ".", 0, "status/hp.png", Color(50,205,50))
        heal_msg_cd = 5
    end
end)

local currentMusic

net.Receive( "Horde_BossMusic", function()
    local ply = LocalPlayer()
    local music = net.ReadString()
    local status = net.ReadBool()
    if not IsValid( ply ) then return end

    if status then
        currentMusic = music
        ply:EmitSound( currentMusic, 0, 100, 1, CHAN_STATIC, SND_SHOULDPAUSE )
    else
        if not currentMusic then return end

        ply:StopSound( currentMusic )
    end
end )

net.Receive( "Horde_MatchMusic", function()
    local ply = LocalPlayer()
    local music = net.ReadString()
    if not IsValid( ply ) then return end

    ply:EmitSound( music, 0, 100, 1, CHAN_STATIC, SND_SHOULDPAUSE )
end )
