# 坐杀博徒：每命中一次抽一张卡（普通 0..88 / 稀有 89..120 / 传说 121..127）
scoreboard players set #dom_r kitpvp.game 0
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 1
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 2
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 4
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 8
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 16
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 32
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game 64

scoreboard players set #dom_p kitpvp.game 0
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 1
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 2
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 4
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 8
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 16
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 32
execute store success score #dom_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 64

execute if score #dom_r kitpvp.game matches 0..88 if score #dom_p kitpvp.game matches 0..20 run function kitpvp:skill/li_ench/card/c00_mo
execute if score #dom_r kitpvp.game matches 0..88 if score #dom_p kitpvp.game matches 21..41 run function kitpvp:skill/li_ench/card/c01_cui
execute if score #dom_r kitpvp.game matches 0..88 if score #dom_p kitpvp.game matches 42..62 run function kitpvp:skill/li_ench/card/c02_str
execute if score #dom_r kitpvp.game matches 0..88 if score #dom_p kitpvp.game matches 63..83 run function kitpvp:skill/li_ench/card/c03_spd
execute if score #dom_r kitpvp.game matches 0..88 if score #dom_p kitpvp.game matches 84..104 run function kitpvp:skill/li_ench/card/c04_res
execute if score #dom_r kitpvp.game matches 0..88 if score #dom_p kitpvp.game matches 105..127 run function kitpvp:skill/li_ench/card/c05_haste
execute if score #dom_r kitpvp.game matches 89..120 if score #dom_p kitpvp.game matches 0..20 run function kitpvp:skill/li_ench/card/c10_fine_sw
execute if score #dom_r kitpvp.game matches 89..120 if score #dom_p kitpvp.game matches 21..41 run function kitpvp:skill/li_ench/card/c11_fine_ap
execute if score #dom_r kitpvp.game matches 89..120 if score #dom_p kitpvp.game matches 42..62 run function kitpvp:skill/li_ench/card/c12_sharp3
execute if score #dom_r kitpvp.game matches 89..120 if score #dom_p kitpvp.game matches 63..83 run function kitpvp:skill/li_ench/card/c13_prot2
execute if score #dom_r kitpvp.game matches 89..120 if score #dom_p kitpvp.game matches 84..104 run function kitpvp:skill/li_ench/card/c14_heal4
execute if score #dom_r kitpvp.game matches 89..120 if score #dom_p kitpvp.game matches 105..127 run function kitpvp:skill/li_ench/card/c15_cd5s
execute if score #dom_r kitpvp.game matches 121..127 if score #dom_p kitpvp.game matches 0..20 run function kitpvp:skill/li_ench/card/c20_level
execute if score #dom_r kitpvp.game matches 121..127 if score #dom_p kitpvp.game matches 21..41 run function kitpvp:skill/li_ench/card/c21_egg
execute if score #dom_r kitpvp.game matches 121..127 if score #dom_p kitpvp.game matches 42..62 run function kitpvp:skill/li_ench/card/c22_sharp5
execute if score #dom_r kitpvp.game matches 121..127 if score #dom_p kitpvp.game matches 63..83 run function kitpvp:skill/li_ench/card/c23_heal10
execute if score #dom_r kitpvp.game matches 121..127 if score #dom_p kitpvp.game matches 84..104 run function kitpvp:skill/li_ench/card/c24_prot5
execute if score #dom_r kitpvp.game matches 121..127 if score #dom_p kitpvp.game matches 105..127 run function kitpvp:skill/li_ench/card/c25_souls
