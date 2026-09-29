# ===== 命数 -1 =====

scoreboard players remove @s kitpvp.lives 1
tellraw @s [{"text":"[调试] 命数 -1，当前：","color":"red"},{"score":{"name":"@s","objective":"kitpvp.lives"},"color":"yellow"}]
