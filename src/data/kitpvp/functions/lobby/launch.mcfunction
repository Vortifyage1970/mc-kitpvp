# 大厅起跳：右击 (0,63,98) 的按钮 → 传送到 (0,64,98) 并给 3 秒漂浮 47
# 抗性 V 不在这里给：起跳柱经过 (0,70,98) 时由 tick 的 lobby 段补（见 lobby/spawn 注册表）
advancement revoke @s only kitpvp:player/lobby_launch
tp @s 0 64 98
effect give @s minecraft:levitation 3 46 true
execute at @s run playsound minecraft:entity.firework_rocket.launch master @s ~ ~ ~ 1 1.2
