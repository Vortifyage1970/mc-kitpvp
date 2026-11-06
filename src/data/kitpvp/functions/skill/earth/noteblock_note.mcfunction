# @s = 音符盒：刚被打了（血量比上一帧少）⇒ 掷一个 0..7，八个乐器/音高组合里随机一个（音量 2.0、半径 32 格：竖琴本身就偏轻，靠音量补）
scoreboard players set @s kitpvp.earth_cd_a 3
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if score @s kitpvp.rng matches 0 at @s run playsound minecraft:block.note_block.harp master @a[distance=..32] ~ ~ ~ 2.0 0.5
execute if score @s kitpvp.rng matches 1 at @s run playsound minecraft:block.note_block.bass master @a[distance=..32] ~ ~ ~ 2.0 0.7
execute if score @s kitpvp.rng matches 2 at @s run playsound minecraft:block.note_block.snare master @a[distance=..32] ~ ~ ~ 2.0 1.0
execute if score @s kitpvp.rng matches 3 at @s run playsound minecraft:block.note_block.hat master @a[distance=..32] ~ ~ ~ 2.0 1.2
execute if score @s kitpvp.rng matches 4 at @s run playsound minecraft:block.note_block.bell master @a[distance=..32] ~ ~ ~ 2.0 1.4
execute if score @s kitpvp.rng matches 5 at @s run playsound minecraft:block.note_block.flute master @a[distance=..32] ~ ~ ~ 2.0 1.6
execute if score @s kitpvp.rng matches 6 at @s run playsound minecraft:block.note_block.chime master @a[distance=..32] ~ ~ ~ 2.0 1.8
execute if score @s kitpvp.rng matches 7 at @s run playsound minecraft:block.note_block.xylophone master @a[distance=..32] ~ ~ ~ 2.0 2.0
