# @s = 刚召唤出来的支援者（at @s，站在召唤点地面）：提到头顶 30 格，开始下落
# 只提一次：摘掉 sup_wait、挂上 sup_falling，tick 里就只对下落中的做落地检测
tp @s ~ ~30 ~
tag @s add kitpvp.sup_falling
tag @s remove kitpvp.sup_wait
scoreboard players set @s kitpvp.sup_land 0
particle minecraft:cloud ~ ~ ~ 0.3 0.2 0.3 0.01 6
