# 预言家开口：10 秒一次，在五句里随机挑一句（4 位随机数 % 5，够均匀）
scoreboard players set @s kitpvp.earth_cd_a 200

# 说话前先现读一遍所有活着玩家的血量（Health × 100，20.0 血 = 2000）
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] store result score @s kitpvp.hp_x10 run data get entity @s Health 100

# 4 位随机数 0..15，再 % 5
scoreboard players set #oracle_rng kitpvp.game 0
execute store success score #oracle_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #oracle_bit kitpvp.game matches 1 run scoreboard players add #oracle_rng kitpvp.game 1
execute store success score #oracle_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #oracle_bit kitpvp.game matches 1 run scoreboard players add #oracle_rng kitpvp.game 2
execute store success score #oracle_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #oracle_bit kitpvp.game matches 1 run scoreboard players add #oracle_rng kitpvp.game 4
execute store success score #oracle_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #oracle_bit kitpvp.game matches 1 run scoreboard players add #oracle_rng kitpvp.game 8
scoreboard players operation #oracle_rng kitpvp.game %= #oracle_five kitpvp.game

# 开口音：一声紫水晶，然后才是那句真话（五句各配一个专属尾音，靠听就能分辨它这次报的是哪句）
playsound minecraft:block.amethyst_block.chime master @a[distance=..32] ~ ~ ~ 0.9 1.2

execute if score #oracle_rng kitpvp.game matches 0 at @s run function kitpvp:skill/earth/oracle_say_1
execute if score #oracle_rng kitpvp.game matches 1 at @s run function kitpvp:skill/earth/oracle_say_2
execute if score #oracle_rng kitpvp.game matches 2 at @s run function kitpvp:skill/earth/oracle_say_3
execute if score #oracle_rng kitpvp.game matches 3 at @s run function kitpvp:skill/earth/oracle_say_4
execute if score #oracle_rng kitpvp.game matches 4 at @s run function kitpvp:skill/earth/oracle_say_5

# 每句的尾音：五句各一个音色
execute if score #oracle_rng kitpvp.game matches 0 run playsound minecraft:block.note_block.bell master @a[distance=..32] ~ ~ ~ 0.9 1.2
execute if score #oracle_rng kitpvp.game matches 1 run playsound minecraft:block.note_block.flute master @a[distance=..32] ~ ~ ~ 0.9 1.4
execute if score #oracle_rng kitpvp.game matches 2 run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 0.9 1.1
execute if score #oracle_rng kitpvp.game matches 3 run playsound minecraft:block.note_block.chime master @a[distance=..32] ~ ~ ~ 0.9 1.6
execute if score #oracle_rng kitpvp.game matches 4 run playsound minecraft:block.note_block.xylophone master @a[distance=..32] ~ ~ ~ 0.9 1.5
