# 没有舔狗（被自爆以外的方式弄丢，比如掉进虚空）才开始 30 秒复活计时
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
scoreboard players set #vdog kitpvp.game 0
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run scoreboard players set #vdog kitpvp.game 1

execute if score #vdog kitpvp.game matches 0 run scoreboard players set @s kitpvp.venus_dog_timer 600
execute if score #vdog kitpvp.game matches 0 run tag @s add kitpvp.venus_dog_dead
