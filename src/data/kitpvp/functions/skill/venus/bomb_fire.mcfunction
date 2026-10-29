# 自爆模块：在舔狗脚下引爆一只苦力怕（下一 tick 立即爆炸），随后舔狗死亡
# 抗性 V 让它免疫爆炸伤害，所以必须显式 kill；venus_cd3 同时是技能冷却与复活计时
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
scoreboard players set #vdog kitpvp.game 0
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run scoreboard players set #vdog kitpvp.game 1

execute if score #vdog kitpvp.game matches 1 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game at @s run function kitpvp:summon/venus_bomb
execute if score #vdog kitpvp.game matches 1 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run kill @s

execute if score #vdog kitpvp.game matches 1 run scoreboard players set @s kitpvp.venus_cd3 600
execute if score #vdog kitpvp.game matches 1 run scoreboard players set @s kitpvp.venus_dog_timer 600
execute if score #vdog kitpvp.game matches 1 run tag @s add kitpvp.venus_dog_dead

execute if score #vdog kitpvp.game matches 1 run title @s actionbar {"text":"自爆模块：舔狗 30 秒后复活","color":"gold"}
execute if score #vdog kitpvp.game matches 1 run playsound minecraft:entity.creeper.primed master @s ~ ~ ~ 1.0 1.0
execute if score #vdog kitpvp.game matches 0 run title @s actionbar {"text":"舔狗不在身边","color":"gray"}
