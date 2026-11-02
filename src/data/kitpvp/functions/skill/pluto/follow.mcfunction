# 每刻把鹦鹉拉到本体肩头：只在 2 格外才拉，免得贴脸抖
# 调用方需 `as 玩家 at 玩家`（本函数用 ~ ~0.6 ~ 取调用位置）
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot,distance=2..] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run tp @s ~ ~0.6 ~
