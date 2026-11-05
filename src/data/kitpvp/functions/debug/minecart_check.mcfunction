# 排查用：站到矿车旁边，跑 /function kitpvp:debug/minecart_check
# 打印最近那只矿车的 ActiveEffects 与 Attributes —— 用来分清"效果没挂上"和"挂上了但看起来不快"
tellraw @s [{"text":"=== 矿车检查 ===\n","color":"gold"}]
tellraw @s [{"text":"ActiveEffects：","color":"gray"},{"nbt":"ActiveEffects","entity":"@e[tag=kitpvp.earth_minecart,limit=1,sort=nearest,distance=..24]","fallback":"（24 格内没找到矿车）"}]
tellraw @s [{"text":"\nAttributes：","color":"gray"},{"nbt":"Attributes","entity":"@e[tag=kitpvp.earth_minecart,limit=1,sort=nearest,distance=..24]","fallback":""}]
tellraw @s [{"text":"\n读法：ActiveEffects 里要有 Id:1b（速度）与 Id:18b（虚弱）；这里是空数组 = 效果根本没挂上","color":"dark_gray"}]
