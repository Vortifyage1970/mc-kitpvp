# 末影珍珠的传送是原版行为，本函数不接管；投出不等冷却、也不碰 cd。
# 补货节流（25 秒）只由 skill/enderman/give 写，否则连投会把补货永远往后推（见 03 §2.13）

title @s actionbar {"text":"末影之珠已投出","color":"dark_purple"}
playsound minecraft:entity.ender_pearl.throw master @s ~ ~ ~ 0.8 1.2
