# 水中被动：脚 / 脚下一格 / 胸 / 头四点采样（含气泡柱），任一点是水即算在水中；
# 多高度是为了"灵敏又不误判"——只露头的自由泳能命中，站在桥上不会误判
tag @s remove kitpvp.in_water
execute if block ~ ~ ~ water run tag @s add kitpvp.in_water
execute if block ~ ~-0.2 ~ water run tag @s add kitpvp.in_water
execute if block ~ ~1 ~ water run tag @s add kitpvp.in_water
execute if block ~ ~1.5 ~ water run tag @s add kitpvp.in_water
execute if block ~ ~ ~ bubble_column run tag @s add kitpvp.in_water
execute if block ~ ~1 ~ bubble_column run tag @s add kitpvp.in_water

# 每刻重挂 1 秒，出水最多残留 1 秒（同大厅的饱和）
execute if entity @s[tag=kitpvp.in_water] run effect give @s minecraft:strength 1 0 true
