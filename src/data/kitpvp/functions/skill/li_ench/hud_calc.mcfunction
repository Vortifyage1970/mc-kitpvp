# 剑：点数×300 + 小数进度；上限 900
scoreboard players operation #hud_s kitpvp.game = @s kitpvp.ench_sw
scoreboard players operation #hud_s kitpvp.game *= #ench_three_hundred kitpvp.game
scoreboard players operation #hud_s kitpvp.game += @s kitpvp.ench_sw_fill
execute if score #hud_s kitpvp.game matches 901.. run scoreboard players set #hud_s kitpvp.game 900
# 甲：同上
scoreboard players operation #hud_a kitpvp.game = @s kitpvp.ench_ap
scoreboard players operation #hud_a kitpvp.game *= #ench_three_hundred kitpvp.game
scoreboard players operation #hud_a kitpvp.game += @s kitpvp.ench_ap_fill
execute if score #hud_a kitpvp.game matches 901.. run scoreboard players set #hud_a kitpvp.game 900
execute if score @s kitpvp.ench_sword matches 11.. run scoreboard players set #hud_s kitpvp.game 900
execute if score @s kitpvp.ench_armor matches 11.. run scoreboard players set #hud_a kitpvp.game 900
