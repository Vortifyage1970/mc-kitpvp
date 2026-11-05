# @s = 电磁炮：每刻数一次"12 格内有没有能打的人"，有就充能、没有就把充能泄掉
# 归属先归零再 operation：魂石链路/手动召的没有 earth_owner，源分缺失会留上一只的旧值
scoreboard players set #spk_owner kitpvp.game 0
scoreboard players operation #spk_owner kitpvp.game = @s kitpvp.earth_owner

# 有主：12 格内存在不属于召唤者的活人 ⇒ #spk_on = 1
# 无主：12 格内只要有人 ⇒ #spk_on = 1（手动召出来测试时照样开火）
scoreboard players set #spk_on kitpvp.game 0
execute if score #spk_owner kitpvp.game matches 1.. at @s as @a[distance=..12,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #spk_owner kitpvp.game run scoreboard players set #spk_on kitpvp.game 1
execute if score #spk_owner kitpvp.game matches ..0 at @s if entity @a[distance=..12,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run scoreboard players set #spk_on kitpvp.game 1

# 没目标：充能清零（像皇家战争里收不到目标的炮，线圈冷却下来）
execute if score #spk_on kitpvp.game matches 0 run scoreboard players set @s kitpvp.sparky_charge 0

# 有目标：充能 +1，封顶 300（= 15 秒）
execute if score #spk_on kitpvp.game matches 1 run scoreboard players add @s kitpvp.sparky_charge 1
execute if score @s kitpvp.sparky_charge matches 301.. run scoreboard players set @s kitpvp.sparky_charge 300

# 充能中的电弧：每刻 3 粒；过 180 点（9 秒）加密、过 270 点（13.5 秒）加嗡鸣
execute if score #spk_on kitpvp.game matches 1 at @s run particle minecraft:electric_spark ~ ~1.3 ~ 0.45 0.5 0.45 0.02 3 normal
execute if score @s kitpvp.sparky_charge matches 180..299 at @s run particle minecraft:electric_spark ~ ~1.5 ~ 0.6 0.7 0.6 0.05 6 normal
execute if score @s kitpvp.sparky_charge matches 270..299 at @s run playsound minecraft:block.beacon.ambient master @a[distance=..16] ~ ~ ~ 0.6 1.9

# 充满：放电（按有没有主人分两支）
execute if score @s kitpvp.sparky_charge matches 300 if score #spk_owner kitpvp.game matches ..0 at @s run function kitpvp:skill/earth/sparky_fire_any
execute if score @s kitpvp.sparky_charge matches 300 if score #spk_owner kitpvp.game matches 1.. at @s run function kitpvp:skill/earth/sparky_fire_owned

# 开火之后滚向目标（4~12 格才动，0.05 格/刻）
execute if score #spk_on kitpvp.game matches 1 at @s run function kitpvp:skill/earth/sparky_move
