# ===== 末影人：末影之珠真施法 =====
# 调用方：skill/enderman_cast（已确认上一刻手持带 KitEnderPearl 标记的物品）
# @s = 末影人
#
# 末影珍珠的传送是原版行为，本函数不接管。
# set cd 写在最后：冷却从"投出一瞬间"开始，共 500 刻（25 秒）。

execute if score @s kitpvp.ender_ammo matches 1.. run scoreboard players remove @s kitpvp.ender_ammo 1

scoreboard players set @s kitpvp.cd 500

title @s actionbar {"text":"末影之珠已投出","color":"dark_purple"}
playsound minecraft:entity.ender_pearl.throw master @s ~ ~ ~ 0.8 1.2
