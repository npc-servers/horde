PERK.PrintName = "Paladin Base"
PERK.Description = [[
Stats:
- Increase Sacred Aura's radius by 1% per rank level, up to 25%.
- Increase Global damage resistance by 0.8% per rank level, up to 20%.
- Increase health by 50.

Main Mechanics:

- "Sacred Aura"

You're surrounded with Sacred Aura, a yellow-colored zone. 
Whenever allies within the aura are healed by you, they gain Armor equal to 50% of your healing they receive.


- "Divine Shield"

Regenerate 1 Faith stack per 3 seconds. You can have up to 10 Faith stacks.
Faith stacks are used by "Divine Shield" ability, but doesn't do anything on their own.

Hold ALT (walk button) to use your "Divine Shield".
While shielding:
- You disable passive Faith stack regeneration, described above.
- Gain 5% Physical damage resistance per Faith stack.
- Lose 1 Faith stack upon taking Physical damage.

Has only access to melee weapons.]]
PERK.Params = {}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_base" then return end
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_base" then return end
end