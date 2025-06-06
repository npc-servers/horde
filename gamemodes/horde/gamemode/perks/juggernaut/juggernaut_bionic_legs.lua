PERK.PrintName = "Bionic Legs"
PERK.Description = "Increase your speed by {1}."
PERK.Icon = "materials/perks/phase_walk.png"
PERK.Params = {
    [1] = {value = 0.4, percent = true},
}
--local speed = 250
--local runningspeed = 500

-- OnSetPerk is *not* called per spawn, but speed is reset when spawning
-- We set a variable to make sure we don't accidently give or take more speed than needed
PERK.Hooks = {}

--hook.Add("Horde_PlayerMoveBonus", "Horde_SpeedBonusRun", function(ply, mv)
  --  if ply:Horde_GetPerk("juggernaut_speed") then
  --      ply:SetRunSpeed(ply:Horde_GetClass().sprintspd + runningspeed)
 --   end
--end)

--hook.Add("Horde_PlayerMoveBonus", "Horde_SpeedBonusWalk", function(ply, mv)
   -- if ply:Horde_GetPerk("juggernaut_speed") then
  --      ply:SetWalkSpeed(ply:Horde_GetClass().movespd + speed)
  --  end
--end)

--hook.Add("Horde_PlayerMoveBonus", "Horde_JuggernautSpeedPerk", function(ply, bonus)
--	if ply:Horde_GetPerk("juggernaut_speed") then
   --     bonus.walkspd = bonus.walkspd * (1+ 0.5)
  --      bonus.sprintspd = bonus.sprintspd * (1 + 0.5)
  --  end
--end)

--hook.Add("Horde_PlayerMoveBonus", "Horde_JuggernautPerkSpeed", function(ply, bonus)
  --  if ply:Horde_GetPerk("juggernaut_speed") then
  --     bonus.walkspd = bonus.walkspd * 1.7
  --     bonus.sprintspd = bonus.sprintspd * 1.7
 --   end
--end)

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("juggernaut_bionic_legs") then return end
    bonus_walk.increase = bonus_walk.increase + 0.4
    bonus_run.increase = bonus_run.increase + 0.4
end
