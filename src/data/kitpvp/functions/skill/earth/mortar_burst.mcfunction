# @s = 鱼弹落点（at @s）：炸开。只伤人、不动地形
# 先把自己的归属抄到假玩家上，下面判"是不是主人"要用
scoreboard players set #mo_own kitpvp.game 0
scoreboard players operation #mo_own kitpvp.game = @s kitpvp.mo_owner
playsound minecraft:entity.generic.explode hostile @a ~ ~ ~ 1.0 1.0
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1
particle minecraft:flame ~ ~ ~ 0.9 0.9 0.9 0.02 24
# 有明确主人：跳过主人；没主人（魂石/指令召的）：全员吃伤害
execute as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] if score #mo_own kitpvp.game matches 1.. unless score @s kitpvp.etid = #mo_own kitpvp.game run damage @s 4 minecraft:explosion
execute as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score #mo_own kitpvp.game matches 1.. run damage @s 4 minecraft:explosion
tag @a remove kitpvp.mo_tgt
kill @e[tag=kitpvp.mo_aim]
kill @s
