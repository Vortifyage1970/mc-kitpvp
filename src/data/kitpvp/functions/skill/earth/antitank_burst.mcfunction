# @s = 炮弹落点（at @s）：反装甲爆炸
# 4 点 magic（2 颗心）：在 bypasses_armor 标签里，铁套/钻套全额吃，这正是"反装甲"的意思
scoreboard players set #at_shell_own kitpvp.game 0
scoreboard players operation #at_shell_own kitpvp.game = @s kitpvp.at_owner
playsound minecraft:entity.generic.explode hostile @a ~ ~ ~ 1.0 1.1
playsound minecraft:item.firecharge.use hostile @a ~ ~ ~ 1.0 0.6
particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1
particle minecraft:flame ~ ~ ~ 1.0 1.0 1.0 0.03 24
# 有明确主人：跳过主人；没主人（魂石/指令召的）：全员吃伤害
execute as @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] if score #at_shell_own kitpvp.game matches 1.. unless score @s kitpvp.etid = #at_shell_own kitpvp.game run damage @s 4 minecraft:magic
execute as @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score #at_shell_own kitpvp.game matches 1.. run damage @s 4 minecraft:magic
tag @a remove kitpvp.at_tgt
kill @e[tag=kitpvp.at_aim,limit=1,sort=nearest]
kill @s
