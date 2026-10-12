# ===== 30 秒到：把手炮归还给海盗 =====
# 触发：schedule function kitpvp:skill/pirate_return 600t replace
#
# 结构对齐 archer_return：
#   先清掉所有海盗手上的 KitCrossbow 弩，再给仍在局内的海盗各发一把，
#   避免"归还原弩"与"补发新弩"叠成两把。
# 代价：正在拉弩的海盗会被打断一次，与原版弓箭手同款副作用，可接受。

# 1. 清掉所有海盗手上的弩
execute as @a[scores={kitpvp.kit=9}] run clear @s minecraft:crossbow{KitCrossbow:1b}

# 2. 每个仍在局内的海盗重新发一把
execute as @a[scores={kitpvp.kit=9,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/pirate_give_crossbow

# 3. 公告
tellraw @a [{"text":"[!] ","color":"green","bold":true},{"text":"海盗的手炮已归还","color":"gray"}]
