scoreboard players set #debug kitpvp.game 0
gamerule sendCommandFeedback false

# 关闭时把 notch_mode 留下的无限效果收干净（只动挂过 tag 的人，不误伤别的来源）
execute as @a[tag=kitpvp.notch_mode] run effect clear @s minecraft:saturation
execute as @a[tag=kitpvp.notch_mode] run effect clear @s minecraft:regeneration
tag @a remove kitpvp.notch_mode

say ===== debug 模式 已关闭 =====
tellraw @a [{"text":"[debug] ","color":"light_purple","bold":true},{"text":"已关闭，自动结算恢复。","color":"white"}]
