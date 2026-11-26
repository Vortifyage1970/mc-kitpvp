# advancement：附魔师打中玩家 -> 剑蓄力 +1
advancement revoke @s only kitpvp:player/ench_hit
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.alive matches 1 if score @s kitpvp.ench_sword matches ..10 run scoreboard players add @s kitpvp.ench_sw 1
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.alive matches 1 run playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.35 1.9
execute if score @s kitpvp.kit matches 98 if score @s kitpvp.alive matches 1 run function kitpvp:skill/enchanter/ench_check
