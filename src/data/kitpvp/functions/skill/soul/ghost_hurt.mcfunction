# 由 advancement kitpvp:player/ghost_soul_attack 触发（@s = 被攻击者，位置/朝向 = 被攻击者）
# distance 限制：1.20.1 无法判定"是谁打的"，只能要求幽灵就在被攻击者附近，
# 否则地图上任何两人互殴都会在幽灵身边刷出阴兵（见 04）
advancement revoke @s only kitpvp:player/ghost_soul_attack

execute at @s as @a[tag=kitpvp.soul_ghost_active,scores={kitpvp.ghost_minion_cd=..0},distance=..8,sort=nearest,limit=1] run function kitpvp:summon/ghost_minion_pair
