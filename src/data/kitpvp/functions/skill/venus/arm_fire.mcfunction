# 武装模块：舔狗获得速度 II / 力量 II / 跳跃提升 V，持续 20 秒（400 刻）
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
scoreboard players set #vdog kitpvp.game 0
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run scoreboard players set #vdog kitpvp.game 1

execute if score #vdog kitpvp.game matches 1 run scoreboard players set @s kitpvp.cd2 1200
execute if score #vdog kitpvp.game matches 1 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run scoreboard players set @s kitpvp.venus_arm_timer 400
execute if score #vdog kitpvp.game matches 1 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run tag @s add kitpvp.venus_armed

execute if score #vdog kitpvp.game matches 1 run title @s actionbar {"text":"武装模块：20 秒","color":"red"}
execute if score #vdog kitpvp.game matches 1 run playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.8 1.0
execute if score #vdog kitpvp.game matches 0 run title @s actionbar {"text":"舔狗不在身边","color":"gray"}
