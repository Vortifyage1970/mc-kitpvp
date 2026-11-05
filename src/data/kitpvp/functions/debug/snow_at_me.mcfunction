# 自测：在脚下立刻铺一格细雪（10 秒后由 tick 收回），用来把"铺雪本身"和"打中触发"分开验
# 站草地上跑：能看见雪 = 铺雪这条路是通的，问题只可能在触发条件
scoreboard players set #snow_time kitpvp.game 200
execute at @s if block ~ ~ ~ minecraft:air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:cave_air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:air run tellraw @a [{"text":"[调试] 已在脚下铺了一格细雪，10 秒后收回","color":"yellow"}]
execute at @s unless block ~ ~ ~ minecraft:air run tellraw @a [{"text":"[调试] 脚下不是空气，这次没铺（可能原本就有一格雪）","color":"red"}]