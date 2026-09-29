# ===== 开启调试无敌 =====
# 抗性 V = amplifier 4，时长给一个很大的秒数

tag @s add kitpvp.debug_god
effect give @s minecraft:resistance 999999 4 true
tellraw @s [{"text":"[调试] 无敌已开启（抗性 V）","color":"green"}]
