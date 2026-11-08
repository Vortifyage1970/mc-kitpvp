# 动员家的倒计时滴答：每 1 秒一声，是「准备」那 5 秒的节拍器
# 注意：schedule 排进来的函数没有位置上下文（在世界出生点跑），所以必须 as 玩家 + at @s 再播，声音才会在各自耳朵边
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] at @s run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.7 1.4
