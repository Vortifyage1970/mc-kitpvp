# @s = 没点"准备"的那个玩家：瞬间伤害 I（6 点）+ 动员家的耳语
# 瞬间伤害是魔法伤害，穿护甲；若只想掉半颗心，把这行换成 damage @s 1 minecraft:generic
effect give @s minecraft:instant_damage 1 0 true
tellraw @s [{"text":"动员家在你耳边悄悄说 ","color":"gray"},{"text":"你没准备哦。","color":"red"}]
