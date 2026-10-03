# ===== 魂石·坦克：右键 → 缓慢 III + 抗性提升 III，20 秒 =====
# 注意：本函数由 tank_dispatch 调用，快照 tank_last 已在 dispatch 首行推进，此处不重复

execute at @s run kill @e[type=minecraft:iron_golem,name="坦克魂石"]

effect give @s minecraft:slowness 20 2 true
effect give @s minecraft:resistance 20 2 true

title @s actionbar {"text":"魂石·磐石：缓慢 III + 抗性 III（20 秒）","color":"aqua"}
playsound minecraft:block.anvil.land master @s ~ ~ ~ 0.8 0.8
