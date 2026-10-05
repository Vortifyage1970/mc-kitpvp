# ===== 纵火狂：发放 1 瓶燃烧瓶 =====
# 调用方：skill/arsonist（45 秒补货分支）
# 开局 2 瓶由 kit/arsonist 直接 give，不走本函数
#
# 最后一行的 set cd 是本函数的职责之一，
# 保证"补货成功才重置冷却"，满弹时冷却不会被白白吃掉。

give @s minecraft:splash_potion{KitFireBomb:1b,CustomPotionColor:16750848,display:{Name:'{"text":"燃烧瓶","color":"gold","bold":true}'}} 1
scoreboard players add @s kitpvp.arsonist_ammo 1
scoreboard players set @s kitpvp.cd 900

title @s actionbar {"text":"补给：+1 燃烧瓶","color":"gold"}
playsound minecraft:entity.arrow.hit_player master @s ~ ~ ~ 0.7 1.4
