# 飞龙宝宝的探针：有什么、剩几刻、火球在哪 —— 用来分清"没吐"和"吐了没打中"
execute store result score #bw_n kitpvp.game if entity @e[tag=kitpvp.earth_babywhelp]
execute store result score #bw_b kitpvp.game if entity @e[tag=kitpvp.bw_ball]
tellraw @a [{"text":"[飞龙宝宝] 场上 ","color":"dark_purple"},{"text":"宝宝 × ","color":"gray"},{"score":{"name":"#bw_n","objective":"kitpvp.game"},"color":"gold"},{"text":" 火球 × ","color":"gray"},{"score":{"name":"#bw_b","objective":"kitpvp.game"},"color":"gold"}]
execute as @e[tag=kitpvp.earth_babywhelp] at @s run tellraw @a [{"text":"  冷却 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.bw_cd"},"color":"aqua"},{"text":"｜最近的玩家 ","color":"gray"},{"text":"你自己就是召唤者 ⇒ 同队不打你，用别的号或先 /team leave","color":"yellow"}]
execute as @e[tag=kitpvp.bw_ball] at @s run tellraw @a [{"text":"  火球寿命 ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.bw_life"},"color":"aqua"}]
tellraw @a [{"text":"  读法：冷却一直是 0 且没火球 ＝ 没找到目标（创造/旁观/同队都被过滤）；有火球但你不掉血 ＝ 火球擦过去了或你在创造","color":"dark_gray"}]
scoreboard players remove #bw_probe kitpvp.game 1
execute if score #bw_probe kitpvp.game matches 1.. run schedule function kitpvp:debug/babywhelp_probe 20t
