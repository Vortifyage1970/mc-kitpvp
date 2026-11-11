# @s = 刚打了篝火一下的玩家（advancement 驱动，只看"伤害来源是篝火"，摔伤/别的怪打中不会触发）
# 5 秒着火：Fire 是"还能烧多少刻"，100 = 5 秒；重复命中直接刷新，不会叠成十几秒
advancement revoke @s only kitpvp:player/campfire_touch
data merge entity @s {Fire:100s}
# 一声点火的"嗤"，贴着耳朵给本人
playsound minecraft:item.firecharge.use master @s ~ ~ ~ 0.9 1.2
