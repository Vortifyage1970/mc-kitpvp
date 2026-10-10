# ===== 地球地图复原 =====
# 调用方：kitpvp:map/restore（game/reset 第四步）
# 结构文件位置：data/kitpvp/structures/earth/main.nbt
# 引用名即 kitpvp:earth/main
#
# --- 一、清空地球地图占用的方块区域 ---
# 区域：(-624,82,-719) ~ (-716,121,-632)
# 体积：93 × 40 × 88 = 327,360，超过 fill 单次上限 32767，
# 按每 4 层 Y 一批切成 10 批，单批 = 93 × 4 × 88 = 32,736，安全。

# Y 82..85
fill -624 82 -719 -716 85 -632 minecraft:air
# Y 86..89
fill -624 86 -719 -716 89 -632 minecraft:air
# Y 90..93
fill -624 90 -719 -716 93 -632 minecraft:air
# Y 94..97
fill -624 94 -719 -716 97 -632 minecraft:air
# Y 98..101
fill -624 98 -719 -716 101 -632 minecraft:air
# Y 102..105
fill -624 102 -719 -716 105 -632 minecraft:air
# Y 106..109
fill -624 106 -719 -716 109 -632 minecraft:air
# Y 110..113
fill -624 110 -719 -716 113 -632 minecraft:air
# Y 114..117
fill -624 114 -719 -716 117 -632 minecraft:air
# Y 118..121
fill -624 118 -719 -716 121 -632 minecraft:air

# --- 二、用结构模板覆盖回初始地形 ---
# 完整语法（1.20.1，参数含义请用 /help place 验证）：
#   place template <template> [pos] [rotation] [mirror] [integrity] [seed]
# 参数（pos / rotation / mirror / integrity / seed）由你自己填。
#
# 注意：本函数是由 game/reset 经 schedule 触发的，没有 @s、也不带位置。
# 如果 place template 的默认执行位置不在你要贴图的地方，必须补 pos 参数，
# 或者外面套一层 execute positioned <x> <y> <z> run place template ...

place template kitpvp:earth/main
