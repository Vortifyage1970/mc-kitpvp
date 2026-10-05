# ===== 纵火狂：燃烧瓶火焰的 5 秒保护 =====
# 由 tick.mcfunction 每刻调用
# 每个 marker 代表一格"被保护的火焰"，寿命 100 刻（5 秒）

# 1. 递减寿命（只对还有寿命的 marker）
scoreboard players remove @e[type=minecraft:marker,tag=kitpvp.arsonist_fire,scores={kitpvp.fire_timer=1..}] kitpvp.fire_timer 1

# 2. 火被手动打灭时补回来
#    只在「原位置是空气」且「下方有支撑」时补：
#      - 玩家用手 / 工具打灭的火 → 位置变回空气 → 立刻复燃
#      - 玩家放的方块、倒的水   → 位置不是 air → 跳过，绝不覆盖
#    已知取舍：放方块 / 倒水可以在 5 秒内"盖住"火而不是"熄灭"火，
#              这属于覆盖行为，按设计文档 2.8「允许有限度放置方块」保留。
execute as @e[type=minecraft:marker,tag=kitpvp.arsonist_fire] at @s unless block ~ ~ ~ fire if block ~ ~ ~ air unless block ~ ~-1 ~ air run setblock ~ ~ ~ fire

# 3. 5 秒到，撤掉守护；火本身保留，此后可以被正常打灭
kill @e[type=minecraft:marker,tag=kitpvp.arsonist_fire,scores={kitpvp.fire_timer=..0}]