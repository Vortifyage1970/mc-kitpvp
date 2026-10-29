# 制冷模块：舔狗周围 10 格生成 10 秒冷气（冷度由 tick 维护）
# 找不到自己的舔狗就不放，也不进冷却
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
scoreboard players set #vdog kitpvp.game 0
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run scoreboard players set #vdog kitpvp.game 1

execute if score #vdog kitpvp.game matches 1 run scoreboard players set @s kitpvp.cd 600
execute if score #vdog kitpvp.game matches 1 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run scoreboard players set @s kitpvp.venus_chill_timer 200
execute if score #vdog kitpvp.game matches 1 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run tag @s add kitpvp.venus_chill

execute if score #vdog kitpvp.game matches 1 run title @s actionbar {"text":"制冷模块：冷气 10 秒","color":"aqua"}
execute if score #vdog kitpvp.game matches 1 run playsound minecraft:block.powder_snow.break master @s ~ ~ ~ 0.8 1.0
execute if score #vdog kitpvp.game matches 0 run title @s actionbar {"text":"舔狗不在身边","color":"gray"}
