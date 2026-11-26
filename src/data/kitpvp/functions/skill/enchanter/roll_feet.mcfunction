# 给靴子掷一次附魔（权重合计 128，保护 28 = 21.9%）
scoreboard players set #ench_r kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 64
execute if score #ench_r kitpvp.game matches 0..27 run function kitpvp:skill/enchanter/apply_feet_protection
execute if score #ench_r kitpvp.game matches 28..41 run function kitpvp:skill/enchanter/apply_feet_projectile_protection
execute if score #ench_r kitpvp.game matches 42..55 run function kitpvp:skill/enchanter/apply_feet_frost_walker
execute if score #ench_r kitpvp.game matches 56..69 run function kitpvp:skill/enchanter/apply_feet_fire_protection
execute if score #ench_r kitpvp.game matches 70..83 run function kitpvp:skill/enchanter/apply_feet_blast_protection
execute if score #ench_r kitpvp.game matches 84..97 run function kitpvp:skill/enchanter/apply_feet_depth_strider
execute if score #ench_r kitpvp.game matches 98..112 run function kitpvp:skill/enchanter/apply_feet_feather_falling
execute if score #ench_r kitpvp.game matches 113..127 run function kitpvp:skill/enchanter/apply_feet_soul_speed
