# 重生后处理（doImmediateRespawn=true，原版已放好 spawnpoint）
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.assassin_hidden

function kitpvp:player/invincible

# 死亡清空了药水效果，重生后重挂职业被动（新增被动职业在此追加一行）
execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank_passive
execute if score @s kitpvp.kit matches 4 run function kitpvp:kit/assassin_passive
execute if score @s kitpvp.kit matches 6 run function kitpvp:kit/ghost_passive

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2
