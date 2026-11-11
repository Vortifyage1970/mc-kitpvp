# 史莱姆魂石：蛋带 EntityTag（最小号史莱姆 + 专属 tag），靠 tag 认它，不认名字
scoreboard players operation @s kitpvp.soul_slime_last = @s kitpvp.soul_slime_used

execute at @s if entity @e[tag=kitpvp.soul_slime_token,distance=..8] run function kitpvp:skill/soul/slime_apply

execute at @s run kill @e[tag=kitpvp.soul_slime_token]
