# ===== 清零自己的冷却 =====

scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
tellraw @s [{"text":"[调试] 自己的冷却已清零","color":"green"}]
