# ===== 纵火狂：燃烧瓶真施法 =====
# 调用方：skill/arsonist_cast（已确认上一刻手持带 KitFireBomb 标记的物品）
# @s = 纵火狂
#
# 弹药扣减、冷却、提示、音效集中在这里。
# last 推进已在 arsonist_cast 里做完，本函数不再重复。

execute if score @s kitpvp.arsonist_ammo matches 1.. run scoreboard players remove @s kitpvp.arsonist_ammo 1

scoreboard players set @s kitpvp.cd 900

title @s actionbar {"text":"燃烧瓶已投出","color":"gold"}
playsound minecraft:entity.splash_potion.throw master @s ~ ~ ~ 0.8 1.0
