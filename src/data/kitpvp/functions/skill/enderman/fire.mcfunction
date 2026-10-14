# 冷却从投出瞬间起算 500 刻（25 秒）；末影珍珠的传送是原版行为，本函数不接管。
# 已在走的冷却不因再投一颗而重置，否则一直投掷会把补货永远往后推（见 04 第八节）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 500

title @s actionbar {"text":"末影之珠已投出","color":"dark_purple"}
playsound minecraft:entity.ender_pearl.throw master @s ~ ~ ~ 0.8 1.2
