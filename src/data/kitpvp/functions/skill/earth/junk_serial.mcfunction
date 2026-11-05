# @s = 刚掉出来那件东西（物品实体）。由调用方 execute as @e[tag=kitpvp.junk_new] 逐个调进来
# 序号不同 ⇒ 物品 NBT 不同 ⇒ 永远不会叠成一摞（1.20.1 改不了堆叠上限，这是唯一稳的办法）
scoreboard players add #junk_serial kitpvp.game 1
execute store result entity @s Item.tag.kitpvp.serial int 1 run scoreboard players get #junk_serial kitpvp.game
tag @s remove kitpvp.junk_new