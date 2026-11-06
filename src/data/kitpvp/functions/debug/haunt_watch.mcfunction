# 幻翼的"共生"守卫 + 强制俯冲（每 10 秒检测一次，一次扑 17 格）
# 每刻检查（由 haunt_test_b 启动，靠自身 schedule 续命，不需要挂进 tick）
execute unless entity @e[tag=kitpvp.debug_phantom_leashed] run kill @e[tag=kitpvp.debug_phantom_holder]
# 拴绳：只在"真断了"的时候补（unless data entity @s Leash），不是每刻硬刷
# 原版生物持绳超过约 10 格必然脱绳，17 格冲刺一定会断 ⇒ 补一次就够，不必每刻都写
execute as @e[tag=kitpvp.debug_phantom_leashed] unless data entity @s Leash run data merge entity @s {Leash:{UUID:[I;1900007,1,1,1]}}
# 脱绳时原版会掉一根 minecraft:lead 在地上（每次断都掉）⇒ 就地清掉，避免拖一路纸条
# 半径只 4 格且限定 Item.id = lead，不会动你背包里的绳子
execute as @e[tag=kitpvp.debug_phantom_leashed] at @s run kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:lead"}},distance=..4]
# ---- 强制俯冲：每 200 刻（10 秒）检测一次，触发就朝玩家方向直推 17 格（17 刻 × 1 格/刻）----
scoreboard players add #ph_t kitpvp.game 1
execute if score #ph_t kitpvp.game matches 200.. run scoreboard players set #ph_t kitpvp.game 0
execute if score #ph_t kitpvp.game matches 0 run scoreboard players set #ph_dv kitpvp.game 17
execute if score #ph_dv kitpvp.game matches 1.. as @e[tag=kitpvp.debug_phantom_holder] at @s facing entity @p[gamemode=!spectator,tag=!kitpvp.spectator] feet run tp @s ^ ^ ^1
execute if score #ph_dv kitpvp.game matches 1.. run scoreboard players remove #ph_dv kitpvp.game 1
execute if entity @e[tag=kitpvp.debug_phantom_holder] run schedule function kitpvp:debug/haunt_watch 1t replace
