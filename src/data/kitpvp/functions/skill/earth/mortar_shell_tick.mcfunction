# @s = 迫击炮的鱼弹（as @s at @s）
# 临时诊断版：正常逻辑保留，但第 12 / 16 刻各跳 3 格，看哪条位移路走通
scoreboard players add @s kitpvp.mo_life 1
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 42 run tp @s ^ ^ ^0.42
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 55 run tp @s ^ ^ ^0.55
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 68 run tp @s ^ ^ ^0.68
execute if entity @e[tag=kitpvp.mo_aim,limit=1] at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet if score @s kitpvp.mo_hs matches 82 run tp @s ^ ^ ^0.82
execute if score @s kitpvp.mo_vy matches 11.. run tp @s ~ ~0.95 ~
execute if score @s kitpvp.mo_vy matches 9..10 run tp @s ~ ~0.8 ~
execute if score @s kitpvp.mo_vy matches 7..8 run tp @s ~ ~0.65 ~
execute if score @s kitpvp.mo_vy matches 5..6 run tp @s ~ ~0.5 ~
execute if score @s kitpvp.mo_vy matches 3..4 run tp @s ~ ~0.35 ~
execute if score @s kitpvp.mo_vy matches 1..2 run tp @s ~ ~0.2 ~
execute if score @s kitpvp.mo_vy matches -1..0 run tp @s ~ ~0 ~
execute if score @s kitpvp.mo_vy matches -3..-2 run tp @s ~ ~-0.35 ~
execute if score @s kitpvp.mo_vy matches -5..-4 run tp @s ~ ~-0.5 ~
execute if score @s kitpvp.mo_vy matches -7..-6 run tp @s ~ ~-0.65 ~
execute if score @s kitpvp.mo_vy matches -9..-8 run tp @s ~ ~-0.8 ~
execute if score @s kitpvp.mo_vy matches ..-10 run tp @s ~ ~-0.95 ~
scoreboard players remove @s kitpvp.mo_vy 1
# === 临时诊断（看完就删） ===
execute if score @s kitpvp.mo_life matches 12 run tellraw @a {"text":"[跳A] 朝落点跳 3 格","color":"red"}
execute if score @s kitpvp.mo_life matches 12 at @s facing entity @e[tag=kitpvp.mo_aim,limit=1] feet run tp @s ^ ^ ^3
execute if score @s kitpvp.mo_life matches 16 run tellraw @a {"text":"[跳B] 沿自身朝向跳 3 格","color":"blue"}
execute if score @s kitpvp.mo_life matches 16 at @s run tp @s ^ ^ ^3
execute if score @s kitpvp.mo_life matches 12 run scoreboard players operation #dbg_hs kitpvp.game = @s kitpvp.mo_hs
execute if score @s kitpvp.mo_life matches 12 run scoreboard players operation #dbg_vy kitpvp.game = @s kitpvp.mo_vy
execute if score @s kitpvp.mo_life matches 12 run tellraw @a [{"text":"[数据] hs=","color":"gray"},{"score":{"name":"#dbg_hs","objective":"kitpvp.game"}},{"text":" vy=","color":"gray"},{"score":{"name":"#dbg_vy","objective":"kitpvp.game"}}]
# === 诊断结束 ===
execute at @e[tag=kitpvp.mo_aim,limit=1] if entity @s[distance=..2] run function kitpvp:skill/earth/mortar_burst
execute if score @s kitpvp.mo_life matches 30.. run function kitpvp:skill/earth/mortar_burst
