# ===== 魂石·弓箭手：1 支箭 + 魂石之弓（无限 I、冲击 I），持续 20 秒 =====
# 不影响其它箭：只 give 一支普通箭，不清玩家的箭；
# 弓的回收走 sudden_drop 里的 clear @a minecraft:bow{KitSoulBow:1b}，按 NBT 精确匹配，
# 不会动玩家自己的弓（弓箭手起始弓不带 KitSoulBow 标记）。
tag @s add kitpvp.soul_given

give @s minecraft:arrow 1
give @s minecraft:bow{KitSoulBow:1b,Enchantments:[{id:"minecraft:infinity",lvl:1},{id:"minecraft:punch",lvl:1}],display:{Name:'{"text":"魂石之弓","color":"light_purple","bold":true}'}} 1

title @s actionbar {"text":"魂石·疾射：无限 I 冲击 I（20 秒）","color":"green"}
playsound minecraft:entity.arrow.shoot master @s ~ ~ ~ 0.8 1.2
