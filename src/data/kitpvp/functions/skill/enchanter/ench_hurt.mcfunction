# advancement：附魔师被玩家打中 -> 护甲蓄力 +1
advancement revoke @s only kitpvp:player/ench_hurt
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_armor matches ..10 run scoreboard players add @s kitpvp.ench_ap 1
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.alive matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.4
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.alive matches 1 run function kitpvp:skill/enchanter/ench_check
