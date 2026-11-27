# advancement：附魔师打中玩家 -> 剑蓄力 +0.2 点（60/300 格，15 下一级）
advancement revoke @s only kitpvp:player/ench_hit
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_sword matches ..10 if score @s kitpvp.ench_sw matches ..2 run scoreboard players add @s kitpvp.ench_sw_fill 60
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_sw matches ..2 if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.9
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 run function kitpvp:skill/enchanter/ench_check
# 里·附魔师（kit 99）：领域内抽卡，领域外什么都不涨
execute if score @s kitpvp.kit matches 99 if score @s kitpvp.alive matches 1 if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/draw
execute if score @s kitpvp.kit matches 99 if score @s kitpvp.alive matches 1 unless entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"常态不能蓄力：用「领域展开：坐杀博徒」开赌场","color":"gray"}
