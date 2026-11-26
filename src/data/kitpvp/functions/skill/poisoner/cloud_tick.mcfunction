# @s = 毒雾（area_effect_cloud）；每 10 刻结算一次，只由 slow2 在局中（#state=1）驱动
scoreboard players add @s kitpvp.poisoner_cloud_t 1
execute if score @s kitpvp.poisoner_cloud_t matches 10.. run function kitpvp:skill/poisoner/cloud_dot
