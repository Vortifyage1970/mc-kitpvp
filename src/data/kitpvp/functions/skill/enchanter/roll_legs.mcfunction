# 给护腿掷一次附魔（权重合计 128，保护 28 = 21.9%）
scoreboard players set #ench_r kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 64
execute if score #ench_r kitpvp.game matches 0..27 run function kitpvp:skill/enchanter/apply_legs_protection
execute if score #ench_r kitpvp.game matches 28..59 run function kitpvp:skill/enchanter/apply_legs_projectile_protection
execute if score #ench_r kitpvp.game matches 60..65 run function kitpvp:skill/enchanter/apply_legs_thorns
execute if score #ench_r kitpvp.game matches 66..96 run function kitpvp:skill/enchanter/apply_legs_fire_protection
execute if score #ench_r kitpvp.game matches 97..127 run function kitpvp:skill/enchanter/apply_legs_blast_protection
