# 环肽驱动：每刻把 16 只重新摆到"圈心玩家"周围
# 圈心优先认召唤者：link 给环上每只写了 earth_owner，玩家身上的 kitpvp.etid 与之相等者就是召唤者
# 召唤者不在了（死了/退游戏/手动召唤没有归属分）就退化成"离圈最近的活玩家"
scoreboard players set #ring_owner kitpvp.game 0
execute as @e[tag=kitpvp.earth_cyclic,limit=1] run scoreboard players operation #ring_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set #ring_has_center kitpvp.game 0
execute if score #ring_owner kitpvp.game matches 1.. as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game run scoreboard players set #ring_has_center kitpvp.game 1

# 旋转：每 4 刻多转一格（22.5°），一圈 64 刻 ≈ 3.2 秒；想更快把 4.. 改 2..（1.6 秒），更慢改 8..（6.4 秒）
scoreboard players add #ring_spin_tick kitpvp.game 1
execute if score #ring_spin_tick kitpvp.game matches 4.. run scoreboard players set #ring_spin_tick kitpvp.game 0
execute if score #ring_spin kitpvp.game matches 1 if score #ring_spin_tick kitpvp.game matches 0 run scoreboard players add #ring_rot kitpvp.game 1
execute if score #ring_rot kitpvp.game matches 16.. run scoreboard players set #ring_rot kitpvp.game 0

execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 0 run function kitpvp:skill/earth/ring_pos_0
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 1 run function kitpvp:skill/earth/ring_pos_1
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 2 run function kitpvp:skill/earth/ring_pos_2
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 3 run function kitpvp:skill/earth/ring_pos_3
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 4 run function kitpvp:skill/earth/ring_pos_4
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 5 run function kitpvp:skill/earth/ring_pos_5
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 6 run function kitpvp:skill/earth/ring_pos_6
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 7 run function kitpvp:skill/earth/ring_pos_7
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 8 run function kitpvp:skill/earth/ring_pos_8
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 9 run function kitpvp:skill/earth/ring_pos_9
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 10 run function kitpvp:skill/earth/ring_pos_10
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 11 run function kitpvp:skill/earth/ring_pos_11
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 12 run function kitpvp:skill/earth/ring_pos_12
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 13 run function kitpvp:skill/earth/ring_pos_13
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 14 run function kitpvp:skill/earth/ring_pos_14
execute if score #ring_has_center kitpvp.game matches 1 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s if score @s kitpvp.etid = #ring_owner kitpvp.game if score #ring_rot kitpvp.game matches 15 run function kitpvp:skill/earth/ring_pos_15
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 0 run function kitpvp:skill/earth/ring_pos_0
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 1 run function kitpvp:skill/earth/ring_pos_1
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 2 run function kitpvp:skill/earth/ring_pos_2
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 3 run function kitpvp:skill/earth/ring_pos_3
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 4 run function kitpvp:skill/earth/ring_pos_4
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 5 run function kitpvp:skill/earth/ring_pos_5
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 6 run function kitpvp:skill/earth/ring_pos_6
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 7 run function kitpvp:skill/earth/ring_pos_7
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 8 run function kitpvp:skill/earth/ring_pos_8
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 9 run function kitpvp:skill/earth/ring_pos_9
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 10 run function kitpvp:skill/earth/ring_pos_10
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 11 run function kitpvp:skill/earth/ring_pos_11
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 12 run function kitpvp:skill/earth/ring_pos_12
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 13 run function kitpvp:skill/earth/ring_pos_13
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 14 run function kitpvp:skill/earth/ring_pos_14
execute if score #ring_has_center kitpvp.game matches 0 as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},sort=nearest,limit=1] at @s if score #ring_rot kitpvp.game matches 15 run function kitpvp:skill/earth/ring_pos_15
