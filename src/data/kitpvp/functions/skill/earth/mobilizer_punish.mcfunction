# @s = 没点按钮的那个玩家：瞬间伤害 I（6 点）+ 动员家的耳语
# 瞬间伤害是魔法伤害，穿护甲；若只想掉半颗心，把 effect 那行换成 damage @s 1 minecraft:generic
# 耳语分两版：#mob_round = 0 是「准备」轮，= 1 是「取消准备」轮（由 prompt / end 各自置位）
effect give @s minecraft:instant_damage 1 0 true
execute if score #mob_round kitpvp.game matches 0 run tellraw @s [{"text":"动员家在你耳边悄悄说 ","color":"gray","italic":true},{"text":"你没准备哦。","color":"red","italic":true}]
execute if score #mob_round kitpvp.game matches 1 run tellraw @s [{"text":"动员家在你耳边悄悄说 ","color":"gray","italic":true},{"text":"你没取消准备哦。","color":"red","italic":true}]