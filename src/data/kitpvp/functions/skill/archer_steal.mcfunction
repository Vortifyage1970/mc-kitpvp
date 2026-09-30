# ===== 非弓箭手捡到弓箭手之弓：没收 + 30 秒后归还 =====
# @s = 捡起弓的非弓箭手
# 调用方：skill/archer_pickup

# 1. 直接从背包里清除这把弓
clear @s minecraft:bow{KitBow:1b}

# 2. 本机提示
title @s actionbar {"text":"这把弓不属于你，已没收","color":"red"}
playsound minecraft:entity.item.break master @s ~ ~ ~ 0.8 1.0

# 3. 全服公告
tellraw @a [{"text":"[!] ","color":"red","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了弓箭手的弓，30 秒后归还","color":"gray"}]

# 4. 30 秒（600 刻）后归还
#    replace 模式：多次被捡只保留最后一次计时，不会叠出多把弓
schedule function kitpvp:skill/archer_return 600t replace
