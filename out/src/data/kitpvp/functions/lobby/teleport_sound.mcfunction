# ===== 大厅：传送音效（一次性） =====
# 调用方：lobby/teleport.mcfunction
#         只在"本刻确实执行了传送"的那一支里调用，不要无条件调用
# @s = 被传送的玩家
#
# ⚠ 本函数绝不能挂进 tick 直调链，也不能放在无条件分支：
#   tick 每刻都会对 tag=kitpvp.in_lobby 的玩家调用 lobby/teleport，
#   一旦无条件触发，音效会被每秒叠加 20 次，听感变成噪音，
#   表现上就是"没正常播放"。
#
# 音效名按需替换，1.20.1 常用的传送类音效：
#   minecraft:entity.enderman.teleport
#   minecraft:block.portal.travel
#   minecraft:item.chorus_fruit.teleport
#
# 参数顺序（1.20.1）：
#   playsound <sound> <source> <targets> [<pos>] [<volume>] [<pitch>] [<minVolume>]
#   source 必须是 master / music / record / weather / block / hostile
#                / neutral / player / ambient / voice 之一。
#   写 players 会直接报错；写 player 有效，但会被玩家的"玩家"音量滑块单独静音。
#   不确定就用 /help playsound 现场核对。

playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.8 1.0

title @s actionbar {"text":"已回到大厅","color":"gray"}
