# advancement：附魔师打中玩家 -> 剑蓄力 +0.2 点（60/300 格，15 下一级）
advancement revoke @s only kitpvp:player/ench_hit
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_sword matches ..10 if score @s kitpvp.ench_sw matches ..2 run scoreboard players add @s kitpvp.ench_sw_fill 60
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_sw matches ..2 if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.9
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 run function kitpvp:skill/enchanter/ench_check