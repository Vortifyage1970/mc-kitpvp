# ===== 末影人：补 1 颗末影之珠 + 进冷却 =====
# 调用方：skill/enderman（已确认 ammo < 3）
# @s = 末影人

give @s minecraft:ender_pearl{KitEnderPearl:1b} 1

scoreboard players add @s kitpvp.ender_ammo 1
scoreboard players set @s kitpvp.cd 500

title @s actionbar {"text":"末影之珠 +1","color":"dark_purple"}
playsound minecraft:entity.enderman.ambient master @s ~ ~ ~ 0.8 1.4
