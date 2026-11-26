# 给头盔掷一次附魔（权重合计 128，保护 38 = 29.7%）
scoreboard players set #ench_r kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 64
execute if score #ench_r kitpvp.game matches 0..37 run function kitpvp:skill/enchanter/apply_head_protection
execute if score #ench_r kitpvp.game matches 38..60 run function kitpvp:skill/enchanter/apply_head_projectile_protection
execute if score #ench_r kitpvp.game matches 61..82 run function kitpvp:skill/enchanter/apply_head_respiration
execute if score #ench_r kitpvp.game matches 83..104 run function kitpvp:skill/enchanter/apply_head_fire_protection
execute if score #ench_r kitpvp.game matches 105..127 run function kitpvp:skill/enchanter/apply_head_blast_protection
