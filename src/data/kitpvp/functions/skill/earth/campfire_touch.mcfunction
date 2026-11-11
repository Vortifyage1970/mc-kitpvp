# @s = 刚打了篝火一下的玩家（advancement 驱动，只看"伤害来源是篝火"，摔伤/别的怪打中不会触发）
# 召唤者本人不烧：召唤瞬间给他记了 campfire_summoner=1，他打自己的篝火只是白打一下
# 5 秒着火：Fire 是"还能烧多少刻"，100 = 5 秒；重复命中直接刷新，不会叠成十几秒
advancement revoke @s only kitpvp:player/campfire_touch
execute unless score @s kitpvp.campfire_summoner matches 1 run data merge entity @s {Fire:100s}
# 一声点火的"嗤"，贴着耳朵给本人（只有真被点着才响）
execute unless score @s kitpvp.campfire_summoner matches 1 run playsound minecraft:item.firecharge.use master @s ~ ~ ~ 0.9 1.2
