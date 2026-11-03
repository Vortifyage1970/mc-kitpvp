# 每刻把鹦鹉直接 tp 到本体脚下（~ ~ ~，不做任何高度修正）：**也不做距离判断**
# 之前写的 "2 格外才拉" 会让它每走两格才瞬移一次，看起来一卡一卡；无条件每刻 tp 反而是平滑的
# 调用方需 `as 玩家 at 玩家`（本函数用 ~ 取调用位置）
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run tp @s ~ ~ ~
