local PANEL = {}

local function multlinetext(text, maxw, font)
    local content = ""
    local tline = ""
    local x = 0
    surface.SetFont(font)

    local newlined = string.Split(text, "\n")

    for _, line in pairs(newlined) do
        local words = string.Split(line, " ")

        for _, word in pairs(words) do
            local tx = surface.GetTextSize(word)

            if x + tx >= maxw then
                content = content .. "\n" .. tline
                tline = ""
                x = surface.GetTextSize(word)
            end

            tline = tline .. word .. " "

            x = x + surface.GetTextSize(word .. " ")
        end

        content = content .. "\n" .. tline
        tline = ""
        x = 0
    end
    return content
end

local function drawStat(self, header, stat, x, y, mat, col)
    surface.SetMaterial(mat)
    surface.SetDrawColor(col)
    surface.DrawTexturedRect(x / 2, y - 20, 40, 40)

    draw.SimpleText(header, "Heading", x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    if stat then
        draw.SimpleText(stat, "Heading", self:GetWide() / 3 - x / 2, y, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end
end

local function drawStatResistance(self, txt, stat, x, y, matTable, matCol)
    local col = IsColor(matCol) and matCol or matCol[stat]
    local mat = Material(matTable[stat], "mips smooth")

    drawStat(self, txt, HORDE:GetStat(stat) * 100 .. "%", x, y, mat, col)
end

local function drawStatBasic(self, txt, stat, x, y, matStr)
    local mat = Material(matStr, "mips smooth")

    drawStat(self, txt, stat, x, y, mat, color_white)
end

local function drawStatPerk(txt, x, y, matStr)
    local mat = Material(matStr, "mips smooth")

    drawStat(nil, txt, nil, x, y, mat, color_white)
end

function PANEL:Init()
    if ScrH() < 1080 then
        self:SetSize(ScrW(), ScrH())
    else
        self:SetSize(ScrW() / 1.25, ScrH() / 1.5)
    end
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))

    local stats_panel = vgui.Create("DPanel", self)
    stats_panel:SetPos(0, 50)
    stats_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    stats_panel:SetBackgroundColor(HORDE.color_hollow)
    self.stats_panel = stats_panel

    local achievements_panel = vgui.Create("DPanel", self)
    achievements_panel:SetPos(0, 50)
    achievements_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    achievements_panel:SetBackgroundColor(HORDE.color_hollow)
    achievements_panel:SetVisible(false)
    self.achievements_panel = achievements_panel

    local maps_panel = vgui.Create("DScrollPanel", achievements_panel)
    maps_panel:Dock(LEFT)
    maps_panel:SetSize(300, self:GetParent():GetTall())
    maps_panel:SetBackgroundColor(Color(0,0,0,0))

    local map_achievement_btns = {}
    local map_achievements_panel = vgui.Create("DScrollPanel", achievements_panel)
    local map_clicked = nil
    map_achievements_panel:Dock(FILL)
    map_achievements_panel:DockMargin(10, 5, 10, 5)
    map_achievements_panel:SetSize(self:GetParent():GetWide() - 300, self:GetParent():GetTall())
    map_achievements_panel.Paint = function ()
        if map_clicked then return end
        draw.SimpleText('Complete maps on 10 waves to earn achievements!', 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.DrawText([[
        *Notes: Achievements are disabled in sandbox mode.

        To achieve the special Horde Completion achievement, you need:
          - Default Config Enabled
          - Default Settings:
            - Base Start Money <= 1000
            - Base Round bonus <= 500
            - Base Walk Speed <= 180
            - Base Run Speed <= 220]], 'Content', 50, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local function firstToUpper(str)
        return (str:gsub("^%l", string.upper))
    end
    self.create_map_achievement_btn = function (map, title, unlocked)
        local achievement = vgui.Create("DPanel", map_achievements_panel)
        achievement:DockMargin(10, 5, 10, 5)
        achievement:SetSize(self:GetParent():GetWide() - 50, 100)
        achievement:Dock(TOP)
        local content = HORDE.MapAchievement_Descriptions[title]
        local ss = string.Split(map, "_")
        if ss[1] == "zs" or ss[1] == "de" or ss[1] == "hr" or ss[1] == "cs" or ss[1] == "gm" or ss[1] == "ow" or ss[1] == "zm" or ss[1] == "kf2" then
            local i = 1
            for _, sb in pairs(ss) do
                if i > 1 then
                    if i == 2 then
                        map = firstToUpper(ss[2])
                    else
                        map = map .. " " .. firstToUpper(ss[i])
                    end
                end
                i = i + 1
            end
        else
            map = string.upper(map)
        end
        achievement.Paint = function ()
            if unlocked then
                draw.RoundedBox(10, 0, 0, map_achievements_panel:GetWide() - 25, 100, HORDE.color_crimson)
                draw.SimpleText(map .. ": " .. title, 'LargeTitle', 50, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(content, 'Trebuchet24',  50, 75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                surface.SetMaterial(Material("trophy.png", "mips smooth"))
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(map_achievements_panel:GetWide() - 125, 25, 50, 50)
            else
                draw.RoundedBox(10, 0, 0, map_achievements_panel:GetWide() - 25, 100, HORDE.color_hollow_dim)
                draw.SimpleText(map .. ": " .. title, 'LargeTitle', 50, 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(content, 'Trebuchet24',  50, 75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                surface.SetMaterial(Material("locked.png", "mips smooth"))
                surface.SetDrawColor(color_white)
                surface.DrawTexturedRect(map_achievements_panel:GetWide() - 125, 25, 50, 50)
            end
        end
        table.insert(map_achievement_btns, achievement)
    end

    HORDE:LoadMapAchievements()
    local achievements = {}
    for map, stats in pairs(HORDE.achievements_map) do
        achievements[map] = HORDE:GetMapAchievements(map)
    end

    self.map_btns = {}
    self.create_map_btn = function (map)
        local map_btn = vgui.Create("DButton", maps_panel)
        local map_btn_hovered = false
        map_btn:DockMargin(10, 5, 10, 5)
        map_btn:SetSize(self:GetParent():GetWide(), 50)
        map_btn:Dock(TOP)
        map_btn:SetText("")
        map_btn.Paint = function ()
            if map_btn_hovered or (self.map_btns[map_btn] == 1) then draw.RoundedBox(0, 0, 10, self:GetWide(), self:GetTall(), HORDE.color_crimson) return end
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), HORDE.color_hollow)
        end
        map_btn.OnCursorEntered = function ()
            map_btn_hovered = true
            surface.PlaySound("UI/buttonrollover.wav")
        end
        map_btn.OnCursorExited = function ()
            map_btn_hovered = false
        end
        map_btn.DoClick = function ()
            for btn, _ in pairs(self.map_btns) do
                self.map_btns[btn] = 0
            end
            self.map_btns[map_btn] = 1
            surface.PlaySound("UI/buttonclick.wav")
            map_clicked = true

            for _, btns in pairs(map_achievement_btns) do
                btns:Remove()
            end

            if not achievements[map] then
                achievements[map] = {}
                achievements[map]["completion_count"] = 0
            end

            self.create_map_achievement_btn(map, HORDE.MapAchievements.normal, achievements[map][HORDE.MapAchievements.normal])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.hard, achievements[map][HORDE.MapAchievements.hard])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.realism, achievements[map][HORDE.MapAchievements.realism])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.nightmare, achievements[map][HORDE.MapAchievements.nightmare])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.apocalypse, achievements[map][HORDE.MapAchievements.apocalypse])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.coop, achievements[map][HORDE.MapAchievements.coop])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.horde, achievements[map][HORDE.MapAchievements.horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.hardcore_horde, achievements[map][HORDE.MapAchievements.hardcore_horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.coop_horde, achievements[map][HORDE.MapAchievements.coop_horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.hardcore_coop_horde, achievements[map][HORDE.MapAchievements.hardcore_coop_horde])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.endless_20, achievements[map][HORDE.MapAchievements.endless_20])
            self.create_map_achievement_btn(map, HORDE.MapAchievements.endless_30, achievements[map][HORDE.MapAchievements.endless_30])
        end

        local name_label = vgui.Create("DLabel", map_btn)
        name_label:Dock(LEFT)
        name_label:SetText("")
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("Content")
        name_label.Paint = function ()
            draw.SimpleText(map, "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
        end

        local num_label = vgui.Create("DLabel", map_btn)
        num_label:Dock(RIGHT)
        num_label:SetText("")
        num_label:SetSize(35, 80)
        num_label:SetColor(Color(255,255,255))
        num_label:SetFont("Content")
        local count = achievements[map]["completion_count"]
        local completion = nil
        if count then
            if count >= 4 then
                completion = "bronze"
            elseif count >= 7 then
                completion = "silver"
            elseif count >= 9 then
                completion = "gold"
            end
        end
        num_label.Paint = function ()
            surface.SetMaterial(Material("trophy.png", "mips smooth"))
            if completion == "bronze" then
                surface.SetDrawColor(Color(205,127,50))
            elseif completion == "silver" then
                surface.SetDrawColor(Color(192,192,192))
            elseif completion == "gold" then
                surface.SetDrawColor(Color(255,215,0))
            else
                return
            end
            surface.DrawTexturedRect(0, 18, 25, 25)
        end

        self.map_btns[map_btn] = 0
    end

    for map, _ in SortedPairs(HORDE.achievements_map) do
        if not achievements[map] then
            achievements[map] = {}
        end
        self.create_map_btn(map)
    end

    local learn_panel = vgui.Create("DPanel", self)
    learn_panel:SetPos(0, 50)
    learn_panel:SetSize(self:GetWide(), self:GetTall() - 50)
    learn_panel:SetBackgroundColor(HORDE.color_hollow)
    learn_panel:SetVisible(false)
    self.learn_panel = learn_panel

    local mechanics_panel = vgui.Create("DScrollPanel", learn_panel)
    mechanics_panel:Dock(LEFT)
    mechanics_panel:SetSize(256, self:GetParent():GetTall())
    mechanics_panel:SetBackgroundColor(Color(0,0,0,0))

    local description_panel = vgui.Create("DScrollPanel", learn_panel)
    description_panel:Dock(FILL)
    description_panel:SetSize(self:GetParent():GetWide() - 266, self:GetParent():GetTall())

    local update_text_panel = vgui.Create("DPanel", description_panel)
    update_text_panel:SetSize(self:GetParent():GetWide(), 2000)
    update_text_panel:SetVisible(true)
    local update_text =[[
        -- Assist
            Added a simple assist reward.

        -- Class Grenades
        Each class now has its own unique grenade that complements its playstyle.
        Grenades have an ammo limit of 6 in total.

        < Assasult: Stun Grenade (arccw_horde_nade_stun)
        < Heavy: Shrapnel Grenade (arccw_horde_nade_shrapnel)
        < Ghost: Sonar Grenade (arccw_horde_nade_sonar)
        < Demolition: M67 Frag Grenade (arccw_horde_m67)
        < Medic: Medic Grenade (arccw_nade_medic)
        < Engineer: Nanobot Grenade (arccw_horde_nade_nanobot)
        < Berserker: Hemo Grenade (arccw_horde_nade_hemo)
        < Warden: EMP Grenade (arccw_horde_nade_emp)
        < Cremator: Molotov (arccw_horde_nade_molotov)

        -- Assault Class Changes:
        Item Changes:
            < Rebalanced weapon damage values and prices. The goal is to make more high tier weapons available.
            < Reworked Weapon: FAMAS (arccw_horde_famas)
            < Reworked Weapon: Galil (arccw_horde_ace)
            < Reworked Weapon: M4A1 (arccw_horde_m4)
            < Reworked Weapon: AK47 (arccw_horde_ak47)
            < Reworked Weapon: SG556 (arccw_horde_sg556)
            < Reworked Weapon: AUG (arccw_horde_aug)

        -- Heavy Class Changes
        Perk Changes:
            < Added maximum armor bonus passive.
            < Ballistic Shock effect changed.
            < Reactive Armor perk effect changed.

        Item Changes:
            < Rebalanced weapon damage values and prices. The goal is to make more high tier weapons available.
            < Weapons with visible Bipods will now have Bipods by default.
            < Energy Shield gadget effect changed.
            < ULPA Filter gadget effect changed.
            < New Gadget: Armor Fusion (gadget_armor_fusion)

        -- Demolition Class Changes
        Perk changes:
            < Reduced Blast resistance passive
            < Added Blast damage bonus passive
            < Pressurized Warhead / Chain Reaction effects changed

        Weapon changes:
            < All default config demolition weapons now have arm distance and headshot detection.
            < Added two new attachments for explosive projectile weapons.
            < Rebalanced weapon damage values.
            < New Weapon: FGM-148 Javelin (arccw_horde_javelin)

        -- Medic Class Changes:
        Item Changes:
            < New Weapon: MP9 Medic (arccw_horde_mp9m)
            < New Weapon: MP5K Medic (arccw_horde_mp5k)
            < New Weapon: ACR Medic (arccw_horde_medic_acr)
            < New Gadget: Aegis (gadget_aegis)

        -- Ghost Class Changes:
        Item Changes:
            < Slightly reduced damage of Barrett and M200.
            < Increased price and damage of AWP.
            < Increased damage of heat crossbow.
            < Automatic weapons have been removed from Ghost weapon pool.
            < Dual pistols off-hand damage have been fixed.
            < New Weapon: SSG08 (arccw_horde_ssg08)

        -- Warden Class Changes:
        Perk Changes:
            < Energize and Inoculation have switched slots.
            < Energize now only applies to damage instance at least 8.

        Item Changes:
            < Fixed Double Barrel dealing too much damage as intended and added back knockback boost.
            < Reworked Weapon: SPAS12 (arccw_horde_spas12)

        -- Cremator Class Changes:
        Perk Changes:
            < Reduced passive Fire damage resistance.
            < Entropy Shield effect changed.

        Item Changes:
            < Increased price of some weapons.

        -- Berserker Class Changes:
        Item Changes:
            < New Gadget: Omnislash (gadget_omnislash)]]
    local mt = multlinetext(update_text, update_text_panel:GetWide() - 50, 'Content')
    update_text_panel.Paint = function ()
        draw.SimpleText("Major Update 1.2.1", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.DrawText(mt, 'Content', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local debuff_text_panel = vgui.Create("DPanel", description_panel)
    debuff_text_panel:SetSize(self:GetParent():GetWide(), 900)
    debuff_text_panel:SetVisible(false)
    debuff_text_panel.Paint = function ()
        local mat = Material("materials/status/bleeding.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.color_crimson_violet)
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material("materials/status/ignite.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_FIRE])
        surface.DrawTexturedRect(50, 230, 40, 40)

        mat = Material("materials/status/frostbite.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_COLD])
        surface.DrawTexturedRect(50, 330, 40, 40)

        mat = Material("materials/status/shock.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING])
        surface.DrawTexturedRect(50, 430, 40, 40)

        mat = Material("materials/status/break.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
        surface.DrawTexturedRect(50, 530, 40, 40)

        mat = Material("materials/status/decay.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(Color(50, 150, 50))
        surface.DrawTexturedRect(50, 630, 40, 40)

        mat = Material("materials/status/necrosis.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(Color(50, 50, 50))
        surface.DrawTexturedRect(50, 730, 40, 40)

        draw.SimpleText("Debuff Status", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Bleed:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from certain enemies and mutations. When inflicted, removes health over time.", 'Content', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ignite:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Fire damage. When inflicted, deals Fire damage over time.", 'Content', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Frostbite:", 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Cold damage. When inflicted, reduces movement speed by 40/45/50/50/55%.", 'Content', 100, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Shock:", 'Heading', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Lightning damage. When inflicted, causes player to receive 15/20/25/25/30% more damage.", 'Content', 100, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Break:", 'Heading', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Poison damage. When inflicted, removes 80/85/90/90/95% of player health that is recovered slowly.", 'Content', 100, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Decay:", 'Heading', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Decay mutation. When inflicted, prevents healing.", 'Content', 100, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Necrosis:", 'Heading', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Buildup from Blight enemies. When inflicted, causes instant death.", 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local damage_text_panel = vgui.Create("DPanel", description_panel)
    damage_text_panel:SetSize(self:GetParent():GetWide(), 1200)
    damage_text_panel:SetVisible(false)
    damage_text_panel.Paint = function ()
        local mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_BALLISTIC], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 130, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_SLASH], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 230, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_BLUNT], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 330, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_PHYSICAL], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_PHYSICAL])
        surface.DrawTexturedRect(50, 430, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_FIRE], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_FIRE])
        surface.DrawTexturedRect(50, 530, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_COLD], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_COLD])
        surface.DrawTexturedRect(50, 630, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_LIGHTNING], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_LIGHTNING])
        surface.DrawTexturedRect(50, 730, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_POISON], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_POISON])
        surface.DrawTexturedRect(50, 830, 40, 40)

        mat = Material(HORDE.DMG_TYPE_ICON[HORDE.DMG_BLAST], "mips smooth")
        surface.SetMaterial(mat)
        surface.SetDrawColor(HORDE.DMG_COLOR[HORDE.DMG_BLAST])
        surface.DrawTexturedRect(50, 930, 40, 40)

        draw.SimpleText("Damage Types", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Ballistic:", 'Heading', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_BULLET, DMG_SNIPER, DMG_BUCKSHOT.", 'Content', 100, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slash:", 'Heading', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_SLASH.", 'Content', 100, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Blunt:", 'Heading', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_CLUB.", 'Content', 100, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Other Physical Damage:", 'Heading', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_GENERIC, DMG_CRUSH, DMG_SONIC.", 'Content', 100, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Fire:", 'Heading', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Ignite buildup. DMG_BURN, DMG_SLOWBURN, DMG_PLASMA.", 'Content', 100, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Cold:", 'Heading', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Frostbite buildup. DMG_REMOVENORAGDOLL.", 'Content', 100, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Lightning:", 'Heading', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Shock buildup. DMG_SHOCK, DMG_ENERGYBEAM.", 'Content', 100, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Poison:", 'Heading', 100, 850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Increases Break buildup. DMG_NERVEGAS, DMG_ACID, DMG_POISON, DMG_PARALYZE", 'Content', 100, 900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Blast:", 'Heading', 100, 950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DMG_BLAST, DMG_MISSILEDEFENSE.", 'Content', 100, 1000, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local function draw_resistances(pos, res)
        local start_pos = 250
        for type, value in SortedPairs(res) do
            local mat = Material(HORDE.DMG_TYPE_ICON[type], "mips smooth")
            surface.SetMaterial(mat)
            surface.SetDrawColor(HORDE.DMG_COLOR[type])
            surface.DrawTexturedRect(start_pos, pos - 15, 30, 30)

            surface.SetDrawColor(color_white)
            if value < 1 then
                draw.SimpleText("x" .. tostring(value), 'Content', start_pos + 40, pos, Color(255,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            elseif value > 1 then
                draw.SimpleText("x" .. tostring(value), 'Content', start_pos + 40, pos, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            start_pos = start_pos + 90
        end
    end
    local function write_paragraph(strs, start_pos)
        for _, str in pairs(strs) do
            draw.SimpleText(str, 'Content', 100, start_pos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            start_pos = start_pos + 50
        end
        return start_pos
    end
    local enemies_text_panel = vgui.Create("DPanel", description_panel)
    enemies_text_panel:SetSize(self:GetParent():GetWide(), 5000)
    enemies_text_panel:SetVisible(false)
    enemies_text_panel.Paint = function ()

        -- Regular enemies.
        draw.SimpleText("Regular Enemies", 'LargeTitle', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Walker", 'Heading', 50, 100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slow-moving zombie.", 'Content', 100, 150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Sprinter", 'Heading', 50, 200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Zombie with moderate speed.", 'Content', 100, 250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Crawler", 'Heading', 50, 300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Weak zombie with high agility. Deals rapid-speed attacks.", 'Content', 100, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Zombie Torso", 'Heading', 50, 400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Upper-half of a headcrab zombie. Deals fast, low-blow attacks.", 'Content', 100, 450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Fast Zombie", 'Heading', 50, 500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Weak headcrab zombie with high agility. Leaps at enemies.", 'Content', 100, 550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Poison Zombie", 'Heading', 50, 600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Strong, slow-moving headcrab zombie. Throws an acid ball that inflicts Poison damage.", 'Content', 100, 650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("H.E.V. Zombie", 'Heading', 50, 700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Strong headcrab zombie equipped with an H.E.V. suit. Equipped with a handgun or shotgun.", 'Content', 100, 750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(700, {[HORDE.DMG_PHYSICAL] = 0.75})

        draw.SimpleText("Manhackbie", 'Heading', 50, 800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Headcrab zombie City-17 metrocop. Deploys a rogue manhack that attacks everything when released.", 'Content', 100, 850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Zombine", 'Heading', 50, 900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Headcrab zombie Combine soldier. Pulls out a grenade at quarter health. Runs at half health.", 'Content', 100, 950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Charred Zombine", 'Heading', 50, 1000, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Charred Zombine with a dark, red hue. Pulls out 3 grenades.", 'Content', 100, 1050, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1000, {[HORDE.DMG_FIRE] = 0.5, [HORDE.DMG_COLD] = 1.25})

        draw.SimpleText("Plague Soldier", 'Heading', 50, 1100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Combine soldier controlled by a parasite. Equipped with an SMG or shotgun. Throws grenades.", 'Content', 100, 1150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        
        -- Elite enemies.
        draw.SimpleText("Elite Enemies", 'LargeTitle', 50, 1250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Exploder", 'Heading', 50, 1300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Bloated headcrab zombie with a purple hue. Explodes on death dealing Poison damage. Does not explode when decapitated or shot in the head.", 'Content', 100, 1350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1300, {[HORDE.DMG_POISON] = 0.25, [HORDE.DMG_BLAST] = 1.5, [HORDE.DMG_FIRE] = 1.5})
        
        draw.SimpleText("Vomitter", 'Heading', 50, 1400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slow-moving Bullsquid. Spits flesh that deals Bleed damage from a distance.", 'Content', 100, 1450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1400, {[HORDE.DMG_POISON] = 0.25})

        draw.SimpleText("Scorcher", 'Heading', 50, 1500, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Scorched, mutated Vomitter with a dark hue. Spits burning flesh that deals Fire damage. Has a flamethrower attack.", 'Content', 100, 1550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1500, {[HORDE.DMG_FIRE] = 0.75, [HORDE.DMG_COLD] = 1.25})
        
        draw.SimpleText("Screecher", 'Heading', 50, 1600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Slow-moving, early model stalker. Deals a burst of Lightning damage. Runs at half health.", 'Content', 100, 1650, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1600, {[HORDE.DMG_LIGHTNING] = 0.5, [HORDE.DMG_BLAST] = 1.25})
        
        draw.SimpleText("Blight", 'Heading', 50, 1700, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Mutated Exploder with a dark hue. Deals Necrosis buildup when not shot in the head.", 'Content', 100, 1750, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1700, {[HORDE.DMG_BLAST] = 1.5, [HORDE.DMG_FIRE] = 1.5})
        
        draw.SimpleText("Weeper", 'Heading', 50, 1800, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Mutated Screecher covered in frostbite. Deals Cold damage.", 'Content', 100, 1850, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(1800, {[HORDE.DMG_COLD] = 0.5, [HORDE.DMG_LIGHTNING] = 0.75, [HORDE.DMG_BLAST] = 1.25, [HORDE.DMG_FIRE] = 1.25})
        
        draw.SimpleText("Hulk", 'Heading', 50, 1900, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Dangerous zombie with high health. Rages at half health", 'Content', 100, 1950, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Yeti", 'Heading', 50, 2000, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Mutated Hulk covered in frostbite. Deals Cold damage bursts at half health.", 'Content', 100, 2050, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw_resistances(2000, {[HORDE.DMG_COLD] = 0.5, [HORDE.DMG_FIRE] = 1.25})
        
        draw.SimpleText("Lesion", 'Heading', 50, 2100, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Dangerous zombie with high health and agility. Rages periodically or when damaged. Leaps at enemies when raged. Deals Bleed damage.", 'Content', 100, 2150, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Lesser Hunter", 'Heading', 50, 2200, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Combine Hunter with rogue programming. Shoots flechettes that explode after a delay. Charges at enemies.", 'Content', 100, 2250, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText("Hell Hunter", 'Heading', 50, 2300, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Mutated Hunter with high health and damage.", 'Content', 100, 2350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Plague Elite", 'Heading', 50, 2400, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Mutated Combine elite soldier controlled by a parasite. Fires energy balls that explode on impact. Can summon Zombine and Plague Soldier minions.", 'Content', 100, 2450, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        
        draw.SimpleText("Bosses", 'LargeTitle', 50, 2550, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("Alpha Gonome", 'Heading', 50, 2600, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        local next_pos = write_paragraph({
            "An aged gonome that gained increased endurance and power.",
            "Corruption Aura: Inflicts Bleeding to players nearby.",
            "Claw Attack: Deals Slashing damage. Inflicts Bleeding.",
            "Acid Throw: Ranged attack that deals Poison damage.",
            "Frenzy (Phase 2): Passively increases movement speed and action speed.",
        }, 2650)

        draw.SimpleText("Gamma Gonome", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "A gonome infused with cryo-engine.",
            "Claw Attack: Deals Slashing damage. Inflicts Frostbite.",
            "Icicle Throw: Ranged attack that deals Cold damage.",
            "Icestorm (Phase 2): Creates a large icestorm near itself, dealing massive Cold damage to nearby units.",
        }, next_pos + 100)

        draw.SimpleText("Hell Knight", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "A highly mutated Lesion forged in fire.",
            "Claw Attack: Deals Slashing damage. Inflicts Fire.",
            "Fiery Fury: Rages while dealing a Fire burst that ignites enemies.",
            "Leap Attack (Raged): Leaps at enemies. Inflicts Fire",
        }, next_pos + 100)
        
        draw.SimpleText("Subject: Wallace Breen", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "A gonome infused with Dr. Wallace Breen of City-17 to increase cognitive capabilities.",
            "Claw Attack: Deals Slashing damage. Inflicts Haemorrhage.",
            "Particle Cannon: An accurate ranged cannon that deals massive Physical and Blast damage. Inflicts Decay.",
            "Shockwave: Generates a shockwave when it received certain amount of damage. Inflicts Haemorrhage.",
            "Haemorrhage: A strong Bleeding debuff that builds up slowly on its own. Removes health one the bar is full.",
            "Particle Cannon (Phase 2): Generates continuous explosions post detonation."
        }, next_pos + 100)

        draw.SimpleText("Xen Host Unit", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Experimental unit made from the Xen Gonarch.",
            "Claw Attack: Deals Slash damage.",
            "Acid Mortar: Spits acid from above acting like a mortar.",
            "Spawn Baby Headcrab: Spawns a swarm of baby headcrabs.",
        }, next_pos + 100)

        draw.SimpleText("Xen Destroyer Unit", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Experimental unit made from the Xen Gargantua. Has enhanced physical capabilities.",
            "Slam Attack: Deals Blunt damage.",
            "Fumethrower: Creates streams of dark flame that deals Fire damage and inflicts Necrosis.",
            "Earthshatter: Stomps the ground and generates a tracing shockwave torwards the target. Deals Physical damage.",
            "Sonic Blast (Phase 2): Accumulates energy over time, indicated by its red light. When full, blinds players and blasts the area with Physical damage.",
        }, next_pos + 100)

        draw.SimpleText("Xen Psychic Unit", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({

            "Experimental unit made from the Xen Kingpin. Has enhanced psychic capabilities.",
            "Claw Attack: Deals Slashing damage.",
            "Lightning Beam: Projects a lightning beam, dealing heavy Lightning damage in an area.",
            "Lightning Orb: Creates homing lightning orbs that follow players. Explodes after delay on contact, dealing Lightning damage.",
            "Melee Mode (Phase 2): Greatly increases speed and focuses on Melee attacks.",
            "Lightning Beam (Phase 2): Lightning Beam leaves behind ground flames that last for a long time.",
            "Psionic Shield (Phase 2): Melee Mode only. When the shield is active, reduces damage taken by 50%.",
        }, next_pos + 100)

        draw.SimpleText("Plague Platoon", 'Heading', 50, next_pos + 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        next_pos = write_paragraph({
            "Specialized Combine units that have been converted into biological weapons using parasites.",
            "Plague Heavy: Armed with an M249 machine gun that inflicts Hinder buildup. Can throw shrapnel grenades",
            "Plague Demolition: Armed with an RPG-7. Can throw M67 grenade with mini-cluster nades.",
            "Plauge Berserker: Armed with a katana that inflicts Bleeding buildup. Parries Physical damage.",
        }, next_pos + 100)
    end

    self.mechanic_btns = {}
    self.create_mechanic_btn = function (text, panel)
        local mechanic_btn = vgui.Create("DButton", mechanics_panel)
        local mechanic_btn_hovered = false
        mechanic_btn:DockMargin(10, 5, 10, 5)
        mechanic_btn:SetSize(self:GetParent():GetWide(), 50)
        mechanic_btn:Dock(TOP)
        mechanic_btn:SetText("")
        mechanic_btn.Paint = function ()
            if mechanic_btn_hovered or (self.mechanic_btns[mechanic_btn] == 1) then draw.RoundedBox(0, 0, 10, self:GetWide(), self:GetTall(), HORDE.color_crimson) return end
            draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), HORDE.color_hollow)
        end
        mechanic_btn.OnCursorEntered = function ()
            mechanic_btn_hovered = true
            surface.PlaySound("UI/buttonrollover.wav")
        end
        mechanic_btn.OnCursorExited = function ()
            mechanic_btn_hovered = false
        end
        mechanic_btn.DoClick = function ()
            --votemap_panel:GetParent():Votediff(vote_btn, diff)
            for btn, _ in pairs(self.mechanic_btns) do
                self.mechanic_btns[btn] = 0
            end
            self.mechanic_btns[mechanic_btn] = 1
            update_text_panel:SetVisible(false)
            damage_text_panel:SetVisible(false)
            debuff_text_panel:SetVisible(false)
            enemies_text_panel:SetVisible(false)
            panel:SetVisible(true)
            surface.PlaySound("UI/buttonclick.wav")
        end

        local name_label = vgui.Create("DLabel", mechanic_btn)
        name_label:Dock(LEFT)
        name_label:SetText("")
        name_label:SetSize(250, 80)
        name_label:SetColor(Color(255,255,255))
        name_label:SetFont("Content")
        name_label.Paint = function ()
            draw.SimpleText(text, "Content", 10, 20, Color(255,255,255), TEXT_ALIGN_LEFT)
        end

        self.mechanic_btns[mechanic_btn] = 0

        return mechanic_btn
    end

    self.create_mechanic_btn("Latest Update", update_text_panel)
    self.create_mechanic_btn("Damage Types", damage_text_panel)
    self.create_mechanic_btn("Debuff Status Effects", debuff_text_panel)
    if GetConVarNumber("horde_default_enemy_config") == 1 then
        self.create_mechanic_btn("Enemies", enemies_text_panel)
    end

    local basic_stats_panel = vgui.Create("DPanel", stats_panel)
    basic_stats_panel:Dock(LEFT)
    basic_stats_panel:SetWide(self:GetWide() / 3)
    basic_stats_panel:SetTall(self:GetTall())
    basic_stats_panel.Paint = function ()
        draw.SimpleText("Basic", 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        drawStatBasic(self, "Speed:", HORDE:GetStat("speed") * 100 .. "%", 100, 100, "materials/status/speed.png")
        drawStatBasic(self, "Health:", MySelf:Health() .. "/" .. MySelf:GetMaxHealth(), 100, 150, "materials/status/health.png")
        drawStatBasic(self, "Armor:", MySelf:Armor() .. "/" .. MySelf:GetMaxArmor(), 100, 200, "materials/status/armor.png")
        drawStatBasic(self, "Evasion:", HORDE:GetStat("evasion") * 100 .. "%", 100, 250, "materials/status/evasion.png")
        drawStatBasic(self, "Block:", HORDE:GetStat("block"), 100, 300, "materials/status/block.png")

        draw.SimpleText("Perks", 'Heading', 50, 370, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        local y = 50
        local class = MySelf:Horde_GetCurrentSubclass()
        if not class then return end

        drawStatPerk(HORDE.perks[HORDE.subclasses[class].BasePerk].PrintName, 100, 370 + y, HORDE.subclasses[class].Icon)
        y = y + 50

        local perks
        if HORDE.classes[class] then
            perks = HORDE.classes[class].perks
        else
            perks = HORDE.subclasses[class].Perks
        end

        for perk_level, v in SortedPairs(perks) do
            if HORDE.current_wave < HORDE:Horde_GetWaveForPerk(perk_level) then goto cont end
            if not MySelf.Horde_PerkChoices then break end

            local classPerkChoices = MySelf.Horde_PerkChoices[class]
            local perkStats = classPerkChoices[perk_level]
            local choice = v.choices[perkStats or 1]
            if not choice then error("Invalid choice in perk level " .. perk_level .. " for " .. class .. "!") return end

            local perk = HORDE.perks[choice]
            local icon = perk.Icon or HORDE.subclasses[class].Icon
            drawStatPerk(perk.PrintName, 100, 370 + y, HORDE.subclasses[class].Icon)

            y = y + 50
            ::cont::
        end
    end

    local res_stats_panel_middle = vgui.Create("DPanel", stats_panel)
    res_stats_panel_middle:Dock(LEFT)
    res_stats_panel_middle:SetWide(self:GetWide() / 3)
    res_stats_panel_middle:SetTall(self:GetTall())
    res_stats_panel_middle.Paint = function ()
        draw.SimpleText("Physical Resistances", 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        drawStatResistance(self, "Ballistic Resistance:", HORDE.DMG_BALLISTIC, 100, 100, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Slash Resistance:", HORDE.DMG_SLASH, 100, 150, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Blunt Resistance:", HORDE.DMG_BLUNT, 100, 200, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Other:", HORDE.DMG_PHYSICAL, 100, 250, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)

        draw.SimpleText("Elemental Resistances", 'Heading', 50, 350, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        drawStatResistance(self, "Fire Resistance:", HORDE.DMG_FIRE, 100, 400, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Cold Resistance:", HORDE.DMG_COLD, 100, 450, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Lightning Resistance:", HORDE.DMG_LIGHTNING, 100, 500, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Poison Resistance:", HORDE.DMG_POISON, 100, 550, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
        drawStatResistance(self, "Blast Resistance:", HORDE.DMG_BLAST, 100, 600, HORDE.DMG_TYPE_ICON, HORDE.DMG_COLOR)
    end

    local res_stats_panel_right = vgui.Create("DPanel", stats_panel)
    res_stats_panel_right:Dock(LEFT)
    res_stats_panel_right:SetWide(self:GetWide() / 3)
    res_stats_panel_right:SetTall(self:GetTall())
    res_stats_panel_right.Paint = function ()
        draw.SimpleText("Status Resistances", 'Heading', 50, 50, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        drawStatResistance(self, "Bleeding Resistance:", HORDE.Status_Bleeding, 100, 100, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Ignite Resistance:", HORDE.Status_Ignite, 100, 150, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Frostbite Resistance:", HORDE.Status_Frostbite, 100, 200, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Shock Resistance:", HORDE.Status_Shock, 100, 250, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Break Resistance:", HORDE.Status_Break, 100, 300, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Decay Resistance:", HORDE.Status_Decay, 100, 350, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Necrosis Resistance:", HORDE.Status_Necrosis, 100, 400, HORDE.Status_Icon, HORDE.STATUS_COLOR)
        drawStatResistance(self, "Hemorrhage Resistance:", HORDE.Status_Hemorrhage, 100, 450, HORDE.Status_Icon, HORDE.STATUS_COLOR)
    end

    local stats_btn = vgui.Create("DButton", self)
    local stats_activated = true
    local stats_hovered = false
    stats_btn:SetText("Stats")
    stats_btn:SetTextColor(Color(255,255,255))
    stats_btn:SetFont("Title")
    stats_btn:SetSize(250, 50)
    stats_btn:SetPos(0, 0)
    stats_btn.Paint = function ()
        if stats_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if stats_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    local achievements_btn = vgui.Create("DButton", self)
    local achievements_activated = false
    local achievements_hovered = false
    achievements_btn:SetText("Achievements")
    achievements_btn:SetTextColor(Color(255,255,255))
    achievements_btn:SetFont("Title")
    achievements_btn:SetSize(250, 50)
    achievements_btn:SetPos(250, 0)
    achievements_btn.Paint = function ()
        if achievements_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if achievements_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    local learn_btn = vgui.Create("DButton", self)
    local learn_activated = false
    local learn_hovered = false
    learn_btn:SetText("Mechanics")
    learn_btn:SetTextColor(Color(255,255,255))
    learn_btn:SetFont("Title")
    learn_btn:SetSize(250, 50)
    learn_btn:SetPos(500, 0)
    learn_btn.Paint = function ()
        if learn_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if learn_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end

    stats_btn.DoClick = function ()
        stats_activated = true
        achievements_activated = nil
        learn_activated = nil
        stats_panel:SetVisible(true)
        achievements_panel:SetVisible(false)
        learn_panel:SetVisible(false)
        surface.PlaySound("UI/buttonclick.wav")
    end

    stats_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        stats_hovered = true
    end

    stats_btn.OnCursorExited = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        stats_hovered = false
    end

    achievements_btn.DoClick = function ()
        achievements_activated = true
        stats_activated = nil
        learn_activated = nil
        achievements_panel:SetVisible(true)
        stats_panel:SetVisible(false)
        learn_panel:SetVisible(false)
        surface.PlaySound("UI/buttonclick.wav")
    end

    achievements_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        achievements_hovered = true
    end

    achievements_btn.OnCursorExited = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        achievements_hovered = false
    end

    learn_btn.DoClick = function ()
        achievements_activated = nil
        stats_activated = nil
        learn_activated = true
        achievements_panel:SetVisible(false)
        stats_panel:SetVisible(false)
        learn_panel:SetVisible(true)
        surface.PlaySound("UI/buttonclick.wav")
    end

    learn_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        learn_hovered = true
    end

    learn_btn.OnCursorExited = function ()
        surface.PlaySound("UI/buttonrollover.wav")
        learn_hovered = false
    end

    local discord_btn = vgui.Create("DButton", self)
    local discord_activated = false
    local discord_hovered = false
    discord_btn:SetText("Discord")
    discord_btn:SetTextColor(Color(255,255,255))
    discord_btn:SetFont("Title")
    discord_btn:SetSize(250, 50)
    discord_btn:SetPos(750, 0)
    discord_btn.Paint = function ()
        if discord_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if discord_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end
    discord_btn.DoClick = function ()
        gui.OpenURL("https://discord.gg/npc")
    end

    local donate_btn = vgui.Create("DButton", self)
    local donate_activated = false
    local donate_hovered = false
    donate_btn:SetText("Donate")
    donate_btn:SetTextColor(Color(255,255,255))
    donate_btn:SetFont("Title")
    donate_btn:SetSize(250, 50)
    donate_btn:SetPos(1000, 0)
    donate_btn.Paint = function ()
        if donate_hovered then draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson) return end
        if donate_activated then
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_crimson)
        else
            draw.RoundedBox(0, 0, 0, 250, 50, HORDE.color_hollow)
        end
    end
    donate_btn.DoClick = function ()
        gui.OpenURL("https://store.npcz.gg/")
    end

    local close_btn = vgui.Create("DButton", self)
    close_btn:SetFont("marlett")
    close_btn:SetText("r")
    close_btn.Paint = function() end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(32, 32)
    close_btn:SetPos(self:GetWide() - 40, 8)
    close_btn.DoClick = function() HORDE:ToggleStats() end

    if HORDE.has_new_update then
        learn_btn:DoClick()
    end
end

function PANEL:Paint(w, h)
    --Derma_DrawBackgroundBlur(self)
    -- Entire
    if ScrW() < 1400 then
        draw.RoundedBox(0, 0, 0, w, h, Color(40,40,40))
    else
        draw.RoundedBox(0, 0, 0, w, h, HORDE.color_hollow)
    end
end

vgui.Register("HordeStats", PANEL)
