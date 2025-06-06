SUBCLASS.PrintName = "Juggernaut" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Heavy -- Required for any new classes
SUBCLASS.Icon = "subclasses/juggernaut.png" -- Required
SUBCLASS.Description = [[
Heavy subclass.
Focuses on improving guns and being tanky,
but moving speed is reduced.]] -- Required
SUBCLASS.BasePerk = "juggernaut_base"
SUBCLASS.Perks = {
    [1] = {title = "Provisions", choices = {"juggernaut_supply_drop", "juggernaut_jetpack"}},
    [2] = {title = "Super Serum", choices = {"juggernaut_heavy_plating", "juggernaut_shockproof"}},
    [3] = {title = "Stopping Power", choices = {"juggernaut_quality_rounds", "juggernaut_crowd_control"}},
	[4] = {title = "Zenith", choices = {"juggernaut_carnivorous", "juggernaut_bionic_legs"}},
} -- Required

--SUBCLASS.Perks = {
  --  [1] = {title = "Provisions", choices = {"juggernaut_magazine", "juggernaut_tank"}},
  --  [2] = {title = "Super Serum", choices = {"juggernaut_stun", "juggernaut_shockproof"}},
  --  [3] = {title = "Bigger Bullets", choices = {"juggernaut_percent", "juggernaut_penetration"}},
  --  [4] = {title = "Ultimatum", choices = {"juggernaut_speed", "juggernaut_armor"}},
--} -- Required