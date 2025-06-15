GADGET.PrintName = "Omnislash"
GADGET.Description = [[Phasing out of reality and repeatedly slashes the target enemy.
Each slash deals 200 damage.
Bounces to a nearby target if the main target is dead.
You are invulnerable during Omnislash.]]
GADGET.Icon = "items/gadgets/omnislash.png"
GADGET.Duration = 4
GADGET.Cooldown = 15
GADGET.Active = true
GADGET.Params = {}
GADGET.Hooks = {}

local function SpawnPlayer( ply, ply_pos )
    if not IsValid(ply) then return end
    if ply:GetNoDraw() == false then return end

    ply.Horde_In_Omni = nil
    ply.Horde_Immune_Status_All = false
    ply:UnSpectate()
    ply:SetNoDraw(false)
    ply:DrawViewModel(true)
    ply:SetPos(ply_pos)
    ply:UnLock()
    ply:SetNoTarget(false)
end

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_omnislash" then return end

    local tr = util.TraceHull( {
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 5000,
        filter = { "player" },
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    } )

    local ent = tr.Entity

    if ent:IsValid() and HORDE:IsEnemy(ent) then
        ply:Horde_SetGadgetCooldown(15)
        local ply_pos = ply:GetPos()

        ply.Horde_In_Omni = true
        ply.Horde_Immune_Status_All = true
        ply:Spectate(OBS_MODE_CHASE)
        ply:SpectateEntity(ent)
        ply:SetNoDraw(true)
        ply:DrawViewModel(false)
        ply:SetNoTarget(true)
        ply:Lock()

        local p = ent:GetPos()
        for i = 1, 15 do
            timer.Simple(i*0.1, function ()
                if not ply.Horde_In_Omni then return end
                if not IsValid(ent) then
                    for _, e in pairs(ents.FindInSphere(p, 200)) do
                        if HORDE:IsEnemy(e) then
                            ent = e
                            ply:SpectateEntity(ent)
                            break
                        end
                    end
                    if not IsValid(ent) then
                        timer.Simple( 0.5, function ()
                        SpawnPlayer(ply, ply_pos)
                        end )
                    end
                end
                local dmg = DamageInfo()
                dmg:SetAttacker(ply)
                dmg:SetInflictor(ply)
                dmg:SetDamageType(DMG_SLASH)
                dmg:SetDamage(200)
                if IsValid(ent) then
                    dmg:SetDamagePosition(ent:GetPos())
                    ent:TakeDamageInfo(dmg)
                    sound.Play("weapons/physcannon/energy_sing_explosion2.wav", ply:GetPos(), 100, 150)
                    local ed = EffectData()
                    ed:SetOrigin(ent:GetPos() + ent:OBBCenter())
                    util.Effect("horde_omnislash_effect", ed, true, true)
                    p = ent:GetPos()
                else
                    timer.Simple( 0.5, function ()
                    SpawnPlayer(ply, ply_pos)
                    end )
                    return
                end

                if i == 15 then
                    timer.Simple( 0.5, function ()
                    SpawnPlayer(ply, ply_pos)
                    end )
                end
            end )
        end
    else
        ply:EmitSound("items/suitchargeno1.wav")
        ply:Horde_SetGadgetCooldown(1)
    end
end