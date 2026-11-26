# advancement：附魔师被玩家打中 -> 护甲蓄力 +0.3 点（90/300 格，比原来慢 70%）
advancement revoke @s only kitpvp:player/ench_hurt
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_armor matches ..10 if score @s kitpvp.ench_ap matches ..2 run scoreboard players add @s kitpvp.ench_ap_fill 90
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_ap matches ..2 if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.4
execute if score @s kitpvp.kit matches 15 if score @s kitpvp.alive matches 1 run function kitpvp:skill/enchanter/ench_check