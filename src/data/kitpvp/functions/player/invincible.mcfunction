# ===== 给 @s 5 秒无敌 =====
# resistance 等级 4 = 抗性 V（100% 减伤）
# 时长给 6 秒，留 1 秒余量给倒计时 clear

tag @s add kitpvp.invincible
scoreboard players set @s kitpvp.inv 100
effect give @s minecraft:resistance 5 4 true