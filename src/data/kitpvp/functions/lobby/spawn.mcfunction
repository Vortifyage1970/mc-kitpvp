# 大厅坐标注册表——改大厅坐标时只认这一处。
#   出生点 / 返回点   0 64 0                                  ← enter / spawn / tp_to_main
#   选职业区目的地    0 63 98                                 ← tp_to_kit
#   讲台 1 目的地     -226 70 94                               ← lectern_teleport_1（音效点 -226 70.5 94）
#   讲台 2 目的地     227 67 97                                ← lectern_teleport_2（音效点 227 67.5 97）
#   传送触发区       (0,66,30)1x1x1 / (-224,70,93)1x1x3 / (0,65,81)1x1x1 / (223,67,96)1x1x3   ← lobby/teleport
#   职业压力板       x=-226..-254（步进 -4），y=71，z=98      ← lobby/pad_enter
#   讲台触发区       x=-21..-19 / 19..21，y=63..66，z=97..99   ← advancements/player/lectern_teleport_*
spawnpoint @s 0 64 0
tp @s 0 64 0
