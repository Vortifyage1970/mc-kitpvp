# 给靴子掷一次附魔（权重合计 128，保护 38 = 29.7%）
scoreboard players set #ench_r kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 64
execute if score #ench_r kitpvp.game matches 0..37 run function kitpvp:skill/enchanter/apply_feet_protection
execute if score #ench_r kitpvp.game matches 38..50 run function kitpvp:skill/enchanter/apply_feet_projectile_protection
execute if score #ench_r kitpvp.game matches 51..63 run function kitpvp:skill/enchanter/apply_feet_frost_walker
execute if score #ench_r kitpvp.game matches 64..76 run function kitpvp:skill/enchanter/apply_feet_fire_protection
execute if score #ench_r kitpvp.game matches 77..89 run function kitpvp:skill/enchanter/apply_feet_blast_protection
execute if score #ench_r kitpvp.game matches 90..102 run function kitpvp:skill/enchanter/apply_feet_depth_strider
execute if score #ench_r kitpvp.game matches 103..115 run function kitpvp:skill/enchanter/apply_feet_feather_falling
execute if score #ench_r kitpvp.game matches 116..127 run function kitpvp:skill/enchanter/apply_feet_soul_speed
