# 自杀一次：走真实死亡链路（death_detect / player/on_death / 命数扣减都照常结算）
kill @s
tellraw @s [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"已自杀：按正常死亡结算（扣命 / 进旁观判定）。","color":"white"}]
