# @s = 点了"取消准备"的那个玩家（只在"结束准备"那 5 秒里出现）
# 取消 = 这一轮不结算：不挨伤害、也不夸；只在 mob_ready=0（还没点过、也没结算过）时响应
execute if score @s kitpvp.mob_ready matches 0 run tellraw @s [{"text":"动员家在你耳边悄悄说 ","color":"gray","italic":true},{"text":"你取消了准备。","color":"yellow","italic":true}]
execute if score @s kitpvp.mob_ready matches 0 run scoreboard players set @s kitpvp.mob_ready 1