# 水中被动：脚下 / 脚下 0.2 / 胸 / 头四个采样点，任一点是水（含气泡柱）就算"处于水中"。
# 多高度采样是为了"灵敏又不误判"：只露头的自由泳（脚方块可能已经是空气）能命中，
# 站在桥上或岸边（脚下是实心方块）不会误判；1 格深的浅水坑也算（脚方块就是水）。
tag @s remove kitpvp.in_water
execute if block ~ ~ ~ water run tag @s add kitpvp.in_water
execute if block ~ ~-0.2 ~ water run tag @s add kitpvp.in_water
execute if block ~ ~1 ~ water run tag @s add kitpvp.in_water
execute if block ~ ~1.5 ~ water run tag @s add kitpvp.in_water
execute if block ~ ~ ~ bubble_column run tag @s add kitpvp.in_water
execute if block ~ ~1 ~ bubble_column run tag @s add kitpvp.in_water

# 每刻重挂 1 秒效果：出水后最多残留 1 秒，不需要单独的到期清理（同大厅的饱和）
execute if entity @s[tag=kitpvp.in_water] run effect give @s minecraft:strength 1 0 true
