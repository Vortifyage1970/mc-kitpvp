# 每刻把整圈重新摆到"最近的活玩家"周围（圈随人走）；@s 本身不需要是玩家
# 旋转：#ring_spin=1 时先推进 #ring_rot（0..3 循环），再按状态分派到 ring_pos_0..3
execute if score #ring_spin kitpvp.game matches 1 run scoreboard players add #ring_rot kitpvp.game 1
execute if score #ring_rot kitpvp.game matches 4.. run scoreboard players set #ring_rot kitpvp.game 0
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},distance=..48,sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 0 run function kitpvp:skill/earth/ring_pos_0
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},distance=..48,sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 1 run function kitpvp:skill/earth/ring_pos_1
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},distance=..48,sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 2 run function kitpvp:skill/earth/ring_pos_2
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},distance=..48,sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 3 run function kitpvp:skill/earth/ring_pos_3
