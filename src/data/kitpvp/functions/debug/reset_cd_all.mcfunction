# ===== 清零所有玩家的冷却 =====

scoreboard players set @a kitpvp.cd 0
scoreboard players set @a kitpvp.cd2 0
tellraw @a [{"text":"[调试] 所有人的冷却已清零","color":"yellow"}]