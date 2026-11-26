# 给胸甲掷一次附魔（权重合计 128，保护 30 = 23.4%）
scoreboard players set #ench_r kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 64
execute if score #ench_r kitpvp.game matches 0..29 run function kitpvp:skill/enchanter/apply_chest_protection
execute if score #ench_r kitpvp.game matches 30..53 run function kitpvp:skill/enchanter/apply_chest_projectile_protection
execute if score #ench_r kitpvp.game matches 54..78 run function kitpvp:skill/enchanter/apply_chest_thorns
execute if score #ench_r kitpvp.game matches 79..102 run function kitpvp:skill/enchanter/apply_chest_fire_protection
execute if score #ench_r kitpvp.game matches 103..127 run function kitpvp:skill/enchanter/apply_chest_blast_protection
