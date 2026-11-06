# 磁铁的吸力：10 格内的掉落物 0.7 格/刻（约 14 格/秒，每刻都拉）；4 格内的玩家 0.1 格 / 每 4 刻（约 0.5 格/秒）
# ★ 玩家那条以前是"每刻 0.03"：单机没感觉，但联机时服务端每刻强行改位置会和客户端预测冲突，延迟高的人会被反复拽回 ⇒ "跑不出去"。
# 写法要点：先 at 磁铁（定圆心）、再 as 物品（换目标）、再 at @s（回到物品位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..10] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.7
# 玩家牵引：每 4 刻拉一次（0.1 格），平均 0.5 格/秒 —— 关键是"次数少"，服务端每刻 tp 会和客户端预测打架，
# 延迟高的玩家会被反复纠正回原位（房主 0 延迟所以感觉不到，别人就"跑不出去"）
scoreboard players add #mag_tick kitpvp.game 1
execute if score #mag_tick kitpvp.game matches 5.. run scoreboard players set #mag_tick kitpvp.game 1
execute if score #mag_tick kitpvp.game matches 1 at @e[tag=kitpvp.earth_magnet] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.1
