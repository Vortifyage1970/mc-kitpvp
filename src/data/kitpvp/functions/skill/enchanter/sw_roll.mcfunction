# 真正掷一次剑附魔（调用前金剑必须已经在主手）
# 权重 128：锋利 45 / 火焰 12 / 击退 22 / 横扫之刃 12 / 亡灵杀手 37
scoreboard players set #ench_r kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 8
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 16
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 32
execute if predicate kitpvp:random/1in2 run scoreboard players add #ench_r kitpvp.game 64
execute if score @s kitpvp.ench_pity matches 3.. run scoreboard players set #ench_r kitpvp.game 0
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 0..44 run function kitpvp:skill/enchanter/apply_sword_sharpness
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 45..56 run function kitpvp:skill/enchanter/apply_sword_fire_aspect
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 57..78 run function kitpvp:skill/enchanter/apply_sword_knockback
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 79..90 run function kitpvp:skill/enchanter/apply_sword_sweeping
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 91..127 run function kitpvp:skill/enchanter/apply_sword_smite
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score #ench_r kitpvp.game matches 0..44 run scoreboard players set @s kitpvp.ench_pity 0
execute unless score #ench_r kitpvp.game matches 0..44 run scoreboard players add @s kitpvp.ench_pity 1
function kitpvp:skill/enchanter/sw_return
