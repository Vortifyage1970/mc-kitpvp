# 用法：站在深池旁边跑 /function kitpvp:debug/dublinn_trace
# 逐段量选择器命中数，定位到底断在哪一环。每行一个数字，0 就是断点
tellraw @s [{"text":"=== 深池链路逐段检查 ===","color":"gold","bold":true}]
scoreboard players set #t1 kitpvp.game 0
execute store result score #t1 kitpvp.game if entity @e[tag=kitpvp.earth_dublinn,distance=..16]
tellraw @s [{"text":"① 16 格内深池载具：","color":"gray"},{"score":{"name":"#t1","objective":"kitpvp.game"},"color":"yellow"}]
scoreboard players set #t2 kitpvp.game 0
execute store result score #t2 kitpvp.game if entity @e[tag=kitpvp.earth_dublinn_zombie,distance=..16]
tellraw @s [{"text":"② 16 格内乘客僵尸：","color":"gray"},{"score":{"name":"#t2","objective":"kitpvp.game"},"color":"yellow"},{"text":"（=0 就是标签丢了，伤害那句找不到目标）","color":"dark_gray"}]
scoreboard players set #t3 kitpvp.game 0
execute store result score #t3 kitpvp.game if entity @a[distance=..3.5]
tellraw @s [{"text":"③ 3.5 格内玩家（无过滤）：","color":"gray"},{"score":{"name":"#t3","objective":"kitpvp.game"},"color":"yellow"}]
scoreboard players set #t4 kitpvp.game 0
execute store result score #t4 kitpvp.game if entity @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}]
tellraw @s [{"text":"④ 3.5 格内玩家（完整过滤）：","color":"gray"},{"score":{"name":"#t4","objective":"kitpvp.game"},"color":"yellow"},{"text":"（③有数④为 0 ⇒ 你在旁观/带 spectator 标签/血量为 0）","color":"dark_gray"}]
tellraw @s [{"text":"⑤ 我的标签：","color":"gray"},{"nbt":"Tags","entity":"@s","color":"aqua"}]
tellraw @s [{"text":"⑥ 我的血量 ×100：","color":"gray"},{"nbt":"Health","entity":"@s","color":"aqua"}]
# ⑦ 直接对自己下一次 7 点 mob_attack（不经过任何选择器），看伤害通道本身通不通
damage @s 7 minecraft:mob_attack
tellraw @s [{"text":"⑦ 已直接对你造成 7 点 mob_attack：掉了 ⇒ 伤害通道正常，问题在③④的过滤；没掉 ⇒ 你在创造/旁观模式","color":"gold"}]
