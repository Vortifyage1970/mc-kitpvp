# ===== 主大厅：压力板职业介绍（每刻轮询） =====
# 由 tick.mcfunction 调用
#
# 行为：玩家踩上「轻质测重压力板」的瞬间，弹出对应职业的介绍卡片
#       （只会调 kitpvp:kit/info/* ，不会自动选职业；
#        玩家看完自己点卡片底部的 [确认选择] 才真正选职业）
#
# 防重复：靠 tag=kitpvp.on_pad 的翻转
#   踩上板 + 没有 tag  → 触发一次，并打上 tag
#   站在板上时        → 已有 tag，不会再触发（潜行、原地跳、转视角都不刷屏）
#   离开板            → 摘掉 tag，下次踩板重新触发
#
# ⚠ kitpvp.on_pad 是"位置状态"tag，与 kitpvp.in_lobby 同类：
#   刻意不在 util/clear_player 里清除。
#   否则玩家站在板上时被 clear_player → tag 被清 → 下一刻重新弹一次描述。

# 踩上板的瞬间：没有 on_pad → 触发
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator,tag=!kitpvp.on_pad] at @s if block ~ ~ ~ minecraft:light_weighted_pressure_plate run function kitpvp:lobby/pad_enter

# 离开板：摘 tag，允许下次踩板重新触发
execute as @a[tag=kitpvp.on_pad] at @s unless block ~ ~ ~ minecraft:light_weighted_pressure_plate run tag @s remove kitpvp.on_pad