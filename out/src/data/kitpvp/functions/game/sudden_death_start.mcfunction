# ===== 突然死亡：启动 =====
# 8 分钟计时归零时由 game/timer_tick 调用一次

tellraw @a [{"text":"[!] ","color":"red","bold":true},{"text":"8 分钟已到，进入突然死亡！","color":"red","bold":true}]
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 1 1.5

# 给所有存活玩家打上标记（供后续逻辑判断）
execute as @a[scores={kitpvp.alive=1},tag=kitpvp.selected] run tag @s add kitpvp.sudden_death

# 启动 20 秒（400 刻）发放循环
schedule function kitpvp:game/sudden_drop 400t replace
