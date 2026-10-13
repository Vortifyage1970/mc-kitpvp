# 重生后处理（doImmediateRespawn=true，原版已放好 spawnpoint）
# 由 tick 在 Health 归位、即原版重生真正完成后才调用——死亡当刻挂效果会被重生清掉
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.assassin_hidden

function kitpvp:player/invincible

# 死亡清空了药水效果，重生后重挂职业被动（新增被动职业在此追加一行）
execute if score @s kitpvp.kit matches 3 run function kitpvp:skill/tank/passive
execute if score @s kitpvp.kit matches 4 run function kitpvp:skill/assassin/passive
execute if score @s kitpvp.kit matches 6 run function kitpvp:skill/ghost/passive
execute if score @s kitpvp.kit matches 10 run function kitpvp:skill/slime/passive

playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2
