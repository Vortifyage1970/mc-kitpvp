# 炮台令牌：上限 3、60 秒（1200 刻）；使用侧 turret_fire 起计
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:stray_spawn_egg{KitTaintedTurretEgg:1b} 0
execute if score @s kitpvp.tmp matches ..2 run function kitpvp:skill/tainted_archer/give_token_turret
execute if score @s kitpvp.tmp matches ..2 run scoreboard players set @s kitpvp.cd 1200
execute if score @s kitpvp.tmp matches ..2 run title @s actionbar {"text":"炮台令牌 +1","color":"dark_red"}
execute if score @s kitpvp.tmp matches ..2 run playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.4
