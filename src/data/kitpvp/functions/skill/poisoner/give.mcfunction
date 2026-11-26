# 补发 1 瓶毒雾并重置 15 秒补货节流（set cd 放最后：补货成功才罚冷却，见 03 §2.13）
give @s minecraft:lingering_potion{Potion:"minecraft:long_poison",display:{Name:'{"text":"毒雾瓶","color":"dark_green"}'}} 1
scoreboard players set @s kitpvp.cd 300

title @s actionbar {"text":"补给：+1 毒雾瓶","color":"dark_green"}
playsound minecraft:entity.arrow.hit_player master @s ~ ~ ~ 0.7 1.4
