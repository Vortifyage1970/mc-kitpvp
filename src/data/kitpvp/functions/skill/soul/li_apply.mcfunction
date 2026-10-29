# 李朱俊泽魂石：开启 iLsacuL 计时（20 秒），并发 5 枚临时生成蛋（同一颗 20 秒后收走）
# 计时靠 #li_soul 强制 #li_active，与"场上有没有 kit=88 玩家"无关（见 tick）
scoreboard players set #li_soul kitpvp.game 400

# 临时蛋带 KitSoulLiEgg 标记：到期只清这一种，李朱俊泽自己发的蛋不受影响
give @s minecraft:pig_spawn_egg{KitLiPig:1b,KitSoulLiEgg:1b,EntityTag:{Tags:["kitpvp.li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}} 5

title @s actionbar {"text":"魂石·iLsacuL：计时开启，5 枚临时生成蛋（20 秒）","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
