# ===== 幽灵魂石：被攻击者侧 → 在其左右身侧各召唤一只阴兵 =====
# 触发器：kitpvp:player/ghost_hurt（minecraft:entity_hurt_player）
# @s = 被攻击者
# 执行位置 / 朝向 = 被攻击者
#
# 冷却判定放在这里而不是 advancement conditions：
#   advancement 的 predicate 字段是否指向 source_entity 在 1.20.1 不确定，
#   一旦失效表现是"完全没冷却"，难排查。
#   改在这里用 scores=..0 精确筛选，不依赖任何不确定语法。

advancement revoke @s only kitpvp:player/ghost_soul_attack

# 关键：as 只换执行者，不动位置/朝向。
# 选出的幽灵玩家带着"被攻击者位置 + 被攻击者朝向"进下一个函数，
# positioned ^x 就是相对被攻击者的左右。
# scores 判定 = 实际冷却闸门，一票否决。
execute at @s as @a[tag=kitpvp.soul_ghost_active,scores={kitpvp.ghost_minion_cd=..0},sort=nearest,limit=1] run function kitpvp:summon/ghost_minion_pair
