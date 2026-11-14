# 只在有领袖时被 tick 调用：两条 12 秒的波次，互相错开 6 秒
# 领袖 → 一只石锄农民；随机一只石锄农民 → 一只木锄农民
execute if score #tf_wave kitpvp.game matches 1.. run scoreboard players remove #tf_wave kitpvp.game 1
execute if score #tf_wave kitpvp.game matches ..0 as @e[tag=kitpvp.tf_leader] at @s run function kitpvp:skill/tainted_farmer/wave_stone

execute if score #tf_wave2 kitpvp.game matches 1.. run scoreboard players remove #tf_wave2 kitpvp.game 1
execute if score #tf_wave2 kitpvp.game matches ..0 as @e[tag=kitpvp.tf_stone,sort=random,limit=1] at @s run function kitpvp:skill/tainted_farmer/wave_wood
