# 幽灵魂石：被攻击者身侧召唤阴兵。触发 advancement kitpvp:player/ghost_hurt
# @s = 被攻击者，执行位置/朝向 = 被攻击者（as 只换执行者，不动位置朝向）
# 冷却闸门放在这里而不是 advancement conditions：1.20.1 的 predicate 能否指向 source_entity 不确定
advancement revoke @s only kitpvp:player/ghost_soul_attack

execute at @s as @a[tag=kitpvp.soul_ghost_active,scores={kitpvp.ghost_minion_cd=..0},sort=nearest,limit=1] run function kitpvp:summon/ghost_minion_pair
