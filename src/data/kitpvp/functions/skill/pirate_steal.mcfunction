# ===== 非海盗捡到海盗手炮：没收 + 30 秒后归还 =====
# @s = 捡起弩的非海盗
# 调用方：skill/pirate_pickup
# 结构对齐 archer_steal

# 1. 从背包里清除这把弩（只清带 KitCrossbow:1b 的那把）
clear @s minecraft:crossbow{KitCrossbow:1b}

# 2. 本机提示
title @s actionbar {"text":"这把弩不属于你，已没收","color":"red"}
playsound minecraft:entity.item.break master @s ~ ~ ~ 0.8 1.0

# 3. 全服公告
tellraw @a [{"text":"[!] ","color":"red","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了海盗的手炮，30 秒后归还","color":"gray"}]

# 4. 30 秒（600 刻）后归还
#    replace 模式：多次被捡只保留最后一次计时，不会叠出多把弩
schedule function kitpvp:skill/pirate_return 600t replace
